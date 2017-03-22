HA$PBExportHeader$w_opciones_por_rol.srw
forward
global type w_opciones_por_rol from w_sheet_1_dw_maint
end type
type tv_1 from treeview within w_opciones_por_rol
end type
type dw_sel from datawindow within w_opciones_por_rol
end type
type st_1 from statictext within w_opciones_por_rol
end type
type cb_inserta from commandbutton within w_opciones_por_rol
end type
end forward

global type w_opciones_por_rol from w_sheet_1_dw_maint
integer width = 2071
integer height = 1820
string title = "Opciones por Rol"
long backcolor = 79741120
boolean ib_notautoretrieve = true
event ue_populate ( )
tv_1 tv_1
dw_sel dw_sel
st_1 st_1
cb_inserta cb_inserta
end type
global w_opciones_por_rol w_opciones_por_rol

type variables
Datastore ids_source
String   is_rol
end variables

event ue_populate();TreeViewItem		ltvi_emp
long li_rows,li_cnt,ll_tvi
string ls_nulo = 'NULO'
long tvi_hdl = 0

SetPointer(HourGlass!)

// Populate the tree with menu
ids_Source.Reset()
li_rows = ids_source.retrieve(is_rol)
ids_source.setfilter("isnull(mn_padre)")
ids_source.filter()


 
/**/
DO UNTIL tv_1.FindItem(RootTreeItem!, 0) = -1
         tv_1.DeleteItem(tvi_hdl)
LOOP
/**/
ltvi_Emp.pictureindex = 1
ltvi_Emp.selectedpictureindex = 2
ltvi_Emp.children = true

li_rows = ids_source.rowcount()
For li_Cnt = 1 To li_Rows
	ltvi_Emp.label = ids_Source.Object.mn_nombre[li_Cnt]
	ltvi_Emp.pictureindex = 1
	ltvi_Emp.selectedpictureindex = 2
	ltvi_Emp.children = true
	ltvi_Emp.data = ids_Source.Object.mn_codigo[li_Cnt]
	if ids_source.object.rm_habilitado[li_cnt] = 'S'then
	ltvi_Emp.statepictureindex = 2
   else
	ltvi_Emp.statepictureindex = 1
   end if
	tv_1.InsertItemLast(0, ltvi_Emp)
Next



end event

on w_opciones_por_rol.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_sel=create dw_sel
this.st_1=create st_1
this.cb_inserta=create cb_inserta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_sel
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_inserta
end on

on w_opciones_por_rol.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.dw_sel)
destroy(this.st_1)
destroy(this.cb_inserta)
end on

event open;call super::open;DataWindowChild   ldwc_aux

ids_Source = Create DataStore
ids_Source.DataObject = "d_habilitar_opciones_menu"
ids_Source.SetTransObject(sqlca)

ids_source.sharedata(dw_datos)


dw_sel.InsertRow(0)
dw_sel.SetItem(1,"rol",'ADMINISTRADOR') //por default
dw_sel.GetChild("rol",ldwc_aux)

ldwc_aux.setTransObject(sqlca)
ldwc_aux.Retrieve("ADMINISTRADOR")


/**/
is_rol = 'ADMINISTRADOR'
Post Event ue_populate()

end event

event resize;RETURN 1
end event

event ue_update;dw_datos.Setfilter("")
dw_datos.Filter()
dw_datos.Update()
commit;
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_opciones_por_rol
boolean visible = false
integer x = 1545
integer y = 204
integer width = 425
integer height = 1480
integer taborder = 20
string dataobject = "d_habilitar_opciones_menu"
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_opciones_por_rol
integer x = 2569
integer y = 68
integer width = 443
integer height = 124
integer taborder = 30
end type

type tv_1 from treeview within w_opciones_por_rol
integer x = 46
integer y = 196
integer width = 1458
integer height = 1172
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hasbuttons = false
boolean haslines = false
boolean hideselection = false
boolean tooltips = false
boolean checkboxes = true
string picturename[] = {"Custom039!","Custom050!","DropDownListBox!","Run!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event key;Long          ll_rows,ll_row,i,ll_handle,ll_level,ll_find,ll_tvc
String        ls_flag,ls_mncodigo
TreeViewItem  ltvi_Current

SetPointer(HourGlass!)

ll_rows = ids_source.rowcount()
ll_row = ids_source.getrow()


IF keyflags = 2 THEN
	IF key = KeyEnter! THEN
		
		ll_handle = tv_1.FindItem(CurrentTreeItem!,0)
		tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=2
		tv_1.setitem(ll_handle,ltvi_current)
		for i = 1 to ll_rows
		ll_handle = tv_1.FindItem(PreviousTreeItem!,ll_handle)	
  	   tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=2
		tv_1.setitem(ll_handle,ltvi_current)
		ids_source.object.rm_habilitado[i]= 'S'
		next

		/**/
		ll_handle = tv_1.FindItem(CurrentTreeItem!,0)
		tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=2
		tv_1.setitem(ll_handle,ltvi_current)
		for i = 1 to ll_rows
		ll_handle = tv_1.FindItem(NextTreeItem!,ll_handle)	
  	   tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=2
		tv_1.setitem(ll_handle,ltvi_current)
		ids_source.object.rm_habilitado[i]= 'S'
		next
		
	END IF
ELSEIF Keyflags = 1 THEN
	IF key = KeyEnter! THEN
		ll_handle = tv_1.FindItem(CurrentTreeItem!,0)
		tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=1
		tv_1.setitem(ll_handle,ltvi_current)
		for i = 1 to ll_rows
		ll_handle = tv_1.FindItem(PreviousTreeItem!,ll_handle)	
  	   tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=1
		tv_1.setitem(ll_handle,ltvi_current)
		ids_source.object.rm_habilitado[i]= 'N'
		next

		/**/
		ll_handle = tv_1.FindItem(CurrentTreeItem!,0)
		tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=1
		tv_1.setitem(ll_handle,ltvi_current)
		for i = 1 to ll_rows
		ll_handle = tv_1.FindItem(NextTreeItem!,ll_handle)	
  	   tv_1.GetItem(ll_handle,ltvi_current)
		ltvi_current.statepictureindex=1
		tv_1.setitem(ll_handle,ltvi_current)
		ids_source.object.rm_habilitado[i]= 'N'
		next
		
	END IF
ELSEIF keyflags = 0 THEN
   IF key = KeySpaceBar! THEN
		ll_handle = tv_1.FindItem(CurrentTreeItem!,0)
		tv_1.GetItem(ll_handle,ltvi_current)
		ls_mncodigo = ltvi_current.Data
		ll_find = ids_source.Find("mn_codigo = '"+ls_mncodigo+"'",1,ll_rows)
		if ll_find <> 0 then 
			ls_flag = ids_source.object.rm_habilitado[ll_find]
			if ls_flag = 'N'then
			ids_source.object.rm_habilitado[ll_find]= 'S'
			else
			ids_source.object.rm_habilitado[ll_find]= 'N'
			end if
  	   end if
	END IF
END IF

SetPointer(Arrow!)
end event

event selectionchanged;// Display the data for the record selected in the DataWindows
Int               li_tvp 
String            ls_rol 
String				ls_mncodigo,ls_mnpadre
TreeViewItem		ltvi_Current,ltvi_parent


SetPointer(HourGlass!)
Parent.SetRedraw(False)

// Function to display the data for the record selected in the 
// appropriate DataWindow.

li_tvp = tv_1.FindItem(ParentTreeItem!,newhandle)
If li_tvp <> -1 then
tv_1.GetItem(li_tvp,ltvi_Parent)
ls_mnpadre = ltvi_Parent.Data
ids_source.SetFilter("mn_padre ='"+ls_mnpadre+"'")
ids_source.Filter()
else
ids_source.SetFilter("isnull(mn_padre)")
ids_source.Filter()
end if


Parent.SetRedraw(True)
SetPointer(Arrow!)
end event

event itempopulate;// Populate the tree with this item's children

Integer				li_Level,li_Rows
Long					ll_Parent
TreeViewItem		ltvi_Current,ltvi_emp
String            ls_mncodigo  
long              li_cnt  

//SetPointer(HourGlass!)

// Determine the level
GetItem(handle, ltvi_Current)
li_Level = ltvi_Current.Level + 1
// Determine the Retrieval arguments for the new data
ls_mncodigo = ltvi_Current.Data

/*Verificar si tiene hijos*/
select count(*)
into  :li_rows
from   sg_menu
where  mn_padre = :ls_mncodigo;

If li_rows = 0 then 	return

// Retrieve the data
ids_source.setfilter("mn_padre ='"+ls_mncodigo+"'")
ids_source.filter()
li_rows = ids_source.rowcount()

For li_Cnt = 1 To li_Rows
	ltvi_Emp.label = ids_Source.Object.mn_nombre[li_Cnt]
	ltvi_Emp.pictureindex = 3
	ltvi_Emp.selectedpictureindex = 4
	ltvi_Emp.children = true
	ltvi_Emp.data = ids_Source.Object.mn_codigo[li_Cnt]
	if ids_source.object.rm_habilitado[li_cnt] = 'S'then
	ltvi_Emp.statepictureindex = 2
   else
	ltvi_Emp.statepictureindex = 1
   end if
	tv_1.InsertItemLast(handle,ltvi_Emp)
Next

Setpointer(Arrow!)




end event

event itemexpanded;int               li_tvp
String				ls_mncodigo,ls_mnpadre
TreeViewItem		ltvi_Current,ltvi_parent
Long              ll_handchild


SetPointer(HourGlass!)
Parent.SetRedraw(False)
// Function to display the data for the record selected in the 
// appropriate DataWindow.
tv_1.GetItem(handle,ltvi_Parent)
ls_mnpadre = ltvi_Parent.Data
ids_source.SetFilter("mn_padre ='"+ls_mnpadre+"'")
ids_source.Filter()
Parent.SetRedraw(True)
ll_handchild = tv_1.FindItem(ChildTreeItem!,handle)	
tv_1.SelectItem(ll_handchild)
SetPointer(Arrow!)
end event

event clicked;return 1
end event

event itemcollapsed;int               li_tvp
String				ls_mncodigo,ls_mnpadre
TreeViewItem		ltvi_Current,ltvi_parent

SetPointer(Arrow!)

end event

type dw_sel from datawindow within w_opciones_por_rol
integer x = 50
integer y = 44
integer width = 1481
integer height = 128
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_rol"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_rol = data
parent.triggerevent("ue_populate")
end event

type st_1 from statictext within w_opciones_por_rol
integer x = 59
integer y = 1400
integer width = 1440
integer height = 184
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Presione Ctrl+ Enter para seleccionar un niveI; Shift + Enter para deseleccionar un nivel; Barra espaciadora para seleccionar un solo item"
boolean focusrectangle = false
end type

type cb_inserta from commandbutton within w_opciones_por_rol
integer x = 1559
integer y = 56
integer width = 448
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar &Opciones"
end type

event clicked;string ls_rol
int li_nreg

ls_rol = dw_sel.getitemstring(dw_sel.getrow(),"rol")

select count(*)
into:li_nreg
from sg_rolmenu
where rs_nombre = :ls_rol;
if li_nreg = 0 Then
	insert into sg_rolmenu
	select mn_codigo,:ls_rol,rm_habilitado,null 
	from sg_rolmenu
	where rs_nombre = 'ADMINISTRADOR';
	commit;
	is_rol = ls_rol
	parent.triggerevent("ue_populate")
End if



end event

