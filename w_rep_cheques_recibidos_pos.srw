HA$PBExportHeader$w_rep_cheques_recibidos_pos.srw
$PBExportComments$Si  Cheques recibidos en el POS
forward
global type w_rep_cheques_recibidos_pos from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_cheques_recibidos_pos
end type
end forward

global type w_rep_cheques_recibidos_pos from w_sheet_1_dw_rep
integer width = 2912
integer height = 1552
string title = "Cheques Recibidos (POS)"
long backcolor = 1090519039
dw_sel_rep dw_sel_rep
end type
global w_rep_cheques_recibidos_pos w_rep_cheques_recibidos_pos

on w_rep_cheques_recibidos_pos.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_cheques_recibidos_pos.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;string ls_parametro[]
this.ib_notautoretrieve = true
ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal
f_recupera_datos(dw_sel_rep,'caja',ls_parametro,2)
f_recupera_datos(dw_sel_rep,'cajero',ls_parametro,2)
dw_sel_rep.InsertRow(0)
dw_datos.SetTransObject(sqlca)

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

event ue_retrieve;string ls_caja,ls_cajero,ls_emple
decimal lc_cambche 
date fecha

dw_sel_rep.accepttext()
SetPointer(HourGlass!)

ls_caja = dw_sel_rep.GetItemString(1,"caja")
ls_cajero = dw_sel_rep.GetItemString(1,"cajero")
fecha = dw_sel_rep.GetItemDate(1,'fecha')
SELECT NVL(SUM("FA_MOVCAJA"."MC_VALOR"),0)  
 INTO :lc_cambche 
 FROM "FA_MOVCAJA"  
WHERE ( "FA_MOVCAJA"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
		( "FA_MOVCAJA"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
		( "FA_MOVCAJA"."TJ_CODIGO" = '3' ) AND
		( TRUNC("FA_MOVCAJA"."MC_FECHA") = :fecha ) AND 
		( "FA_MOVCAJA"."CJ_CAJA" = :ls_caja ) AND
		( "FA_MOVCAJA"."EP_CODIGO" = :ls_cajero );
		
select ep_nombre||' '||ep_apepat
into :ls_emple
from no_emple
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :ls_cajero;

dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_cajero.text = '"+ls_emple+"'")
dw_datos.Retrieve(integer(str_appgeninfo.sucursal),fecha,ls_caja,ls_cajero,lc_cambche)
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cheques_recibidos_pos
integer x = 0
integer y = 176
integer width = 2875
integer height = 1272
string dataobject = "d_rep_cheques_recibidos_pos_summary"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cheques_recibidos_pos
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cheques_recibidos_pos
end type

type dw_sel_rep from datawindow within w_rep_cheques_recibidos_pos
integer width = 2875
integer height = 188
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_caja_fecha_final"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

