HA$PBExportHeader$w_actualiza_rol_x_rubro2.srw
$PBExportComments$Si.Actualmente en uso Para actualizar los valores de los rubros que se ingresan manualmente o requieren un ajuste.
forward
global type w_actualiza_rol_x_rubro2 from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_actualiza_rol_x_rubro2
end type
type em_1 from editmask within w_actualiza_rol_x_rubro2
end type
type st_1 from statictext within w_actualiza_rol_x_rubro2
end type
type st_2 from statictext within w_actualiza_rol_x_rubro2
end type
type dw_2 from datawindow within w_actualiza_rol_x_rubro2
end type
type st_3 from statictext within w_actualiza_rol_x_rubro2
end type
type dw_3 from datawindow within w_actualiza_rol_x_rubro2
end type
end forward

global type w_actualiza_rol_x_rubro2 from w_sheet_1_dw_maint
integer width = 3730
integer height = 1996
string title = "Actualizaci$$HEX1$$f300$$ENDHEX$$n de Rol por rubro"
dw_1 dw_1
em_1 em_1
st_1 st_1
st_2 st_2
dw_2 dw_2
st_3 st_3
dw_3 dw_3
end type
global w_actualiza_rol_x_rubro2 w_actualiza_rol_x_rubro2

type variables
decimal ic_factor_iess
end variables

on w_actualiza_rol_x_rubro2.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.dw_2=create dw_2
this.st_3=create st_3
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_3
end on

on w_actualiza_rol_x_rubro2.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.dw_3)
end on

event open;ib_notautoretrieve = true
dw_1.insertrow(0)
f_recupera_empresa(dw_1,"ru_codigo")
dw_1.SetItem(1,"ru_codigo",18)
dw_2.insertrow(0)

dw_3.insertrow(0)
f_recupera_empresa(dw_3,"sucursal")
dw_datos.Sharedata(dw_report)

select nvl(rc_porcen/100,0.0935)
into   :ic_factor_iess
from no_rubcal
where ru_codigo = '18';

If sqlca.sqlcode <> 0 then
ic_factor_iess = 0.0935	
end if 


call super::open

end event

event ue_retrieve;String   ls_rucodigo,ls_sucodigo
String   ls_periodo

ls_rucodigo = dw_1.Object.ru_codigo[1]
ls_periodo  = string(em_1.text)
ls_sucodigo = dw_3.Object.sucursal[1]

if dw_datos.retrieve(str_appgeninfo.empresa,ls_rucodigo,ls_periodo,ls_sucodigo) = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha generado para este per$$HEX1$$ed00$$ENDHEX$$odo el rol $$HEX2$$f3002000$$ENDHEX$$no se ha generado el rubro")
	return
end if

end event

event ue_update;Int rc,i
Long ll_nreg
String ls_epcodigo,ls_nrol,ls_periodo
decimal lc_aporte_iess


Setpointer(Hourglass!)
ll_nreg =  dw_datos.rowcount()
ls_periodo = em_1.text 

rc = dw_datos.Update(TRUE,FALSE)
IF rc = 1 THEN		  	
		 /*Actualizar el Rubro de Aporte al iess cada vez que un rubro que aporta al iess es modificado*/	  
		for i = 1 to  ll_nreg
				if dw_datos.object. cc_estado[i] <> "notmodified!" then
				ls_epcodigo       =  dw_datos.Object.ep_codigo[i]
				ls_nrol                =  dw_datos.Object.rr_codigo[i]
				
				if  f_rubro_iess(ls_epcodigo,ls_periodo,ls_nrol,ic_factor_iess) < 0 then
				MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el rubro de aporte al iess "+sqlca.sqlerrtext)
				Rollback;
				return
				end if		
				
				if f_calcula_rol(ls_epcodigo,ls_periodo,ls_nrol) < 0 then
				MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el Rol " +sqlca.sqlerrtext)
				Rollback;
				return	
				end if
				end if
		next
ELSE
MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Actualizaci$$HEX1$$f300$$ENDHEX$$n de la tabla Rol fall$$HEX1$$f300$$ENDHEX$$.")
ROLLBACK ;
END IF
COMMIT ;
dw_datos.resetupdate();
Setpointer(Arrow!)
w_marco.Setmicrohelp("Listo....")
end event

event resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
else
	ldw_aux = dw_datos
end if

ldw_aux.resize(this.workSpaceWidth(),this.workSpaceHeight() - 350)
end event

event close;call super::close;dw_datos.SharedataOff()
end event

event ue_print;call super::ue_print;dw_report.Modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualiza_rol_x_rubro2
integer x = 55
integer y = 392
integer width = 3589
integer height = 1452
integer taborder = 40
string dataobject = "d_act_rol_x_rubro_opcion2"
boolean border = true
boolean hsplitscroll = true
end type

event dw_datos::itemchanged;Decimal lc_valorhora,lc_numhora,lc_total
String ls_ioe,ls_sigla,ls_rucodigo
Char  lch_flag

dw_datos.AcceptText()

ls_rucodigo = dw_datos.Object.ru_codigo[row]
ls_ioe           = dw_datos.Object.no_rubro_ru_ioe[row]

if dwo.name = 'lq_valor'   and ( ls_rucodigo = '6'  or ls_rucodigo = '7') then
   lc_numhora = 	dw_datos.Object.lq_numhor[row]
   lc_total          = dec(data)*lc_numhora
  dw_datos.Object.lq_total[row] = lc_total
end if

if dwo.name = 'lq_numhor'  and ( ls_rucodigo = '6'  or ls_rucodigo = '7')  then
     lc_valorhora  = 	dw_datos.Object.lq_valor[row]
	lc_total           = dec(data)*lc_valorhora
     dw_datos.Object.lq_total[row] = lc_total
end if


//if ls_ioe = 'I' then
//dw_datos.Object.no_cabrol_rr_totingr[row] = dw_datos.Object.cc_ingresos[row]
//else
//dw_datos.Object.no_cabrol_rr_totegre[row] = dw_datos.Object.cc_egresos[row]	
//end if
//dw_datos.Object.no_cabrol_rr_liquido[row] = dw_datos.Object.cc_liquido[row]
end event

event dw_datos::updatestart;return 0
end event

event dw_datos::doubleclicked;call super::doubleclicked;Long i
Decimal lc_valor,lc_costunit

This.AcceptText()
If dwo.name = 'lq_valor' &
Then
	lc_valor = This.GetItemNumber(row,"lq_valor")
	for i = row to this.rowcount()
	this.setitem(i,"lq_valor",lc_valor)
	next
End if

If dwo.name = 'lq_numhor' &
Then
	lc_valor = This.GetItemNumber(row,"lq_numhor")
	for i = row to this.rowcount()
	this.setitem(i,"lq_numhor",lc_valor)
	next	
End if

If dwo.name = 'lq_total' &
Then
	lc_valor = This.GetItemNumber(row,"lq_total")
	for i = row to this.rowcount()
	this.setitem(i,"lq_total",lc_valor)
	next	
End if


end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualiza_rol_x_rubro2
integer x = 187
integer y = 428
integer width = 3575
integer height = 1368
integer taborder = 60
string dataobject = "d_rep_rol_x_rubro"
end type

type dw_1 from datawindow within w_actualiza_rol_x_rubro2
integer x = 521
integer y = 84
integer width = 1198
integer height = 76
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_rubros"
boolean border = false
boolean livescroll = true
end type

type em_1 from editmask within w_actualiza_rol_x_rubro2
integer x = 55
integer y = 84
integer width = 297
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##-####"
string displaydata = "12-2004~t12-2004/"
end type

type st_1 from statictext within w_actualiza_rol_x_rubro2
integer x = 59
integer y = 20
integer width = 215
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
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_actualiza_rol_x_rubro2
integer x = 521
integer y = 16
integer width = 183
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

type dw_2 from datawindow within w_actualiza_rol_x_rubro2
integer x = 55
integer y = 252
integer width = 1106
integer height = 88
integer taborder = 50
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

type st_3 from statictext within w_actualiza_rol_x_rubro2
integer x = 55
integer y = 196
integer width = 389
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
string text = "Ubicar empleado:"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_actualiza_rol_x_rubro2
integer x = 1774
integer y = 16
integer width = 1856
integer height = 340
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

