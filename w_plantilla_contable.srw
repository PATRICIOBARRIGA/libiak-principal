HA$PBExportHeader$w_plantilla_contable.srw
$PBExportComments$Si. Para mantenimiento de los Modelos de Asientos Contables,
forward
global type w_plantilla_contable from w_sheet_master_detail
end type
type st_1 from statictext within w_plantilla_contable
end type
end forward

global type w_plantilla_contable from w_sheet_master_detail
integer width = 4114
integer height = 1500
string title = "Plantillas Contables"
long backcolor = 81324524
st_1 st_1
end type
global w_plantilla_contable w_plantilla_contable

type variables
datawindowChild dwc_cuentas

end variables

on w_plantilla_contable.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_plantilla_contable.destroy
call super::destroy
destroy(this.st_1)
end on

event open;f_recupera_empresa(dw_master,"ti_codigo")
f_recupera_empresa(dw_detail,"cs_codigo")


istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

call super::open
dw_master.ii_nrCols = 3
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "ct_codigo"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "ct_codigo"
dw_detail.uf_setArgTypes()
//dw_detail.SetRowFocusIndicator(Hand!)
dw_master.uf_insertCurrentRow()
dw_master.setfocus()
/***/
dw_detail.GetChild("pl_codigo",dwc_cuentas)
dwc_cuentas.SetTransObject(SQLCA)
dwc_cuentas.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

f_recupera_empresa(dw_detail,"pl_codigo_1")

//dw_1.settransobject(sqlca)
//dw_1.retrieve()

end event

event ue_update;Long ll_secuencial,rc,ll_row
dwitemstatus l_status

ll_row = dw_master.getrow()
if ll_row <= 0 then return


l_status = dw_master.getitemstatus(ll_row,0,primary!)
if l_status = new! or l_status = newmodified! then
ll_secuencial = f_secuencial(str_appgeninfo.empresa,"AUTOMATICO")
else
ll_secuencial = long(dw_master.GetitemString(ll_row,"ct_codigo"))
end if

/**/
If ll_secuencial < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial..Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return 
End if 

dw_master.SetItem(ll_row,"ct_codigo",string(ll_secuencial))


rc = dw_master.update(true,false)
if rc = 1 then
    rc = dw_detail.update(true,false)
    if rc = 1 then
	 dw_master.resetupdate()
	 dw_detail.resetupdate()
	 commit;	
    else
	 rollback;
	 return
    end if
else
rollback;
return
end if


dwc_cuentas.SetFilter("")
dwc_cuentas.Filter() 
dw_detail.GetChild("pl_codigo",dwc_cuentas)
dw_master.Setfocus()
end event

event ue_edit;call super::ue_edit;//ib_edit = true
//dw_master.ii_nrocolsAct = 3			
//dw_master.is_activecols[1] = 'cp_fecha'
//dw_master.is_activecols[2] = 'ti_codigo'
//dw_master.is_activecols[3] = 'cp_observ'
//dw_master.uf_active(ib_edit)
//dw_master.uf_changebackground(ib_edit,16777215 , 67108864)


/*Activa detalle*/
//dw_detail.ii_nrocolsAct = 5			
//dw_detail.is_activeCols[1] = 'pl_codigo'
//dw_detail.is_activeCols[2] = 'cs_codigo'
//dw_detail.is_activeCols[3] = 'dt_signo'
//dw_detail.is_activeCols[4] = 'dt_valor'
//dw_detail.is_activeCols[5] = 'dt_detalle'
//
//dw_detail.uf_active(ib_edit)
//dw_detail.uf_changebackground(ib_edit,16777215 , 67108864)


dw_detail.enabled = true
return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_plantilla_contable
event ue_nextfield pbm_dwnprocessenter
integer x = 0
integer y = 0
integer width = 4078
integer taborder = 0
string dataobject = "d_cabaut"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_master::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_master::ue_postinsert;call super::ue_postinsert;Long ll_row 

ll_row = This.GetRow()
This.SetITem(ll_row,"em_codigo",str_appgeninfo.empresa)
This.SetITem(ll_row,"su_codigo",str_appgeninfo.sucursal)
Return 1
end event

event dw_master::itemchanged;call super::itemchanged;dwItemStatus l_status

If  dwo.name  =  "ct_observ" &
Then
l_status  = dw_master.getitemStatus(row,0,primary!)
If l_status =  new! or l_status = newmodified! then
dw_detail.SetFocus()
dw_detail.InsertRow(0)
dw_detail.SetColumn('pl_codigo')
end if 
End if
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_plantilla_contable
event ue_nextfield pbm_dwnprocessenter
event ue_tabout pbm_dwntabout
integer x = 0
integer y = 420
integer width = 4078
integer height = 980
string title = "Detalle"
string dataobject = "d_comp_automatico"
borderstyle borderstyle = stylebox!
end type

event dw_detail::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_detail::ue_tabout;Long ll_new
If getcolumnName() = "ct_descri" &
Then
ll_new = This.insertrow(0)
This.SetRow(ll_new)
This.Scrolltorow(ll_new)
This.SetColumn(5)
End if 
end event

event dw_detail::editchanged;call super::editchanged;String ls_data
If dwo.name = "pl_codigo" &
Then
ls_data = data+'%'
dwc_cuentas.SetFilter("co_plansuc_pl_codigo like '"+ls_data+"' ")
dwc_cuentas.Filter()
This.GetChild("pl_codigo",dwc_cuentas)
End if 
Return 1
end event

event dw_detail::updatestart;call super::updatestart;/*Insertar los datos de  la clave al detalle*/

Long  ll_nreg ,ll_row ,i
String ls_ctcodigo,ls_tipo

dw_master.AcceptText()
ll_row            = dw_master.GetRow()
ls_ctcodigo  = dw_master.GetItemString(ll_row , "ct_codigo")
ll_nreg          = This.RowCount()
For i = 1 to ll_nreg
	 This.SetItem(i,"em_codigo",str_appgeninfo.empresa)
  	 This.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
	 This.SetItem(i,"ct_codigo",ls_ctcodigo)
Next 	
Return 0

end event

event dw_detail::itemchanged;call super::itemchanged;String ls_cencos,ls_null
Setnull(ls_null)

if dwo.name = "pl_codigo"&
then
	
	select pl_cencos
	into :ls_cencos
	from co_placta
	where em_codigo = :str_appgeninfo.empresa
	and pl_codigo = :data;
	
	if sqlca.sqlcode < 0 &
	then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al determinar el Centro de costos"+sqlca.sqlerrtext)
	Return
	end if
	
	if ls_cencos ='N'or ls_cencos = ' ' or isnull(ls_cencos)&
	then
	this.Modify("cs_codigo.Protect=1")
	this.setitem(row,"cs_codigo",ls_null)
   else
	this.Modify("cs_codigo.Protect=0")	
	end if
		
end if	
end event

type dw_report from w_sheet_master_detail`dw_report within w_plantilla_contable
integer x = 2139
integer y = 808
integer width = 1435
integer taborder = 0
end type

type st_1 from statictext within w_plantilla_contable
integer x = 91
integer y = 356
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Detalle"
boolean focusrectangle = false
end type

