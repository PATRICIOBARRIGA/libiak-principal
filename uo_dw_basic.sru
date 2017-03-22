HA$PBExportHeader$uo_dw_basic.sru
forward
global type uo_dw_basic from datawindow
end type
end forward

global type uo_dw_basic from datawindow
integer width = 873
integer height = 512
integer taborder = 1
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
event ue_accepttext pbm_custom01
event ue_predelete pbm_custom02
event ue_postdelete pbm_custom03
event ue_preinsert pbm_custom04
event ue_postinsert pbm_custom05
end type
global uo_dw_basic uo_dw_basic

type variables
boolean ib_inErrorCascade	// True if inside a validation error
			// used to suppress duplicated val error
string is_serialCodeColumn	// column of the dw that will receive an
			// auto-incremental code
string is_serialCodeType	// name in the SerialCode table of the
			// auto-incremental code
string is_serialCodeDetail
string is_serialCodeCompany
s_argInformation istr_argInformation
int ii_deleteFlag		// 1 go on with row delete
			// -1 abort delete row
			// also is return value in
			// postDelete event
boolean ib_inClicked	// True if clicked event is
			// being processed
int      ii_nrocolsAct			
string is_ActiveCols[20] //name of cols that active for to edit			
end variables

forward prototypes
public function integer uf_firstrow ()
public function integer uf_insertcurrentrow ()
public function integer uf_lastrow ()
public function integer uf_nextrow ()
public function integer uf_priorrow ()
private function integer uf_retrieve4_1st_string (string as_arg1)
private function integer uf_retrieve4_1st_number (long al_arg1)
private function integer uf_retrieve_numbernumber (long al_arg1, long al_arg2)
private function integer uf_retrieve_numberstring (long al_arg1, string as_arg2)
private function integer uf_retrieve_stringnumber (string as_arg1, long al_arg2)
public function integer uf_updatecommit ()
private function integer uf_retrieve_stringstring (string as_arg1, string as_arg2)
public function integer uf_retrieve_basic ()
public function integer uf_retrieve ()
private function integer uf_setautoincrementaldetail (string as_columnname, string as_buffer)
public function integer uf_retrieve_enhanced ()
private function integer uf_setautoincrementalcode (string as_codecompany, string as_columnname, string as_codetype, string as_buffer)
public function integer uf_sort ()
public function integer uf_deletecurrentrow ()
public function integer uf_filter ()
public function integer uf_active (boolean ab_flag)
public function integer uf_changebackground (boolean ab_flag, long al_activecolor, long al_inactivecolor)
end prototypes

event ue_accepttext;this.acceptText()

end event

event ue_predelete;this.ii_deleteFlag = 1
end event

public function integer uf_firstrow ();if this.getRow() > 1 then
	return this.scrollToRow(1)
else
	beep(1)
	return -1
end if

end function

public function integer uf_insertcurrentrow ();long ll_curRow
long ll_newRow

ll_curRow = this.getRow()
if ll_curRow < 0 then ll_curRow = 0

triggerEvent("ue_preinsert")

ll_newRow = this.insertRow(ll_curRow + 1)
if ll_newRow < 1 then
	messageBox("Error Interno", "No se puede insertar una nueva fila", StopSign!)
end if

if this.scrollToRow(ll_newRow) = -1 then
	messageBox("Error Interno", "No se puede ir a la fila reci$$HEX1$$e900$$ENDHEX$$n insertada", StopSign!)
end if

triggerEvent("ue_postinsert")

// in case there are initial values for some columns
this.setItemStatus(ll_newRow, 0, Primary!, NotModified!)

return ll_curRow

end function

public function integer uf_lastrow ();long ll_rowCount

ll_rowCount = this.rowCount()
if ll_rowCount > 1 and ll_rowCount > this.getRow() then
	return this.scrollToRow(ll_rowCount)
else
	beep(1)
	return -1
end if


end function

public function integer uf_nextrow ();if this.scrollNextRow() = -1 then
	beep(1)
	return -1
else
	return 1
end if

end function

public function integer uf_priorrow ();long ll_cur_row
long ll_new_row

ll_cur_row = this.getRow() - 1
ll_new_row = this.scrollPriorRow()
if ll_new_row = -1 then
	beep(1)
	return -1
elseif ll_new_row > ll_cur_row then
	this.setColumn(this.getColumn())
	return -1
end if

return 1
end function

private function integer uf_retrieve4_1st_string (string as_arg1);choose case istr_argInformation.argType[2]
	case "string" // 2st argument of 4 is string
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - dateTime
		end choose // 2st arg is string
	case "number" // 2st arg of 4 is number
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - dateTime
		end choose // 2st arg is number
	case "date" // 2st arg of 4 is date
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - dateTime
		end choose // 2st arg is date
	case "datetime" // 2st arg of 4 is datetime
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(as_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - dateTime
		end choose // 2st arg is dateTime
end choose	// end of the case on the second arg

return -1

end function

private function integer uf_retrieve4_1st_number (long al_arg1);choose case istr_argInformation.argType[2]
	case "string" // 2st argument of 4 is string
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.stringValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // string - dateTime
		end choose // 2st arg is string
	case "number" // 2st arg of 4 is number
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.numberValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // number - dateTime
		end choose // 2st arg is number
	case "date" // 2st arg of 4 is date
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // date - dateTime
		end choose // 2st arg is date
	case "datetime" // 2st arg of 4 is datetime
		choose case this.istr_argInformation.argType[3]
			case "string"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - string
			case "number"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - number
			case "date"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - date
			case "datetime"
				choose case this.istr_argInformation.argType[4]
					case "string"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4])
					case "number"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4])
					case "date"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4])
					case "datetime"
						return this.retrieve(al_arg1, this.istr_argInformation.dateTimeValue[2], this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4])
				end choose // dateTime - dateTime
		end choose // 2st arg is dateTime
end choose	// end of the case on the second arg

return -1
end function

private function integer uf_retrieve_numbernumber (long al_arg1, long al_arg2);choose case istr_argInformation.argType[3]
	case "string" // 3st argument of 5 is string
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - dateTime
		end choose // 3st arg is string
	case "number" // 3st arg of 5 is number
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - dateTime
		end choose // 3st arg is number
	case "date" // 3st arg of 5 is date
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - dateTime
		end choose // 3st arg is date
	case "datetime" // 3st arg of 5 is datetime
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - dateTime
		end choose // 3st arg is dateTime
end choose	// end of the case on the second arg

return -1

end function

private function integer uf_retrieve_numberstring (long al_arg1, string as_arg2);choose case istr_argInformation.argType[3]
	case "string" // 3st argument of 5 is string
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - dateTime
		end choose // 3st arg is string
	case "number" // 3st arg of 5 is number
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - dateTime
		end choose // 3st arg is number
	case "date" // 3st arg of 5 is date
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - dateTime
		end choose // 3st arg is date
	case "datetime" // 3st arg of 5 is datetime
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(al_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - dateTime
		end choose // 3st arg is dateTime
end choose	// end of the case on the second arg

return -1

end function

private function integer uf_retrieve_stringnumber (string as_arg1, long al_arg2);choose case istr_argInformation.argType[3]
	case "string" // 3st argument of 5 is string
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - dateTime
		end choose // 3st arg is string
	case "number" // 3st arg of 5 is number
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - dateTime
		end choose // 3st arg is number
	case "date" // 3st arg of 5 is date
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - dateTime
		end choose // 3st arg is date
	case "datetime" // 3st arg of 5 is datetime
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, al_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - dateTime
		end choose // 3st arg is dateTime
end choose	// end of the case on the second arg

return -1
end function

public function integer uf_updatecommit ();integer li_res
long ll_sqldbcode
string ls_sqlErrText

if this.update(True, False) = 1 then

	commit using sqlca;
	if sqlca.sqlcode = 0 then
		this.resetUpdate()
		return 1
	end if

	ll_sqldbcode = sqlca.sqldbcode
	ls_sqlErrText = sqlca.sqlErrText
	rollback using sqlca;
	messageBox("Error de base de datos" + string(ll_sqldbcode), &
															ls_sqlErrText, StopSign!)
	if sqlca.sqlcode <> 0 then	// of the rollback
		messageBox("Error de base de datos" + string(sqlca.sqldbcode), &
															sqlca.sqlErrText, StopSign!)
	end if
	return -1

else
	rollback using sqlca;
	if sqlca.sqlcode <> 0 then
		messageBox("Error de base de datos" + string(sqlca.sqldbcode), &
															sqlca.sqlErrText, StopSign!)
	end if
	return -1
end if

end function

private function integer uf_retrieve_stringstring (string as_arg1, string as_arg2);choose case istr_argInformation.argType[3]
	case "string" // 3st argument of 5 is string
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.stringValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // string - dateTime
		end choose // 3st arg is string
	case "number" // 3st arg of 5 is number
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.numberValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // number - dateTime
		end choose // 3st arg is number
	case "date" // 3st arg of 5 is date
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // date - dateTime
		end choose // 3st arg is date
	case "datetime" // 3st arg of 5 is datetime
		choose case this.istr_argInformation.argType[4]
			case "string"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.stringValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - string
			case "number"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.numberValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - number
			case "date"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - date
			case "datetime"
				choose case this.istr_argInformation.argType[5]
					case "string"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.stringValue[5])
					case "number"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.numberValue[5])
					case "date"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateValue[5])
					case "datetime"
						return this.retrieve(as_arg1, as_arg2, this.istr_argInformation.dateTimeValue[3], this.istr_argInformation.dateTimeValue[4], this.istr_argInformation.dateTimeValue[5])
				end choose // dateTime - dateTime
		end choose // 3st arg is dateTime
end choose	// end of the case on the second arg

return -1

end function

public function integer uf_retrieve_basic ();s_arginformation xx

xx = istr_arginformation

SetTransObject(sqlca)
choose case istr_argInformation.nrArgs
	case 0
		return retrieve()
	case 1
		choose case istr_argInformation.argType[1]
			case "string"
				return retrieve(istr_argInformation.stringValue[1])
			case "number"
				return retrieve(istr_argInformation.numberValue[1])
			case "date"
				return retrieve(istr_argInformation.dateValue[1])
			case "datetime"
				return retrieve(istr_argInformation.dateTimeValue[1])
		end choose
	case 2
		choose case istr_argInformation.argType[1]
			case "string"
				choose case istr_argInformation.argType[2]
					case "string"
						return retrieve(istr_argInformation.stringValue[1], istr_argInformation.stringValue[2])
					case "number"
						return retrieve(istr_argInformation.stringValue[1], istr_argInformation.numberValue[2])
					case "date"
						return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateValue[2])
					case "datetime"
						return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateTimeValue[2])
				end choose
			case "number"
				choose case istr_argInformation.argType[2]
					case "string"
						return retrieve(istr_argInformation.numberValue[1], istr_argInformation.stringValue[2])
					case "number"
						return retrieve(istr_argInformation.numberValue[1], istr_argInformation.numberValue[2])
					case "date"
						return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateValue[2])
					case "datetime"
						return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateTimeValue[2])
				end choose
			case "date"
				choose case istr_argInformation.argType[2]
					case "string"
						return retrieve(istr_argInformation.dateValue[1], istr_argInformation.stringValue[2])
					case "number"
						return retrieve(istr_argInformation.dateValue[1], istr_argInformation.numberValue[2])
					case "date"
						return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateValue[2])
					case "datetime"
						return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateTimeValue[2])
				end choose
			case "datetime"
				choose case istr_argInformation.argType[2]
					case "string"
						return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.stringValue[2])
					case "number"
						return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.numberValue[2])
					case "date"
						return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateValue[2])
					case "datetime"
						return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateTimeValue[2])
				end choose
		end choose
	case 3
		choose case istr_argInformation.argType[1]
			case "string" // 1st argument of 3 is string
				choose case istr_argInformation.argType[2]
					case "string"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.stringValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.stringValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateTimeValue[3])
						end choose // string - string
					case "number"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.numberValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.numberValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateTimeValue[3])
						end choose // string - number
					case "date"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateTimeValue[3])
						end choose // string - date
					case "datetime"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.stringValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateTimeValue[3])
						end choose // string - dateTime
				end choose // 1st arg is string
			case "number" // 1st arg of 3 is number
				choose case istr_argInformation.argType[2]
					case "string"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.stringValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.stringValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateTimeValue[3])
						end choose // number - string
					case "number"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.numberValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.numberValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateTimeValue[3])
						end choose // number - number
					case "date"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateTimeValue[3])
						end choose // number - date
					case "datetime"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.numberValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateTimeValue[3])
						end choose // number - dateTime
				end choose // 1st arg is number
			case "date" // 1st arg of 3 is date
				choose case istr_argInformation.argType[2]
					case "string"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.stringValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.stringValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateTimeValue[3])
						end choose // date - string
					case "number"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.numberValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.numberValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateTimeValue[3])
						end choose // date - number
					case "date"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateTimeValue[3])
						end choose // date - date
					case "datetime"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateTimeValue[3])
						end choose // date - dateTime
				end choose // 1st arg is date
			case "datetime" // 1st arg of 3 is datetime
				choose case istr_argInformation.argType[2]
					case "string"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.stringValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.stringValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.stringValue[2], istr_argInformation.dateTimeValue[3])
						end choose // dateTime - string
					case "number"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.numberValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.numberValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.numberValue[2], istr_argInformation.dateTimeValue[3])
						end choose // dateTime - number
					case "date"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateValue[2], istr_argInformation.dateTimeValue[3])
						end choose // dateTime - date
					case "datetime"
						choose case istr_argInformation.argType[3]
							case "string"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.stringValue[3])
							case "number"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.numberValue[3])
							case "date"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateValue[3])
							case "datetime"
								return retrieve(istr_argInformation.dateTimeValue[1], istr_argInformation.dateTimeValue[2], istr_argInformation.dateTimeValue[3])
						end choose // dateTime - dateTime
				end choose // 1st arg is dataTime
		end choose	// end of the case 3 args

	case 4
		choose case istr_argInformation.argType[1]
			case "string"
				return uf_retrieve4_1st_string(istr_argInformation.stringValue[1])
			case "number"
				return uf_retrieve4_1st_number(istr_argInformation.numberValue[1])
			case else
				messageBox("Error interno", "Si se dan 4 argumentos el " + &
								"primero solo puede ser 'string' o 'number' y" + &
								" no '" + istr_argInformation.argType[1] + &
								"'", StopSign!)
		end choose // case 4 args for the dw

	case 5 // args to the dw
		choose case istr_argInformation.argType[1]
			case "string"
				choose case istr_argInformation.argType[2]
					case "string"
						return uf_retrieve_stringString(istr_argInformation.stringValue[1], istr_argInformation.stringValue[2])
					case "number"
						return uf_retrieve_stringNumber(istr_argInformation.stringValue[1], istr_argInformation.numberValue[2])
					case else
						messageBox("Error interno", "Si se dan 5 argumentos " +&
								"el segundo solo puede ser 'string' o 'number'" +&
								" y no '" + &
								istr_argInformation.argType[2] + "'", &
								StopSign!)
				end choose // case 5 args for the dw
			case "number"
				choose case istr_argInformation.argType[2]
					case "string"
						return uf_retrieve_numberString(istr_argInformation.numberValue[1], istr_argInformation.stringValue[2])
					case "number"
						return uf_retrieve_numberNumber(istr_argInformation.numberValue[1], istr_argInformation.numberValue[2])
					case else
						messageBox("Error interno", "Si se dan 5 argumentos " +&
								"el segundo solo puede ser 'string' o 'number'" +&
								" y no '" + &
								istr_argInformation.argType[2] + "'", &
								StopSign!)
				end choose // case 5 args for the dw
			case else
				messageBox("Error interno", "Si se dan 5 argumentos el " + &
								"primero solo puede ser 'string' o 'number' y" + &
								" no '" + istr_argInformation.argType[1] + &
								"'", StopSign!)
		end choose // case 5 args for the dw

	case else
		messageBox("Error interno", "El n$$HEX1$$fa00$$ENDHEX$$mero de argumentos (" + &
								string(istr_argInformation.nrArgs) + &
									") debe estar entre 0 y 5", StopSign!)
		return -1
end choose

return -1
end function

public function integer uf_retrieve ();return this.uf_retrieve_basic()

end function

private function integer uf_setautoincrementaldetail (string as_columnname, string as_buffer);dwBuffer ldw_buffer
long ll_row
long ll_nextCode

if as_buffer = "Primary!" then
	ldw_buffer = Primary!
elseif as_buffer = "Filter!" then
	messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
						"Tipo de buffer '" + as_buffer + "' a$$HEX1$$fa00$$ENDHEX$$n no implantado", StopSign!)
	return -1
//	ldw_buffer = Filter!
else
	messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
						"Tipo de buffer '" + as_buffer + "' desconocido", StopSign!)
	return -1
end if
ll_nextcode = this.getNextModified(ll_row, ldw_buffer)
do while True
	ll_row = this.getNextModified(ll_row, ldw_buffer)
	if ll_row < 1 then exit
	if this.getItemStatus(ll_row, 0, ldw_buffer) <> newModified! then continue

	if this.setItem(ll_row, as_columnName, string(ll_nextCode)) <> 1 then
		messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado" ,&
						"' en la columna '" + &
						as_columnName + "'", StopSign!)
		return -1
   end if
  ll_nextcode ++
loop

return 1

end function

public function integer uf_retrieve_enhanced ();SetTransObject(sqlca)

choose case istr_argInformation.nrArgs
	case 0
		return retrieve()
	case 1
		return retrieve(istr_argInformation.stringValue[1])
	case 2
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2])
	case 3
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3])
	case 4
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3],istr_argInformation.stringValue[4])
	case 5
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3],istr_argInformation.stringValue[4],istr_argInformation.stringValue[5])
	case 6
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3],istr_argInformation.stringValue[4],istr_argInformation.stringValue[5],istr_argInformation.stringValue[6])
	case 7
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3],istr_argInformation.stringValue[4],istr_argInformation.stringValue[5],istr_argInformation.stringValue[6],istr_argInformation.stringValue[7])
	case 8
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3],istr_argInformation.stringValue[4],istr_argInformation.stringValue[5],istr_argInformation.stringValue[6],istr_argInformation.stringValue[7],istr_argInformation.stringValue[8])
	case 9
		return retrieve(istr_argInformation.stringValue[1],istr_argInformation.stringValue[2],istr_argInformation.stringValue[3],istr_argInformation.stringValue[4],istr_argInformation.stringValue[5],istr_argInformation.stringValue[6],istr_argInformation.stringValue[7],istr_argInformation.stringValue[8],istr_argInformation.stringValue[9])
	case else
		messageBox("Error interno", "El n$$HEX1$$fa00$$ENDHEX$$mero de argumentos (" + &
					  string(istr_argInformation.nrArgs) + &
					  ") debe estar entre 0 y 9", StopSign!)
		return -1
end choose

return -1
end function

private function integer uf_setautoincrementalcode (string as_codecompany, string as_columnname, string as_codetype, string as_buffer);dwBuffer ldw_buffer
string   ls_tipo_dato, ls_sucursal
long 		ll_row
long 		ll_nextCode

if as_buffer = "Primary!" then
	ldw_buffer = Primary!
elseif as_buffer = "Filter!" then
	messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
						"Tipo de buffer '" + as_buffer + "' a$$HEX1$$fa00$$ENDHEX$$n no implantado", StopSign!)
	return -1
//	ldw_buffer = Filter!
else
	messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
						"Tipo de buffer '" + as_buffer + "' desconocido", StopSign!)
	return -1
end if

do while True
	ll_row = this.getNextModified(ll_row, ldw_buffer)
	if ll_row < 1 then exit
	if this.getItemStatus(ll_row, 0, ldw_buffer) <> newModified! then continue

	if  is_serialCodeCompany <> "" then
			 select pr_valor,pr_tipo, pr_sucursal
			 into :ll_nextCode, :ls_tipo_dato, :ls_sucursal
			 from pr_param
			 where pr_nombre = :as_codeType 
			 and em_codigo = :as_codeCompany 
			 for  update of  pr_valor
			 using sqlca;
			 if sqlca.sqlcode <> 0 then
				  messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
								 "No puedo obtener nuevo c$$HEX1$$f300$$ENDHEX$$digo tipo '" + &
									as_codeType + "' para la columna '" + &
									as_columnName + "' de la compa$$HEX2$$f100ed00$$ENDHEX$$a '" + &
									as_codeCompany + "'", StopSign!)
				  return -1
			  end if
	  		  if isnull(ls_tipo_dato) then ls_tipo_dato = 'STRING'
	  		  if isnull(ls_sucursal) then ls_sucursal = 'N'
			  if ls_sucursal = 'S' then //quiere nuemerar por sucursal
					select ps_valor
					 into :ll_nextCode 
					 from pr_numsuc
					 where em_codigo = :as_codeCompany
					 and su_codigo = :str_appgeninfo.sucursal
					 and pr_nombre = :as_codeType
					 for update of ps_valor
					 using sqlca;
				       if sqlca.sqlcode <> 0 then
					  messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
									 "No puedo obtener nuevo c$$HEX1$$f300$$ENDHEX$$digo tipo '" + &
										as_codeType + "' para la columna '" + &
										as_columnName + "' de la compa$$HEX2$$f100ed00$$ENDHEX$$a '" + &
										as_codeCompany + "'" + "' de la sucursal '" + &
										str_appgeninfo.sucursal + "'", StopSign!)
					  return -1
				      end if
					  update pr_numsuc
					  set ps_valor = :ll_nextCode + 1
					  where em_codigo = :as_codeCompany
					  and su_codigo = :str_appgeninfo.sucursal
					  and pr_nombre = :as_codeType
					  using sqlca;		  
			  else //no es por sucursal
				  update pr_param 
				  set pr_valor = :ll_nextCode + 1
				  where pr_nombre = :as_codeType
				  and em_codigo = :as_codeCompany 
				  using sqlca;
			end if
	else
		  select pr_valor
		  into :ll_nextCode 
		  from pr_param
		  where pr_nombre = :as_codeType
		  for update of pr_valor
		 using sqlca;
		  if sqlca.sqlcode <> 0 then
			  messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
							 "No puedo obtener nuevo c$$HEX1$$f300$$ENDHEX$$digo tipo '" + &
								as_codeType + "' para la columna '" + &
								as_columnName + "' de la compa$$HEX2$$f100ed00$$ENDHEX$$a '" + &
								as_codeCompany + "'", StopSign!)
			  return -1
		  end if
		  update pr_param 
		  set pr_valor = :ll_nextCode + 1
		  where pr_nombre = :as_codeType
		  using sqlca;		
	end if

 if ls_tipo_dato = 'STRING' then
	if this.setItem(ll_row, as_columnName, string(ll_nextCode)) <> 1 then
		messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
						"No puedo poner el c$$HEX1$$f300$$ENDHEX$$digo tipo '" + &
						as_codeType + "' en la columna '" + &
						as_columnName + "'", StopSign!)
		return -1
   end if
elseif ls_tipo_dato = 'NUMBER' then
	if this.setItem(ll_row, as_columnName, ll_nextCode) <> 1 then
		messageBox("Error de C$$HEX1$$f300$$ENDHEX$$digo Autoincrementado", &
						"No puedo poner el c$$HEX1$$f300$$ENDHEX$$digo tipo '" + &
						as_codeType + "' en la columna '" + &
						as_columnName + "'", StopSign!)
		return -1
   end if	
end if
//// Fin del codigo sin SP

loop

return 1

end function

public function integer uf_sort ();string ls_null
integer li_res

setNull(ls_null)
li_res = this.setSort(ls_null)
if li_res = 1 then
	return this.sort()
else
	return li_res
end if

end function

public function integer uf_deletecurrentrow ();int li_res
long ll_curRow

ll_curRow = this.getRow()
if ll_curRow < 1 then
	beep(1)
	return -1
end if

//li_res = messageBox("Por favor confirme","$$HEX1$$bf00$$ENDHEX$$Desea borrar la fila actual?",&
//							Question!, YesNo!, 2)
//
//if li_res <> 1 then return -1
//

this.triggerEvent("ue_preDelete")		// this event must touch ii_deleteFlag
if this.ii_deleteFlag = 1 then
	li_res = this.deleteRow(ll_curRow)
	if li_res <> 1 then return li_res
	this.triggerEvent("ue_postDelete") // this event may touch ii_deleteFlag
end if

return this.ii_deleteFlag
end function

public function integer uf_filter ();string ls_null
integer li_res

setNull(ls_null)
li_res = this.SetFilter(ls_null)
if li_res = 1 then
	This.Filter()
	return This.groupcalc()
else
	return li_res
end if

end function

public function integer uf_active (boolean ab_flag);/*Active column depending of flag
ab_flag = true :Active 
ab_flag = false :Inactive*/
integer li_protect,i
String ls_colname,ls_criterio

If ab_flag then
	li_protect = 0
else
	li_protect = 1
end if

for i = 1 to ii_nrocolsAct
ls_colname = is_activeCols[i]
ls_criterio = ls_colname+".protect = "+string(li_protect)
This.Modify(ls_criterio)
next

return 1

end function

public function integer uf_changebackground (boolean ab_flag, long al_activecolor, long al_inactivecolor);/*Active column depending of flag
ab_flag = true :ActiveColor 
ab_flag = false :InactiveColor*/

int i
String ls_colname,ls_criterio
Long ll_colorback

If ab_flag then
	ll_colorback = al_activecolor
else
	ll_colorback = al_inactivecolor
end if

for i = 1 to ii_nrocolsAct
ls_colname = is_activeCols[i]
ls_criterio = ls_colname+".background.color= "+string(ll_colorback)
This.Modify(ls_criterio)
next

return 1

end function

event dberror;long ll_filaError
string ls_mensaje
dwBuffer lb_bufferError

ll_filaError = row
lb_bufferError = buffer
// this.getUpdateStatus( ll_filaError, lb_bufferError)
choose case lb_bufferError
	case Primary!
		this.scrollToRow(ll_filaError)
	case Filter!
//		messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n", "La fila que caus$$HEX2$$f3002000$$ENDHEX$$el error est$$HEX2$$e1002000$$ENDHEX$$filtrada", StopSign!)
	case Delete!
//		messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n", "La fila que caus$$HEX2$$f3002000$$ENDHEX$$el error est$$HEX2$$e1002000$$ENDHEX$$borrada", StopSign!)
end choose

CHOOSE CASE sqldbcode
	CASE 1400
		ls_mensaje = 'Informaci$$HEX1$$f300$$ENDHEX$$n Obligatoria faltante.' +sqlerrtext
	CASE 2291
		ls_mensaje = 'Error de integridad de la informaci$$HEX1$$f300$$ENDHEX$$n. Clave for$$HEX1$$e100$$ENDHEX$$nea no existe ' +sqlerrtext
	CASE 1
		ls_mensaje = 'Error de clave primaria. C$$HEX1$$f300$$ENDHEX$$digo $$HEX1$$fa00$$ENDHEX$$nico del registro ya existe ' +sqlerrtext
	CASE 2292
		ls_mensaje = 'Error el registro que se intenta borrar est$$HEX2$$e1002000$$ENDHEX$$referenciado por otros registros ' +sqlerrtext
	CASE ELSE
		ls_mensaje =sqlerrtext
END CHOOSE
ls_mensaje = ls_mensaje+ '. Cambios no registrados'

messageBox("Error de la base de datos "+string(sqldbcode), ls_mensaje, StopSign!)

return(1)

end event

event itemerror;if this.ib_inErrorCascade then
	this.ib_inErrorCascade = False
	return(1)
else
	this.ib_inErrorCascade = True
	this.setFocus()
end if
end event

event itemfocuschanged;string ls_helpText
powerObject lp_object
window lw_parent
window lw_frame

ls_helpText = this.describe(this.getColumnName()+".tag")
if ls_helpText = "?" then
	ls_helpText = ""		// if there$$HEX1$$b400$$ENDHEX$$s no tag value, make it empty
end if
lp_object = this.GetParent()
lp_object = lp_object.GetParent()
if not isValid(lp_object) then
	lw_parent = parent
	lw_frame = lw_parent.ParentWindow()
  if isValid(lw_frame) then
	  if lw_frame.windowType = MDIHelp! then lw_frame.setMicroHelp(ls_helpText)
  end if
else
	lw_parent = lp_object.GetParent()
	lw_frame = lw_parent.ParentWindow()
  if isValid(lw_frame) then
	  if lw_frame.windowType = MDIHelp! then lw_frame.setMicroHelp(ls_helpText)
 end if	
end if
end event

event losefocus;this.postEvent("ue_accepttext")

end event

event updatestart;dwItemStatus    l_status
integer li_colnbr = 1
long ll_row = 1
string ls_colname, ls_textname,ls_res
int li_res

//Actualizamos el campo de estado del registro actual
ls_res = this.Describe("estado.ColType")
if ls_res <> "!" then
  l_status = this.GetItemStatus(this.GetRow(),0,Primary!)
  if l_status = New! or l_status = NewModified! then
	  this.SetItem(this.GetRow(),"estado",'N')
  elseif l_status = DataModified! then
	  this.SetItem(this.GetRow(),"estado",'A')
  end if
end if

// Make sure the last entry is accepted
if this.acceptText() = -1 then
	this.SetFocus()
	return(1)
end if

// Find the first empty row and column, if any
if this.findRequired(Primary!, ll_row, li_colnbr,ls_colname,True) < 0 then
	//If the search fails due to an error, then return
	return(1)
end if

// Was any row found?
if ll_row <> 0 then
	// Get the text of that column's label.
	//ls_textname = ls_colname + "_t.Text"
	//ls_colname = this.describe(ls_textname)

	// Make the problem column current.
	this.setColumn(li_colnbr)
	this.scrollToRow(ll_row)
	this.setFocus()

	// Tell the user which column to fill in.
	f_error("Valor Obligatorio Faltante", &
				"Por favor ingrese un valor para '"	+ ls_colname + &
						"', fila " + string(ll_row) + ".", &
				"datawindow", "error", "")
	return(1)
end if

if this.is_serialCodeColumn <> "" and this.is_serialCodeType <> "" then
	li_res = this.uf_setAutoIncrementalCode(this.is_serialCodeCompany, &
												this.is_serialCodeColumn, &
												this.is_serialCodeType, "Primary!")
	if li_res <> 1 then
		return(1)
	end if
//	this.uf_setAutoIncrementalCode(this.ii_serialCodeCompany, &
//												this.is_serialCodeColumn, &
//												this.is_serialCodeType, "Filter!")
end if

if this.is_serialCodeDetail <> "" then
	li_res = this.uf_setAutoIncrementaldetail(this.is_serialCodeDetail,"Primary!")
	if li_res <> 1 then
		return(1)
	end if	
end if

end event

on uo_dw_basic.create
end on

on uo_dw_basic.destroy
end on

