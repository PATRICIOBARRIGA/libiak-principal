HA$PBExportHeader$w_sri_ventas.srw
$PBExportComments$Si.
forward
global type w_sri_ventas from window
end type
type cb_5 from commandbutton within w_sri_ventas
end type
type cb_4 from commandbutton within w_sri_ventas
end type
type rb_3 from radiobutton within w_sri_ventas
end type
type cb_3 from commandbutton within w_sri_ventas
end type
type em_1 from editmask within w_sri_ventas
end type
type st_2 from statictext within w_sri_ventas
end type
type st_1 from statictext within w_sri_ventas
end type
type rb_2 from radiobutton within w_sri_ventas
end type
type rb_1 from radiobutton within w_sri_ventas
end type
type dw_1 from datawindow within w_sri_ventas
end type
type cb_1 from commandbutton within w_sri_ventas
end type
end forward

global type w_sri_ventas from window
integer width = 3561
integer height = 2072
boolean titlebar = true
string title = "SRI Ventas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_retrieve pbm_custom01
cb_5 cb_5
cb_4 cb_4
rb_3 rb_3
cb_3 cb_3
em_1 em_1
st_2 st_2
st_1 st_1
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
cb_1 cb_1
end type
global w_sri_ventas w_sri_ventas

event ue_retrieve;string ls_tipo
date ld_periodo

Setpointer(Hourglass!)
ld_periodo = date('01/'+em_1.text)
if rb_1.checked = true then
	ls_tipo = '18'
	cb_4.visible = false	
end if
if rb_2.checked = true then
	ls_tipo = '4'
	cb_4.visible = false	
end if
if rb_3.checked = true then
	ls_tipo = '44'
	cb_4.visible = true
end if
dw_1.Retrieve(ls_tipo,ld_periodo)
Setpointer(arrow!)
end event

on w_sri_ventas.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.rb_3=create rb_3
this.cb_3=create cb_3
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.rb_3,&
this.cb_3,&
this.em_1,&
this.st_2,&
this.st_1,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.cb_1}
end on

on w_sri_ventas.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.rb_3)
destroy(this.cb_3)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;dw_1.SetTransObject(sqlca)


end event

type cb_5 from commandbutton within w_sri_ventas
integer x = 2615
integer y = 76
integer width = 480
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ret.Fte. CXC a Vtas."
end type

event clicked;//Encuenta las retenciones en la fuente de todos los clientes generadas en cartera (FXM)
//Realizado por edivas
//Fecha de creaci$$HEX1$$f300$$ENDHEX$$n: 03/08/2006

string ls_codcli,ls_mtcodigo,ls_ruc,ls_fecha
dec{2} lc_valor,lc_valbase
int li_encontro,li_reten
date ld_fecreg


setpointer(hourglass!)
ls_fecha = em_1.text
if isnull(ls_fecha) or ls_fecha = "" then 
  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar antes el per$$HEX1$$ed00$$ENDHEX$$odo a declarar")
    em_1.setfocus()
	return
end if
ld_fecreg = date('01/'+em_1.text)
w_marco.Setmicrohelp("Aumento RetFte de cartera a las ventas...")

select count(*)
into :li_encontro
from sri_ventas
where tipocomprobante = 18
and fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy')
and estado = 'S'; 
IF li_encontro > 0 THEN
  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El aumento de la Retenci$$HEX1$$f300$$ENDHEX$$n en la Fuente para este periodo ya fue realizado")				  
  Return
END IF	

select pr_valor
into :li_reten
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'RET_PTO';
if sqlca.sqlcode =100 then
	messagebox("Error","No se encuentra el dato",stopsign!)
	return
end if

declare cliente cursor for

select c.ce_rucic,sum(p.ch_valor) 
from cc_movim m, fa_clien c,cc_cheque p
where m.em_codigo = c.em_codigo
and m.ce_codigo = c.ce_codigo
and m.TT_CODIGO = p.TT_CODIGO
AND m.TT_IOE = p.TT_IOE
AND m.EM_CODIGO = p.EM_CODIGO
AND m.SU_CODIGO = p.SU_CODIGO
AND m.MT_CODIGO = p.MT_CODIGO
AND m.TT_CODIGO  =  '5'
AND m.TT_IOE    = 'C'
and m.em_codigo = :str_appgeninfo.empresa
and to_char(m.mt_fecha,'mm/yyyy') = :ls_fecha
and p.fp_codigo = 6
group by c.ce_rucic;

open cliente;
do 
	fetch cliente into :ls_ruc,:lc_valor;	
	if sqlca.sqlcode <> 0 then exit

		select count(*)
		into :li_encontro
		from sri_ventas
		where idcliente = :ls_ruc
		and tipocomprobante = 18
		and fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy'); 
		if li_encontro = 1 then		
			lc_valbase = lc_valor * 100 / li_reten
			
			  UPDATE sri_ventas
			  SET  valretair = valretair + :lc_valor,
			  		baseimpair = baseimpair + :lc_valbase,
					estado = 'S'
			  WHERE idcliente = :ls_ruc
			  AND tipocomprobante = 18
			  AND fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy');
			  IF SQLCA.SQLCODE < 0 THEN
				  Rollback;
				  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar datos en tabla sri_ventas")				  
				  Return
			  END IF	
		end if
loop while true
close cliente;
commit;
setpointer(arrow!)
w_marco.Setmicrohelp("Proceso Terminado")

end event

type cb_4 from commandbutton within w_sri_ventas
boolean visible = false
integer x = 1797
integer y = 76
integer width = 809
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aumento NC de Cartera a NC de V."
end type

event clicked;Long ll_nreg,i,ll_ntickets,ll_numcli
dec{2} lc_baseimp,lc_montoiva,lc_montoivab
String ls_rucic,ls_tpcli,ls_fecreg
date ld_fecreg

Setpointer(Hourglass!)

ld_fecreg = date('01/'+em_1.text)
if rb_3.checked = true then

ll_nreg  = dw_1.rowcount()
if ll_nreg < 1 then 
   messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Antes debe recuperar los datos")
	return
end if

w_marco.Setmicrohelp("Aumento del valor de las notas de cr$$HEX1$$e900$$ENDHEX$$dito de cartera a las de ventas...Por favor espere")

select count(*)
into :ll_nreg
from sri_ventas
WHERE tipocomprobante = 44
AND fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy')
and ivapresuntivo = 'S';
if ll_nreg > 0 then
  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las NC de cartera de este per$$HEX1$$ed00$$ENDHEX$$odo ya fueron procesadas")	
  w_marco.Setmicrohelp("")
  return
end if

ll_nreg  = dw_1.rowcount()
if ll_nreg < 1 then return
for i = 1 to ll_nreg
  ls_rucic     = dw_1.Getitemstring(i,"idcliente")
  ls_tpcli     = dw_1.Getitemstring(i,"tpidcliente")  
  ls_fecreg     = dw_1.Getitemstring(i,"fecharegistro")    
  lc_baseimp   = dw_1.Getitemnumber(i,"baseimpgrav")
  lc_montoiva  = dw_1.Getitemnumber(i,"montoiva")
  lc_montoivab  = dw_1.Getitemnumber(i,"montoivabienes")  
  ll_ntickets   = long(dw_1.Getitemstring(i,"numcomprob"))
  
	select count(*) 
	into :ll_numcli
	from sri_ventas
	where idcliente = :ls_rucic
	and tipocomprobante = 4
	and fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy');
	if ll_numcli = 0 then
		INSERT INTO "SRI_VENTAS"  
         ( "TPIDCLIENTE", "IDCLIENTE", "TIPOCOMPROBANTE", "FECHAREGISTRO", "NUMCOMPROB",   
           "FECHAEMISION", "BASEIMPONIBLE", "IVAPRESUNTIVO", "BASEIMPGRAV", "PORCENTAJEIVA",   
           "MONTOIVA", "BASEIMPICE", "PORCENTAJEICE", "MONTOICE", "MONTOIVABIENES",   
           "PORRETBIENES", "VALORRETBIENES", "MONTOIVASERVICIOS", "PORRETSERVICIOS",   
           "VALORRETSERVICIOS", "RETPRESUNTIVA", "CODRETAIR", "BASEIMPAIR",   
           "PORCENTAJEAIR", "VALRETAIR" )  
  		VALUES ( :ls_tpcli,   :ls_rucic,   '4',   :ls_fecreg,   :ll_ntickets,   
           :ls_fecreg,   0,   'N',   :lc_baseimp,   2,
			  round(:lc_baseimp*0.12,2),   0,   0,   0,   round(:lc_baseimp*0.12,2),   
           0,   0,   0,   0,   
			  0,   'N',   '307',   0,   
           1,   0 )  ;
		IF SQLCA.SQLCODE < 0 THEN
		    messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar datos en sri_ventas")
		    Rollback;
		    Return
		END IF			
	else
		UPDATE SRI_VENTAS
		SET  baseimpgrav = baseimpgrav + :lc_baseimp,
			 montoiva  = montoiva + :lc_montoiva,
			 montoivabienes  = montoivabienes + :lc_montoivab,
			 numcomprob = numcomprob + :ll_ntickets
		WHERE idcliente = :ls_rucic
		AND tipocomprobante = 4
		AND fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy');
		
		IF SQLCA.SQLCODE < 0 THEN
		  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar datos en sri_ventas")
		  Rollback;
		  Return
		END IF			
		dw_1.setitem(i,"ivapresuntivo",'S')
	end if
next	

dw_1.update()
COMMIT;
Setpointer(Arrow!)
w_marco.Setmicrohelp("Listo...proceso terminado")
end if
end event

type rb_3 from radiobutton within w_sri_ventas
integer x = 805
integer y = 184
integer width = 343
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&NC Cartera"
end type

type cb_3 from commandbutton within w_sri_ventas
integer x = 3104
integer y = 76
integer width = 384
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Grabar Archivo"
end type

event clicked;string ls_fecha
setpointer(hourglass!)

ls_fecha = mid(em_1.text,1,2)
ls_fecha = ls_fecha + mid(em_1.text,4,4)

if rb_1.checked then
 if dw_1.rowcount() = 0 then return
 dw_1.SaveAs("Archivos\SRI_VENTAS"+ls_fecha+".XML",XML!,FALSE)	
 MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","EL archivo:~n"+&
           "SRI_VENTAS"+ls_fecha+".XML ~n Esta en la carpeta ARCHIVOS") 
end if

if rb_2.checked then
	if dw_1.rowcount() = 0 then return 
	dw_1.SaveAs("Archivos\SRI_DEVOLVENTAS"+ls_fecha+".XML",XML!,FALSE)
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Los archivos:~n"+&
				  "SRI_DEVOLVENTAS"+ls_fecha+".XML ~n Esta en la carpeta ARCHIVOS")
end if


setpointer(arrow!)
end event

type em_1 from editmask within w_sri_ventas
integer x = 453
integer y = 76
integer width = 288
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/yyyy"
boolean autoskip = true
end type

type st_2 from statictext within w_sri_ventas
integer x = 443
integer y = 160
integer width = 293
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[ mm/aaaa ]"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_sri_ventas
integer x = 37
integer y = 92
integer width = 425
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo a declarar:"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_sri_ventas
integer x = 805
integer y = 104
integer width = 398
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Devoluciones"
end type

type rb_1 from radiobutton within w_sri_ventas
integer x = 805
integer y = 24
integer width = 293
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Ventas"
end type

type dw_1 from datawindow within w_sri_ventas
integer x = 23
integer y = 272
integer width = 3474
integer height = 1688
string title = "none"
string dataobject = "d_sri_ventas"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_sri_ventas
integer x = 1248
integer y = 76
integer width = 539
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Validar C$$HEX1$$e900$$ENDHEX$$dulas y RUC"
end type

event clicked;Long ll_nreg,i,ll_ntickets
dec{2} lc_baseimp,lc_montoiva,lc_montoivab,lc_baseimpair
String ls_rucic,ls_tipo
date ld_fecreg

Setpointer(Hourglass!)
ll_nreg  = dw_1.rowcount()
if ll_nreg < 1 then 
   messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Antes debe recuperar los datos")
	return
end if

w_marco.Setmicrohelp("Validando C$$HEX1$$e900$$ENDHEX$$dulas y RUC de clientes...Por favor espere")
ld_fecreg = date('01/'+em_1.text)
if rb_1.checked = true then
	ls_tipo = '18'
end if
if rb_2.checked = true then
	ls_tipo = '4'
end if
if rb_3.checked = true then
	ls_tipo = '44'
end if



for i = 1 to ll_nreg
  
  ls_rucic     = dw_1.Getitemstring(i,"idcliente")
  lc_baseimp   = dw_1.Getitemnumber(i,"baseimpgrav")
  lc_montoiva  = dw_1.Getitemnumber(i,"montoiva")
  lc_montoivab  = dw_1.Getitemnumber(i,"montoivabienes")  
  lc_baseimpair  = dw_1.Getitemnumber(i,"baseimpair")    
  ll_ntickets   = long(dw_1.Getitemstring(i,"numcomprob"))
  
  if (f_valida_rucic(ls_rucic) < 0) and (ls_rucic <> '9999999999999') then

		  DELETE FROM SRI_VENTAS
		  WHERE idcliente = :ls_rucic
		  AND tipocomprobante = :ls_tipo
		  AND fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy');
		  IF SQLCA.SQLCODE < 0 THEN
			 messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al eliminar el registro "+sqlca.sqlerrtext)
			 Rollback;
			 Return
		  END IF

		  if ls_tipo = '44' then
			  UPDATE SRI_VENTAS
			  SET  baseimpgrav = baseimpgrav + :lc_baseimp,
					 montoiva  = montoiva + :lc_montoiva,
					 montoivabienes  = montoivabienes + :lc_montoivab,
					 baseimpair  = baseimpair + :lc_baseimpair,	 
					 numcomprob = numcomprob + :ll_ntickets
			  WHERE idcliente = '9999999999999'
			  AND tipocomprobante = 4
			  AND fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy');
			  
			  IF SQLCA.SQLCODE < 0 THEN
				  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar datos en sri_ventas")
				  Rollback;
				  Return
			  END IF			
		  else
			  UPDATE SRI_VENTAS
			  SET  baseimpgrav = baseimpgrav + :lc_baseimp,
					 montoiva  = montoiva + :lc_montoiva,
					 montoivabienes  = montoivabienes + :lc_montoivab,
					 baseimpair  = baseimpair + :lc_baseimpair,	 
					 numcomprob = numcomprob + :ll_ntickets
			  WHERE idcliente = '9999999999999'
			  AND tipocomprobante = :ls_tipo
			  AND fecharegistro = to_char(last_day(:ld_fecreg),'dd/mm/yyyy');
			  
			  IF SQLCA.SQLCODE < 0 THEN
				  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar datos")
				  Rollback;
				  Return
			  END IF
		  end if
  End if	
next	
COMMIT;
dw_1.Retrieve(ls_tipo,ld_fecreg)
Setpointer(Arrow!)
w_marco.Setmicrohelp("Listo...Proceso realizado con $$HEX1$$e900$$ENDHEX$$xito")

end event

