HA$PBExportHeader$w_importa_tablas_sistema.srw
forward
global type w_importa_tablas_sistema from w_response_basic
end type
type dw_nuevo from datawindow within w_importa_tablas_sistema
end type
type st_1 from statictext within w_importa_tablas_sistema
end type
type sle_1 from singlelineedit within w_importa_tablas_sistema
end type
end forward

global type w_importa_tablas_sistema from w_response_basic
integer width = 1458
integer height = 768
string title = "Seleccione la tabla a importar"
dw_nuevo dw_nuevo
st_1 st_1
sle_1 sle_1
end type
global w_importa_tablas_sistema w_importa_tablas_sistema

on w_importa_tablas_sistema.create
int iCurrent
call super::create
this.dw_nuevo=create dw_nuevo
this.st_1=create st_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_nuevo
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_1
end on

on w_importa_tablas_sistema.destroy
call super::destroy
destroy(this.dw_nuevo)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;call super::open;DataWindowChild  ldw_aux

dw_response.InsertRow(0)
dw_response.GetChild("tabla",ldw_aux)
ldw_aux.SetTransObject(sqlca)
ldw_aux.Retrieve()
end event

type pb_cancel from w_response_basic`pb_cancel within w_importa_tablas_sistema
integer x = 1010
integer y = 444
integer taborder = 40
end type

event pb_cancel::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_importa_tablas_sistema
integer x = 512
integer y = 436
integer taborder = 30
end type

event pb_ok::clicked;call super::clicked;string ls_tabla,ls_dw_syntax,ls_select,ls_error,ls_archivo
integer rtn

SetPointer(HourGlass!)
ls_tabla = upper(dw_response.GetItemString(dw_response.GetRow(),"tabla"))
ls_select = "SELECT * FROM "+ ls_tabla + " WHERE ESTADO = 'WWW'"
ls_dw_syntax = sqlca.SyntaxFromSQL(ls_select, "", ls_error)
If ls_error <> "" Then
	MessageBox("ERROR AL CREAR SQL", ls_error)
	Return
End If
ls_archivo = 'Archivos\' + ls_tabla+'.TXT'
dw_nuevo.Create(ls_dw_syntax)
dw_nuevo.SetTransObject(sqlca)
dw_nuevo.ImportFile(ls_archivo)
//rtn = dw_nuevo.Update()
//IF rtn = 1 AND sqlca.sqlnrows > 0 THEN
//		COMMIT USING SQLCA;
//ELSE
//		ROLLBACK USING SQLCA;
//		messagebox("Error","La Tabla no se import$$HEX2$$f3002000$$ENDHEX$$correctamente")
//		return
//END IF
SetPointer(Arrow!)
close(parent)

end event

type dw_response from w_response_basic`dw_response within w_importa_tablas_sistema
integer x = 283
integer y = 244
integer width = 1051
integer height = 96
integer taborder = 20
string dataobject = "d_sel_tabla_a_exportar"
end type

type dw_nuevo from datawindow within w_importa_tablas_sistema
boolean visible = false
integer x = 87
integer y = 696
integer width = 494
integer height = 140
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
end type

type st_1 from statictext within w_importa_tablas_sistema
integer x = 101
integer y = 128
integer width = 398
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Usuario (Owner):"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_importa_tablas_sistema
integer x = 512
integer y = 128
integer width = 416
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_owner
DataWindowChild  ldw_aux

ls_owner = sle_1.text
dw_response.GetChild("tabla",ldw_aux)
ldw_aux.SetTransObject(sqlca)
If not isnull(ls_owner) and ls_owner<> "TODOS"  then
	ldw_aux.setfilter("owner = '"+ls_owner+"'")
else
	ldw_aux.setfilter('')
End if
ldw_aux.SetRedraw(false)
ldw_aux.Filter()
ldw_aux.SetRedraw(true)





end event

