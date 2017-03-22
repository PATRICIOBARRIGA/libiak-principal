HA$PBExportHeader$w_cxc_creditos.srw
$PBExportComments$Lista todos los movimientos de credito en cuentas por cobrar. Para permitir la anulacion.
forward
global type w_cxc_creditos from w_sheet_1_dw_maint
end type
type dw_detail from datawindow within w_cxc_creditos
end type
type dw_cruce from datawindow within w_cxc_creditos
end type
type em_1 from editmask within w_cxc_creditos
end type
type em_2 from editmask within w_cxc_creditos
end type
type st_1 from statictext within w_cxc_creditos
end type
type st_2 from statictext within w_cxc_creditos
end type
type st_3 from statictext within w_cxc_creditos
end type
type st_4 from statictext within w_cxc_creditos
end type
type st_5 from statictext within w_cxc_creditos
end type
type dw_ubica from datawindow within w_cxc_creditos
end type
type pb_1 from picturebutton within w_cxc_creditos
end type
end forward

global type w_cxc_creditos from w_sheet_1_dw_maint
integer width = 4073
integer height = 2276
string title = "Actualizaci$$HEX1$$f300$$ENDHEX$$n de cr$$HEX1$$e900$$ENDHEX$$ditos con SP"
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
global w_cxc_creditos w_cxc_creditos

forward prototypes
public function integer wf_actualiza_saldos ()
public function integer wf_preprint ()
end prototypes

event type integer ue_consultar(); dw_ubica.visible = true
 dw_ubica.Setfocus()
 return 1
end event

public function integer wf_actualiza_saldos ();/*Tomar los datos del buffer de borrado para asignar los saldos a los d$$HEX1$$e900$$ENDHEX$$bitos*/
Decimal lc_venumero,lc_valorcruces
String ls_mtcoddeb,ls_ttcoddeb,ls_ttioedeb,ls_mtcodigo,ls_cliente,ls_ttioe,ls_ttcodigo
Long ll_del,i

ls_cliente = dw_datos.object.ce_codigo[dw_datos.getrow()]
ll_del = dw_cruce.DeletedCount()

//Toma los datos del buffer de borrado
for i = 1 to ll_del 
lc_venumero = dw_cruce.Object.ve_numero.delete[ i ]
ls_mtcoddeb  = dw_cruce.Object.mt_coddeb.delete[ i ]
ls_ttcoddeb   = dw_cruce.Object.tt_coddeb.delete[ i ]
ls_ttioedeb    = dw_cruce.Object.tt_ioedeb.delete[ i ]
//lc_valorcruce = dw_cruce.Object.cr_valdeb.delete[i]
ls_mtcodigo   = dw_cruce.Object.mt_codigo.delete[ i ]
ls_ttcodigo   = dw_cruce.Object.tt_codigo.delete[ i ]
ls_ttioe   = dw_cruce.Object.tt_ioe.delete[ i ]



lc_valorcruces = 0;

SELECT  sum(NVL(CR_VALDEB,0))
INTO   :lc_valorcruces
FROM   CC_CRUCE
WHERE TT_CODDEB = :ls_ttcoddeb
AND TT_IOEDEB = :ls_ttioedeb
AND MT_CODDEB = :ls_mtcoddeb
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TT_CODIGO <> :ls_ttcodigo
AND TT_IOE <> :ls_ttioe
AND MT_CODIGO <> :ls_mtcodigo;

IF sqlca.sqlcode <> 0 or isnull(lc_valorcruces)then
lc_valorcruces = 0;
END IF


UPDATE CC_MOVIM
SET MT_SALDO = NVL(MT_VALOR,0) - :lc_valorcruces
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND MT_CODIGO = :ls_mtcoddeb
AND TT_IOE = :ls_ttioedeb
AND TT_CODIGO = :ls_ttcoddeb;

IF sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo de los d$$HEX1$$e900$$ENDHEX$$bitos..."+sqlca.sqlerrtext)
	Rollback;
	Return -1
End if

//Actualiza saldo del credito
UPDATE FA_CLIEN
SET CE_SALCRE = CE_SALCRE - :lc_valorcruces
WHERE CE_CODIGO = :ls_cliente
AND EM_CODIGO = :str_appgeninfo.empresa;
   
if sqlca.sqlcode < 0 then
   messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'Problemas al actualizar el cupo del cliente ' +sqlca.sqlerrtext)
   rollback;
   return -1
end if

next

return 1
end function

public function integer wf_preprint ();long ll_filAct
string ls_mt_numero, ls_tt_codigo, ls_valletras,ls_fp,ls_nc
decimal lc_valor
int li_res

ll_filAct = dw_detail.getRow()
ls_mt_numero = dw_detail.getItemString(ll_filAct, "mt_codigo")
ls_tt_codigo = dw_detail.getItemString(ll_filAct, "tt_codigo")
ls_nc = dw_detail.getItemString(ll_filAct, "ch_numero")

ls_fp = dw_detail.getItemString(dw_detail.getrow(), "fp_codigo")
lc_valor = dw_detail.getItemNumber(dw_detail.getrow(), "ch_valor")
ls_valletras = f_numero_a_letras (lc_valor)

f_recupera_empresa(dw_report,"fp_codigo") 
dw_report.retrieve('9',str_appgeninfo.empresa, str_appgeninfo.sucursal,ls_nc)   

return 1

end function

on w_cxc_creditos.create
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

on w_cxc_creditos.destroy
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
String ls_mtcoddeb ,ls_venumero,ls_ttcoddeb,ls_ttioe,ls_mtcodigo,ls_cliente,ls_rol,ls_anula,ls_ttcodigo,ls_formapago
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

ls_mtcodigo = dw_datos.object.mt_codigo[ll_row]
ls_ttcodigo = dw_datos.object.tt_codigo[ll_row]
ls_ttioe = dw_datos.object.tt_ioe[ll_row]

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mtcodigo+"] ser$$HEX2$$e1002000$$ENDHEX$$anulado completamente....Est$$HEX2$$e1002000$$ENDHEX$$seguro de realizar la operaci$$HEX1$$f300$$ENDHEX$$n ?",Question!,YesNoCancel!,2) <> 1 then return  -1
ll_row = dw_datos.getrow()
ls_cliente = dw_datos.object.ce_codigo[ll_row]
ll_reg =  dw_cruce.rowcount( )

//No se puede anular una Nota de credito por devolucion.
SELECT FP_CODIGO
INTO :ls_formapago
FROM CC_CHEQUE
WHERE em_codigo = :str_appgeninfo.empresa
AND su_codigo = :str_appgeninfo.sucursal
AND tt_codigo = :ls_ttcodigo
AND tt_ioe = :ls_ttioe
AND mt_codigo = :ls_mtcodigo;

if ls_formapago = '2' then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No est$$HEX2$$e1002000$$ENDHEX$$permitido anular Notas de cr$$HEX1$$e900$$ENDHEX$$dito por devoluci$$HEX1$$f300$$ENDHEX$$n..!!!",Exclamation!)
	return -1
end if

DECLARE sp_cxc PROCEDURE FOR sp_cxc_anulacioncredito(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_ttcodigo,:ls_ttioe,:ls_mtcodigo);
EXECUTE sp_cxc;
if sqlca.sqlcode = -1 then
 rollback;	
 messagebox("Error","No se pudo ejecutar el procedimiento SP_CXC_ANULACIONCREDITO~n"+sqlca.sqlerrtext)
else
 messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Procesado ejecutado exitosamente...~n"+sqlca.sqlerrtext)
 commit;
end if



/***********/
////if ll_reg <= 0 then 
////	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este movimiento no tiene cruces realizados")
////	return -1
////end if	
//
//if ll_reg > 0 then
//	for i = ll_reg to 1 step -1
//	dw_cruce.deleterow(i)
//    next
//end if
//
//
//ll_reg =  dw_detail.rowcount( )
//if ll_reg > 0 then
//	for i = ll_reg to 1 step -1
//	dw_detail.deleterow(i)
//    next
//end if
//
////Elimina mov de credito
//dw_datos.deleterow(0)
//
//
//
//rc =  dw_cruce.update(true,false)
//if rc = 1 then 
//      	     rc = dw_detail.update(true,false)
//		      if rc = 1 then 
//				dw_datos.update(true,false)	
//							
//					/*Actualiza saldos*/		
//					if wf_actualiza_saldos() = 1 then
//						commit;
//						Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mtcodigo+"] ha sido anulado con $$HEX1$$e900$$ENDHEX$$xito")	
//					else
//					rollback;
//					Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mtcodigo+"] NO ha sido anulado")	
//					return -1
//					end if				
//			else
//			rollback;
//			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mtcodigo+"] 	NO ha sido anulado con $$HEX1$$e900$$ENDHEX$$xito")	
//			return -1
//			end if
//else
//rollback;
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ["+ls_mtcodigo+"]No ha sido anulado con $$HEX1$$e900$$ENDHEX$$xito")	
//return -1	
//end if
//
this.triggerevent("ue_retrieve")
SetPointer(Arrow!)
return 1





end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cxc_creditos
integer x = 27
integer y = 156
integer width = 3973
integer height = 424
integer taborder = 30
string dataobject = "d_um_creditos_cxc"
boolean border = true
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;String ls_mtcodigo,ls_ttcodigo,ls_ttioe

If currentrow <= 0 or isnull(currentrow) then  return
If this.object.tt_ioe[currentrow] = 'C' then 
	dw_detail.reset()
	ls_mtcodigo = this.object.mt_codigo[currentrow]
	ls_ttcodigo  = this.object.tt_codigo[currentrow]
	ls_ttioe       = this.object.tt_ioe[currentrow]
	dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo,ls_ttcodigo,ls_ttioe)
	dw_cruce.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo)
end if
end event

event dw_datos::clicked;call super::clicked;//Inicia la anulacion del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito

If row <= 0 or isnull(row) then  return
Setrow(row)
ScrolltoRow(row)
If dwo.name = "t_3" then 
parent.triggerevent("ue_anular")
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_cxc_creditos
integer x = 27
integer y = 156
integer width = 3287
integer height = 1592
integer taborder = 40
string dataobject = "d_nc_preimp_devol_facytick_veh"
end type

event dw_report::constructor;call super::constructor;dw_report.setTransObject(sqlca)
end event

type dw_detail from datawindow within w_cxc_creditos
integer x = 23
integer y = 644
integer width = 3968
integer height = 444
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_cheque"
boolean livescroll = true
end type

event clicked;//Imprimir el registro actual segun formato de NC.
If row <= 0 or isnull(row) then  return
Setrow(row)
ScrolltoRow(row)
If dwo.name = "cc_imprimir" then 
parent.triggerevent("ue_print")
end if
end event

type dw_cruce from datawindow within w_cxc_creditos
integer x = 32
integer y = 1176
integer width = 3954
integer height = 968
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_debitos_vs_creditos"
boolean livescroll = true
end type

type em_1 from editmask within w_cxc_creditos
integer x = 238
integer y = 20
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

type em_2 from editmask within w_cxc_creditos
integer x = 873
integer y = 20
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

type st_1 from statictext within w_cxc_creditos
integer x = 9
integer y = 32
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

type st_2 from statictext within w_cxc_creditos
integer x = 635
integer y = 28
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

type st_3 from statictext within w_cxc_creditos
integer x = 37
integer y = 584
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
string text = "Detalle del cr$$HEX1$$e900$$ENDHEX$$dito"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_cxc_creditos
integer x = 9
integer y = 100
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
string text = "Cr$$HEX1$$e900$$ENDHEX$$ditos"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_cxc_creditos
integer x = 41
integer y = 1116
integer width = 411
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
string text = "D$$HEX1$$e900$$ENDHEX$$bitos cruzados"
boolean focusrectangle = false
end type

type dw_ubica from datawindow within w_cxc_creditos
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1737
integer y = 16
integer width = 1559
integer height = 268
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
string ls_mtcodigo,ls_ttcodigo,ls_ttioe


ll_find = dw_datos.Find("mt_codigo = '"+data+"'",1,dw_datos.rowcount())
if ll_find <= 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe este Movimiento en esta sucursal...<Por favor verifique>")
	return
end if	
dw_datos.Setfocus()
dw_datos.ScrollToRow(ll_find)
dw_datos.SetRow(ll_find)

If dw_datos.object.tt_ioe[ll_find] = 'C' then 
	dw_detail.reset()
	ls_mtcodigo = dw_datos.object.mt_codigo[ll_find]
	ls_ttcodigo  = dw_datos.object.tt_codigo[ll_find]
	ls_ttioe        = dw_datos.object.tt_ioe[ll_find]
	dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo,ls_ttcodigo,ls_ttioe)
	dw_cruce.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo)
end if



end event

type pb_1 from picturebutton within w_cxc_creditos
integer x = 1326
integer y = 20
integer width = 123
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Search!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para buscar por n$$HEX1$$fa00$$ENDHEX$$mero de cr$$HEX1$$e900$$ENDHEX$$dito"
end type

event clicked;parent.triggerevent("ue_consultar")
end event

