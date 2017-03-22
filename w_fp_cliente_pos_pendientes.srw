HA$PBExportHeader$w_fp_cliente_pos_pendientes.srw
$PBExportComments$Pantalla para ubicar los cheques de un cliente dado
forward
global type w_fp_cliente_pos_pendientes from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_fp_cliente_pos_pendientes
end type
end forward

global type w_fp_cliente_pos_pendientes from w_sheet_1_dw_maint
integer width = 2743
integer height = 1876
string title = "Consulta: Formas de Pago Pendientes "
long backcolor = 67108864
dw_1 dw_1
end type
global w_fp_cliente_pos_pendientes w_fp_cliente_pos_pendientes

type variables
char ich_tipo
end variables

on w_fp_cliente_pos_pendientes.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_fp_cliente_pos_pendientes.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;datawindowchild ldwc_fp

dw_1.insertrow(0)
dw_1.setfocus()
dw_1.setitem(1,"fecha",today())
dw_1.getChild("forma_pago", ldwc_fp)
ldwc_fp.setTransObject(sqlca)
ldwc_fp.retrieve(str_appgeninfo.empresa)
ldwc_fp.setfilter("fp_string like '%V%'")
ldwc_fp.filter()

select sa_tipo
into :ich_tipo
from sg_acceso 
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username;

ib_notautoretrieve = true
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

int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;string ls_fpago,ls_cuenta,ls_docum,ls_sqldwnew,rc,ls_addwhere,ls_sqloriginal
date ld_fecha
integer row, li_condicion

setpointer(hourglass!)
dw_datos.reset()
ls_sqloriginal = dw_datos.describe("DataWindow.Table.Select")

dw_1.accepttext()
row = dw_1.getrow()
ls_fpago = dw_1.GetItemString(row,'forma_pago')
ld_fecha = dw_1.GetItemDate(row,'fecha')
ls_cuenta = dw_1.GetItemString(row,'nro_cta')
ls_docum = dw_1.GetItemString(row,'nro_docum')

if (isnull(ls_cuenta) or ls_cuenta = "") then li_condicion = 0
if (isnull(ls_docum) or ls_docum = "") then li_condicion = 0
if ls_cuenta <> "" then li_condicion = 1
if ls_docum <> "" then li_condicion = 2
if (ls_cuenta <> "") and (ls_docum <> "") then	li_condicion = 3	

choose case li_condicion
	case 0
		dw_datos.retrieve('2',str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_fpago,ld_fecha)		
	case 1
		ls_addwhere = " and (~~~"FA_RECPAG~~~".~~~"RP_NUMCTA~~~" = ~~~'"+ls_cuenta+"~~~')"
		ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"
		rc = dw_datos.modify(ls_sqldwnew)
		IF rc = "" THEN
		dw_datos.retrieve('2',str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_fpago,ld_fecha)
		ELSE
		MessageBox("Error", "Fallo Modify " + rc)
		END IF
	case 2
		ls_addwhere = " and (~~~"FA_RECPAG~~~".~~~"RP_NUMDOC~~~" =  ~~~'"+ls_docum+"~~~' )"
		ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"
		rc = dw_datos.modify(ls_sqldwnew)
		IF rc = "" THEN	
		dw_datos.retrieve('2',str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_fpago,ld_fecha)
		ELSE
		MessageBox("Error", "Fallo Modify " + rc)
		END IF
	case 3
		ls_addwhere = " and (~~~"FA_RECPAG~~~".~~~"RP_NUMCTA~~~" =  ~~~'"+ls_cuenta+"~~~' )"+&
		"and (~~~"FA_RECPAG~~~".~~~"RP_NUMDOC~~~" =  ~~~'"+ls_docum+"~~~' )"
		ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"
		rc = dw_datos.modify(ls_sqldwnew)
		IF rc = "" THEN
		dw_datos.retrieve('2',str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_fpago,ld_fecha)
		ELSE
		MessageBox("Error", "Fallo Modify " + rc)
		END IF
		
end choose

dw_datos.Modify("DataWindow.Table.Select ='"+ls_sqloriginal+"'")
setpointer(arrow!)

end event

event closequery;return
end event

event ue_insert;return 1
end event

event w_fp_cliente_pos_pendientes::ue_delete;call super::ue_delete;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_fp_cliente_pos_pendientes
event ue_keydown pbm_dwnkey
integer y = 248
integer width = 2670
integer height = 1452
integer taborder = 20
string dataobject = "d_fp_clientes_pos_pendiente"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;return 1
end event

event dw_datos::updatestart;date ldt_servidor,ldt_fecven

dw_datos.AcceptText()

select trunc(sysdate)
into : ldt_servidor
from dual;

If dw_datos.rowcount() = 0 Then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No hay datos para actualizar",StopSign!,ok!)
return 1
End if

//ldt_fecven = date(dw_datos.GetItemDatetime(dw_datos.getrow(),"rp_fecven"))
ldt_fecven = date(dw_datos.GetItemDatetime(dw_datos.getrow(),"rp_fecven",primary!,true))
If ldt_fecven >= ldt_servidor Then
	dw_datos.SetItem(dw_datos.getrow(),"rp_comen",'S')
else
	if ich_tipo <> 'C' and ich_tipo <> 'A' then
		messagebox("Error","La fecha de vencimiento es menor que la fecha actual",StopSign!,ok!)
		dw_datos.SetItem(dw_datos.getrow(),"rp_fecven",ldt_fecven)
		return 1
	end if
End if
Return 0




  

end event

event dw_datos::doubleclicked;call super::doubleclicked;
if ich_tipo = 'C' or ich_tipo = 'A' then
	dw_datos.Object.rp_fecven.Protect = False
end if

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_fp_cliente_pos_pendientes
integer x = 46
integer y = 284
integer width = 768
integer taborder = 30
end type

type dw_1 from datawindow within w_fp_cliente_pos_pendientes
event ue_nextfield pbm_dwnprocessenter
integer width = 2670
integer height = 248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_fp_cli_pos_pendiente"
borderstyle borderstyle = styleraised!
end type

event ue_nextfield;Send(handle(this),256,9,long(0,0))
return 1
end event

