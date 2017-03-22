HA$PBExportHeader$w_ingreso_recibido_caja.srw
forward
global type w_ingreso_recibido_caja from w_sheet_1_dw_maint
end type
type sle_1 from singlelineedit within w_ingreso_recibido_caja
end type
type sle_2 from singlelineedit within w_ingreso_recibido_caja
end type
type sle_3 from singlelineedit within w_ingreso_recibido_caja
end type
type sle_4 from singlelineedit within w_ingreso_recibido_caja
end type
type st_1 from statictext within w_ingreso_recibido_caja
end type
type st_2 from statictext within w_ingreso_recibido_caja
end type
type st_3 from statictext within w_ingreso_recibido_caja
end type
type st_4 from statictext within w_ingreso_recibido_caja
end type
type dw_ubica from datawindow within w_ingreso_recibido_caja
end type
type st_5 from statictext within w_ingreso_recibido_caja
end type
type st_6 from statictext within w_ingreso_recibido_caja
end type
type st_7 from statictext within w_ingreso_recibido_caja
end type
type st_8 from statictext within w_ingreso_recibido_caja
end type
end forward

global type w_ingreso_recibido_caja from w_sheet_1_dw_maint
integer width = 2139
integer height = 1212
string title = "Caja del d$$HEX1$$ed00$$ENDHEX$$a"
long backcolor = 81324524
event ue_consultar pbm_custom16
sle_1 sle_1
sle_2 sle_2
sle_3 sle_3
sle_4 sle_4
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
dw_ubica dw_ubica
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
end type
global w_ingreso_recibido_caja w_ingreso_recibido_caja

type variables
string is_mensaje
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

event ue_consultar;dw_datos.postevent(doubleclicked!)
end event

public function integer wf_preprint ();string ls_numing,ls_caja,ls_cajero
long ll_nreg
date ld_fecha

ll_nreg = dw_datos.getrow()
ls_caja = dw_datos.getitemstring(ll_nreg,"cj_caja")
ls_numing = dw_datos.getitemstring(ll_nreg,"ci_codigo")
ld_fecha = date(dw_datos.getitemdatetime(ll_nreg,"ci_fecha"))
ls_cajero = dw_datos.getitemstring(ll_nreg,"ep_codigo")
dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"'")
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_numing,ls_cajero,ls_caja,ld_fecha)
return 1
end function

on w_ingreso_recibido_caja.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.sle_2=create sle_2
this.sle_3=create sle_3
this.sle_4=create sle_4
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.dw_ubica=create dw_ubica
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.sle_3
this.Control[iCurrent+4]=this.sle_4
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.dw_ubica
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_7
this.Control[iCurrent+13]=this.st_8
end on

on w_ingreso_recibido_caja.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_ubica)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
end on

event open;string ls_parametro[]
date ld_hoy

ld_hoy = date(f_hoy())
ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal
dw_datos.insertrow(0)
dw_datos.setitem(dw_datos.getrow(),"ci_fecha",ld_hoy)
f_recupera_datos(dw_datos,"cj_caja",ls_parametro[],2)
f_recupera_datos(dw_datos,"ep_codigo",ls_parametro,2)
f_recupera_empresa(dw_datos,'cn_codigo')
f_recupera_datos(dw_ubica,"caja",ls_parametro[],2)
f_recupera_datos(dw_ubica,"cajero",ls_parametro,2)
f_recupera_empresa(dw_report,'cn_codigo')
dw_report.settransobject(sqlca)
this.ib_notautoretrieve = true
call super::open
end event

event ue_update;
integer  li_rtn,li_secuen
long     ll_nreg,ll_ingreso
string   ls_caja ='1' ,ls_numing,ls_cajero,ls_tipo,ls_nulo
datetime ld_hoy
date     ld_fecha


ld_hoy = f_hoy()

if date(ld_hoy) <> ld_fecha then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha del cierre no corresponde a la fecha actual...Esta seguro de ingresar con esta fecha...Por favor verifique ")
end if


dw_datos.accepttext()
ll_nreg = dw_datos.getrow()
ls_caja = dw_datos.getitemstring(ll_nreg,"cj_caja")
ls_cajero = dw_datos.getitemstring(ll_nreg,"ep_codigo")
ld_fecha = date(dw_datos.getitemdatetime(ll_nreg,"ci_fecha"))
ls_numing = dw_datos.getitemstring(ll_nreg,"ci_codigo")
dw_datos.setitem(ll_nreg,"em_codigo",str_appgeninfo.empresa)
dw_datos.setitem(ll_nreg,"su_codigo",str_appgeninfo.sucursal)
dw_datos.setitem(ll_nreg,"cj_caja",ls_caja)
//dw_datos.setitem(ll_nreg,"ci_feccie",ld_hoy)
dw_datos.setitem(ll_nreg,"ci_feccie",ld_fecha)

if isnull(ls_numing) then
	select count(1)
	into:li_secuen
	from fa_cierre
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and ep_codigo = :ls_cajero
	and trunc(ci_fecha) = :ld_fecha;
		
	If li_secuen <> 0 Then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El recibo de este d$$HEX1$$ed00$$ENDHEX$$a ya fue realizado...verifique",stopsign!)
		return
	End if
else
	select count(1)
	into:li_secuen
	from fa_cierre
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and ci_codigo = :ls_numing	
		and ep_codigo = :ls_cajero
	and trunc(ci_fecha) = :ld_fecha;

	Select sa_tipo
	into :ls_tipo
	from sg_acceso
	where em_codigo = :str_appgeninfo.empresa
	and sa_login = :str_appgeninfo.username;

	If ls_tipo <> 'A' Then
		if date(ld_hoy) <> ld_fecha then 
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No puede modificar el recibo de otro d$$HEX1$$ed00$$ENDHEX$$a",stopsign!)		
			return
		end if
	End if
	
end if


if li_secuen = 0 then
	select ps_valor
	into:ll_ingreso
	from pr_numsuc
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and pr_nombre = 'CIERRE';
	
	
	if sqlca.sqlcode<>0 then
		messageBox('Error','Problemas al encontrar el siguiente numero de cierre ' + sqlca.sqlerrtext)
		return
	end if
	if isnull(ll_ingreso) then
		ll_ingreso = 1
	else
		ll_ingreso++
	end if
	ls_numing = string(ll_ingreso)
	dw_datos.setitem(ll_nreg,"ci_codigo",ls_numing)
	

	update pr_numsuc 
	set ps_valor = :ll_ingreso
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and pr_nombre = 'CIERRE';
	
end if

li_rtn = dw_datos.update()
if li_rtn <> 1 then
	rollback;
	messagebox("Error","Problemas al actualizar el total recibido de caja",stopsign!)
	return
else
	commit;
	dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"'"+&
	"st_secpini.text = '"+sle_1.text+"' st_secini.text = '"+sle_2.text+"' st_secpfin.text = '"+sle_3.text+"' st_secfin.text = '"+sle_4.text+"'")
	dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_numing,ls_cajero,ls_caja,ld_fecha)
	dw_report.print()	
	dw_datos.reset()
	dw_datos.insertrow(0)
	dw_datos.setitem(ll_nreg,"ci_fecha",ld_hoy)
	setnull(ls_nulo)
	sle_1.text = ls_nulo
	sle_2.text = ls_nulo
	sle_3.text = ls_nulo 
	sle_4.text = ls_nulo
	dw_datos.setfocus()
End if

end event

event ue_retrieve;return 1
end event

event ue_insert;datetime ld_fecha

ld_fecha = f_hoy()

dw_datos.reset()
dw_datos.insertrow(0)
dw_datos.setitem(dw_datos.getrow(),"ci_fecha",date(ld_fecha))
dw_datos.setcolumn("cj_caja")
dw_datos.setfocus()
dw_ubica.Visible = false
sle_1.visible = true
sle_2.visible = true
sle_3.visible = true
sle_4.visible = true

st_1.visible = true
st_2.visible = true
st_3.visible = true
st_4.visible = true


end event

event ue_print;string ls_range
int li_res
w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then

	openwithparm(w_dw_print_options,dw_report)
   li_res = message.doubleparm
   if li_res <> 1 then
		li_res = 1
	else
		li_res = dw_report.print()
		if li_res = 1 then li_res = this.wf_postPrint()
	end if
		
	if li_res = 1 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_datos.enabled = True
		dw_datos.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so the master and detail get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.modify("datawindow.print.preview.zoom=100~t" + &
										"datawindow.print.preview=yes")
			dw_datos.enabled = False
			dw_datos.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_into_report_mode()
		end if
end if

this.setRedraw(True)

end event

event closequery;return
end event

event ue_delete;call super::ue_delete;sle_1.visible = false
sle_2.visible = false
sle_3.visible = false
sle_4.visible = false

st_1.visible = false
st_2.visible = false
st_3.visible = false
st_4.visible = false

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ingreso_recibido_caja
event ue_nextfield pbm_custom01
integer x = 41
integer y = 40
integer width = 2039
integer height = 496
string dataobject = "d_ingreso_recibido_caja"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_datos::ue_nextfield;send(handle(this),256,9,long(0,0))
return 1
end event

event dw_datos::doubleclicked;call super::doubleclicked;datetime ld_fecha
String ls_tipo




dw_ubica.reset()
dw_ubica.insertrow(0)
dw_ubica.setitem(dw_ubica.getrow(),"fecha",today())
dw_ubica.setcolumn("numero")
dw_ubica.setfocus()
dw_ubica.Visible = true
dw_datos.enabled = true
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ingreso_recibido_caja
integer x = 41
integer y = 40
integer width = 2016
integer height = 432
integer taborder = 0
string dataobject = "d_imp_caja_del_dia"
end type

type sle_1 from singlelineedit within w_ingreso_recibido_caja
integer x = 1019
integer y = 604
integer width = 526
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type sle_2 from singlelineedit within w_ingreso_recibido_caja
integer x = 1019
integer y = 700
integer width = 526
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type sle_3 from singlelineedit within w_ingreso_recibido_caja
integer x = 1019
integer y = 796
integer width = 526
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type sle_4 from singlelineedit within w_ingreso_recibido_caja
integer x = 1019
integer y = 892
integer width = 526
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type st_1 from statictext within w_ingreso_recibido_caja
integer x = 174
integer y = 612
integer width = 640
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
string text = "N$$HEX2$$b0002000$$ENDHEX$$Ticket Preimpreso Inicial:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ingreso_recibido_caja
integer x = 165
integer y = 708
integer width = 613
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
string text = " N$$HEX2$$b0002000$$ENDHEX$$de Ticket Inicial:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ingreso_recibido_caja
integer x = 174
integer y = 804
integer width = 640
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
string text = "N$$HEX2$$b0002000$$ENDHEX$$Ticket Preimpreso Final:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_ingreso_recibido_caja
integer x = 174
integer y = 900
integer width = 640
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
string text = "N$$HEX2$$b0002000$$ENDHEX$$de Ticket Final:"
boolean focusrectangle = false
end type

type dw_ubica from datawindow within w_ingreso_recibido_caja
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 174
integer y = 340
integer width = 1815
integer height = 420
boolean titlebar = true
string title = "Recuperar recibo de caja"
string dataobject = "d_sel_recibido_caja"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_datos.SetFocus()
end if
end event

event itemerror;messageBox('Por Favor',is_mensaje)
return 1
end event

event buttonclicked;string ls_numing,ls_caja = '1',ls_cajero,ls_tipo
integer li_nreg
date ld_fecha
datetime ldt_now

accepttext()
ls_numing = dw_ubica.getitemstring(row,"numero")
//ls_caja = dw_ubica.getitemstring(row,"caja")
ls_cajero = dw_ubica.getitemstring(row,"cajero")
ld_fecha = dw_ubica.getitemdate(row,"fecha")

//if isnull(ls_caja) then
//	is_mensaje = 'Seleccione una caja para obtener la consulta'
//	return 1
//end if

if isnull(ls_cajero) then
	is_mensaje = 'Seleccione un cajero para obtener la consulta'		
	return 1
end if	
if isnull(ld_fecha) then
	is_mensaje = 'Ingrese la fecha para obtener la consulta'				
	return 1
end if		
if isnull(ls_numing) then
	is_mensaje = 'Ingrese el n$$HEX1$$fa00$$ENDHEX$$mero de recibo para obtener la consulta'						
	return 1
end if		


SELECT trunc(sysdate)
INTO      :ldt_now
FROM    dual;

Select sa_tipo
into :ls_tipo
from sg_acceso
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username;

//Solo un usuario Administrador puede realizar consultas de d$$HEX1$$ed00$$ENDHEX$$as anteriores

If ls_tipo <> 'A' Then
        if date(ld_fecha) < date(ldt_now) then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n',' No es de hoy d$$HEX1$$ed00$$ENDHEX$$a el ingreso de caja $$HEX2$$f3002000$$ENDHEX$$No Tiene Permiso para realizar esta acci$$HEX1$$f300$$ENDHEX$$n')
		return -1
        end if
End if


li_nreg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,+&
				ls_numing,ls_caja,ls_cajero,ld_fecha)

If li_nreg < 1 Then
	is_mensaje = "No existe n$$HEX1$$fa00$$ENDHEX$$mero de recibo de caja"
	return 1
End if

dw_ubica.visible = false
sle_1.visible = false
sle_2.visible = false
sle_3.visible = false
sle_4.visible = false

st_1.visible = false
st_2.visible = false
st_3.visible = false
st_4.visible = false

end event

type st_5 from statictext within w_ingreso_recibido_caja
integer x = 87
integer y = 612
integer width = 73
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "*"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_ingreso_recibido_caja
integer x = 87
integer y = 704
integer width = 73
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "*"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_ingreso_recibido_caja
integer x = 87
integer y = 788
integer width = 73
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "*"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_ingreso_recibido_caja
integer x = 87
integer y = 884
integer width = 73
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "*"
alignment alignment = center!
boolean focusrectangle = false
end type

