HA$PBExportHeader$w_rep_estado_de_cuenta.srw
$PBExportComments$Si.Estado de cuenta de un cliente en particular
forward
global type w_rep_estado_de_cuenta from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_estado_de_cuenta
end type
type rb_1 from radiobutton within w_rep_estado_de_cuenta
end type
end forward

global type w_rep_estado_de_cuenta from w_sheet_1_dw_rep
integer width = 3095
integer height = 1616
string title = "Estado de Cuenta Cliente"
long backcolor = 81324524
dw_sel_rep dw_sel_rep
rb_1 rb_1
end type
global w_rep_estado_de_cuenta w_rep_estado_de_cuenta

on w_rep_estado_de_cuenta.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.rb_1
end on

on w_rep_estado_de_cuenta.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.rb_1)
end on

event open;dw_sel_rep.InsertRow(0)
dw_sel_rep.setfocus()
dw_datos.SetTransObject(sqlca)
this.ib_notautoretrieve = true
//f_recupera_empresa(dw_sel_rep,'cliente')
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_retrieve;long ll_filact,ll_reg
date fec_ini, fec_fin,ld_ini,ld_fin
string ls_cliente, ls_nombre, ls_tipo,ls_all
decimal{2} lc_salini
DataStore lds_estcta


SetPointer(HourGlass!)

lds_estcta = Create DataStore
lds_estcta.dataobject = 'd_estado_cuenta_cartera_salini'
lds_estcta.settransobject(sqlca)

ll_filact = dw_sel_rep.GetRow()
dw_sel_rep.accepttext()
ls_cliente = dw_sel_rep.GetItemstring(ll_filact,'cliente')
fec_ini = dw_sel_rep.GetItemDate(ll_filact,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(ll_filact,'fec_fin')
ls_tipo = dw_sel_rep.GetItemstring(ll_filact,'tipo')
ls_all =   dw_sel_rep.GetItemstring(ll_filact,'lote')

if ls_all = 'S' then
	
     if rb_1.checked = false then
		dw_datos.dataobject = 'd_estado_cuenta_cartera_clientes_b' /*Sin sucursal para B2007*/
		dw_datos.settransobject(sqlca)
		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
	else
		dw_datos.dataobject = 'd_estado_cuenta_cartera_clientes_resumen' /*Sin sucursal para B2007*/
		dw_datos.settransobject(sqlca)
		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
	end if
else
	
		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
		messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
		return 1
		end if
		
		Select ltrim(decode(length(ce_rucic),13,ce_codigo||'  RUC: '||ce_rucic||' '||ce_razons||' '||ce_nomrep||' '||ce_aperep,ce_nombre||'  '||ce_apelli))
		into :ls_nombre
		from fa_clien
		where em_codigo = :str_appgeninfo.empresa
		and ce_codigo = :ls_cliente;
		if sqlca.sqlcode <> 0 then
		messageBox('Error','Cliente no registrado')
		dw_sel_rep.selecttext(1,len(ls_cliente))
		return
		End if
		dw_sel_rep.modify("st_cliente.text = '"+ls_nombre+"'")
	
		if ls_tipo = '1' then
			 dw_datos.dataobject = 'd_rep_calificacion_cliente'
			 dw_datos.settransobject(sqlca)
			 dw_datos.Retrieve(fec_ini,fec_fin,ls_cliente)
	    else
	    	      ld_ini=date('01/01/03')
			 ld_fin = relativedate(fec_ini,-1)		
			 ll_reg =  lds_estcta.retrieve(str_appgeninfo.empresa,ls_cliente,ld_ini,ld_fin)	
				 if ll_reg = 0 then
			 lc_salini = 0
			 else
			 lc_salini = lds_estcta.object.cc_saldo[1]
			 end if	
				
		      dw_datos.dataobject = 'd_estado_cuenta_cartera_unnomotors'
			 dw_datos.settransobject(sqlca)
			 dw_datos.Retrieve(str_appgeninfo.empresa,ls_cliente,fec_ini,fec_fin,lc_salini)
		end if
end if


//
dw_datos.modify("st_cliente.text = '"+ls_nombre+"' st_empresa.text = '"+gs_empresa+"'"+&
	"st_fecha.text='Desde: "+string(fec_ini,'dd/mm/yyyy')+" Hasta "+string(fec_fin,'dd/mm/yyyy')+"' datawindow.print.preview = yes")
	
SetPointer(Arrow!)
end event

event ue_mail;OpenSheetWithParm(w_mail_send,dw_datos,w_marco,15,Original!)
return 1
end event

event closequery; return 0

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_estado_de_cuenta
integer x = 0
integer y = 216
integer width = 3049
integer height = 1260
integer taborder = 20
string dataobject = "d_estado_cuenta_cartera"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrievestart;call super::retrievestart;//dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
//										"datawindow.print.preview=yes")
end event

event dw_datos::retrieveend;call super::retrieveend;String ls_cliente,ls_tipo,ls_all
Dec{2}  lc_valorreal,lc_valorref
Date     ld_fecfin

ls_cliente  = dw_sel_rep.Object.cliente[1]
ld_fecfin   = dw_sel_rep.Object.fec_fin[1]
ls_tipo      = dw_sel_rep.Object.tipo[1]
ls_all         = dw_sel_rep.Object.lote[1] 

if ls_tipo = '1' OR ls_all = 'S' then  return 1


SELECT NVL(SUM("CC_CHEQUE"."CH_VALOR"),0)
INTO :lc_valorreal
FROM    "CC_CHEQUE",   
              "CC_MOVIM"  
WHERE ( "CC_MOVIM"."EM_CODIGO" = "CC_CHEQUE"."EM_CODIGO" ) and  
         ( "CC_MOVIM"."SU_CODIGO" = "CC_CHEQUE"."SU_CODIGO" ) and  
         ( "CC_MOVIM"."MT_CODIGO" = "CC_CHEQUE"."MT_CODIGO" ) and  
         ( "CC_MOVIM"."TT_IOE" = "CC_CHEQUE"."TT_IOE" ) and  
         ( "CC_MOVIM"."TT_CODIGO" = "CC_CHEQUE"."TT_CODIGO" ) and  
         ( ( "CC_CHEQUE"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
         ( "CC_CHEQUE"."TT_IOE" = 'C' ) AND  
         ( "CC_MOVIM"."CE_CODIGO" = :ls_cliente ) AND  
         ( Trunc("CC_CHEQUE"."CH_FECEFEC") > trunc(sysdate) ) AND
         ( "CC_CHEQUE"."FP_CODIGO" = '1') )  ;  
			
		
dw_datos.Object.posfreal[1] = lc_valorreal		


SELECT NVL(SUM("CC_CHEQUE"."CH_VALOR"),0)
INTO :lc_valorref
FROM    "CC_CHEQUE",   
              "CC_MOVIM"  
WHERE ( "CC_MOVIM"."EM_CODIGO" = "CC_CHEQUE"."EM_CODIGO" ) and  
         ( "CC_MOVIM"."SU_CODIGO" = "CC_CHEQUE"."SU_CODIGO" ) and  
         ( "CC_MOVIM"."MT_CODIGO" = "CC_CHEQUE"."MT_CODIGO" ) and  
         ( "CC_MOVIM"."TT_IOE" = "CC_CHEQUE"."TT_IOE" ) and  
         ( "CC_MOVIM"."TT_CODIGO" = "CC_CHEQUE"."TT_CODIGO" ) and  
         ( ( "CC_CHEQUE"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
         ( "CC_CHEQUE"."TT_IOE" = 'C' ) AND  
         ( "CC_MOVIM"."CE_CODIGO" = :ls_cliente ) AND  
         ( Trunc("CC_CHEQUE"."CH_FECEFEC") > :ld_fecfin ) AND
         ( "CC_CHEQUE"."FP_CODIGO" = '1') )  ;  

dw_datos.Object.posfref[1] = lc_valorref		
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_estado_de_cuenta
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_estado_de_cuenta
integer taborder = 50
end type

type dw_sel_rep from datawindow within w_rep_estado_de_cuenta
integer width = 3049
integer height = 216
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sel_cliente_estado_cta"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;long ll_filact
date fec_ini, fec_fin
string ls_cliente,ls,ls_nombre
//
ll_filact = this.GetRow()
SetPointer(HourGlass!)
CHOOSE CASE this.GetColumnName()
	CASE 'cliente'
		ls_cliente = this.GetText()
		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//		ls = this.GetItemString(ll_filact,'tipo')
		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
			return 1
		end if
		Select ltrim(decode(length(ce_rucic),13,'R.U.C.: '||ce_rucic||' '||ce_razons||' '||ce_nomrep||' '||ce_aperep,ce_nombre||'  '||ce_apelli))
		into :ls_nombre
		from fa_clien
		where em_codigo = :str_appgeninfo.empresa
		and ce_codigo = :ls_cliente;
		if sqlca.sqlcode <> 0 then
			messageBox('Error','Cliente no registrado')
			dw_sel_rep.selecttext(1,len(ls_cliente))
			return
		End if
		dw_sel_rep.modify("st_cliente.text = '"+ls_nombre+"' st_empresa = '"+gs_empresa+"' st_sucursal = '"+gs_su_nombre+"'")		
////		if ls = 'P' then
////			f_genera_estado_cta(ls_cliente,fec_ini,fec_fin)
////		else
////			f_genera_estado_cta_acumulado(ls_cliente,fec_ini,fec_fin)
////		end if
//		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cliente,fec_ini,fec_fin)
////	CASE 'fec_ini'
////		ls_cliente = this.GetItemString(ll_filact,'cliente')
////		fec_ini = date(this.GetText())
////		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
////		ls = this.GetItemString(ll_filact,'tipo')		
////		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
////			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
////			return 1
////		end if
////		if ls = 'P' then
////			f_genera_estado_cta(ls_cliente,fec_ini,fec_fin)
////		else
////			f_genera_estado_cta_acumulado(ls_cliente,fec_ini,fec_fin)
////		end if
////
////		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
////	CASE 'fec_fin'
////		ls_cliente = this.GetItemString(ll_filact,'cliente')		
////		fec_fin = date(this.GetText())
////		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
////		ls = this.GetItemString(ll_filact,'tipo')		
////		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
////			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
////			return 1
////		end if
////		if ls = 'P' then
////			f_genera_estado_cta(ls_cliente,fec_ini,fec_fin)
////		else
////			f_genera_estado_cta_acumulado(ls_cliente,fec_ini,fec_fin)
////		end if
////		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
END CHOOSE
//If dwo.name ='tipo' Then
//		ls= this.GetText()
//		ls_cliente = this.GetItemString(ll_filact,'cliente')	
//		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
//		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
//			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
//			return 1
//		end if
//		if ls = '1' then
//			dw_datos.dataobject = 'dw_rep_facturas_por_vend_clien_total'
//			dw_datos.settransobject(sqlca)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'1',fec_ini,fec_fin,ls_cliente)
//		else
//			dw_datos.dataobject = 'd_estado_cuenta_cartera'
//			dw_datos.settransobject(sqlca)
//		   dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
//		end if
//End if
SetPointer(Arrow!)
end event

type rb_1 from radiobutton within w_rep_estado_de_cuenta
integer x = 2528
integer y = 40
integer width = 489
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
long backcolor = 67108864
string text = "Agrupados"
borderstyle borderstyle = styleraised!
end type

