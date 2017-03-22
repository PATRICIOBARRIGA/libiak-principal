HA$PBExportHeader$w_pipe.srw
forward
global type w_pipe from window
end type
type st_cnx from statictext within w_pipe
end type
type st_leyenda from statictext within w_pipe
end type
type rb_3 from radiobutton within w_pipe
end type
type rb_items from radiobutton within w_pipe
end type
type rb_1 from radiobutton within w_pipe
end type
type p_1 from picture within w_pipe
end type
type st_7 from statictext within w_pipe
end type
type st_6 from statictext within w_pipe
end type
type st_5 from statictext within w_pipe
end type
type dw_1 from datawindow within w_pipe
end type
type st_4 from statictext within w_pipe
end type
type st_3 from statictext within w_pipe
end type
type st_2 from statictext within w_pipe
end type
type st_1 from statictext within w_pipe
end type
type cb_2 from commandbutton within w_pipe
end type
type dw_pipe_errors from datawindow within w_pipe
end type
type gb_1 from groupbox within w_pipe
end type
type gb_2 from groupbox within w_pipe
end type
type gb_3 from groupbox within w_pipe
end type
type gb_4 from groupbox within w_pipe
end type
type ln_1 from line within w_pipe
end type
type ln_2 from line within w_pipe
end type
type cb_1 from commandbutton within w_pipe
end type
end forward

global type w_pipe from window
integer width = 2953
integer height = 1720
boolean titlebar = true
string title = "Pipa"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_cnx st_cnx
st_leyenda st_leyenda
rb_3 rb_3
rb_items rb_items
rb_1 rb_1
p_1 p_1
st_7 st_7
st_6 st_6
st_5 st_5
dw_1 dw_1
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
dw_pipe_errors dw_pipe_errors
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
ln_1 ln_1
ln_2 ln_2
cb_1 cb_1
end type
global w_pipe w_pipe

type variables
Transaction  itrans_origen, itrans_destino
uo_pipe        iuo_pipa

end variables

on w_pipe.create
this.st_cnx=create st_cnx
this.st_leyenda=create st_leyenda
this.rb_3=create rb_3
this.rb_items=create rb_items
this.rb_1=create rb_1
this.p_1=create p_1
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.dw_1=create dw_1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_pipe_errors=create dw_pipe_errors
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.ln_1=create ln_1
this.ln_2=create ln_2
this.cb_1=create cb_1
this.Control[]={this.st_cnx,&
this.st_leyenda,&
this.rb_3,&
this.rb_items,&
this.rb_1,&
this.p_1,&
this.st_7,&
this.st_6,&
this.st_5,&
this.dw_1,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.dw_pipe_errors,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.ln_1,&
this.ln_2,&
this.cb_1}
end on

on w_pipe.destroy
destroy(this.st_cnx)
destroy(this.st_leyenda)
destroy(this.rb_3)
destroy(this.rb_items)
destroy(this.rb_1)
destroy(this.p_1)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_pipe_errors)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.cb_1)
end on

event open;/*Inicia la transferencia*/
iuo_pipa = CREATE uo_pipe


iuo_pipa.ist_status_read     =  st_1
iuo_pipa.ist_status_written =  st_2
iuo_pipa.ist_status_error    =  st_3

end event

type st_cnx from statictext within w_pipe
integer x = 110
integer y = 504
integer width = 745
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_leyenda from statictext within w_pipe
integer x = 475
integer y = 356
integer width = 1888
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_pipe
integer x = 699
integer y = 32
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Precios"
end type

type rb_items from radiobutton within w_pipe
integer x = 699
integer y = 180
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Items"
end type

type rb_1 from radiobutton within w_pipe
integer x = 699
integer y = 104
integer width = 759
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stocks (In_itesucur,in_itebod)"
end type

type p_1 from picture within w_pipe
integer x = 325
integer y = 32
integer width = 201
integer height = 204
string picturename = "Destination5!"
boolean focusrectangle = false
end type

type st_7 from statictext within w_pipe
integer x = 64
integer y = 36
integer width = 270
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Operaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type st_6 from statictext within w_pipe
integer x = 73
integer y = 356
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estado"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pipe
boolean visible = false
integer x = 219
integer y = 624
integer width = 347
integer height = 216
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contenido extra$$HEX1$$ed00$$ENDHEX$$do de la tabla"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_pipe
boolean visible = false
integer x = 594
integer y = 612
integer width = 1765
integer height = 332
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pipe
integer x = 50
integer y = 648
integer width = 197
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Errores:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pipe
integer x = 2007
integer y = 504
integer width = 343
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pipe
integer x = 1522
integer y = 508
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pipe
integer x = 1047
integer y = 504
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pipe
integer x = 2459
integer y = 196
integer width = 407
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop"
end type

type dw_pipe_errors from datawindow within w_pipe
integer x = 50
integer y = 720
integer width = 2318
integer height = 856
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pipe
integer x = 55
integer y = 448
integer width = 832
integer height = 136
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Conecciones de base de datos"
end type

type gb_2 from groupbox within w_pipe
integer x = 1019
integer y = 448
integer width = 402
integer height = 136
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filas escritas"
end type

type gb_3 from groupbox within w_pipe
integer x = 1970
integer y = 444
integer width = 402
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filas con error"
end type

type gb_4 from groupbox within w_pipe
integer x = 1490
integer y = 444
integer width = 402
integer height = 136
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filas le$$HEX1$$ed00$$ENDHEX$$das"
end type

type ln_1 from line within w_pipe
long linecolor = 10789024
integer linethickness = 4
integer beginx = 2354
integer beginy = 616
integer endx = 46
integer endy = 616
end type

type ln_2 from line within w_pipe
long linecolor = 10789024
integer linethickness = 4
integer beginx = 37
integer beginy = 340
integer endx = 2354
integer endy = 340
end type

type cb_1 from commandbutton within w_pipe
integer x = 2455
integer y = 64
integer width = 411
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Transferir"
end type

event clicked;integer li_sr,li_rorigen ,li_rdestino
 
itrans_origen = CREATE transaction
itrans_origen.dbms = "O10"
itrans_origen.database =''
itrans_origen.logid = 'dvinueza'
itrans_origen.logpass = 'vida'
itrans_origen.servername = 'motoruno'
CONNECT USING itrans_origen;

if itrans_origen.SQLCode = 0 then
li_rorigen = 1
st_cnx.text = 'Conexi$$HEX1$$f300$$ENDHEX$$n con matriz establecida'
else
li_rorigen = 0
st_cnx.text = 'Conexi$$HEX1$$f300$$ENDHEX$$n con matriz desconectada'
Messagebox("Conexi$$HEX1$$f300$$ENDHEX$$n con Matriz","Conecci$$HEX1$$f300$$ENDHEX$$n no establecida ..."+itrans_origen.sqlerrtext)
end if


itrans_destino = CREATE transaction
itrans_destino.dbms = "O10"
itrans_destino.database =''
itrans_destino.logid = str_appgeninfo.username
itrans_destino.logpass = str_appgeninfo.password
itrans_destino.servername = ''
CONNECT USING itrans_destino;

if itrans_origen.SQLCode = 0 then
li_rdestino = 1
st_cnx.text = 'Conexi$$HEX1$$f300$$ENDHEX$$n con base local establecida'
else
li_rdestino = 0
st_cnx.text = 'Conexi$$HEX1$$f300$$ENDHEX$$n con base local  desconectada'
Messagebox("Conexi$$HEX1$$f300$$ENDHEX$$n con base local","Conecci$$HEX1$$f300$$ENDHEX$$n no establecida ..."+itrans_destino.sqlerrtext)
end if

if li_rorigen = 1 and li_rdestino = 1 then
	st_cnx.text = 'Conecci$$HEX1$$f300$$ENDHEX$$n establecida'
else
	st_cnx.text = 'Conecci$$HEX1$$f300$$ENDHEX$$n NO establecida'
	return
end if


IF rb_items.checked = true THEN
	
	 iuo_pipa.dataobject = "pl_sucur"
  	 st_leyenda.text = "Iniciando transferencia de la tabla pr_sucur"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)

      if li_sr = 1 then
	 iuo_pipa.dataobject = "pl_inbode"
 	 st_leyenda.text ="Iniciando transferencia de la tabla in_bode"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	 end if	
		
       if li_sr = 1 then 
  	  st_leyenda.text = "Iniciando transferencia de la tabla in_fabricante"	
	  iuo_pipa.dataobject = "pl_fabricante"
       li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	  end if	
		
      if li_sr = 1 then
	 iuo_pipa.dataobject = "pl_clase"
 	 st_leyenda.text ="Iniciando transferencia de la tabla in_clase"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	 end if	
		
	if li_sr = 1 then	
	 iuo_pipa.dataobject = "pl_items"
	 
  	 st_leyenda.text = "Iniciando transferencia de la tabla in_item"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	end if
	
//	if li_sr = 1 then
//	 iuo_pipa.dataobject = "pl_itedet"
//	 
//  	 st_leyenda.text = "Iniciando transferencia de la tabla in_itedet"	
//      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
//	end if
		
	if li_sr = 1 then	
	 iuo_pipa.dataobject = "pl_relitem"
  	 st_leyenda.text = "Iniciando transferencia de la tabla in_relitem"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	end if
		
	if li_sr = 1 then	
	 iuo_pipa.dataobject = "pl_tippre"
  	 st_leyenda.text = "Iniciando transferencia de la tabla in_tippre"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	end if
		
	 if li_sr = 1 then	
	 iuo_pipa.dataobject = "pl_itesucur"
  	 st_leyenda.text = "Iniciando transferencia de la tabla in_itesucur"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	end if
	
	if li_sr = 1 then
	 iuo_pipa.dataobject = "pl_itebod"
       st_leyenda.text ="Iniciando transferencia de la tabla in_itebod"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	end if	
	
	
      if li_sr = 1 then
	 iuo_pipa.dataobject = "pl_formpag"
 	 st_leyenda.text ="Iniciando transferencia de la tabla fa_formpag"	
      li_sr = iuo_pipa.Start(itrans_origen,itrans_destino,dw_pipe_errors)
	 end if	

      if li_sr = 1 then st_leyenda.text = 'Transferencia completa...!'	
	
		
END IF 

end event

