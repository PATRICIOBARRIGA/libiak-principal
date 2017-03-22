HA$PBExportHeader$w_um_rep_kardex.srw
$PBExportComments$Si.
forward
global type w_um_rep_kardex from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_um_rep_kardex
end type
end forward

global type w_um_rep_kardex from w_sheet_1_dw_rep
integer width = 3813
integer height = 1740
string title = "Reporte de Kardex"
long backcolor = 81324524
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
dw_1 dw_1
end type
global w_um_rep_kardex w_um_rep_kardex

type variables
string   is_pepa 
end variables

on w_um_rep_kardex.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_um_rep_kardex.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;//this.ib_notautoretrieve = true
dw_1.InsertRow(0)
//call super::open
end event

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;String  ls,ls_nombre,ls_codant, ls_valorado,ls_sucursal,ls_seccion
integer li_tipo
decimal{2}    lc_ingegr,lc_stkini,lc_stkact
date    ld_fecha,ld_fini

setpointer(hourglass!)
dw_1.AcceptText()
ls_valorado = dw_1.GetItemString(1,'valorado')
li_tipo        =   dw_1.getitemnumber(1,"tipo")
ld_fini        =   dw_1.GetItemDate(1,"fecha_ini")
ld_fecha    =   dw_1.GetItemDate(1,"fecha_corte")
ls               =   dw_1.GetitemString(1,'codigo')

 // con este voy a buscar
 //primero por codigo anterior
select it_codigo,it_nombre
into :is_pepa,:ls_nombre
from in_item
where em_codigo = : str_appgeninfo.empresa
and it_codant = :ls;
If sqlca.sqlcode <> 0 then
	MessageBox("ERROR","C$$HEX1$$f300$$ENDHEX$$digo no existe, por favor revise lista")
	return
End if
dw_1.setitem(1,"nombre",ls_nombre)

/*Para unomotors el kardex siempre debe ser valorado*/
ls_valorado ='S'

/*Por empresa*/
If li_tipo = 1 then
	select nvl(sum(decode (tm_ioe,'I',mv_cantid,'E',mv_cantid *-1)),0) 
	into    :lc_ingegr
	from   in_movim
	where em_codigo =:str_appgeninfo.empresa
     and     it_codigo = :is_pepa
	and    trunc(mv_fecha) < :ld_fini;
	
     
	select sum(it_stkini), sum(it_stock)
	into    :lc_stkini,:lc_stkact
	from in_itesucur
	where su_codigo not in (90)
	and it_codigo =:is_pepa;


	dw_datos.DataObject = 'd_um_kardex_x_empresa'
	dw_datos.SetTransObject(sqlca)
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'")
	dw_datos.retrieve(str_appgeninfo.empresa,is_pepa,ld_fini,ld_fecha,lc_ingegr,lc_stkini,lc_stkact,ls_valorado)
end if

/*Por sucursal*/
If li_tipo = 2 then
	select nvl(sum(decode (tm_ioe,'I',mv_cantid,'E',mv_cantid *-1)),0) 
	into    :lc_ingegr
	from   in_movim
	where em_codigo =:str_appgeninfo.empresa
	and     su_codigo =:str_appgeninfo.sucursal
	and     it_codigo = :is_pepa
	and    trunc(mv_fecha) < :ld_fini;
	

	dw_datos.DataObject = 'd_um_kardex_x_sucursal'
	dw_datos.SetTransObject(sqlca)
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"'")
	dw_datos.retrieve(str_appgeninfo.sucursal,is_pepa,ld_fini,ld_fecha,lc_ingegr,ls_valorado)
end if

/*Por seccion*/
if li_tipo = 3 then
	select nvl(sum(decode (tm_ioe,'I',mv_cantid,'E',mv_cantid *-1)),0) 
	into    :lc_ingegr
	from   in_movim
	where em_codigo =:str_appgeninfo.empresa
	and     su_codigo =:str_appgeninfo.sucursal
	and     bo_codigo =:str_appgeninfo.seccion
	and     it_codigo = :is_pepa
	and    trunc(mv_fecha) < :ld_fini;
	

	dw_datos.DataObject = 'd_um_kardex_x_seccion'
	dw_datos.SetTransObject(sqlca)
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"'  st_seccion.text = '"+gs_bo_nombre+"'")
	dw_datos.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,is_pepa,ld_fini,ld_fecha,lc_ingegr,ls_valorado)			
end if
dw_datos.Modify("DataWindow.Print.Preview=Yes")
setpointer(arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_um_rep_kardex
integer x = 0
integer y = 296
integer width = 3762
integer height = 1324
integer taborder = 20
string dataobject = "d_um_kardex_x_sucursal"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_um_rep_kardex
integer x = 1029
integer y = 876
integer width = 658
integer height = 336
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_um_rep_kardex
integer x = 174
integer y = 848
end type

type dw_1 from datawindow within w_um_rep_kardex
integer width = 3758
integer height = 288
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_um_sel_item_kardex"
boolean border = false
boolean livescroll = true
end type

event losefocus;//date    ld_fecha
//string  ls_fecha
//
//ld_fecha = dw_1.GetItemDate(1,"fecha_corte")
//ls_fecha = string(ld_fecha,"dd/mm/yyyy")
//declare rp_kardex_sucur procedure for
//  rp_kardex_sucur(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:is_pepa,:ls_fecha)
//  using sqlca;
//execute rp_kardex_sucur;
//if sqlca.sqldbcode <> 0 then
//	MessageBox("ERROR","El proceso no se ejecut$$HEX2$$f3002000$$ENDHEX$$o se ejecut$$HEX2$$f3002000$$ENDHEX$$mal.");
//	Return(1);
//end if
//dw_report.retrieve()
//dw_report.SetFocus()
end event

