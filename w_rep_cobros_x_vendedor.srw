HA$PBExportHeader$w_rep_cobros_x_vendedor.srw
$PBExportComments$PARA SATEXPRO
forward
global type w_rep_cobros_x_vendedor from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_cobros_x_vendedor
end type
type em_2 from editmask within w_rep_cobros_x_vendedor
end type
type st_1 from statictext within w_rep_cobros_x_vendedor
end type
type st_2 from statictext within w_rep_cobros_x_vendedor
end type
type st_3 from statictext within w_rep_cobros_x_vendedor
end type
type st_4 from statictext within w_rep_cobros_x_vendedor
end type
type dw_1 from datawindow within w_rep_cobros_x_vendedor
end type
type cbx_1 from checkbox within w_rep_cobros_x_vendedor
end type
type cb_1 from commandbutton within w_rep_cobros_x_vendedor
end type
type dw_4 from datawindow within w_rep_cobros_x_vendedor
end type
type dw_3 from datawindow within w_rep_cobros_x_vendedor
end type
type dw_2 from datawindow within w_rep_cobros_x_vendedor
end type
type rb_1 from radiobutton within w_rep_cobros_x_vendedor
end type
type rb_2 from radiobutton within w_rep_cobros_x_vendedor
end type
type rb_3 from radiobutton within w_rep_cobros_x_vendedor
end type
end forward

global type w_rep_cobros_x_vendedor from w_sheet_1_dw_rep
integer width = 5701
integer height = 2284
string title = "Cobros  por vendedor"
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
dw_1 dw_1
cbx_1 cbx_1
cb_1 cb_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_rep_cobros_x_vendedor w_rep_cobros_x_vendedor

event ue_retrieve;Date ld_ini,ld_fin
String ls_epcodigo,rc,ls_nulo,ls_sqloriginal,ls_addwhere,ls_texto,ls_sqldwnew


ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if cbx_1.checked then
	//dw_datos.dataobject = 'd_rep_cobros_x_vendedor_all'
	//dw_datos.SetTransobject(sqlca)
	//dw_datos.retrieve(ld_ini,ld_fin)
elseif rb_2.checked then
	dw_datos.dataobject = 'd_rep_cobros_x_vendedor_redcolor'
	dw_datos.SetTransobject(sqlca)
	ls_epcodigo = dw_1.Object.ep_codigo[1]
	dw_datos.retrieve(ld_ini,ld_fin,ls_epcodigo)
elseif rb_3.checked then
	dw_datos.dataobject = 'd_rep_cobros_x_vendedor_redcolor_com'
	dw_datos.SetTransobject(sqlca)
	ls_epcodigo = dw_1.Object.ep_codigo[1]
	dw_datos.retrieve()
end if
dw_datos.visible = true
dw_datos.BringtoTop = true
dw_datos.modify("st_empresa.text  = '"+gs_empresa+"'")
end event

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_2.SettransObject( sqlca )
dw_3.SetTransObject( sqlca )
dw_4.SetTransObject( sqlca )
f_recupera_empresa(dw_1,"ep_codigo")

dw_1.Insertrow(0)

end event

on w_rep_cobros_x_vendedor.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.dw_1=create dw_1
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cbx_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.rb_1
this.Control[iCurrent+14]=this.rb_2
this.Control[iCurrent+15]=this.rb_3
end on

on w_rep_cobros_x_vendedor.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_1)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
end on

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cobros_x_vendedor
boolean visible = false
integer x = 46
integer y = 260
integer width = 5591
integer height = 1884
string dataobject = "d_rep_cobros_x_vendedor_redcolor"
boolean vscrollbar = false
boolean hsplitscroll = true
boolean livescroll = false
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cobros_x_vendedor
integer x = 197
integer y = 996
integer taborder = 60
string dataobject = "d_rep_cobros_x_vendedor_redcolor"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cobros_x_vendedor
integer x = 3835
integer y = 1132
integer taborder = 80
end type

type em_1 from editmask within w_rep_cobros_x_vendedor
integer x = 1147
integer y = 140
integer width = 343
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_cobros_x_vendedor
integer x = 1792
integer y = 140
integer width = 343
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_cobros_x_vendedor
integer x = 891
integer y = 152
integer width = 224
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

type st_2 from statictext within w_rep_cobros_x_vendedor
integer x = 1577
integer y = 152
integer width = 206
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

type st_3 from statictext within w_rep_cobros_x_vendedor
integer x = 914
integer y = 68
integer width = 763
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
string text = "Ingrese el per$$HEX1$$ed00$$ENDHEX$$odo de  cancelaci$$HEX1$$f300$$ENDHEX$$n"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_cobros_x_vendedor
boolean visible = false
integer x = 2213
integer y = 60
integer width = 297
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
string text = "Asesor:"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rep_cobros_x_vendedor
boolean visible = false
integer x = 2208
integer y = 132
integer width = 1193
integer height = 84
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dwc_listaempleados"
boolean border = false
boolean livescroll = true
end type

event itemchanged;cbx_1.checked = false
end event

type cbx_1 from checkbox within w_rep_cobros_x_vendedor
boolean visible = false
integer x = 2789
integer y = 40
integer width = 599
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos los asesores"
boolean lefttext = true
end type

event clicked;dw_1.object.ep_codigo[1] = ''
end event

type cb_1 from commandbutton within w_rep_cobros_x_vendedor
boolean visible = false
integer x = 2203
integer y = 128
integer width = 649
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar cobros"
end type

event clicked;Long i, ll_reg,j, ll_rc,ll_new,ll_count
Decimal{2} lc_saldodeb,lc_saldocre,lc_valcre,lc_valdeb,lc_valorpago
String ls_movcre,ls_suc,ls_movdeb,ls_movcreant,ls_fpcodigo,ls_chnumero,ls_ttcodigo,ls_ttioe,ls_ttcoddeb,ls_ttioedeb
Date  ld_fecefec,ld_fecha,ld_fini,ld_ffin





ld_fini = date(em_1.text)
ld_ffin= date(em_2.text)

dw_datos.visible= false


ll_reg  = dw_2.retrieve(str_appgeninfo.empresa,ld_fini ,ld_ffin)

dw_4.reset()
ll_count = dw_4.Retrieve(str_appgeninfo.empresa,ld_fini,ld_ffin) 

if ll_count > 0 then
	
	if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya se realiz$$HEX2$$f3002000$$ENDHEX$$el proceso para este per$$HEX1$$ed00$$ENDHEX$$odo...Desea volver a ejecutarlo....?" ,Question!,YesNo!,2) = 2 then
		return
	end if
	
     DELETE FROM CC_COMISIONES
     WHERE TRUNC(CR_FECHA) BETWEEN :ld_fini and:ld_ffin;
	
	
end if

UPDATE CC_CRUCE
SET CR_VALCRE = CR_valdeb
WHERE TRUNC(CR_FECHA) BETWEEN :ld_fini and :ld_ffin;
If sqlca.sqlcode <> 0 Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el valor en la tabla de cruces...! "+sqlca.sqlerrtext)
	Rollback;
	return
end if

//Recuperar pagos

w_marco.SetMicrohelp("Calculando comisiones....Por favor espere...!!!")
dw_4.reset()
for i= 1 to ll_reg
	     ls_ttcodigo = dw_2.Object.tt_codigo[i]
		ls_ttioe = dw_2.Object.tt_ioe[i]  
		ls_movcre = dw_2.object.mt_codigo[ i ]
		ls_suc = dw_2.Object.su_codigo[ i ]
		ld_fecha =   date(dw_2.Object.ch_fecha[i])
		ld_fecefec = date(dw_2.Object.ch_fecefec[i])
		ls_fpcodigo =dw_2.Object.fp_codigo[i]
		ls_chnumero = dw_2.Object.ch_numero[i]
		lc_valorpago =  dw_2.object.ch_valor[ i ] 
	    
	     lc_saldocre = lc_valorpago
		
		//Recuperar solo si se tiene un nuevo nro de mov de credito
		
		if ls_movcreant <> ls_movcre then 
		ll_rc = dw_3.retrieve(str_appgeninfo.empresa,ls_suc,ls_movcre)
		end if
		
		for j = 1 to ll_rc
			
			if lc_saldocre > 0 then
			 
//				     if j= 1 then 
//						lc_saldodeb =  dw_3.Object.cr_valdeb[j ]
//					else
						lc_saldodeb   = dw_3.Object.cr_saldo[j ]
//					end if
					
					if lc_saldodeb = 0 then continue
					ls_ttcoddeb= dw_3.Object.tt_coddeb[j]
					ls_ttioedeb = dw_3.Object.tt_ioedeb[j]
					ls_movdeb = dw_3.Object.mt_coddeb[j ]
					lc_valdeb = lc_saldodeb  
					if lc_valdeb > 0 then
						
						     ll_new = dw_4.insertrow(0)
							 dw_4.Object.em_codigo[ll_new] = '1'
							dw_4.Object.su_codigo[ll_new] = ls_suc
							dw_4.Object.tt_codigo[ll_new] = ls_ttcodigo
							dw_4.Object.tt_ioe[ll_new] = ls_ttioe
							dw_4.Object.mt_codigo[ll_new] = ls_movcre
							
							dw_4.Object.tt_coddeb[ll_new] = ls_ttcoddeb
							dw_4.Object.tt_ioedeb[ll_new] = ls_ttioedeb
							dw_4.Object.mt_coddeb[ll_new] = ls_movdeb
														
							
							dw_4.Object.mt_codigo[ll_new] = ls_movcre
							dw_4.Object.mt_coddeb[ll_new] = ls_movdeb
							
							dw_4.Object.fp_codigo[ll_new] = ls_fpcodigo
							dw_4.Object.ch_fecefec[ll_new] = ld_fecefec
							dw_4.Object.cr_fecha[ll_new] = ld_fecha
							dw_4.Object.ch_numero[ll_new]= ls_chnumero
							
							 if lc_saldodeb <= lc_saldocre then
								dw_4.Object.cr_valdeb[ll_new] = lc_valdeb
								lc_saldodeb = lc_saldodeb - lc_valdeb
							     lc_saldocre  = lc_saldocre  - lc_valdeb
								dw_3.Object.cr_saldo[j]= lc_saldodeb  
							else
								 dw_4.Object.cr_valdeb[ll_new] = lc_saldocre
								lc_saldodeb = lc_saldodeb - lc_saldocre
								lc_saldocre  = lc_saldocre  - lc_saldocre
								dw_3.Object.cr_saldo[j]= lc_saldodeb 
							 end if
					end if
					
			end if
			
      next
	ls_movcreant = ls_movcre
next
w_marco.SetMicrohelp("Listo...Para ver el resultado por favor presione Ctrl+ R....")
end event

type dw_4 from datawindow within w_rep_cobros_x_vendedor
integer x = 46
integer y = 1020
integer width = 5595
integer height = 1128
integer taborder = 90
string title = "Comisiones"
string dataobject = "d_pagos_comisiones"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event updatestart;
Long ll_sec,i

select max(to_number(secuencial))
into :ll_sec
from cc_comisiones;

if sqlca.sqlcode = 100 then
	ll_sec = 0
end if

if isnull(ll_sec)then ll_sec = 0 

this.Setfilter("" )
this.filter()
for i = 1 to this.rowcount()
	this.object.secuencial[i] = ll_sec +1 
	ll_sec = ll_sec +1
next
return 0
end event

type dw_3 from datawindow within w_rep_cobros_x_vendedor
integer x = 2583
integer y = 260
integer width = 3054
integer height = 752
integer taborder = 100
string title = "Cancelaciones"
string dataobject = "d_pagos_cruzados_cxc"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

type dw_2 from datawindow within w_rep_cobros_x_vendedor
integer x = 46
integer y = 260
integer width = 2528
integer height = 752
integer taborder = 70
string title = "Pagos"
string dataobject = "d_pagos_cxc"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event rowfocuschanged;String ls_movcredito,ls_sucursal
Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

ls_movcredito = this.Object.mt_codigo[currentrow]
ls_sucursal = this.Object.su_codigo[currentrow]

dw_3.Retrieve(str_appgeninfo.empresa,ls_sucursal,ls_movcredito)

dw_4.Setfilter("mt_codigo  = '"+ls_movcredito+"' and su_codigo = '"+ls_sucursal+"'")
dw_4.filter()

end event

type rb_1 from radiobutton within w_rep_cobros_x_vendedor
integer x = 91
integer y = 24
integer width = 622
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Procesar cobros"
end type

event getfocus;if rb_1.checked = true then
cb_1.visible = true
st_1.visible = true
st_2.visible = true
st_3.visible = true
st_4.visible = false
dw_1.visible = false
em_1.visible = true
em_2.visible = true
end if
end event

event clicked;if rb_1.checked  then
cb_1.visible = true
st_1.visible = true
st_2.visible = true
st_3.visible = true
st_4.visible = false
dw_1.visible = false
em_1.visible = true
em_2.visible = true
end if
end event

type rb_2 from radiobutton within w_rep_cobros_x_vendedor
integer x = 91
integer y = 100
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver cobros procesados"
end type

event getfocus;if rb_2.checked then
	cb_1.visible = false
	dw_1.visible = true
	st_1.visible = true
	st_2.visible = true
	st_3.visible = true
	st_4.visible = true
	dw_1.visible = true
	em_1.visible = true
	em_2.visible = true

end if
end event

event clicked;if rb_2.checked = true then
	cb_1.visible = false
	dw_1.visible = true
	st_1.visible = true
	st_2.visible = true
	st_3.visible = true
	st_4.visible = true
	dw_1.visible = true
	em_1.visible = true
	em_2.visible = true

end if
end event

type rb_3 from radiobutton within w_rep_cobros_x_vendedor
integer x = 91
integer y = 172
integer width = 626
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calcular comisiones"
end type

event clicked;if rb_3.checked then
cb_1.visible = false
st_1.visible = false
st_2.visible = false
st_3.visible = false
st_4.visible = false
dw_1.visible = false
em_1.visible = false
em_2.visible = false
end if
end event

event getfocus;if rb_3.checked then
cb_1.visible = false
st_1.visible = false
st_2.visible = false
st_3.visible = false
st_4.visible = false
dw_1.visible = false
em_1.visible = false
em_2.visible = false
end if
end event

