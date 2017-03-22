HA$PBExportHeader$w_um_rep_mov_x_empresa.srw
forward
global type w_um_rep_mov_x_empresa from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_um_rep_mov_x_empresa
end type
type em_2 from editmask within w_um_rep_mov_x_empresa
end type
type st_1 from statictext within w_um_rep_mov_x_empresa
end type
type st_2 from statictext within w_um_rep_mov_x_empresa
end type
end forward

global type w_um_rep_mov_x_empresa from w_sheet_1_dw_rep
integer width = 3515
integer height = 1876
string title = "Resumen de Mov. por tipo"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_um_rep_mov_x_empresa w_um_rep_mov_x_empresa

on w_um_rep_mov_x_empresa.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_um_rep_mov_x_empresa.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;Date ld_fecini,ld_fecfin
String ls_tipmov,ls_tipomov,ls_mov,ls_seccion,ls_ioe,ls_filtro,ls_sec,ls_tmcodigo[],ls_texto
integer i =1
long ll_nreg

SetPointer(Hourglass!)



ld_fecini  = date(em_1.text)
ld_fecfin  = date(em_2.text)
dw_datos.Retrieve(str_appgeninfo.empresa,ld_fecini,ld_fecfin)	
SetPointer(Arrow!)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_um_rep_mov_x_empresa
integer x = 32
integer y = 156
integer width = 3424
integer height = 1604
integer taborder = 20
string dataobject = "d_um_mov_x_tipo"
boolean hsplitscroll = true
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text ='"+gs_empresa+"'")

end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_um_rep_mov_x_empresa
integer x = 1600
integer y = 1028
integer taborder = 30
string dataobject = "d_um_mov_x_tipo"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_um_rep_mov_x_empresa
integer x = 2560
integer y = 1196
integer taborder = 50
end type

type em_1 from editmask within w_um_rep_mov_x_empresa
integer x = 288
integer y = 40
integer width = 334
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_um_rep_mov_x_empresa
integer x = 882
integer y = 40
integer width = 334
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_um_rep_mov_x_empresa
integer x = 82
integer y = 48
integer width = 197
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_um_rep_mov_x_empresa
integer x = 690
integer y = 48
integer width = 187
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
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

