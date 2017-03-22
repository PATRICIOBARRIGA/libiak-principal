HA$PBExportHeader$w_kit.srw
$PBExportComments$Si.Ingreso de kits
forward
global type w_kit from w_sheet_1_dw_maint
end type
type dw_master from uo_dw_basic within w_kit
end type
type st_1 from statictext within w_kit
end type
type dw_1 from datawindow within w_kit
end type
type shl_1 from statichyperlink within w_kit
end type
end forward

global type w_kit from w_sheet_1_dw_maint
integer width = 4544
integer height = 2228
string title = "Kits de Productos"
boolean resizable = false
boolean ib_notautoretrieve = true
dw_master dw_master
st_1 st_1
dw_1 dw_1
shl_1 shl_1
end type
global w_kit w_kit

on w_kit.create
int iCurrent
call super::create
this.dw_master=create dw_master
this.st_1=create st_1
this.dw_1=create dw_1
this.shl_1=create shl_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.shl_1
end on

on w_kit.destroy
call super::destroy
destroy(this.dw_master)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.shl_1)
end on

event open;//ib_notautoretrieve = true
dw_master.InsertRow(0)
dw_master.SetFocus()
dw_1.SetTransObject(sqlca)
dw_1.retrieve()
call super::open
end event

event resize;//dataWindow ldw_aux
//
//if this.ib_inReportMode then
//	ldw_aux = dw_report
//	Ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 2*ldw_aux.y)
//else
//	ldw_aux = dw_datos
//	ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() ) // - 2*ldw_aux.y)
//end if
return 1
end event

event ue_update;call super::ue_update;//Recuperar el detalle de kits

dw_1.retrieve()
end event

event ue_saveas;int li_res
li_res = dw_1.saveas()
end event

event ue_delete;long ll_reg,i

ll_reg = dw_1.rowcount()

for i = dw_1.rowcount() to 1 step -1
	if dw_1.object.borrar[i] = 'S' then
		dw_1.deleterow(i)
	end if
next

if dw_1.deletedcount()>0 then
	if dw_1.update()= 1 then
		    commit;
		else
			rollback;
			return
	 end if
end if
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_kit
event ue_keydown pbm_dwnkey
integer y = 148
integer width = 4530
integer height = 352
string dataobject = "d_detalle_kit"
end type

event dw_datos::ue_keydown;if (KeyDown(KeyF2!))	 then
	dw_master.Reset()
	dw_datos.Reset()
	dw_master.InsertRow(0)
	dw_master.SetFocus()
end if
end event

event dw_datos::itemchanged;call super::itemchanged;string ls_kit, ls , ls_pepa, ls_nombre, ls_codant, ls_null
long li_fila, li_filmas
li_fila = this.getRow()
li_filmas = dw_master.getRow()
choose case this.GetColumnName()
  case "codant"
	ls = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	 select it_codigo, it_nombre, it_kit
		into :ls_pepa, :ls_nombre, :ls_kit
		from in_item
	  where em_codigo = : str_appgeninfo.empresa
	    and it_codant = :ls;
   if sqlca.sqlcode <> 0 then
	 //luego por codigo de barras
	 select it_codigo, it_codant, it_nombre, it_kit
		into :ls_pepa, :ls_codant, :ls_nombre, :ls_kit
		from in_item
	  where em_codigo = : str_appgeninfo.empresa
	    and it_codbar = :ls;
     if sqlca.sqlcode <> 0 then
		setnull(ls_null)
		this.SetItem(li_fila,"codant",ls_null)
		this.SetItem(li_fila,"nombre",ls_null)
		beep(1)
//		is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
		messagebox("Reintente Operaci$$HEX1$$f300$$ENDHEX$$n","No existe c$$HEX1$$f300$$ENDHEX$$digo de producto",StopSign!)
		return
	  else
		this.SetItem(li_fila,"codant",ls_codant)
	end if	 
 end if 	
ls_kit = dw_master.getItemString(li_filmas,"it_codigo")
this.SetItem(li_fila,"it_codigo",ls_pepa)
this.SetItem(li_fila,"nombre",ls_nombre)
this.SetItem(li_fila,"it_codigo1",ls_kit)
this.SetItem(li_fila,"em_codigo",str_appgeninfo.empresa)
end choose
end event

event dw_datos::clicked;call super::clicked;
//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = false
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_datos.GetRow() 
dw_datos.SetColumn('codant')
dw_datos.SetFocus()

end event

event dw_datos::losefocus;call super::losefocus;//CHOOSE CASE this.getcolumnName()
//
//CASE "ri_observ"
//window lw_aux
//lw_aux = parent.getActiveSheet()
//dw_datos.SetFocus()
//if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
//this.SetColumn('codant')
//
//END CHOOSE
//
end event

event dw_datos::ue_postinsert;call super::ue_postinsert;str_prodparam.fila = this.GetRow()
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_kit
end type

type dw_master from uo_dw_basic within w_kit
event ue_keydown pbm_dwnkey
integer width = 4539
integer height = 132
integer taborder = 2
string dataobject = "d_sel_kit"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event ue_keydown;call super::ue_keydown;if (KeyDown(KeyF2!))	 then
	dw_master.Reset()
	dw_datos.Reset()
	dw_master.InsertRow(0)
	dw_master.SetFocus()
end if
end event

event clicked;call super::clicked;
//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = false
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_master.GetRow() 
dw_master.SetFocus()
end event

event itemchanged;call super::itemchanged;string ls_kit, ls , ls_pepa, ls_nombre, ls_codant, ls_null
int li_fila

li_fila = this.GetRow()
choose case this.GetColumnName()
	case "codant"
	ls = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	 select it_codigo, it_nombre, it_kit
		into :ls_pepa, :ls_nombre, :ls_kit
		from in_item
	  where em_codigo = : str_appgeninfo.empresa
	    and it_codant = :ls;
   if sqlca.sqlcode <> 0 then
	 //luego por codigo de barras
	 select it_codigo, it_codant, it_nombre, it_kit
		into :ls_pepa, :ls_codant, :ls_nombre, :ls_kit
		from in_item
	  where em_codigo = : str_appgeninfo.empresa
	    and it_codbar = :ls;
     if sqlca.sqlcode <> 0 then
		setnull(ls_null)
		this.SetItem(li_fila,"codant",ls_null)
		this.SetItem(li_fila,"nombre",ls_null)
		this.SetItem(li_fila,"it_codigo",ls_null)
		beep(1)
//		is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
		messagebox("Reintente Operaci$$HEX1$$f300$$ENDHEX$$n","No existe c$$HEX1$$f300$$ENDHEX$$digo de producto",StopSign!)
		return
	  else
		this.SetItem(li_fila,"codant",ls_codant)
	end if	 
 end if 		
if ls_kit = 'S' then
		this.setitem(li_fila, 'nombre',ls_nombre)
		this.SetItem(li_fila,"it_codigo",ls_pepa)
		if dw_datos.retrieve(str_appgeninfo.empresa,ls_pepa) < 1 then
			dw_datos.InsertRow(0)
			dw_datos.PostEvent(Clicked!)
		end if
else
	setnull(ls_null)
	this.SetItem(li_fila,"codant",ls_null)
	this.SetItem(li_fila,"nombre",ls_null)
	this.SetItem(li_fila,"it_codigo",ls_null)
	beep(1)	
//	is_mensaje = "El producto no fue definido como kit"
	messagebox("Reintente Operaci$$HEX1$$f300$$ENDHEX$$n","El producto no fue definido como kit",StopSign!)
	return 
end if
end choose
end event

type st_1 from statictext within w_kit
integer x = 2322
integer y = 72
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "<F2> Nuevo Kit"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_kit
integer y = 576
integer width = 4535
integer height = 1564
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_inrelitem"
boolean livescroll = true
end type

event rowfocuschanged;this.setRowFocusIndicator(hand!)
end event

type shl_1 from statichyperlink within w_kit
integer x = 32
integer y = 512
integer width = 855
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Equivalencias de kits"
boolean focusrectangle = false
end type

