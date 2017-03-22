HA$PBExportHeader$w_um_actualiza_creditos.srw
$PBExportComments$EN PRODUCCCION 01/2010
forward
global type w_um_actualiza_creditos from w_sheet_1_dw_maint
end type
type dw_detail from datawindow within w_um_actualiza_creditos
end type
type dw_cruce from datawindow within w_um_actualiza_creditos
end type
type em_1 from editmask within w_um_actualiza_creditos
end type
type em_2 from editmask within w_um_actualiza_creditos
end type
type st_1 from statictext within w_um_actualiza_creditos
end type
type st_2 from statictext within w_um_actualiza_creditos
end type
type st_3 from statictext within w_um_actualiza_creditos
end type
type st_4 from statictext within w_um_actualiza_creditos
end type
type st_5 from statictext within w_um_actualiza_creditos
end type
type dw_ubica from datawindow within w_um_actualiza_creditos
end type
end forward

global type w_um_actualiza_creditos from w_sheet_1_dw_maint
integer width = 4183
integer height = 2276
string title = "Actualizaci$$HEX1$$f300$$ENDHEX$$n de cr$$HEX1$$e900$$ENDHEX$$ditos"
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
end type
global w_um_actualiza_creditos w_um_actualiza_creditos

event type integer ue_consultar(); dw_ubica.visible = true
 dw_ubica.Setfocus()
 return 1
end event

on w_um_actualiza_creditos.create
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
end on

on w_um_actualiza_creditos.destroy
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

event resize;return 1
end event

event ue_anular;Long ll_reg,i,rc,ll_row
String ls_mtcoddeb ,ls_venumero,ls_ttcoddeb,ls_ttioedeb,ls_mtcodigo,ls_cliente
Decimal lc_valorcruce
Decimal{0} lc_venumero


SetPointer(Hourglass!)


If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento  ser$$HEX2$$e1002000$$ENDHEX$$anulado completamente....Est$$HEX2$$e1002000$$ENDHEX$$seguro ?",Question!,YesNoCancel!,2) <> 1 then return  -1
ll_row = dw_datos.getrow()
ls_cliente = dw_datos.object.ce_codigo[ll_row]
ll_reg =  dw_cruce.rowcount( )

//if ll_reg <= 0 then 
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este movimiento no tiene cruces realizados")
//	return -1
//end if	

if ll_reg > 0 then
	for i = ll_reg to 1 step -1
	dw_cruce.deleterow(i)
    next
end if

/*Tomar los datos del buffer de borrado para asignar los saldos a los d$$HEX1$$e900$$ENDHEX$$bitos*/
Long ll_del
ll_del = dw_cruce.DeletedCount()


for i = 1 to ll_del 
lc_venumero = dw_cruce.Object.ve_numero.delete[i]
ls_mtcoddeb  = dw_cruce.Object.mt_coddeb.delete[i]
ls_ttcoddeb   = dw_cruce.Object.tt_coddeb.delete[i]
ls_ttioedeb    = dw_cruce.Object.tt_ioedeb.delete[i]
lc_valorcruce = dw_cruce.Object.cr_valdeb.delete[i]
ls_mtcodigo   = dw_cruce.Object.mt_codigo.delete[i]


UPDATE CC_MOVIM
SET MT_SALDO = NVL(MT_SALDO,0) + :lc_valorcruce
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



UPDATE FA_CLIEN
SET CE_SALCRE = CE_SALCRE - :lc_valorcruce
WHERE CE_CODIGO = :ls_cliente
AND EM_CODIGO = :str_appgeninfo.empresa;
   
if sqlca.sqlcode < 0 then
   messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'Problemas al actualizar el cupo del cliente ' +sqlca.sqlerrtext)
   rollback;
   return -1
end if
next


ll_reg =  dw_detail.rowcount( )
if ll_reg > 0 then
	for i = ll_reg to 1 step -1
	dw_detail.deleterow(i)
    next
end if

dw_datos.deleterow(0)




 rc =  dw_cruce.update(true,false)
 if rc = 1 then 
      	     rc = dw_detail.update(true,false)
		      if rc = 1 then 
			dw_datos.update(true,false)	
			/*Actualiza saldos*/
					
			else
			rollback;
			return -1
			end if
else
rollback;
return -1	
end if

commit;
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento ' "+ls_mtcodigo+" '  ha sido anulado con $$HEX1$$e900$$ENDHEX$$xito")	

SetPointer(Arrow!)
return 1





end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_um_actualiza_creditos
integer x = 37
integer y = 160
integer width = 4055
integer height = 432
integer taborder = 30
string dataobject = "d_um_creditos_cxc"
boolean border = true
end type

event dw_datos::clicked;

If row <= 0 or isnull(row) then  return
Setrow(row)
ScrolltoRow(row)
If dwo.name = 't_3' then
  if	Messagebox("Atenc$$HEX1$$ed00$$ENDHEX$$on","Va a realizar la anulaci$$HEX1$$f300$$ENDHEX$$n del movimiento...Est$$HEX2$$e1002000$$ENDHEX$$seguro ...?",Question!,YesNo!) = 2 then return
End if
end event

event dw_datos::rowfocuschanged;

String ls_mtcodigo,ls_ttcodigo,ls_ttioe

//If this.object.tt_ioe[currentrow] = 'C' then 
//	dw_detail.reset()
	ls_mtcodigo = this.object.mt_codigo[currentrow]
	ls_ttcodigo  = this.object.tt_codigo[currentrow]
	ls_ttioe        = this.object.tt_ioe[currentrow]
	dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo,ls_ttcodigo,ls_ttioe)
	dw_cruce.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo)
//end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_um_actualiza_creditos
integer x = 3141
integer y = 4
integer width = 713
integer height = 100
integer taborder = 40
end type

type dw_detail from datawindow within w_um_actualiza_creditos
integer x = 37
integer y = 652
integer width = 4059
integer height = 444
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_cheque"
boolean livescroll = true
end type

type dw_cruce from datawindow within w_um_actualiza_creditos
integer x = 37
integer y = 1172
integer width = 4059
integer height = 968
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_debitos_vs_creditos"
boolean livescroll = true
end type

type em_1 from editmask within w_um_actualiza_creditos
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

type em_2 from editmask within w_um_actualiza_creditos
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

type st_1 from statictext within w_um_actualiza_creditos
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

type st_2 from statictext within w_um_actualiza_creditos
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

type st_3 from statictext within w_um_actualiza_creditos
integer x = 37
integer y = 592
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

type st_4 from statictext within w_um_actualiza_creditos
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

type st_5 from statictext within w_um_actualiza_creditos
integer x = 41
integer y = 1104
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

type dw_ubica from datawindow within w_um_actualiza_creditos
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 773
integer y = 1564
integer width = 1559
integer height = 292
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar cr$$HEX1$$e900$$ENDHEX$$dito"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

