HA$PBExportHeader$w_diferencia_stocks.srw
$PBExportComments$Si.
forward
global type w_diferencia_stocks from window
end type
type cb_3 from commandbutton within w_diferencia_stocks
end type
type st_4 from statictext within w_diferencia_stocks
end type
type st_3 from statictext within w_diferencia_stocks
end type
type sle_4 from singlelineedit within w_diferencia_stocks
end type
type sle_3 from singlelineedit within w_diferencia_stocks
end type
type cb_2 from commandbutton within w_diferencia_stocks
end type
type hpb_1 from hprogressbar within w_diferencia_stocks
end type
type cb_1 from commandbutton within w_diferencia_stocks
end type
type rb_2 from radiobutton within w_diferencia_stocks
end type
type sle_2 from singlelineedit within w_diferencia_stocks
end type
type sle_1 from singlelineedit within w_diferencia_stocks
end type
type st_2 from statictext within w_diferencia_stocks
end type
type st_1 from statictext within w_diferencia_stocks
end type
type rb_1 from radiobutton within w_diferencia_stocks
end type
type gb_1 from groupbox within w_diferencia_stocks
end type
type gb_2 from groupbox within w_diferencia_stocks
end type
end forward

global type w_diferencia_stocks from window
integer width = 1952
integer height = 896
boolean titlebar = true
string title = "Procesar Diferencias de Stocks"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_3 cb_3
st_4 st_4
st_3 st_3
sle_4 sle_4
sle_3 sle_3
cb_2 cb_2
hpb_1 hpb_1
cb_1 cb_1
rb_2 rb_2
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
rb_1 rb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_diferencia_stocks w_diferencia_stocks

type variables

end variables

on w_diferencia_stocks.create
this.cb_3=create cb_3
this.st_4=create st_4
this.st_3=create st_3
this.sle_4=create sle_4
this.sle_3=create sle_3
this.cb_2=create cb_2
this.hpb_1=create hpb_1
this.cb_1=create cb_1
this.rb_2=create rb_2
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_1=create rb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_3,&
this.st_4,&
this.st_3,&
this.sle_4,&
this.sle_3,&
this.cb_2,&
this.hpb_1,&
this.cb_1,&
this.rb_2,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.rb_1,&
this.gb_1,&
this.gb_2}
end on

on w_diferencia_stocks.destroy
destroy(this.cb_3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.cb_2)
destroy(this.hpb_1)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;this.move(5,5)

end event

type cb_3 from commandbutton within w_diferencia_stocks
boolean visible = false
integer x = 965
integer y = 768
integer width = 224
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;//string   ls_item,ls_codant,ls_bodega,ls_codigo,ls_nombre,ls_fabri,ls_depto
//decimal  ld_saldo,ld_saldo_inicial,ld_saldo_actual
//decimal  ld_saldo_sucursal,ld_ingresos,ld_egresos
//long  ll_total
//
//Setpointer(hourglass!)
//w_marco.setmicrohelp("Procesando diferencias de stock.....Espere por favor")
////Arregla stocks de todos los productos
//declare c2 cursor for
// select it_codigo,it_codant
//   from in_item
//  where em_codigo = :str_appgeninfo.empresa
//  and it_kit = 'N'
//  and it_codant in ('2100-GL',
//'E020-GL',
//'GCC1-50K',
//'CS-1K',
//'SA16',
//'CEP',
//'PA',
//'PA4',
//'EP120CC',
//'GZ',
//'8129-CU',
//'EM-TN',
//'0114-5K',
//'5322-TR',
//'P5361',
//'6032-CU',
//'WS3-CU',
//'TR-GL',
//'150-CU',
//'BA-GL',
//'CCA-CA',
//'DA-GL',
//'AT152/2',
//'AF150',
//'AF180',
//'AF360',
//'HU3',
//'E030-GL',
//'AT1523',
//'FCDF1/2X5',
//'FMA1/2',
//'901B-CU',
//'4058-GL',
//'7080-GL',
//'TP31-1K',
//'FMA11/2',
//'P19133-CU',
//'710439/1',
//'710439/2',
//'P7508-GL',
//'7690-GL',
//'M200-CU',
//'P17200-GL',
//'P17276D-CU',
//'P7200-GL',
//'P7200-CU',
//'P7200E-DI',
//'MC1006',
//'MC1007',
//'MC1004',
//'P1576S-CU',
//'P1020-GL',
//'P1020E-DI',
//'A111222-1.2K',
//'BS17-CU',
//'T230-TN',
//'P2575-GL',
//'P117823-GL',
//'M219-GL',
//'FVS-MT',
//'FVS-1K',
//'P298415',
//'HH60',
//'PR-GL',
//'1726-CU',
//'1731-CU',
//'RVA170-CU',
//'2131-GL',
//'DW515K',
//'P12284P-GL',
//'A110901-1K',
//'M1390-GL',
//'P17227-GL',
//'P17226-CU',
//'P17223-CU')
// order by cl_codigo,it_codant;
//  
//declare c3 cursor for
//   select bo_codigo
//   from in_bode
//   where em_codigo = :str_appgeninfo.empresa
//   and su_codigo = :str_appgeninfo.sucursal;
//
//   select count(*)
//   into :ll_total
//   from in_item
//   where em_codigo = :str_appgeninfo.empresa
//   and it_kit = 'N'
//   and it_codant in ('2100-GL',
//'E020-GL',
//'GCC1-50K',
//'CS-1K',
//'SA16',
//'CEP',
//'PA',
//'PA4',
//'EP120CC',
//'GZ',
//'8129-CU',
//'EM-TN',
//'0114-5K',
//'5322-TR',
//'P5361',
//'6032-CU',
//'WS3-CU',
//'TR-GL',
//'150-CU',
//'BA-GL',
//'CCA-CA',
//'DA-GL',
//'AT152/2',
//'AF150',
//'AF180',
//'AF360',
//'HU3',
//'E030-GL',
//'AT1523',
//'FCDF1/2X5',
//'FMA1/2',
//'901B-CU',
//'4058-GL',
//'7080-GL',
//'TP31-1K',
//'FMA11/2',
//'P19133-CU',
//'710439/1',
//'710439/2',
//'P7508-GL',
//'7690-GL',
//'M200-CU',
//'P17200-GL',
//'P17276D-CU',
//'P7200-GL',
//'P7200-CU',
//'P7200E-DI',
//'MC1006',
//'MC1007',
//'MC1004',
//'P1576S-CU',
//'P1020-GL',
//'P1020E-DI',
//'A111222-1.2K',
//'BS17-CU',
//'T230-TN',
//'P2575-GL',
//'P117823-GL',
//'M219-GL',
//'FVS-MT',
//'FVS-1K',
//'P298415',
//'HH60',
//'PR-GL',
//'1726-CU',
//'1731-CU',
//'RVA170-CU',
//'2131-GL',
//'DW515K',
//'P12284P-GL',
//'A110901-1K',
//'M1390-GL',
//'P17227-GL',
//'P17226-CU',
//'P17223-CU')
//order by cl_codigo,it_codant;
//  
//hpb_1.maxposition = ll_total
//hpb_1.Setstep = 1
//hpb_1.Position = 0
//open c2;
//  do
//    fetch c2 into :ls_item,:ls_codant;
//	 if sqlca.sqlcode <> 0 then exit
//	 ld_saldo_sucursal = 0
//	 w_marco.setmicrohelp("Procesando Item: "+ls_codant+" espere por favor...")
//	 open c3;
//	 do
//		fetch c3 into :ls_bodega;
//		if sqlca.sqlcode <> 0 then exit
//         select nvl(ib_stkini,0),nvl(ib_stock,0)
//         into :ld_saldo_inicial,:ld_saldo_actual
//         from in_itebod
//         where em_codigo = :str_appgeninfo.empresa
//         and su_codigo = :str_appgeninfo.sucursal
//		and bo_codigo = :ls_bodega
//         and it_codigo = :ls_item;
//
//		select nvl(sum(decode(tm_ioe,'I',mv_cantid)),0),nvl(sum(decode(tm_ioe,'E',mv_cantid)),0)
//		into :ld_ingresos,:ld_egresos
//		from in_movim
//		where em_codigo = :str_appgeninfo.empresa
//		and su_codigo = :str_appgeninfo.sucursal
//		and bo_codigo = :ls_bodega
//		and it_codigo = :ls_item;
//			
//          ld_saldo = ld_saldo_inicial + ld_ingresos - ld_egresos
//		 ld_saldo_sucursal = ld_saldo_sucursal + ld_saldo
//	 
//		update in_itebod
//		set ib_stock = :ld_saldo
//		where em_codigo = :str_appgeninfo.empresa
//		and su_codigo = :str_appgeninfo.sucursal
//		and bo_codigo = :ls_bodega
//		and it_codigo = :ls_item;
//
//	 loop while TRUE
//	 close c3;
//		update in_itesucur
//		set it_stkdis  = :ld_saldo_sucursal,
//		      it_stock = :ld_saldo_sucursal,
//			 it_stkreal = :ld_saldo_sucursal
//		 where em_codigo = :str_appgeninfo.empresa
//		 and su_codigo = :str_appgeninfo.sucursal
//		 and it_codigo = :ls_item;
//
//hpb_1.Stepit()
//loop while TRUE
//close c2;
//
//commit using sqlca;
//setpointer(arrow!)
//w_marco.setmicrohelp("Proceso Terminado items procesados = "+string(ll_total))
end event

type st_4 from statictext within w_diferencia_stocks
integer x = 1019
integer y = 336
integer width = 370
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$d. Fabricante:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_diferencia_stocks
integer x = 946
integer y = 440
integer width = 443
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$d. Departamento:"
boolean focusrectangle = false
end type

type sle_4 from singlelineedit within w_diferencia_stocks
integer x = 1394
integer y = 428
integer width = 457
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within w_diferencia_stocks
integer x = 1394
integer y = 324
integer width = 457
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_diferencia_stocks
integer x = 1509
integer y = 76
integer width = 343
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cerrar"
end type

event clicked;close(parent)
end event

type hpb_1 from hprogressbar within w_diferencia_stocks
integer x = 846
integer y = 640
integer width = 1074
integer height = 64
end type

type cb_1 from commandbutton within w_diferencia_stocks
integer x = 41
integer y = 620
integer width = 759
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar diferencias en kardex"
end type

event clicked;string   ls_item,ls_codant,ls_bodega,ls_codigo,ls_nombre,ls_fabri,ls_depto
decimal  ld_saldo,ld_saldo_inicial,ld_saldo_actual
decimal  ld_saldo_sucursal,ld_ingresos,ld_egresos
long  ll_total
//boolean  lb_actualizar = FALSE

If rb_1.checked Then
	ls_codigo = '%'
	ls_nombre='%'
	ls_fabri = '%'
	ls_depto='%'
End if
If rb_2.checked Then
	ls_codigo = sle_1.text
	ls_nombre = sle_2.text
	ls_fabri = sle_3.text
	ls_depto = sle_4.text
	 
    If (isnull(ls_codigo) or ls_codigo = '') and (isnull(ls_nombre) or ls_nombre = '') and &
	 (isnull(ls_fabri) or ls_fabri = '') and (isnull(ls_depto) or ls_depto = '') Then
      messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el dato del producto a procesar")
      return
    End if
End if		

Setpointer(hourglass!)
w_marco.setmicrohelp("Procesando diferencias de stock.....Espere por favor")
//Arregla stocks de todos los productos
declare c2 cursor for
 select it_codigo,it_codant
   from in_item
  where em_codigo = :str_appgeninfo.empresa
  and it_kit <> 'S'
  and (it_codant like :ls_codigo or it_nombre like :ls_nombre or fb_codigo like :ls_fabri or cl_codigo like :ls_depto)
  order by cl_codigo,it_codant;
  
declare c3 cursor for
   select bo_codigo
   from in_bode
   where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :str_appgeninfo.sucursal;

   select count(1)
   into :ll_total
   from in_item
   where em_codigo = :str_appgeninfo.empresa
   and it_kit <> 'S'
   and (it_codant like :ls_codigo or it_nombre like :ls_nombre or fb_codigo like :ls_fabri or cl_codigo like :ls_depto)
   order by cl_codigo,it_codant;
  
hpb_1.maxposition = ll_total
hpb_1.Setstep = 1
hpb_1.Position = 0
open c2;
  do
    fetch c2 into :ls_item,:ls_codant;
	 if sqlca.sqlcode <> 0 then exit
	 ld_saldo_sucursal = 0
	 w_marco.setmicrohelp("Procesando Item: "+ls_codant+" espere por favor...")
	 open c3;
	 do
		fetch c3 into :ls_bodega;
		if sqlca.sqlcode <> 0 then exit
         select nvl(ib_stkini,0),nvl(ib_stock,0)
         into :ld_saldo_inicial,:ld_saldo_actual
         from in_itebod
         where em_codigo = :str_appgeninfo.empresa
         and su_codigo = :str_appgeninfo.sucursal
		and bo_codigo = :ls_bodega
         and it_codigo = :ls_item;

		select nvl(sum(decode(tm_ioe,'I',mv_cantid)),0),nvl(sum(decode(tm_ioe,'E',mv_cantid)),0)
		into :ld_ingresos,:ld_egresos
		from in_movim
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and bo_codigo = :ls_bodega
		and it_codigo = :ls_item;
			
          ld_saldo = ld_saldo_inicial + ld_ingresos - ld_egresos
		 ld_saldo_sucursal = ld_saldo_sucursal + ld_saldo
	 
	     update in_itebod
		set ib_stock = :ld_saldo
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and bo_codigo = :ls_bodega
		and it_codigo = :ls_item;

	 loop while TRUE
	 close c3;
		update in_itesucur
		set it_stkdis  = :ld_saldo_sucursal,
		      it_stock = :ld_saldo_sucursal,
			 it_stkreal = :ld_saldo_sucursal
		 where em_codigo = :str_appgeninfo.empresa
		 and su_codigo = :str_appgeninfo.sucursal
		 and it_codigo = :ls_item;

hpb_1.Stepit()
loop while TRUE
close c2;

commit using sqlca;
setpointer(arrow!)
w_marco.setmicrohelp("Proceso Terminado items procesados = "+string(ll_total))
end event

type rb_2 from radiobutton within w_diferencia_stocks
integer x = 146
integer y = 156
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccionar por"
boolean checked = true
end type

event clicked;sle_1.enabled = true
sle_2.enabled = true
sle_3.enabled = true
sle_4.enabled = true
rb_1.checked = false
rb_2.checked = true
sle_1.setfocus()



end event

type sle_2 from singlelineedit within w_diferencia_stocks
integer x = 357
integer y = 428
integer width = 535
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_diferencia_stocks
integer x = 357
integer y = 324
integer width = 535
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_diferencia_stocks
integer x = 155
integer y = 440
integer width = 201
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nombre:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_diferencia_stocks
integer x = 155
integer y = 336
integer width = 201
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$digo:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_diferencia_stocks
integer x = 146
integer y = 64
integer width = 347
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
end type

event clicked;sle_1.enabled = false
sle_2.enabled = false
sle_3.enabled = false
sle_4.enabled = false
sle_1.text = ''
sle_2.text = ''
sle_3.text = ''
sle_4.text = ''
rb_1.checked = true
rb_2.checked = false

end event

type gb_1 from groupbox within w_diferencia_stocks
integer x = 37
integer width = 645
integer height = 264
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Productos"
end type

type gb_2 from groupbox within w_diferencia_stocks
integer y = 540
integer width = 1943
integer height = 36
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

