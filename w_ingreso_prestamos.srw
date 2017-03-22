HA$PBExportHeader$w_ingreso_prestamos.srw
$PBExportComments$Si.
forward
global type w_ingreso_prestamos from w_sheet_1_dw_maint
end type
type dw_2 from datawindow within w_ingreso_prestamos
end type
type st_1 from statictext within w_ingreso_prestamos
end type
type dw_3 from datawindow within w_ingreso_prestamos
end type
type st_2 from statictext within w_ingreso_prestamos
end type
type st_3 from statictext within w_ingreso_prestamos
end type
type rb_1 from radiobutton within w_ingreso_prestamos
end type
type rb_2 from radiobutton within w_ingreso_prestamos
end type
end forward

global type w_ingreso_prestamos from w_sheet_1_dw_maint
integer width = 2976
integer height = 1872
string title = "Ingreso de pr$$HEX1$$e900$$ENDHEX$$stamos"
long backcolor = 67108864
dw_2 dw_2
st_1 st_1
dw_3 dw_3
st_2 st_2
st_3 st_3
rb_1 rb_1
rb_2 rb_2
end type
global w_ingreso_prestamos w_ingreso_prestamos

type variables
datawindowchild   idwc_tipo,idwc_rubro
string is_tipo,is_rubro
end variables

on w_ingreso_prestamos.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_3=create dw_3
this.st_2=create st_2
this.st_3=create st_3
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
end on

on w_ingreso_prestamos.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;String ls_tipo = 'P'

ib_notautoretrieve = true

//dw_1.insertrow(0)
//dw_1.getchild("tp_codigo",idwc_tipo)
//idwc_tipo.settransobject(sqlca)
//idwc_tipo.retrieve()
dw_2.insertrow(0)
dw_2.getchild("ru_codigo",idwc_rubro)
idwc_rubro.settransobject(sqlca)
idwc_rubro.retrieve(ls_tipo)

dw_3.insertrow(0)
call super::open
end event

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.empresa)
end event

event ue_update;Integer      i,j,li_cuotas
Long         ll_nreg,ll_secuencial
Decimal    lc_valor
String       ls_epcodigo,ls_tpcodigo,ls_rucodigo,ls_obs
Date         ld_fecha 


SetPointer(Hourglass!)

dw_datos.AcceptText()

if rb_1.checked then ls_tpcodigo = 'P'
if rb_2.checked then ls_tpcodigo = 'D'

//ls_tpcodigo = dw_1.Object.tp_codigo[1]
ls_rucodigo = dw_2.Object.ru_codigo[1]

SELECT PR_VALOR
INTO :ll_secuencial
FROM PR_PARAM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND PR_NOMBRE = 'PRESTAMO';

If sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede encontrar el secuencial para pr$$HEX1$$e900$$ENDHEX$$stamos"+sqlca.sqlerrtext)
	Rollback;
	return
end if

ll_nreg = dw_datos.rowcount()

for i = 1 to ll_nreg
	
	ls_epcodigo  =  dw_datos.object.ep_codigo[i]
	ld_fecha        = date(dw_datos.object.fecha[i])
     li_cuotas       =  dw_datos.object.n_cuotas[i]
	lc_valor         =  dw_datos.object.valor[i]
	ls_obs           =  dw_datos.object.observacion[i]

	If   lc_valor <> 0 then
          ll_secuencial = ll_secuencial + 1		
		
		dw_datos.object.nro[i] = ll_secuencial
		INSERT INTO NO_PRESTAMO( EP_CODIGO,      
                                                                    PP_NUMERO ,     
													   RU_CODIGO,      
                										   PP_FECHA ,      
													   PP_CUOTAS ,     
													   PP_VALOR,       
													   PP_SALDO ,      
													   PP_INTERES,
													   TP_CODIGO,      
													   PP_ESTADO,      
													   PP_OBSERV,      
            											   ESTADO )
		VALUES(:ls_epcodigo,:ll_secuencial,:ls_rucodigo,:ld_fecha,:li_cuotas,:lc_valor,:lc_valor,0,:ls_tpcodigo,'P',:ls_obs,null);														
		
		If sqlca.sqlcode < 0 Then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al crear el pr$$HEX1$$e900$$ENDHEX$$stamo"+sqlca.sqlerrtext)
		Rollback;
		Return
		End if
		
		
		for j = 1 to li_cuotas
			
			INSERT INTO NO_DETPAG(EP_CODIGO, 
			                                                   PP_NUMERO,      
													 DP_NUMERO,      
													 DP_VALCUO,      
													 DP_FECPAG,      
													 DP_CUOCANC,
													 ESTADO )
			VALUES (:ls_epcodigo,:ll_secuencial,:j,:lc_valor/:li_cuotas,:ld_fecha,'N',null);																		 
			If sqlca.sqlcode< 0 Then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al asignar las cuotas "+sqlca.sqlerrtext)
			Rollback;
			Return
			End if
			ld_fecha = relativedate(ld_fecha,30)		
     	next

	end if
next

update pr_param
set pr_valor = :ll_secuencial
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'PRESTAMO';

If sqlca.sqlcode< 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el secuencial "+sqlca.sqlerrtext)
Rollback;
Return
End if


commit;
w_marco.SetMicrohelp("Pr$$HEX1$$e900$$ENDHEX$$stamos ingresados .....Listo!!! ")
SetPointer(Arrow!)
end event

event resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
else
	ldw_aux = dw_datos
end if

ldw_aux.resize(this.workSpaceWidth() - 1*ldw_aux.x, this.workSpaceHeight() - 1*ldw_aux.y)

end event

event closequery;return
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ingreso_prestamos
integer x = 23
integer y = 412
integer width = 2894
integer height = 1356
integer taborder = 40
string dataobject = "d_ingreso_prestamos"
end type

event dw_datos::doubleclicked;call super::doubleclicked;Decimal{2} lc_valor
Long ll_nreg
Int      i
String ls_obs
ll_nreg = this.rowcount()


If dwo.name = 'valor' &
Then
	lc_valor = this.object.valor[row]
	for i = row to ll_nreg
	this.object.valor[i] = lc_valor
	next	
End if

If dwo.name = 'nro_cuotas' &
Then
	lc_valor = this.object.nro_cuotas[row]
	for i = row to ll_nreg
	this.object.nro_cuotas[i] = lc_valor
	next	
End if

If dwo.name = 'observacion' &
Then
	ls_obs = this.object.observacion[row]
	for i = row to ll_nreg
	this.object.observacion[i] = ls_obs
	next	
End if
end event

event dw_datos::itemchanged;call super::itemchanged;if dwo.name = 'valor'  and  dec(data) > 0 then
this.object.n_cuotas[row] = 1
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ingreso_prestamos
integer x = 1216
integer y = 920
integer taborder = 50
end type

type dw_2 from datawindow within w_ingreso_prestamos
integer x = 1399
integer y = 104
integer width = 1061
integer height = 80
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_rubroxtipo"
boolean border = false
boolean livescroll = true
end type

event itemfocuschanged;//String ls_tipo,ls_estado
//
//ls_tipo = dw_1.Object.tp_codigo[1]
//
//select  estado
//into    :ls_estado
//from    no_tippres
//where tp_codigo = :ls_tipo;
//
//dw_2.getchild("ru_codigo",idwc_rubro)
//idwc_rubro.SetTransobject(sqlca)
//idwc_rubro.retrieve(ls_estado)
end event

type st_1 from statictext within w_ingreso_prestamos
integer x = 1413
integer y = 28
integer width = 192
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
string text = "Rubro"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_ingreso_prestamos
integer x = 87
integer y = 280
integer width = 1184
integer height = 92
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sle"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;string ls_data
long ll_nreg,ll_find



if not isnull(data )and data<>"" then
ls_data = data+'%'
else 
Setnull(ls_data)
end if

ll_nreg = dw_datos.rowcount()
ll_find = dw_datos.find("cc_empleado like'"+ls_data+"'",1,ll_nreg)
if ll_find <> 0 then
dw_datos.selectrow(0,false)
dw_datos.scrolltorow(ll_find)
//dw_datos.selectrow(ll_find,true)
dw_datos.Setrow(ll_find)
else	
dw_datos.selectrow(0,false)
dw_datos.Setrow(0)
end if
end event

type st_2 from statictext within w_ingreso_prestamos
integer x = 87
integer y = 216
integer width = 375
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
string text = "Ubicar empleado"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ingreso_prestamos
integer x = 87
integer y = 28
integer width = 160
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
string text = "Tipo"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_ingreso_prestamos
integer x = 69
integer y = 104
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pr$$HEX1$$e900$$ENDHEX$$stamo"
end type

type rb_2 from radiobutton within w_ingreso_prestamos
integer x = 407
integer y = 104
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descuento"
end type

