HA$PBExportHeader$uo_dw_master.sru
$PBExportComments$Master dw to be used in a master/detail window
forward
global type uo_dw_master from uo_dw_master_basic
end type
end forward

global type uo_dw_master from uo_dw_master_basic
end type
global uo_dw_master uo_dw_master

type variables
uo_dw_detail idw_detail	// master dw of this dw
boolean ib_engineCascadeDeletes	// True if db engine
			// will cascade the deletions
			// in the master table to the
			// detail table

end variables

forward prototypes
public function integer uf_deletecurrentrow ()
public function integer uf_retrieve ()
public function integer uf_updatecommit (long al_masterrow, boolean ab_afterdeleterow)
end prototypes

public function integer uf_deletecurrentrow ();int li_res
long ll_curRow
long ll_totalRows
long ll_row

ll_curRow = this.getRow()
if ll_curRow < 1 then
	beep(1)
	return -1
end if

li_res = messageBox("Por favor confirme","$$HEX1$$bf00$$ENDHEX$$Desea borrar la fila actual?",&
							Question!, YesNo!, 2)

if li_res <> 1 then return -1

this.setRedraw(False)
this.idw_detail.setRedraw(False)

// Check if deletions are cascaded automatically by the db engine
if this.ib_engineCascadeDeletes then
	this.idw_detail.reset()
else
	ll_totalRows = this.idw_detail.rowCount()
	for ll_row = ll_totalRows to 1 step -1
		this.idw_detail.deleteRow(ll_row)
	next
end if

ib_inDeleteRow = True
this.deleteRow(ll_curRow)
this.uf_updateCommit(ll_curRow, True)
ll_curRow = this.getRow()
if ll_curRow > 0 then
	this.idw_detail.uf_retrieve(ll_curRow)
end if
ib_inDeleteRow = False

this.setRedraw(True)
this.idw_detail.setRedraw(True)

return 1

end function

public function integer uf_retrieve ();int li_res

if ii_nrCols > 5 then
	li_res = this.uf_retrieve_enhanced()
else
	li_res = this.uf_retrieve_basic()
end if

if li_res = 0 then
	this.idw_detail.reset()
	return 0
elseif li_res < 0 then
	messageBox("Error de lectura", "Al leer el maestro", StopSign!)
	return li_res
else
	return this.idw_detail.uf_retrieve(this.getRow())
end if

end function

public function integer uf_updatecommit (long al_masterrow, boolean ab_afterdeleterow);integer li_res
boolean lb_updatesMade
long ll_sqldbcode
string ls_sqlerrtext

if ab_afterDeleteRow then	// when this f is called after a delete

	// First save the detail dw
	if this.idw_detail.modifiedCount() > 0 or this.idw_detail.deletedCount() > 0 then
		li_res = this.idw_detail.update(True, False)
		lb_updatesMade = True
	else
		li_res = 1
	end if

	if li_res = 1 then // if detail save went OK
		// Then save me (the master)
		if this.modifiedCount() > 0 or this.deletedCount() > 0 then
			li_res = this.update(True, False)
			lb_UpdatesMade = True
		else
			li_res = 1
		end if
	end if

else	// rowfocuschanged or explicit update (no row deleted)

	if this.idw_detail.acceptText() = -1 or this.acceptText() = -1 then
		return -1
	end if

	// first try to save me
	// note that this will also set autoIncremental cols
	if this.modifiedCount() > 0 or this.deletedCount() > 0 then
		li_res = this.update(True, False)
		lb_updatesMade = True
	else
		li_res = 1
	end if

	if li_res = 1 then
		// Copy the connection column(s) from the master to the detail
		// Why to do it at save time: because some connection cols values are
		// only known after successful saving of the master (i.e. autoincremental)
		if this.idw_detail.uf_setAutoColumns(al_masterRow) = 1 then
			if this.idw_detail.modifiedCount() > 0 or this.idw_detail.deletedCount() > 0 then
				li_res = this.idw_detail.update(True, False)
				lb_updatesMade = True
			else
				li_res = 1
			end if
		else
			li_res = -1
		end if
	end if

end if

if li_res = 1 then
	// master and detail were saved without problems, so commit changes
	if lb_updatesMade then // if at least one update was performed
		commit using sqlca;
		if sqlca.sqlcode = 0 then
			// finally turn off update flags 'cause everything was saved OK
			this.resetUpdate()
			this.idw_detail.resetUpdate()
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

event rowfocuschanged;call super::rowfocuschanged;long ll_curRow
int li_res

if ib_inDeleteRow then return

ll_curRow = this.getRow()
if ll_curRow = 0 then return
if this.il_previousRow = ll_curRow then return

if this.ib_notJustOpened = False then
	this.il_previousRow = ll_curRow
	this.ib_notjustOpened = True
	return
end if

// check if there are pending changes in the detail
if this.idw_detail.acceptText() = -1 then
	this.scrollToRow(this.il_previousRow)
	return
end if

if (this.idw_detail.modifiedCount() > 0 or &
			this.idw_detail.deletedCount() > 0) and this.ib_noautoSave then
	li_res = messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n", &
				"Hay cambios pendientes en el detalle~n$$HEX1$$bf00$$ENDHEX$$Desea guardarlos?", &
				Question!, YesNo!, 1)
	if li_res = 2 then
		// user wants to check detail so don't change of row
		this.scrollToRow(this.il_previousRow)
		return
	end if
end if

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
		this.idw_detail.reset()
	else
		this.idw_detail.uf_retrieve(ll_curRow)
	end if
	this.il_previousRow = ll_curRow
end if

this.setRedraw(True)

end event

