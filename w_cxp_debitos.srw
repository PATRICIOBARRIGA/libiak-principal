HA$PBExportHeader$w_cxp_debitos.srw
$PBExportComments$Lista todos los movimientos de credito en cuentas por cobrar. Para permitir la anulacion.
forward
global type w_cxp_debitos from w_sheet_1_dw_maint
end type
type dw_detail from datawindow within w_cxp_debitos
end type
type dw_cruce from datawindow within w_cxp_debitos
end type
type em_1 from editmask within w_cxp_debitos
end type
type em_2 from editmask within w_cxp_debitos
end type
type st_1 from statictext within w_cxp_debitos
end type
type st_2 from statictext within w_cxp_debitos
end type
type st_3 from statictext within w_cxp_debitos
end type
type st_4 from statictext within w_cxp_debitos
end type
type st_5 from statictext within w_cxp_debitos
end type
type dw_ubica from datawindow within w_cxp_debitos
end type
type pb_1 from picturebutton within w_cxp_debitos
end type
end forward

global type w_cxp_debitos from w_sheet_1_dw_maint
integer width = 4073
integer height = 2276
string title = "Consulta y Anulaci$$HEX1$$f300$$ENDHEX$$n de debitos"
boolean ib_notautoretrieve = true
event type integer ue_consultar ( )
dw_detail dw_detail
dw_cruce dw_cruce
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
dw_ubica dw_ubica
pb_1 pb_1
end type
global w_cxp_debitos w_cxp_debitos

type variables
String is_pvcodigo
end variables

forward prototypes
public function integer wf_actualiza_saldos ()
end prototypes

event type integer ue_consultar(); dw_ubica.visible = true
 dw_ubica.Setfocus()
 return 1
end event

public function integer wf_actualiza_saldos ();/*Tomar los datos del buffer de borrado para asignar los saldos a los d$$HEX1$$e900$$ENDHEX$$bitos*/
Decimal lc_valorcruces
String ls_cofacpro,ls_tvcodigo,ls_tvtipo,ls_mpcodigo,ls_codprov,ls_mpcoddeb,ls_tvcoddeb,ls_tvtipodeb
Long ll_del,i

//ls_codprov = dw_datos.object.in_prove_pv_codigo[ dw_datos.getrow( ) ]
ll_del = dw_cruce.DeletedCount( )

//Toma los datos del buffer de borrado
for i = 1 to ll_del

ls_cofacpro =  dw_cruce.Object.cp_movim_co_facpro.delete[ i ]
ls_mpcodigo  = dw_cruce.Object.cp_cruce_mp_codigo.delete[ i ]
ls_tvcodigo   = dw_cruce.Object.cp_cruce_tv_codigo.delete[ i ]
ls_tvtipo       = dw_cruce.Object.cp_cruce_tv_tipo.delete[ i ]
ls_tvcoddeb = dw_cruce.Object.cp_cruce_tv_coddeb.delete[i]
ls_tvtipodeb = dw_cruce.Object.cp_cruce_tv_tipodeb.delete[ i ]
ls_mpcoddeb  = dw_cruce.Object.cp_cruce_mp_coddeb.delete[ i ]


lc_valorcruces = 0;

SELECT  sum(NVL(CX_VALCRE,0 ) )
INTO   :lc_valorcruces
FROM   CP_CRUCE
WHERE TV_CODIGO = :ls_tvcodigo
AND TV_TIPO = :ls_tvtipo
AND MP_CODIGO = :ls_mpcodigo
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TV_CODDEB <> :ls_tvcoddeb
AND TV_TIPODEB <> :ls_tvtipodeb
AND MP_CODDEB <> :ls_mpcoddeb;

IF sqlca.sqlcode <> 0 or isnull(lc_valorcruces)then
lc_valorcruces = 0;
END IF


UPDATE CP_MOVIM
SET MP_SALDO = NVL(MP_VALOR,0 ) - :lc_valorcruces
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND MP_CODIGO = :ls_mpcodigo
AND TV_TIPO = :ls_tvtipo
AND TV_CODIGO = :ls_tvcodigo;

IF sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo de los d$$HEX1$$e900$$ENDHEX$$bitos..."+sqlca.sqlerrtext)
	Rollback;
	Return -1
End if



next

return 1
end function

on w_cxp_debitos.create
int iCurrent
call super::create
this.dw_detail=create dw_detail
this.dw_cruce=create dw_cruce
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.dw_ubica=create dw_ubica
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.dw_cruce
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.dw_ubica
this.Control[iCurrent+11]=this.pb_1
end on

on w_cxp_debitos.destroy
call super::destroy
destroy(this.dw_detail)
destroy(this.dw_cruce)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_ubica)
destroy(this.pb_1)
end on

event open;call super::open;dw_detail.SetTransObject(sqlca)
dw_cruce.SetTransObject(sqlca)
f_recupera_empresa(dw_detail,"fp_codigo")
f_recupera_empresa(dw_detail,"if_codigo")
dw_ubica.insertrow(0)
em_1.text = string(today())
em_2.text = string(today())
end event

event ue_retrieve;Date  ld_ini , ld_fin

ld_ini  = date(em_1.text)
ld_fin  = date(em_2.text)

dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_ini,ld_fin)

end event

event resize;
dw_datos.resize(this.workSpaceWidth() - 50, dw_datos.height)
dw_detail.resize(this.workSpaceWidth() - 50, dw_detail.height)
dw_cruce.resize(this.workSpaceWidth() - 50, this.workSpaceheight() - (dw_datos.height + dw_detail.height + 320))
return 1
end event

event closequery;return 0
end event

event ue_anular;Long ll_reg,i,rc,ll_row
String ls_mpcodigo ,ls_cofacpro,ls_tvcodigo,ls_tvtipo,ls_cliente,ls_mpcoddeb,ls_rol,ls_anula
Decimal lc_valorcruce
Decimal{0} lc_venumero

SetPointer(Hourglass!)

SELECT RS_NOMBRE,SA_ANULA
into :ls_rol,:ls_anula
FROM SG_ACCESO
WHERE em_codigo = :str_appgeninfo.empresa 
and SA_LOGIN = :str_appgeninfo.username;

ll_row = dw_datos.getrow()
If ll_row = 0 then return -1

if ls_anula <> 'S' or ls_anula='' or isnull(ls_anula) then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede anular ...Usuario no autorizado...!!!",Exclamation!)
	return -1
end if



ls_mpcoddeb = dw_datos.object.cp_movim_mp_codigo[ll_row]
ls_tvcodigo    = dw_datos.object.cp_movim_tv_codigo[ll_row]
ls_tvtipo        = dw_datos.object.cp_movim_tv_tipo[ll_row]

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mpcoddeb+"] ser$$HEX2$$e1002000$$ENDHEX$$anulado completamente....Est$$HEX2$$e1002000$$ENDHEX$$seguro de realizar la operaci$$HEX1$$f300$$ENDHEX$$n ?",Question!,YesNoCancel!,2) <> 1 then return  -1
ll_row = dw_datos.getrow()
ls_cliente = dw_datos.object.in_prove_pv_codigo[ll_row]
ll_reg =  dw_cruce.rowcount( )


//Marcar como borrado los cruces
//if ll_reg > 0 then
//	for i = ll_reg to 1 step -1
//	dw_cruce.deleterow( i )
//    next 
//end if
//
////borra detalle del pago
//ll_reg =  dw_detail.rowcount( )
//if ll_reg > 0 then
//	
//	for i = ll_reg to 1  step -1
//	dw_detail.deleterow( i )
//    next
//	 
//end if
//
//
//rc =  dw_cruce.update(true,false)
//if rc = 1 then 
//	
//      	     rc = dw_detail.update(true,false)
//		      if rc = 1 then 
//					
//			dw_datos.deleterow(0 )		
//			 rc = dw_datos.update(true,false)	
//			/*Actualiza saldos*/
//				if rc = 1 then
//					wf_actualiza_saldos( )
//				else
//				rollback;
//				return -1
//				end if	
//			
//			else
//			rollback;
//			return -1
//			end if
//else
//rollback;
//return -1	
//end if


DECLARE sp_cxp PROCEDURE FOR sp_cxp_anulaciondebito(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_tvcodigo,:ls_tvtipo,:ls_mpcoddeb);
EXECUTE sp_cxp;
if sqlca.sqlcode = -1 then
 rollback;	
 messagebox("Error","No se pudo ejecutar el procedimiento SP_CXP_ANULACIONDEBITO~n"+sqlca.sqlerrtext)
 return -1
else
 messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Procesado ejecutado exitosamente...~n"+sqlca.sqlerrtext)
 commit;
end if



commit;
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mpcoddeb+"] ha sido anulado con $$HEX1$$e900$$ENDHEX$$xito")	

this.triggerevent("ue_retrieve")
SetPointer(Arrow!)
return 1





end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cxp_debitos
integer x = 27
integer y = 156
integer width = 3973
integer height = 424
integer taborder = 30
string dataobject = "d_um_cxp_debitos"
boolean border = true
end type

event dw_datos::clicked;call super::clicked;//Inicia la anulacion del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito

If row <= 0 or isnull(row) then  return
Setrow(row)
ScrolltoRow(row)
If dwo.name = "t_1" then 
parent.triggerevent("ue_anular")
end if
end event

event dw_datos::updatestart;return 0
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;String ls_mpcodigo,ls_tvcodigo,ls_tvtipo

If currentrow <= 0 or isnull(currentrow) then  return

If this.object.cp_movim_tv_tipo[currentrow] = 'D' then 
//	dw_detail.reset()
	ls_mpcodigo = this.object.cp_movim_mp_codigo[currentrow]
	ls_tvcodigo  = this.object.cp_movim_tv_codigo[currentrow]
	ls_tvtipo       = this.object.cp_movim_tv_tipo[currentrow]
	dw_detail.retrieve(ls_mpcodigo,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tvcodigo,ls_tvtipo)
	dw_cruce.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcodigo)
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_cxp_debitos
integer x = 3141
integer y = 4
integer width = 713
integer height = 100
integer taborder = 40
end type

type dw_detail from datawindow within w_cxp_debitos
integer x = 32
integer y = 648
integer width = 3973
integer height = 444
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_cxp_detallepago"
boolean livescroll = true
end type

type dw_cruce from datawindow within w_cxp_debitos
integer x = 32
integer y = 1176
integer width = 3959
integer height = 968
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_debitos_vs_creditos_cxp"
boolean livescroll = true
end type

event buttonclicked;if dwo.name  = 'b_2' then
	this.insertrow(0)
end if
if dwo.name  = 'b_3' then
	this.deleterow(0)
end if
if dwo.name  = 'b_4' then
	
end if
end event

event itemchanged;//Validar que el valor la factura exista y sea del proveedor correspondiente
String ls_mpcodigo,ls_tvcodigo,ls_tvtipo

If dwo.name = "" then
	
	SELECT MP_CODIGO,TV_CODIGO,TV_TIPO
	into :ls_mpcodigo,:ls_tvcodigo,:ls_tvtipo
	FROM CP_MOVIM
	WHERE CO_FACPRO = :data
	AND PV_CODIGO = :is_pvcodigo;
	
End if
end event

type em_1 from editmask within w_cxp_debitos
integer x = 507
integer y = 44
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
boolean autoskip = true
end type

type em_2 from editmask within w_cxp_debitos
integer x = 1143
integer y = 44
integer width = 343
integer height = 76
integer taborder = 20
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

type st_1 from statictext within w_cxp_debitos
integer x = 279
integer y = 56
integer width = 201
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cxp_debitos
integer x = 905
integer y = 52
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
string text = "hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_cxp_debitos
integer x = 37
integer y = 580
integer width = 402
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "Detalle del d$$HEX1$$e900$$ENDHEX$$bito"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_cxp_debitos
integer x = 32
integer y = 56
integer width = 238
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "D$$HEX1$$e900$$ENDHEX$$bitos"
boolean focusrectangle = false
end type

type st_5 from statictext within w_cxp_debitos
integer x = 41
integer y = 1116
integer width = 416
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "Cr$$HEX1$$e900$$ENDHEX$$ditos cruzados"
boolean focusrectangle = false
end type

type dw_ubica from datawindow within w_cxp_debitos
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1989
integer y = 484
integer width = 1417
integer height = 252
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar cr$$HEX1$$e900$$ENDHEX$$dito"
string dataobject = "d_sel_factura"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
end if

end event

event itemchanged;Long ll_find
string ls_mpcodigo,ls_tvcodigo,ls_tvtipo


ll_find = dw_datos.Find("cp_movim_mp_codigo = '"+data+"'",1,dw_datos.rowcount())
if ll_find <= 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe este Movimiento en esta sucursal...<Por favor verifique>")
	return
end if	
dw_datos.Setfocus()
dw_datos.ScrollToRow(ll_find)
dw_datos.SetRow(ll_find)

If dw_datos.object.cp_movim_tv_tipo[ll_find] = 'C' then 
	dw_detail.reset()
	ls_mpcodigo = dw_datos.object.cp_movim_mp_codigo[ll_find]
	ls_tvcodigo  = dw_datos.object.cp_movim_tv_codigo[ll_find]
	ls_tvtipo        = dw_datos.object.cp_movim_tv_tipo[ll_find]
	dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcodigo,ls_tvcodigo,ls_tvtipo)
	dw_cruce.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcodigo)
end if



end event

type pb_1 from picturebutton within w_cxp_debitos
integer x = 1623
integer y = 28
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Search!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para buscar por n$$HEX1$$fa00$$ENDHEX$$mero de d$$HEX1$$e900$$ENDHEX$$bito"
end type

event clicked;parent.triggerevent("ue_consultar")
end event

