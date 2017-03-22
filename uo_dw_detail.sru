HA$PBExportHeader$uo_dw_detail.sru
$PBExportComments$Basic detail window
forward
global type uo_dw_detail from uo_dw_basic
end type
end forward

global type uo_dw_detail from uo_dw_basic
boolean border = true
borderstyle borderstyle = stylelowered!
end type
global uo_dw_detail uo_dw_detail

type variables
//int ii_nrArgs		// # of retrieval args of this window
//any ia_args[5]		// retrieval args of this window
string is_connectionCols[6] 	// names of the cols that connect
			// this dw with its master
uo_dw_master_basic idw_master	// master dw of this dw
boolean ib_nullsInConnection
end variables

forward prototypes
public function integer uf_setautocolumns (long al_masterrow)
public function integer uf_retrieve (long al_masterrow)
public function integer uf_setargvalues (long al_masterrow)
public function integer uf_setargtypes ()
end prototypes

public function integer uf_setautocolumns (long al_masterrow);// this functions copies the common columns from the master
// (usually the primary key of the master), it also sets the
// autonumbered column of this detail (if it exists)

long ll_totalRows
int li_col
dwItemStatus ldwis_colStatus
boolean lb_masterColsChanged
long ll_row
string ls_colName
boolean lb_autoIncrementalCode
long ll_serialCode

ll_totalRows = this.rowCount()

// find out if any of the connection cols of the master has changed
for li_col = 1 to this.idw_master.ii_nrCols
	ldwis_colStatus = this.idw_master.getItemStatus(al_masterRow, &
								this.idw_master.is_connectionCols[li_col], Primary!)
	if ldwis_colStatus = DataModified! or ldwis_colStatus = NewModified! then
		lb_masterColsChanged = True
		exit
	end if
next

this.uf_setArgValues(al_masterrow)

// Scan each row in the detail and copy the connection cols from the master
for ll_row = 1 to ll_totalRows
	ldwis_colStatus = this.getItemStatus(ll_row, 0, Primary!)
	if ldwis_colStatus = New! or &
		(ldwis_colStatus = NotModified! and not lb_masterColsChanged) then
		continue
	end if
	for li_col = 1 to this.idw_master.ii_nrCols
		ls_colName = this.is_connectionCols[li_col]
		choose case this.istr_argInformation.argType[li_col]
			case "string"
				this.setItem(ll_row, ls_colName, &
								this.istr_argInformation.stringValue[li_col])
			case "number"
				this.setItem(ll_row, ls_colName, &
								this.istr_argInformation.numberValue[li_col])
			case "date"
				this.setItem(ll_row, ls_colName, &
								this.istr_argInformation.dateValue[li_col])
			case "datetime"
				this.setItem(ll_row, ls_colName, &
								this.istr_argInformation.dateTimeValue[li_col])
			case else
				messageBox("Error interno", "Tipo de campo '" + &
								istr_argInformation.argType[li_col] + &
								"' no soportado en la columna '" + &
								this.idw_master.is_connectionCols[li_col] + &
								"' del maestro", StopSign!)
				return -1
		end choose
	next
next

// now set the autoincremental code for every row in the detail
if this.is_serialCodeColumn <> "" then
	for ll_row = 1 to ll_totalRows
		choose case this.getItemStatus(ll_row, 0, Primary!)
			case New!
				continue
			case NewModified!, DataModified!
				this.setItem(ll_row, this.is_serialCodeColumn, ll_row)
			case NotModified!
				ll_serialCode = this.getItemNumber(ll_row, this.is_serialCodeColumn)
				if ll_serialCode <> ll_row then
					this.setItem(ll_row, this.is_serialCodeColumn, ll_row)
				end if
		end choose
	next
end if

return 1

end function

public function integer uf_retrieve (long al_masterrow);if this.idw_master.getItemStatus(al_masterRow,0,Primary!) = New! then
	return this.reset()
end if

this.uf_setArgValues(al_masterRow)
if this.ib_nullsInConnection then
	return this.reset()
else
	if this.idw_master.ii_nrCols > 5 then
		return this.uf_retrieve_enhanced()
	else
		return this.uf_retrieve_basic()
	end if
end if

end function

public function integer uf_setargvalues (long al_masterrow);int li_col
string ls_colName



if al_masterRow = 0 then return  -1

// Get the value of the master columns
for li_col = 1 to this.idw_master.ii_nrCols
	ls_colName = this.idw_master.is_connectionCols[li_col]
	choose case this.istr_argInformation.argType[li_col]
		case "string" 
			istr_argInformation.stringValue[li_col] = this.idw_master.getItemString(al_masterRow, ls_colName)
			ib_nullsInConnection = isNull(istr_argInformation.stringValue[li_col])
		case "number"
			istr_argInformation.numberValue[li_col] = this.idw_master.getItemNumber(al_masterRow, ls_colName)
			ib_nullsInConnection = isNull(istr_argInformation.numberValue[li_col])
		case "date"
			istr_argInformation.dateValue[li_col] = 	this.idw_master.getItemDate(al_masterRow, ls_colName)
			ib_nullsInConnection = isNull(istr_argInformation.dateValue[li_col])
		case "datetime"
			istr_argInformation.dateTimeValue[li_col] = this.idw_master.getItemDateTime(al_masterRow, ls_colName)
			ib_nullsInConnection = isNull(istr_argInformation.dateValue[li_col])
		case else
			messageBox("Error interno", "Tipo de campo '" + &
									this.istr_argInformation.argType[li_col] + &
									"' no soportado en la columna '" + &
									this.idw_master.is_connectionCols[li_col] + &
									"' del maestro", StopSign!)
			return -1
	end choose
next

return 1

end function

public function integer uf_setargtypes ();int li_col
string ls_colType

this.istr_argInformation.nrArgs = this.idw_master.ii_nrCols

// Get the type and value of the master columns
if this.istr_argInformation.nrArgs > 6 then
	for li_col = 1 to this.istr_argInformation.nrArgs
		this.istr_argInformation.argType[li_col] = "string"
	next
else
  for li_col = 1 to this.istr_argInformation.nrArgs
	  ls_colType = lower(left(this.idw_master.Describe( &
				  this.idw_master.is_connectionCols[li_col]+".Coltype"), 5))
	  choose case ls_colType
		  case "char("
			  this.istr_argInformation.argType[li_col] = "string"
		  case "long"
			  this.istr_argInformation.argType[li_col] = "number"
        case "decim"
           this.istr_argInformation.argType[li_col] = "number"
		  case "numbe"
			  this.istr_argInformation.argType[li_col] = "number"
		  case "date"
			  this.istr_argInformation.argType[li_col] = "date"
		  case "datet", "times"
			  this.istr_argInformation.argType[li_col] = "datetime"
		  case else
			  messageBox("Error interno", "Tipo de campo '" + ls_colType + &
							  "' no soportado para la columna de conexi$$HEX1$$f300$$ENDHEX$$n " + &
							  string(li_col), StopSign!)
			  return -1
	  end choose
  next
end if
return 1

end function

on uo_dw_detail.create
call super::create
end on

on uo_dw_detail.destroy
call super::destroy
end on

