HA$PBExportHeader$w_ingresos_otros_roles.srw
$PBExportComments$Si.
forward
global type w_ingresos_otros_roles from w_sheet_1_dw_maint
end type
type cb_1 from commandbutton within w_ingresos_otros_roles
end type
type rb_1 from radiobutton within w_ingresos_otros_roles
end type
type rb_2 from radiobutton within w_ingresos_otros_roles
end type
type em_1 from editmask within w_ingresos_otros_roles
end type
type st_1 from statictext within w_ingresos_otros_roles
end type
type dw_1 from datawindow within w_ingresos_otros_roles
end type
type st_2 from statictext within w_ingresos_otros_roles
end type
type dw_detail from datawindow within w_ingresos_otros_roles
end type
type rb_3 from radiobutton within w_ingresos_otros_roles
end type
type st_3 from statictext within w_ingresos_otros_roles
end type
type rb_4 from radiobutton within w_ingresos_otros_roles
end type
end forward

global type w_ingresos_otros_roles from w_sheet_1_dw_maint
integer width = 3186
integer height = 1980
string title = ""
long backcolor = 67108864
boolean ib_notautoretrieve = true
cb_1 cb_1
rb_1 rb_1
rb_2 rb_2
em_1 em_1
st_1 st_1
dw_1 dw_1
st_2 st_2
dw_detail dw_detail
rb_3 rb_3
st_3 st_3
rb_4 rb_4
end type
global w_ingresos_otros_roles w_ingresos_otros_roles

type variables
Datawindowchild idwc_rubros

end variables

on w_ingresos_otros_roles.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_1=create em_1
this.st_1=create st_1
this.dw_1=create dw_1
this.st_2=create st_2
this.dw_detail=create dw_detail
this.rb_3=create rb_3
this.st_3=create st_3
this.rb_4=create rb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_detail
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.rb_4
end on

on w_ingresos_otros_roles.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.dw_detail)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.rb_4)
end on

event open;call super::open;
//f_recupera_empresa(dw_1,'ru_codigo')
em_1.text = string(today())
dw_1.getchild("ru_codigo",idwc_rubros)
idwc_rubros.SetTransObject(sqlca)
idwc_rubros.Retrieve(str_appgeninfo.empresa)

dw_1.insertrow(0)
dw_detail.SetTransobject(sqlca)


end event

event ue_update;/*Permitir el registro de los empleados que tienen valor > 0*/
Long ll_reg,i,ll_cod_max_rol,rc,ll_new
String ls_epcodigo,ls_rrcodigo,ls_tipo,ls_rucodigo
Datetime ld_fecha
Decimal lc_valor


If rb_1.checked then ls_tipo = 'I'
If rb_2.checked then ls_tipo = 'U'
If rb_3.checked then ls_tipo = 'L' /*Liquidaci$$HEX1$$f300$$ENDHEX$$n de todos los otros rubros*/
If rb_4.checked then ls_tipo = 'C' 

ls_rucodigo = dw_1.Object.ru_codigo[1]
ld_fecha = datetime(em_1.text)


ll_reg = dw_datos.rowcount() 
dw_datos.Setfilter("rr_totingr > 0")
dw_datos.filter()

dw_datos.RowsMove(1, dw_datos.Filteredcount(),Filter!,dw_datos,1, delete!)

dw_detail.reset()
for i = 1 to dw_datos.Rowcount()
	  ls_epcodigo =  dw_datos.getitemstring(i,"ep_codigo")
	  lc_valor = dw_datos.Object.rr_totingr[i]
	  SELECT nvl(max(to_number("NO_CABROL"."RR_CODIGO")),0)
       INTO  :ll_cod_max_rol
	  FROM  "NO_CABROL"  
	  WHERE "NO_CABROL"."EP_CODIGO" = :ls_epcodigo;
	  
	  If ll_cod_max_rol = 0 then
		ls_rrcodigo = '1'
      else
		ls_rrcodigo = string(ll_cod_max_rol + 1)
	  End if
	  dw_datos.Object.rr_codigo[i] = ls_rrcodigo
  	  dw_datos.Object.rr_liquido[i] = lc_valor
	  dw_datos.Object.rr_tipo[i] = ls_tipo
	  dw_datos.Object.rr_fecha[i] = ld_fecha
	  
	  
	  /*INSERTA EL DETALLE DEL RUBRO*/
	   ll_new = dw_detail.insertrow(0)
	  dw_detail.Object.ep_codigo[ll_new] = ls_epcodigo
	  dw_detail.Object.ru_codigo[ll_new] = ls_rucodigo
	  dw_detail.Object.lq_valor[ll_new] = lc_valor
	  dw_detail.Object.lq_numhor[ll_new] = 0
	  dw_detail.Object.rr_codigo[ll_new] = ls_rrcodigo
	  dw_detail.Object.lq_total[ll_new] = lc_valor

next


rc = dw_datos.update(true,false)
if rc = 1 then
	     rc =  dw_detail.update(true,false)
          if rc = 1 then
		dw_datos.resetupdate()
		dw_detail.resetupdate()
		else
		rollback;
		return
		end if
else
rollback;
return
end if
commit;

end event

event resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
else
	ldw_aux = dw_datos
end if

ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 380)
end event

event close;call super::close;return
end event

event closequery;call super::closequery;return
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ingresos_otros_roles
integer x = 5
integer y = 380
integer width = 3141
integer height = 1480
integer taborder = 50
string dataobject = "d_ingreso_otros_roles"
end type

event dw_datos::doubleclicked;call super::doubleclicked;Integer i
Long ll_nreg
Decimal lc_valor
String ls_dato
Date  ld_date

dw_datos.AcceptText()
ll_nreg = dw_datos.rowcount()

If dwo.name = 'rr_observ' then
	ls_dato = dw_datos.Object.rr_observ[row]  
for i  = row to ll_nreg
	dw_datos.Object.rr_observ[i] =  ls_dato 
next
end if
If dwo.name = 'rr_totingr' then
	lc_valor = dw_datos.Object.rr_totingr[row]  
for i  = row to ll_nreg
	dw_datos.Object.rr_totingr[i] =  lc_valor 
next
end if

end event

event dw_datos::updatestart;call super::updatestart;return
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ingresos_otros_roles
integer x = 2629
integer y = 1032
integer width = 466
integer height = 284
integer taborder = 30
end type

event dw_report::rbuttondown;call super::rbuttondown;return
end event

type cb_1 from commandbutton within w_ingresos_otros_roles
integer x = 2386
integer y = 108
integer width = 379
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar N$$HEX1$$f300$$ENDHEX$$mina"
end type

event clicked;//Ingreso de empleados para alimentar el tipo de Rubro Utilidades
Long ll_new,ll_valor
String ls_nombre,ls_epcodigo,ls_cscodigo,ls_sucodigo,ls_fecha
datetime ld_fecrol



Setpointer(Hourglass!)

SELECT nvl(max(rr_fecha),trunc(sysdate))
INTO :ld_fecrol
FROM no_cabrol r, no_emple e
WHERE r.ep_codigo = e.ep_codigo
and r.rr_tipo = 'P';

SELECT count(*)
INTO :ll_valor
FROM no_cabrol r, no_emple e
WHERE r.ep_codigo = e.ep_codigo
and r.rr_tipo = 'P'
and r.rr_fecha = :ld_fecrol;


ls_fecha = string(ld_fecrol,'mm-yyyy')

if ll_valor = 0 then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Las provisiones de '+ls_fecha+' no han sido generadas.')
	return
end if

//if ll_valor > 0 then
//	if messageBox('Confirme','Las provisiones de '+ls_fecha+' no han sido pagadas...Desea Hacerlo?',Question!,YesNo!)=1 then
//		UPDATE no_cabrol  
//		SET rr_pagado = 'S'  
//		WHERE rr_fecha = :ld_fecrol 
//		AND   rr_tipo = 'P';
//		commit;
//		w_marco.setmicrohelp("Las provisiones han sido pagadas")
//	else
//		return
//	end if
//end if

DECLARE C1 CURSOR FOR  

SELECT "NO_EMPLE"."EP_CODIGO",
              "NO_EMPLE"."SU_CODIGO",
              "NO_EMPLE"."EP_APEPAT"||' '|| "NO_EMPLE"."EP_APEMAT"||' '|| "NO_EMPLE"."EP_NOMBRE",
             "NO_EMPLE"."CS_CODIGO"
FROM    "NO_EMPLE"
WHERE  "NO_EMPLE"."EP_FECSAL" IS NULL
ORDER BY      "NO_EMPLE"."EP_APEPAT"||' '|| "NO_EMPLE"."EP_APEMAT"||' '|| "NO_EMPLE"."EP_NOMBRE" ASC;

		

open C1;
ll_new = 0
do
	fetch C1
	into :ls_epcodigo,:ls_sucodigo,:ls_nombre,:ls_cscodigo;

	   if sqlca.sqlcode <> 0 then
	     exit;
	end if
     ll_new =  dw_datos.insertrow(0)
	dw_datos.SetItem(ll_new,'ep_codigo', ls_epcodigo)
	dw_datos.SetItem(ll_new,'no_emple_su_codigo', ls_sucodigo)
	dw_datos.SetItem(ll_new,'cc_empleado', ls_nombre)
	dw_datos.SetItem(ll_new,'no_emple_cs_codigo', ls_cscodigo)
loop while TRUE;	
close C1;
end event

type rb_1 from radiobutton within w_ingresos_otros_roles
integer x = 174
integer y = 72
integer width = 334
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
string text = "&Incentivos"
boolean checked = true
end type

event clicked;dw_1.setitem(1,"ru_codigo",'')
end event

type rb_2 from radiobutton within w_ingresos_otros_roles
integer x = 174
integer y = 216
integer width = 334
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
string text = "&Utilidades"
end type

event clicked;dw_1.setitem(1,"ru_codigo",'')
end event

type em_1 from editmask within w_ingresos_otros_roles
integer x = 992
integer y = 68
integer width = 343
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_ingresos_otros_roles
integer x = 773
integer y = 76
integer width = 197
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_ingresos_otros_roles
integer x = 992
integer y = 180
integer width = 1179
integer height = 76
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_rubros"
boolean border = false
boolean livescroll = true
end type

event getfocus;String ls_tiporol


If rb_1.checked then ls_tiporol = 'I' 
If rb_2.checked then ls_tiporol = 'U'
If rb_3.checked then ls_tiporol = 'P'  /*Aqui se puede listar cualquier rubro que se vaya a pagar*/
If rb_4.checked then ls_tiporol = 'C' 

idwc_rubros.Setfilter("")
idwc_rubros.filter()
idwc_rubros.Setfilter("ru_tipo = '"+ls_tiporol+"'")
idwc_rubros.Filter()
return 0
end event

type st_2 from statictext within w_ingresos_otros_roles
integer x = 791
integer y = 184
integer width = 165
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
string text = "Rubro:"
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_ingresos_otros_roles
boolean visible = false
integer x = 2715
integer y = 708
integer width = 379
integer height = 540
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_detalle_roles"
boolean livescroll = true
end type

type rb_3 from radiobutton within w_ingresos_otros_roles
integer x = 174
integer y = 288
integer width = 530
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
string text = "&Beneficios sociales"
end type

event clicked;dw_1.setitem(1,"ru_codigo",'')
end event

type st_3 from statictext within w_ingresos_otros_roles
integer x = 73
integer y = 8
integer width = 283
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
string text = "Tipos de Rol"
boolean focusrectangle = false
end type

type rb_4 from radiobutton within w_ingresos_otros_roles
integer x = 174
integer y = 144
integer width = 352
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
string text = "&Comisiones"
end type

