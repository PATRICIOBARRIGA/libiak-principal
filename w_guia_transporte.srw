HA$PBExportHeader$w_guia_transporte.srw
$PBExportComments$Si.Guia de transporte para despachos de pedidos
forward
global type w_guia_transporte from w_sheet_master_detail
end type
type st_1 from statictext within w_guia_transporte
end type
type dw_1 from uo_dw_basic within w_guia_transporte
end type
type cb_1 from commandbutton within w_guia_transporte
end type
end forward

global type w_guia_transporte from w_sheet_master_detail
integer width = 5339
integer height = 1948
string title = "Guia de Transporte"
long backcolor = 81324524
st_1 st_1
dw_1 dw_1
cb_1 cb_1
end type
global w_guia_transporte w_guia_transporte

type variables
date id_hoy
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();dataWindowChild ldwc_aux
long ll_filActMaestro,ll_reg,i
string ls_numero
long ll_numfact[]

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ls_numero = dw_master.getItemString(ll_filActMaestro, "gu_numero")
ll_reg = dw_detail.rowcount()
if ll_reg <= 0 then return -1

/*Para recuperar con la clave primaria de la fa_venta*/
for i = 1 to ll_reg
ll_numfact[i] =  dw_detail.Object.ve_numero[i]
next

//dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,dw_master.getitemstring(dw_master.getrow(),'gu_numero'),str_appgeninfo.seccion)		
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_numfact,str_appgeninfo.seccion)		
return 1

end function

event open;string ls_parametro[], ls_datos[]
date ld_hoy
datawindowchild dwc,dwcresponsable

id_hoy = date(f_hoy())
f_recupera_empresa(dw_master,'ep_codigo')

istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
call super::open

dw_master.ii_nrCols = 1
dw_master.is_connectionCols[1] = "gu_numero"
dw_detail.is_connectionCols[1] = "gu_numero"
dw_detail.uf_setArgTypes()
//dw_detail.SetRowFocusIndicator(Hand!)

dw_master.uf_insertCurrentRow()

/*Recuperar las facturas pendientes de despacho*/
dw_1.settransobject(sqlca)
dw_1.retrieve(str_appgeninfo.sucursal,id_hoy)




end event

on w_guia_transporte.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
end on

on w_guia_transporte.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event ue_update;long   ll_filmas, ll_fil, ll, ll_borradas, ll_ve
string ls_numero, ls_null,  ls_gu

ll_filmas = dw_master.GetRow()
ls_numero = dw_master.GetItemString(ll_filmas,'gu_numero')
If isnull(ls_numero) or ls_numero = ''&
Then
	/*Tomar el secuencial de la Gu$$HEX1$$ed00$$ENDHEX$$a*/
	SELECT pr_valor
	INTO   :ll
	FROM   pr_param
	WHERE  em_codigo = :str_appgeninfo.empresa
	AND    pr_nombre = 'GUIA_TR';
	If sqlca.sqlcode <> 0 then
		messageBox('Error Interno','No se puede encontrar el n$$HEX1$$fa00$$ENDHEX$$mero de Guia')
		return
	End if
	UPDATE pr_param
	SET    pr_valor = pr_valor + 1
	WHERE  em_codigo = :str_appgeninfo.empresa
	AND    pr_nombre = 'GUIA_TR';
	If sqlca.sqlcode < 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Problemas al generar el secuencial')
		Rollback;
		return
	End if

	ls_numero = string(ll)
	dw_master.SetItem(ll_filmas,'em_codigo',str_appgeninfo.empresa)
	dw_master.SetItem(ll_filmas,'su_codigo',str_appgeninfo.sucursal)
	dw_master.SetItem(ll_filmas,'gu_numero',ls_numero)	
End if
Setnull(ls_null)
dw_master.SetTransObject(sqlca)

/*Actualiza*/
If dw_master.Update(true,false) = 1 then
	ll_fil = dw_detail.RowCount()
	//If isnull(dw_detail.GetItemString(ll_fil,'ve_numpre')) then ll_fil = ll_fil -1
	For ll = 1 to ll_fil
		dw_detail.SetItemStatus(ll, 0, Primary!, DataModified!)
		dw_detail.SetItem(ll,'gu_numero',ls_numero)		
	Next
	If dw_detail.Update(true,false) = 1 Then
		dw_master.ResetUpdate() // Both updates are OK
		dw_detail.ResetUpdate() // Clear update flags
		COMMIT USING SQLCA;		
         dw_detail.Retrieve(ls_numero)		
         //dw_detail.print()
	else
		messageBox('Error al grabar','Problemas al grabar el detalle de la guia. '+sqlca.sqlerrtext)
		rollback using sqlca;		
		return
	End if
else
		messageBox('Error al grabar','Problemas al grabar la cabecera de la guia. ' +sqlca.sqlerrtext)
		rollback using sqlca;		
		return
End if
        
/*Recupera los despachos pendientes*/		  
//dw_report.print()
If wf_preprint() = 1 then
dw_report.print()
end if
dw_1.retrieve(str_appgeninfo.sucursal,id_hoy)

		  
end event

event ue_delete;call super::ue_delete;graphicObject lgo_curObject
long ll_curRow, li_res
uo_dw_basic ludw_basic

lgo_curObject = getFocus()

// solo se puede borrar en el detalle
If lower(lgo_curObject.className()) = "dw_detail" & 
Then
	ll_curRow = dw_detail.GetRow()
	beep(1)
	Return
End if

end event

event ue_print;dwItemStatus   lst_estado
long ll_curRowMaster
w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then
	if dw_report.print() = 1 then
		if this.wf_postPrint() = 1 then
			this.setRedraw(False)
			dw_report.enabled = False
			dw_report.visible = False
			dw_master.enabled = True
			dw_master.visible = True
			dw_detail.enabled = True
			dw_detail.visible = True
			this.ib_inReportMode = False
			this.triggerEvent(resize!)	
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_outof_report_mode()
		end if
	end if		
else
	ll_curRowMaster = dw_master.getRow()
	if ll_curRowMaster < 1 then
		beep(1)
		return
	end if
	
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.enabled = True
			dw_report.visible = True
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
								  "datawindow.print.preview=yes")
			dw_report.modify("st_empresa.text = 'PINTULAC' st_sucursal.text = '"+gs_su_nombre+"'")					  
			dw_master.enabled = False
			dw_master.visible = False
			dw_detail.enabled = False
			dw_detail.visible = False
			dw_1.enabled = False
			dw_1.visible = False
			this.ib_inReportMode = True
			this.triggerEvent(resize!)
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_into_report_mode()
			this.Setredraw(true)
		end if
end if
end event

event close;call super::close
 
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - dw_master.width,li_height - 100)
dw_detail.resize(dw_detail.width, li_height - dw_master.height) 
this.setRedraw(True)
return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_guia_transporte
integer x = 0
integer y = 0
integer width = 2208
integer height = 308
string dataobject = "d_guia_despacho"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;If dwo.name = 'gu_vehiculo' Then
	dw_detail.SetFocus()
	dw_detail.InsertRow(0)
	dw_detail.PostEvent(clicked!)
End if
end event

event dw_master::ue_predelete;this.ii_deleteFlag = 0
beep(1)
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"gu_fecha",f_hoy())

end event

type dw_detail from w_sheet_master_detail`dw_detail within w_guia_transporte
integer x = 5
integer y = 328
integer width = 2208
integer height = 1472
integer taborder = 40
string dragicon = "Imagenes\row.ico"
string dataobject = "d_detalle_guia"
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event dw_detail::itemchanged;long numero, ll_filact,null
datetime fecha
decimal valor
string numpre, clien, guia,codcli

If dwo.name = 've_numero' &
Then
		 numero = long(data)
		 SELECT  "FA_VENTA"."VE_NUMPRE",   
					"FA_VENTA"."VE_FECHA",   
					"FA_VENTA"."VE_VALPAG",   
					"FA_CLIEN"."CE_CODIGO"||' '||NVL("FA_CLIEN"."CE_RAZONS",'')||' / '||DECODE("FA_CLIEN"."CE_TIPO",'N',"FA_CLIEN"."CE_NOMBRE"||' '||"FA_CLIEN"."CE_APELLI","FA_CLIEN"."CE_NOMREP"||' '||"FA_CLIEN"."CE_APEREP") "cliente",   
					"FA_VENTA"."GU_NUMERO",
					"FA_CLIEN"."CE_CODIGO"
			 INTO :numpre, :fecha, :valor, :clien, :guia,:codcli
		    FROM "FA_VENTA",   
					"FA_CLIEN"  
		   WHERE ( "FA_CLIEN"."CE_CODIGO" = "FA_VENTA"."CE_CODIGO" ) and  
					( "FA_CLIEN"."EM_CODIGO" = "FA_VENTA"."EM_CODIGO" ) and  
					( ( "FA_VENTA"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
					( "FA_VENTA"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
					( "FA_VENTA"."ES_CODIGO" = '1' ) AND  
					( "FA_VENTA"."VE_NUMERO" = :numero ) );
		 if sqlca.sqlcode <> 0 then
			  messageBox('Error','La factura no existe o fue anulada')
		  	    this.ib_inErrorCascade = true
				 setnull(null)
				 this.SetItem(ll_filact,'ve_numero',null)
				 return			  
		 end if
		 If not isnull(guia) then
			  if messagebox('Confirme por favor','La factura ya fue ingresada en la Gu$$HEX1$$ed00$$ENDHEX$$a No. ' + guia + '. Desea reemplazar',Question!,YesNo!) = 2 then 
				  this.ib_inErrorCascade = true
				  setnull(null)
				  this.SetItem(ll_filact,'ve_numero',null)
				  return
			  end if
		End if			  
		this.SetItem(row,'ve_numpre',numpre)
		this.SetItem(row,'ve_fecha',fecha)
		this.SetItem(row,'ve_valpag',valor)		
		this.SetItem(row,'cliente',clien)
		this.SetItem(row,'gu_numero',guia)
		this.SetItem(row,'em_codigo',str_appgeninfo.empresa)
		this.SetItem(row,'su_codigo',str_appgeninfo.sucursal)	
		this.SetItem(row,'bo_codigo',str_appgeninfo.seccion)	
      this.SetItem(row,'es_codigo','1')
		this.SetRow(this.InSertRow(0))
		this.rowcount()
	   this.SetColumn('ve_numero')
					
End If










end event

event dw_detail::dragdrop;call super::dragdrop;/////////////////////////////////////////////////////////////////////////////////////////

DataWindow ldw_Source
long ll_venumero,ll_new
long null,ll_row
datetime fecha
decimal valor
string numpre, clien, guia,codcli


IF source.TypeOf() = DataWindow! THEN
		ldw_Source = source
      ll_row = ldw_source.getrow()
		IF ll_row > 0 THEN
			ll_venumero = ldw_source.getitemNumber(ll_row,"ve_numero")
			ldw_source.deleterow(ll_row)
			ll_new = this.insertrow(0) 
			this.setitem(ll_new,"ve_numero",ll_venumero)
			/**/
       	SELECT  "FA_VENTA"."VE_NUMPRE",   
					"FA_VENTA"."VE_FECHA",   
					"FA_VENTA"."VE_VALPAG",   
					"FA_CLIEN"."CE_CODIGO"||' '||NVL("FA_CLIEN"."CE_RAZONS",'')||' / '||DECODE("FA_CLIEN"."CE_TIPO",'N',"FA_CLIEN"."CE_NOMBRE"||' '||"FA_CLIEN"."CE_APELLI","FA_CLIEN"."CE_NOMREP"||' '||"FA_CLIEN"."CE_APEREP") "cliente",   
					"FA_VENTA"."GU_NUMERO",
					"FA_CLIEN"."CE_CODIGO"
			INTO :numpre, :fecha, :valor, :clien, :guia,:codcli
		   FROM "FA_VENTA",   
					"FA_CLIEN"  
		   WHERE ( "FA_CLIEN"."CE_CODIGO" = "FA_VENTA"."CE_CODIGO" ) and  
					( "FA_CLIEN"."EM_CODIGO" = "FA_VENTA"."EM_CODIGO" ) and  
					( ( "FA_VENTA"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
					( "FA_VENTA"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
					( "FA_VENTA"."ES_CODIGO" = '1' ) AND  
					( "FA_VENTA"."VE_NUMERO" = :ll_venumero ) );
		   if sqlca.sqlcode <> 0 then
			   messageBox('Error','La factura no existe o fue anulada')
		  	   this.ib_inErrorCascade = true
				setnull(null)
				this.SetItem(ll_new,'ve_numero',null)
				return			  
		   end if
		   If not isnull(guia) then
			   if messagebox('Confirme por favor','La factura ya fue ingresada en la Gu$$HEX1$$ed00$$ENDHEX$$a No. ' + guia + '. Desea reemplazar',Question!,YesNo!) = 2 then 
				  this.ib_inErrorCascade = true
				  setnull(null)
				  this.SetItem(ll_new,'ve_numero',null)
				  return
			   end if
		   End if			  
			this.SetItem(ll_new,'ve_numpre',numpre)
			this.SetItem(ll_new,'ve_fecha',fecha)
			this.SetItem(ll_new,'ve_valpag',valor)		
			this.SetItem(ll_new,'cliente',clien)
			this.SetItem(ll_new,'gu_numero',guia)
			this.SetItem(ll_new,'em_codigo',str_appgeninfo.empresa)
			this.SetItem(ll_new,'su_codigo',str_appgeninfo.sucursal)	
			this.SetItem(ll_new,'bo_codigo',str_appgeninfo.seccion)	
			this.SetItem(ll_new,'es_codigo','1')
		END IF
END IF



end event

event dw_detail::clicked;call super::clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////

//Check the user clicked on a valid row
if row > 0 then
	
	// Select the Clicked row
	dw_detail.SelectRow(0, false)
	dw_detail.SelectRow(row, true)
	// Begin the drag
	this.drag(begin!)
end if
end event

type dw_report from w_sheet_master_detail`dw_report within w_guia_transporte
integer x = 466
integer y = 80
integer width = 3643
integer height = 1824
integer taborder = 10
string dataobject = "d_rep_guia_despacho"
end type

type st_1 from statictext within w_guia_transporte
integer x = 2249
integer y = 32
integer width = 585
integer height = 68
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
string text = "Despachos Pendientes"
boolean focusrectangle = false
end type

type dw_1 from uo_dw_basic within w_guia_transporte
integer x = 2254
integer y = 140
integer width = 3022
integer height = 1664
integer taborder = 11
string dragicon = "imagenes\row.ico"
boolean bringtotop = true
string dataobject = "d_despachos_pendientes"
boolean border = true
boolean hsplitscroll = true
end type

event dragdrop;/////////////////////////////////////////////////////////////////////////////////////////

DataWindow ldw_Source
long ll_venumero,ll_new
long null,ll_row
datetime fecha
decimal valor
string numpre, clien, guia,codcli,dir,obs


IF source.TypeOf() = DataWindow! THEN
		ldw_Source = source
         ll_row = ldw_source.getrow()
		IF ll_row > 0 THEN
			ll_venumero = ldw_source.getitemNumber(ll_row,"ve_numero")
			ldw_source.deleterow(ll_row)
			ll_new = this.insertrow(0) 
			this.setitem(ll_new,"ve_numero",ll_venumero)
			/**/
			SELECT "FA_CLIEN"."CE_RAZONS"||' '||"FA_CLIEN"."CE_NOMREP"||' '||"FA_CLIEN"."CE_APEREP",
			"FA_CLIEN"."CE_CADOM1"||' '||"FA_CLIEN"."CE_SECDOM",
			"FA_VENTA"."VE_OBSERV"
			INTO	:clien,:dir,:obs
			FROM   "FA_VENTA","FA_CLIEN"  
			WHERE ("FA_CLIEN"."EM_CODIGO"= "FA_VENTA"."EM_CODIGO")AND 
			("FA_CLIEN"."CE_CODIGO"= "FA_VENTA"."CE_CODIGO")AND 
			("FA_VENTA"."ES_CODIGO" = '1' ) AND  
			("FA_VENTA"."EM_CODIGO" = :str_appgeninfo.empresa)AND
			("FA_VENTA"."SU_CODIGO" = :str_appgeninfo.sucursal)AND
			("FA_VENTA"."BO_CODIGO"= :str_appgeninfo.seccion)AND
			("FA_VENTA"."GU_NUMERO" is null ) AND  
			("FA_VENTA"."VE_NUMERO" = :ll_venumero);
			if sqlca.sqlcode <> 0 then
				messageBox('Error','La factura no existe o fue anulada')
				return			  
			end if
			
			this.SetItem(ll_new,'cliente',clien)
			this.SetItem(ll_new,'ve_numero',ll_venumero)
			this.setitem(ll_new,'cc_direccion',dir)
			this.setitem(ll_new,'ve_observ',obs)
		END IF
END IF



end event

event clicked;call super::clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////

//Check the user clicked on a valid row
if row > 0 then
	
	// Select the Clicked row
	dw_1.SelectRow(0, false)
	dw_1.SelectRow(row, true)
	
	// Begin the drag
	this.drag(begin!)
end if
end event

type cb_1 from commandbutton within w_guia_transporte
integer x = 2912
integer y = 28
integer width = 343
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refrescar"
end type

event clicked;dw_1.retrieve(str_appgeninfo.sucursal,id_hoy)
end event

