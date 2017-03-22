HA$PBExportHeader$w_pd_presupuesto_compras.srw
forward
global type w_pd_presupuesto_compras from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_pd_presupuesto_compras
end type
type em_1 from editmask within w_pd_presupuesto_compras
end type
type em_2 from editmask within w_pd_presupuesto_compras
end type
type st_1 from statictext within w_pd_presupuesto_compras
end type
type st_2 from statictext within w_pd_presupuesto_compras
end type
type dw_vtas from datawindow within w_pd_presupuesto_compras
end type
type dw_mat from datawindow within w_pd_presupuesto_compras
end type
type shl_1 from statichyperlink within w_pd_presupuesto_compras
end type
type st_4 from statictext within w_pd_presupuesto_compras
end type
type dw_tmp from datawindow within w_pd_presupuesto_compras
end type
type shl_2 from statichyperlink within w_pd_presupuesto_compras
end type
type cb_1 from commandbutton within w_pd_presupuesto_compras
end type
end forward

global type w_pd_presupuesto_compras from w_sheet_1_dw_maint
integer width = 6482
integer height = 2176
string title = "Presupuesto de compras"
boolean ib_notautoretrieve = true
dw_1 dw_1
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
dw_vtas dw_vtas
dw_mat dw_mat
shl_1 shl_1
st_4 st_4
dw_tmp dw_tmp
shl_2 shl_2
cb_1 cb_1
end type
global w_pd_presupuesto_compras w_pd_presupuesto_compras

forward prototypes
public function integer wf_procesa_kit (string as_itcodigo, decimal ac_cantmin, decimal ac_cantreq, string as_um)
end prototypes

public function integer wf_procesa_kit (string as_itcodigo, decimal ac_cantmin, decimal ac_cantreq, string as_um);String ls_itcodkit,ls_itcodigo3,ls_clase,ls_um
decimal lc_cantmin3,lc_cantmin2,lc_q
Integer i,li_find,li_reg
Boolean ib_kit

//Recupera la formulaci$$HEX1$$f300$$ENDHEX$$n en el caso de que un elemento de la formulaci$$HEX1$$f300$$ENDHEX$$n sea tambien SE.




Setnull(ls_itcodkit)
Setnull(ls_itcodigo3)
Setnull(ls_clase)
lc_cantmin3 = 0

//ls_itcodaux = as_itcodigo
 

//Determina si es parte de UN KIT
SELECT IT_CODIGO1
INTO  :ls_itcodkit
FROM IN_RELITEM 
WHERE IT_CODIGO =:as_itcodigo;

if isnull(ls_itcodkit) then ls_itcodkit = as_itcodigo

//Abre formulaciones para SE que tienen como componente otro SE
//Abre cursor con el codigo del kit en el caso de que este  definido como atomo.	
//La formulacion esta realizada para el KIT
li_reg = dw_datos.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_itcodkit,'F',ac_cantreq)
if li_reg = 0 then return -1

For i = 1 to li_reg 
		ls_itcodigo3 = dw_datos.object.it_codigo1[i]
		lc_cantmin3 = dw_datos.object.rq_cantid[i]
		ls_clase       = dw_datos.object.it_base[i]
		ls_um          = dw_datos.object.ub_sigla[i]
		
		if ls_clase  = 'E' then	
			wf_procesa_kit(ls_itcodigo3,lc_cantmin3,ac_cantreq,ls_um)
		end if
		li_find = dw_mat.find("it_codigo= '"+ls_itcodigo3+"'",1, dw_mat.rowcount())
		
		  if   as_um = 'GR' then
			 lc_q =  (lc_cantmin3/1000)*ac_cantmin*ac_cantreq
		 else
			  lc_q =  lc_cantmin3*ac_cantmin*ac_cantreq 
		 end if
		if li_find <> 0 then dw_mat.object.cantreq[li_find] = dw_mat.object.cantreq[li_find] +lc_q
NEXT
return 1
end function

on w_pd_presupuesto_compras.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_vtas=create dw_vtas
this.dw_mat=create dw_mat
this.shl_1=create shl_1
this.st_4=create st_4
this.dw_tmp=create dw_tmp
this.shl_2=create shl_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_vtas
this.Control[iCurrent+7]=this.dw_mat
this.Control[iCurrent+8]=this.shl_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.dw_tmp
this.Control[iCurrent+11]=this.shl_2
this.Control[iCurrent+12]=this.cb_1
end on

on w_pd_presupuesto_compras.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_vtas)
destroy(this.dw_mat)
destroy(this.shl_1)
destroy(this.st_4)
destroy(this.dw_tmp)
destroy(this.shl_2)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_vtas.SetTransObject(sqlca)
dw_mat.SetTransObject(sqlca)
//dw_aux.SetTransObject(sqlca)
dw_mat.retrieve()

em_1.text = '01/01/2010'
em_2.text = '31/10/2010'
end event

event ue_retrieve;dw_vtas.retrieve(date(em_1.text),date(em_2.text))
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pd_presupuesto_compras
integer x = 640
integer y = 112
integer width = 3840
integer height = 1240
boolean titlebar = true
string dataobject = "d_presupuesto_materia_x_item"
boolean resizable = true
boolean border = true
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_pd_presupuesto_compras
integer x = 3410
integer y = 136
integer width = 1623
integer height = 560
integer taborder = 50
end type

type dw_1 from datawindow within w_pd_presupuesto_compras
integer x = 2496
integer y = 800
integer width = 2354
integer height = 556
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_rep_cross_ventas_items_unid"
boolean livescroll = true
end type

type em_1 from editmask within w_pd_presupuesto_compras
integer x = 315
integer y = 32
integer width = 343
integer height = 72
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
end type

type em_2 from editmask within w_pd_presupuesto_compras
integer x = 987
integer y = 32
integer width = 343
integer height = 72
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
end type

type st_1 from statictext within w_pd_presupuesto_compras
integer x = 50
integer y = 40
integer width = 251
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

type st_2 from statictext within w_pd_presupuesto_compras
integer x = 699
integer y = 40
integer width = 251
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

type dw_vtas from datawindow within w_pd_presupuesto_compras
integer x = 82
integer y = 128
integer width = 4773
integer height = 552
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_psto_ventas"
boolean livescroll = true
end type

event rowfocuschanged;//dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,this.object.fa_detve_it_codigo[currentrow],'C',this.object.cc_vtas[currentrow])
end event

event retrieveend;
//Recalcular el costo para todos los productos.
decimal ac_cantidad,lc_costo
string  pepa
int i 

for i = 1 to this.rowcount()

	ac_cantidad = this.object.subdes[i]
	pepa = this.object.fa_detve_it_codigo[i]
	
	SELECT SUM(:ac_cantidad*"PD_DETRTA"."RQ_CANTID2"*"IN_ITEM"."IT_COSTO") COSTO
	INTO :lc_costo
	FROM "IN_ITEM",  "PD_DETRTA","PD_RECETA"
	WHERE ("PD_RECETA"."RT_CODIGO" = "PD_DETRTA"."RT_CODIGO")
	AND ( "IN_ITEM"."IT_CODIGO" = "PD_DETRTA"."IT_CODIGO1" )  
	AND ("PD_RECETA"."ESTADO"  = 'C')
	AND ("PD_RECETA"."IT_CODIGO"  = :pepa);
	
	this.object.cantreq[i]  = ac_cantidad
	this.object.costototal[i] = lc_costo

next;

end event

type dw_mat from datawindow within w_pd_presupuesto_compras
integer x = 87
integer y = 756
integer width = 4768
integer height = 1276
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_psto_materiaprima_y_materiales"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

type shl_1 from statichyperlink within w_pd_presupuesto_compras
integer x = 1371
integer y = 32
integer width = 215
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Calcular"
boolean focusrectangle = false
end type

event clicked;//string ls_op,ls_pepa,ls_itcodigo,ls_clase,ls_se,ls_itcodant,ls_itcodigo2,ls_itcodkit,ls_um
//decimal lc_cantmin, lc_cantreq,lc_cantmin2,lc_cantmin3
//integer  i,j,li_find,li_reg,ll_new
//
//
//
//For i=1 to dw_vtas.rowcount()
//	
////ls_op        = dw_vtas.object.opcion[i]
////ls_pepa     = dw_vtas.object.fa_detve_it_codigo[i]
////lc_cantreq = dw_vtas.object.cantreq[i]
////
////if ls_op <> 'S' then continue
////
//	//Busca composicion
////	li_reg = dw_datos.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_pepa,'C',lc_cantreq)
////     
////	
////     for j = 1 to li_reg
////         ls_itcodigo = dw_datos.Object.it_codigo1[j]
////		lc_cantmin = dw_datos.Object.rq_cantid[j]
////		ls_clase = dw_datos.Object.it_base[j]
////		ls_um   = dw_datos.Object.ub_sigla[j]
//		
////		ll_new = dw_aux.insertrow(0)
////		dw_aux.Object.it_codigo1[ll_new] = ls_itcodigo
////		dw_aux.Object.rq_cantid[ll_new] = lc_cantmin
////		dw_aux.Object.it_base[ll_new]= ls_clase
////		dw_aux.Object.ub_sigla[ll_new] =ls_um
//		
//		
////		
////		
//////       Determina si es SE	
////		IF ls_clase = 'E'  THEN
////			wf_procesa_kit(ls_itcodigo,lc_cantmin,lc_cantreq,ls_um)
////		END  IF
//////		
////		li_find = dw_mat.find("it_codigo= '"+ls_itcodigo+"'",1, dw_mat.rowcount())
////		if li_find <> 0 then dw_mat.object.cantreq[li_find] = dw_mat.object.cantreq[li_find] + lc_cantmin*lc_cantreq
//	next
//    
//	  
//NEXT
//
end event

type st_4 from statictext within w_pd_presupuesto_compras
integer x = 105
integer y = 692
integer width = 1024
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Presupuesto de materia prima y materiales"
boolean focusrectangle = false
end type

type dw_tmp from datawindow within w_pd_presupuesto_compras
boolean visible = false
integer x = 2304
integer y = 4
integer width = 2085
integer height = 2056
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_temp_formulaciones"
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
end type

type shl_2 from statichyperlink within w_pd_presupuesto_compras
integer x = 2610
integer y = 40
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Calcular"
boolean focusrectangle = false
end type

event clicked;string ls_op,ls_pepa,ls_pepaant,ls_itcodigo,ls_clase,ls_se,ls_itcodant,ls_itcodigo2,ls_itcodkit,ls_um,ls_um_ant,ls_rc
decimal lc_cantmin, lc_cantprd,lc_cantmin2,lc_cantmin3,lc_q,lc_q_ant
integer  li_nivel, li_cont,i,j,li_reg,ll_new,k,ll_find



For i=1 to dw_vtas.rowcount()
	
ls_op        = dw_vtas.object.opcion[i]
ls_pepa     = dw_vtas.object.fa_detve_it_codigo[i]
lc_cantprd = dw_vtas.object.cantreq[i]
lc_q_ant = lc_cantprd

if ls_op <> 'S' then continue

  //Inicializa tabla temporal
  dw_tmp.reset()
  //Busca composicion
  li_reg = dw_datos.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_pepa,'C',lc_cantprd)
   
  li_cont = 1
  li_nivel = 1
  
  DO
	    //Copiar 
		k= 1
		
		for k =1 to li_reg 
	     ls_itcodigo = dw_datos.Object.it_codigo1[k]
		ls_itcodant = dw_datos.Object.it_codant[k]
		lc_cantmin = dw_datos.Object.rq_cantid[k]
//		lc_q_ant    = dw_datos.Object.rq_cantreq[k]  
		ls_clase     = dw_datos.Object.it_base[k]
		ls_um        = dw_datos.Object.ub_sigla[k]

	    		
		ll_new = dw_tmp.insertrow(0)
         dw_tmp.Object.id[ll_new] = li_cont
		dw_tmp.Object.it_codigo[ll_new] = ls_itcodigo
		dw_tmp.Object.it_codant[ll_new] = ls_itcodant
		dw_tmp.Object.rq_cantmin[ll_new] = lc_cantmin
		dw_tmp.Object.um[ll_new] = ls_um
     	dw_tmp.Object.rq_cantant[ll_new] =lc_q_ant
		
		
		if   ls_um_ant = 'GR' then
			 lc_q =  (lc_cantmin/1000)*lc_q_ant*lc_cantprd
		 else
			 lc_q =  lc_cantmin*lc_q_ant*lc_cantprd 
		 end if
		dw_tmp.Object.rq_cantreq[ll_new] = lc_q
		dw_tmp.Object.nivel[ll_new] = li_nivel
		dw_tmp.Object.tipo[ll_new] = ls_clase
		next
	
	      //inicia recorrido de la tabla temporal
		 if li_cont > dw_tmp.rowcount() then li_cont --
		 ls_pepa = dw_tmp.Object.it_codigo[li_cont]
		 ls_um_ant   = dw_tmp.Object.um[li_cont]
		 lc_q_ant = dw_tmp.Object.rq_cantreq[li_cont]
		 ls_pepaant = ls_pepa
		
		 //Verifica si es componente de un kit
		 SELECT IT_CODIGO1
		 INTO  :ls_pepa
		 FROM IN_RELITEM,IN_ITEM,IN_UNIBAS
		 WHERE IN_ITEM.IT_CODIGO = IN_RELITEM.IT_CODIGO1
		 AND IN_UNIBAS.UB_CODIGO = IN_ITEM.UB_CODIGO
		 AND IN_RELITEM.IT_CODIGO =:ls_pepa;
		 
          if isnull(ls_pepa) then ls_pepa = ls_pepa
			  
		 
		 //Marca el registro como visitado 
		 dw_tmp.Object.rc[li_cont] = 'S'
		 li_reg = dw_datos.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_pepa,'F',1)
		 if li_reg > 0 then li_nivel++ 
		 li_cont++ 
		 ls_rc = dw_tmp.object.rc[dw_tmp.rowcount()]
		 ls_se = dw_tmp.object.tipo[dw_tmp.rowcount()]
LOOP UNTIL ls_rc =  'S' and li_reg = 0
 
NEXT

end event

type cb_1 from commandbutton within w_pd_presupuesto_compras
integer x = 1906
integer y = 12
integer width = 347
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;integer i,li_find
String ls_pepa
Decimal lc_q

dw_tmp.AcceptText()
for i = 1 to dw_tmp.rowcount()
	Setnull(ls_pepa)
	lc_q = 0
	li_find = 0
	ls_pepa = dw_tmp.Object.it_codigo[i]
     lc_q = dw_tmp.Object.rq_cantreq[i]
     li_find = dw_mat.find("it_codigo = '"+ls_pepa+"'",1,dw_mat.rowcount())
	 if li_find <> 0 then
	dw_mat.Object.cantreq[li_find] =dw_mat.Object.cantreq[li_find] + lc_q 
	 end if
next
end event

