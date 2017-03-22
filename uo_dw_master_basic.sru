HA$PBExportHeader$uo_dw_master_basic.sru
$PBExportComments$Common functionality of master dw for single and multiple details
forward
global type uo_dw_master_basic from uo_dw_basic
end type
end forward

global type uo_dw_master_basic from uo_dw_basic
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type
global uo_dw_master_basic uo_dw_master_basic

type variables
int ii_nrCols 		// # of cols passed from the master to the detail
string is_connectionCols[6] 	// names of the cols in the master
			// that must be copied to the detail
boolean ib_noautosave	// True: save details without asking in rowfocuschanged
long il_previousRow	// row prior to current
boolean ib_notJustOpened	// turned on after first
			// rowfocuschanged
boolean ib_inDeleteRow	// if deleteRow is being
			// processed
end variables

forward prototypes
public function integer uf_insertcurrentrow ()
public function integer uf_retrieve ()
public function integer uf_updatecommit (long al_masterrow, boolean ab_afterdeleterow)
public function integer uf_deletecurrentrow ()
end prototypes

public function integer uf_insertcurrentrow ();long ll_curRow
long ll_newRow

ll_curRow = this.getRow()
if ll_curRow < 0 then
	messageBox("Error Interno", "No se puede determinar la fila actual", StopSign!)
	return -1
elseif ll_curRow > 0 then
	if this.uf_updateCommit(ll_curRow, False) <> 1 then
		return -1
	end if
end if

triggerEvent("ue_preinsert")

ll_newRow = this.insertRow(ll_curRow + 1)
if ll_newRow < 1 then
	messageBox("Error Interno", "No se puede insertar una nueva fila", StopSign!)
	return -1
end if

if this.scrollToRow(ll_newRow) = -1 then
	messageBox("Error Interno", "No se puede ir a la fila reci$$HEX1$$e900$$ENDHEX$$n insertada", StopSign!)
end if

triggerEvent("ue_postinsert")

// in case there are initial values for some columns
this.setItemStatus(ll_newRow, 0, Primary!, NotModified!)

return ll_curRow

end function

public function integer uf_retrieve ();return -1
end function

public function integer uf_updatecommit (long al_masterrow, boolean ab_afterdeleterow);return -1

end function

public function integer uf_deletecurrentrow ();return -1

end function

