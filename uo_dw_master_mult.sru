HA$PBExportHeader$uo_dw_master_mult.sru
$PBExportComments$Master dw for multiple detail dw
forward
global type uo_dw_master_mult from uo_dw_master_basic
end type
end forward

global type uo_dw_master_mult from uo_dw_master_basic
end type
global uo_dw_master_mult uo_dw_master_mult

type variables
uo_dw_detail idw_detail[4]// detail dw's of this dw
boolean ib_engineCascadeDeletes[4]	// True if db engine
			// will cascade the deletions
			// in the master table to the
			// detail table

end variables

forward prototypes
public function integer uf_deletecurrentrow ()
public function integer uf_updatecommit (long al_masterrow, boolean ab_afterdeleterow)
public function integer uf_retrieve (s_arginformation estructura)
end prototypes

public function integer uf_deletecurrentrow ();int li_res
long ll_curRow
long ll_totalRows
long ll_row
int li_detNumber

ll_curRow = this.getRow()
if ll_curRow < 1 then
	beep(1)
	return -1
end if

li_res = messageBox("Por favor confirme","$$HEX1$$bf00$$ENDHEX$$Desea borrar la fila actual?",&
							Question!, YesNo!, 2)

if li_res <> 1 then return -1

this.setRedraw(False)
for li_detNumber = 1 to 4
	this.idw_detail[li_detNumber].setRedraw(False)
next

// Check if deletions are cascaded automatically by the db engine
for li_detNumber = 1 to 4
	if this.ib_engineCascadeDeletes[li_detNumber] then
		this.idw_detail[li_detNumber].reset()
	else
		ll_totalRows = this.idw_detail[li_detNumber].rowCount()
		for ll_row = ll_totalRows to 1 step -1
			this.idw_detail[li_detNumber].deleteRow(ll_row)
		next
	end if
next

ib_inDeleteRow = True
this.deleteRow(ll_curRow)
this.uf_updateCommit(ll_curRow, True)
ll_curRow = this.getRow()
if ll_curRow > 0 then
	for li_detNumber = 1 to 4
		this.idw_detail[li_detNumber].uf_retrieve(ll_curRow)
	next
end if
ib_inDeleteRow = False

this.setRedraw(True)
for li_detNumber = 1 to 4
	this.idw_detail[li_detNumber].setRedraw(True)
next

return 1
end function

public function integer uf_updatecommit (long al_masterrow, boolean ab_afterdeleterow);int li_res
boolean lb_updatesMade
long ll_sqldbcode
string ls_sqlerrtext
int li_detNumber

if ab_afterDeleteRow then	// when this f is called after a delete

	// First save the detail dw's
	for li_detNumber = 1 to 4
		if this.idw_detail[li_detNumber].dataObject = "" then continue
		if this.idw_detail[li_detNumber].modifiedCount() > 0 or &
							this.idw_detail[li_detNumber].deletedCount() > 0 then
			li_res = this.idw_detail[li_detNumber].update(False, False)
			lb_updatesMade = True
		else
			li_res = 1
		end if
		if li_res = -1 then exit
	next

	if li_res = 1 then // if details save went OK
		// Then save me (the master)
		if this.modifiedCount() > 0 or this.deletedCount() > 0 then
			li_res = this.update(False, False)
			lb_UpdatesMade = True
		else
			li_res = 1
		end if
	end if

else	// rowfocuschanged or explicit update (no row deleted)

	if this.acceptText() = -1 then return -1
	for li_detNumber = 1 to 4
		if this.idw_detail[li_detNumber].dataObject = "" then continue
		if this.idw_detail[li_detNumber].acceptText() = -1 then return -1
	next

	// first try to save me
	// note that this will also set autoIncremental cols
	if this.modifiedCount() > 0 or this.deletedCount() > 0 then
		li_res = this.update(False, False)
		lb_updatesMade = True
	else
		li_res = 1
	end if

	if li_res = 1 then
		// Copy the connection column(s) from the master to the details
		// Why to do it at save time: because some connection cols values are
		// only known after successful saving of the master (i.e. autoincremental)
		for li_detNumber = 1 to 4
			if this.idw_detail[li_detNumber].dataObject = "" then continue
			if this.idw_detail[li_detNumber].uf_setAutoColumns(al_masterRow) = 1 then
				if this.idw_detail[li_detNumber].modifiedCount() > 0 or &
							this.idw_detail[li_detNumber].deletedCount() > 0 then
					li_res = this.idw_detail[li_detNumber].update(False, False)
					lb_updatesMade = True
				else
					li_res = 1
				end if
			else
				li_res = -1
			end if
			if li_res = -1 then exit
		next
	end if

end if

if li_res = 1 then
	// master and detail were saved without problems, so commit changes
	if lb_updatesMade then // if at least one update was performed
		commit using sqlca;
		if sqlca.sqlcode = 0 then
			// finally turn off update flags 'cause everything was saved OK
			this.resetUpdate()
			for li_detNumber = 1 to 4
				if this.idw_detail[li_detNumber].dataObject = "" then continue
				this.idw_detail[li_detNumber].resetUpdate()
			next
			return 1
		else
			ll_sqldbcode = sqlca.sqldbcode
			ls_sqlerrtext = sqlca.sqlerrtext
		end if
	else
		return 1	// everything OK, no updates issued
	end if
end if

// Something failed, may be the updates, maybe the commit

if lb_updatesMade then		// if any updates issued, changes must be rolled back
	rollback using sqlca;
end if

if li_res = 1 then // the commit failed
	messageBox("Error de base de datos" + string(ll_sqldbcode), &
																ls_sqlErrText, StopSign!)
end if

if sqlca.sqlcode <> 0 then
	messageBox("Error de base de datos" + string(sqlca.sqldbcode), &
															sqlca.sqlErrText, StopSign!)
end if

return -1

end function

public function integer uf_retrieve (s_arginformation estructura);int li_res
int li_detNumber
istr_argInformation = estructura
li_res = this.uf_retrieve_basic()
if li_res = 0 then
	for li_detNumber = 1 to 4
		this.idw_detail[li_detNumber].reset()
	next
	return 0
elseif li_res < 0 then
	messageBox("Error de lectura", "Al leer el maestro", StopSign!)
	return li_res
else
	for li_detNumber = 1 to 4
		li_res = this.idw_detail[li_detNumber].uf_retrieve(this.getRow())
		if li_res = -1 then return -1
	next
	return li_res
end if
end function

event rowfocuschanged;call super::rowfocuschanged;long ll_curRow
int li_res
int li_detNumber,li_reg

if ib_inDeleteRow then return

ll_curRow = this.getRow()
if this.il_previousRow = ll_curRow then return

if this.ib_notJustOpened = False then
	this.il_previousRow = ll_curRow
	this.ib_notjustOpened = True
	return
end if

// check if there are pending changes in the detail

for li_detNumber = 1 to 4

	if this.idw_detail[li_detNumber].acceptText() = -1 then
		this.scrollToRow(this.il_previousRow)
		return
	end if

	if (this.idw_detail[li_detNumber].modifiedCount() > 0 or &
						this.idw_detail[li_detNumber].deletedCount() > 0) and &
						this.ib_noAutoSave then
		li_res = messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n", &
				"Hay cambios pendientes en los detalles~n$$HEX1$$bf00$$ENDHEX$$Desea guardarlos?",&
				Question!, YesNo!, 1)
		if li_res = 2 then
			// user wants to check detail so don't change of row
			this.scrollToRow(this.il_previousRow)
			return
		end if
	end if
next

setPointer(HourGlass!)
this.setRedraw(False)

// Now save the master dw (the detail is saved implicitly)
if this.il_previousRow <> 0 then
	li_res = this.uf_updateCommit(this.il_previousRow, False)
else
	li_res = this.uf_updateCommit(ll_curRow, False)
end if

if li_res <> 1 then
	this.scrollToRow(this.il_previousRow)
else
	if this.getItemStatus(ll_curRow, 0, Primary!) = New! or ll_curRow = 0 then
		for li_detNumber = 1 to 4
			this.idw_detail[li_detNumber].reset()
		next
	else
		for li_detNumber = 1 to 4
			this.idw_detail[li_detNumber].uf_retrieve(ll_curRow)
		next
	end if
	this.il_previousRow = ll_curRow
end if

this.setRedraw(True)

end event

on uo_dw_master_mult.create
call super::create
end on

on uo_dw_master_mult.destroy
call super::destroy
end on

