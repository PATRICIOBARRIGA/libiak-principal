HA$PBExportHeader$w_toma_fisica.srw
$PBExportComments$Si.
forward
global type w_toma_fisica from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_toma_fisica
end type
type cb_1 from commandbutton within w_toma_fisica
end type
type dw_imp from datawindow within w_toma_fisica
end type
type st_1 from statictext within w_toma_fisica
end type
end forward

global type w_toma_fisica from w_sheet_master_detail
integer width = 3077
integer height = 1812
string title = "Toma F$$HEX1$$ed00$$ENDHEX$$sica ...optimizada"
event ue_consultar pbm_custom14
event type long ue_saveas ( )
dw_ubica dw_ubica
cb_1 cb_1
dw_imp dw_imp
st_1 st_1
end type
global w_toma_fisica w_toma_fisica

type variables
string is_mensaje
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

event ue_consultar;dw_master.postevent(DoubleClicked!)
end event

event type long ue_saveas();return dw_report.saveas()
end event

public function integer wf_preprint ();dataWindowChild ldwc_aux
long ll_filActMaestro
string ll_ts_numero,ls_observ

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ll_ts_numero = dw_master.getItemString(ll_filActMaestro, "ts_numero")
ls_observ = dw_master.getitemstring(ll_filActMaestro,"ts_observ")	
dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+& 
						"st_seccion.text = '"+gs_bo_nombre+"' st_observacion.text = '"+ls_observ+"'")
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
                   str_appgeninfo.seccion, ll_ts_numero)
				
return 1

end function

on w_toma_fisica.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.cb_1=create cb_1
this.dw_imp=create dw_imp
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_imp
this.Control[iCurrent+4]=this.st_1
end on

on w_toma_fisica.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.cb_1)
destroy(this.dw_imp)
destroy(this.st_1)
end on

event open;istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion

call super::open
dw_master.is_SerialCodeColumn = "ts_numero"
dw_master.is_SerialCodeType = "TOMFIS"

dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "ds_secue"

dw_master.ii_nrCols = 4
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "bo_codigo"
dw_master.is_connectionCols[4] = "ts_numero"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "bo_codigo"
dw_detail.is_connectionCols[4] = "ts_numero"

dw_detail.uf_setArgTypes()

//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()
Long ll_filact
dw_master.uf_insertCurrentRow()
ll_filact= dw_master.getrow()
dw_master.setitem(ll_filact,"ts_fecha",f_hoy())
dw_master.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
dw_master.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
dw_master.SetItem(ll_filact,"bo_codigo",str_appgeninfo.seccion)
dw_master.setFocus()
dw_detail.setrowfocusindicator(hand!)
end event

event ue_retrieve;//graphicObject lgo_curObject
//long ll_curRow
//
//lgo_curObject = getFocus()
//
//if lgo_curObject.typeof() <> DataWindow! then
//	beep(1)
//	return
//end if
//
//choose case lower(lgo_curObject.className())
//	case "dw_master"
//		dw_master.uf_retrieve()
//	case "dw_detail"
//		ll_curRow = dw_master.getRow()
//		if ll_curRow > 0 then
//			dw_detail.uf_retrieve(ll_curRow)
//		else
//			dw_detail.reset()
//		end if
//end choose

return 1

end event

event activate;call super::activate;//m_marco.m_edicion.m_consultar1.enabled = TRUE
//m_marco.m_edicion.m_consultar1.visible = TRUE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = TRUE
//m_marco.m_opcion1.m_producto.m_buscarproducto2.visible = true
//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
//m_marco.m_opcion1.m_producto.m_buscarproducto2.toolbaritemvisible = true
end event

event ue_print;call super::ue_print;dw_report.modify("datawindow.print.preview.zoom = 100")
end event

type dw_master from w_sheet_master_detail`dw_master within w_toma_fisica
event ue_keydwn pbm_dwnkey
integer x = 0
integer y = 0
integer width = 3045
integer height = 272
string dataobject = "d_cab_toma_fisica"
boolean vscrollbar = false
end type

event dw_master::clicked;call super::clicked;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = false
end event

event dw_master::itemchanged;call super::itemchanged;//long ll_filact 
//ll_filact = this.GetRow()
//this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
//this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
//this.SetItem(ll_filact,"bo_codigo",str_appgeninfo.seccion)
//
//choose case this.GetColumnName()
//CASE 'ts_observ'
//dw_detail.SetFocus()
////w_orden_compra.postevent('ue_insert')
////dw_detail.PostEvent(clicked!)
//window lw_aux
//lw_aux = parent.getActiveSheet()
//if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
////dw_detail.postEvent(itemchanged!)
//
//END CHOOSE
end event

event dw_master::losefocus;call super::losefocus;//CHOOSE CASE this.getColumnName()
//	CASE "ts_observ"
//		dw_detail.SetFocus()
//END CHOOSE
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_toma_fisica
integer x = 0
integer y = 272
integer width = 3045
integer height = 1436
string dataobject = "d_detalle_toma_fisica"
end type

event dw_detail::itemchanged;long ll_filact, ll_filActMaster, ls_null,ll_find,li,ll_end
string  ls_codant, ls_pepa, ls_nombre,ls_numtf,ls_codaux

this.accepttext()
ll_filact = this.getRow()
ll_filActMaster = dw_master.getRow()
ll_end  = this.rowcount()

choose case this.getcolumnname()
CASE 'codant'
     ls_codaux = Message.stringParm	
	If not isnull(ls_codaux) and trim(ls_codaux) <> '' Then
		row = this.getrow()
		data = ls_codaux
		setnull(Message.stringParm)
	End if
     li = 1
	  DO WHILE li <> ll_end
		//Prevent endless loop
      ll_find = dw_detail.Find("codant = '"+data+"'",li,ll_end)
      If ll_find <> row and ll_find <> 0 Then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n", "Existen c$$HEX1$$f300$$ENDHEX$$digos duplicados en la l$$HEX1$$ed00$$ENDHEX$$nea:' "+String(ll_find)+"'~r~npor favor verifique!")
		Return
	   End if	
	   li++ 
     LOOP
	
	// con este voy a buscar
	//primero por codigo anterior
	 select it_codigo, it_nombre
	 into :ls_pepa, :ls_nombre
	 from in_item
	 where em_codigo = :str_appgeninfo.empresa
	 and it_codant = :data;
   
	 if sqlca.sqlcode <> 0 then
		 //luego por codigo de barras
		 select it_codigo, it_codant, it_nombre
		 into :ls_pepa, :ls_codant, :ls_nombre
		 from in_item
		 where em_codigo = :str_appgeninfo.empresa
		 and it_codbar = :data;
		 if sqlca.sqlcode <> 0 then
				setnull(ls_null)
				this.SetItem(ll_filact,"codant",ls_null)
				beep(1)
					 is_mensaje = 'No existe c$$HEX1$$f300$$ENDHEX$$digo de producto'
				return 1
		  else
				this.SetItem(ll_filact,"codant",ls_codant)
		  end if	
	 end if 
  	 this.SetItem(ll_filact,"nombre",ls_nombre)
  	 this.SetItem(ll_filact,"it_codigo",ls_pepa)		
end choose

end event

event dw_detail::clicked;call super::clicked;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 
end event

event dw_detail::losefocus;call super::losefocus;long ll_nreg

CHOOSE CASE this.getcolumnName()

CASE "ds_cantid"
	dw_detail.SetFocus()
//	dw_detail.triggerevent('ue_edi')
//	ls_codant = getitemstring(getrow(),"codant")
//	ll_nreg = dw_detail.rowcount()
//	ll_find =  dw_detail.find("codant = '"+ls_codant+"'",1, ll_nreg - 1)
//	if ll_find <> 0 and ll_nreg <> 1 then
//		messagebox("Error","Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el c$$HEX1$$f300$$ENDHEX$$digo...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find))
//		if getrow() < ll_nreg Then
//			return
//		else
//			deleterow(getrow())
//		   return
//		end if
//	end if
	ll_nreg = dw_detail.InsertRow(0)
	dw_detail.ScrollTORow(ll_nreg)
	dw_detail.SetRow(ll_nreg)	 
	dw_detail.SetColumn('codant')
	dw_detail.PostEvent('ue_postinsert')

END CHOOSE

end event

event dw_detail::ue_postinsert;call super::ue_postinsert;Long ll_fila

str_prodparam.fila = dw_detail.getrow()

ll_fila = dw_detail.getrow()
dw_detail.Object.em_codigo[ll_fila] = str_appgeninfo.empresa
dw_detail.Object.su_codigo[ll_fila] = str_appgeninfo.sucursal
dw_detail.Object.bo_codigo[ll_fila] = str_appgeninfo.seccion
dw_detail.Object.ds_secue[ll_fila] = dw_detail.Object.cc_row[ll_fila]
end event

event dw_detail::itemerror;call super::itemerror;string ls_colname, ls_datatype

ls_colname = dwo.Name
ls_datatype = dwo.ColType

CHOOSE CASE ls_colname

	CASE "codant" 
		string  null_num
		SetNull(null_num)
		This.SetItem(row, ls_colname, null_num)
		MessageBox("ERROR",is_mensaje)
		RETURN 1

END CHOOSE
end event

type dw_report from w_sheet_master_detail`dw_report within w_toma_fisica
integer x = 0
integer y = 256
integer width = 2409
integer height = 1452
string dataobject = "d_rep_detalle_toma_fisica"
borderstyle borderstyle = styleraised!
end type

type dw_ubica from datawindow within w_toma_fisica
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 773
integer y = 832
integer width = 1445
integer height = 280
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Ticket"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls, ls_criterio, ls_tipo,ls_numero
long ll_found,ll_nreg
//
//CHOOSE CASE this.GetColumnName()
//
//	CASE 'factura'
//		ls_tipo = this.GetItemString(1,'tipo')
//		ls = this.getText()
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "ts_numero = " + "'" + ls + "'"
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ticket no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "ts_numero like" + "'" +  ls +"'"
//				dw_master.SetFilter(ls_criterio)
//				dw_master.Filter()
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//				
//		END CHOOSE
//END CHOOSE


CHOOSE CASE this.GetColumnName()
	CASE 'factura'
		ls_numero = this.getText()
		ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numero)
		if ll_nreg <= 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones <Por favor verifique>")
			return
		end if
	   if ll_nreg = 1 then
		dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numero)
		end if	
END CHOOSE
end event

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

type cb_1 from commandbutton within w_toma_fisica
integer x = 2217
integer y = 52
integer width = 709
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar desde archivo"
boolean flatstyle = true
end type

event clicked;string null_str,ls_codant,ls_pepa
long ll_reg,i,ll_new
Decimal{2} lc_cantid

SetNull(null_str)

dw_imp.reset()
dw_imp.ImportFile(null_str)

ll_reg = dw_imp.rowcount()


Setpointer(Hourglass!)
w_marco.SetMicrohelp("Por favor espere mientras termina la importaci$$HEX1$$f300$$ENDHEX$$n...")
for i = 1 to ll_reg
	ls_codant = dw_imp.object.codant[i]
	lc_cantid  = dw_imp.object.cantidad[i]
	
	
	 select it_codigo
	 into :ls_pepa
	 from in_item
	 where em_codigo = :str_appgeninfo.empresa
	 and it_codant = :ls_codant;
		
	ll_new = dw_detail.insertrow(0)
	dw_detail.Object.su_codigo[ll_new] = str_appgeninfo.sucursal
	dw_detail.Object.bo_codigo[ll_new] = str_appgeninfo.seccion
	dw_detail.Object.ds_secue[ll_new] = string(i)
	dw_detail.Object.it_codigo[ll_new]  = ls_pepa
	dw_detail.object.codant[ll_new] = dw_imp.object.codant[i]
	dw_detail.object.nombre[ll_new] = dw_imp.object.descripcion[i]
	dw_detail.Object.ds_cantid[ll_new] = dw_imp.object.cantidad[i]
next
Setpointer(Arrow!)
w_marco.SetMicrohelp("Listo...se han importado "+string(ll_reg)+" filas...")
end event

type dw_imp from datawindow within w_toma_fisica
boolean visible = false
integer x = 928
integer y = 628
integer width = 2793
integer height = 400
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_importa_items_a_tomafis"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_toma_fisica
integer x = 192
integer y = 192
integer width = 498
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
boolean focusrectangle = false
end type

