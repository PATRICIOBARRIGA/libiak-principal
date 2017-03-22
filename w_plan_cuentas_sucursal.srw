HA$PBExportHeader$w_plan_cuentas_sucursal.srw
$PBExportComments$Respaldo
forward
global type w_plan_cuentas_sucursal from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_plan_cuentas_sucursal
end type
type cb_1 from commandbutton within w_plan_cuentas_sucursal
end type
type cb_2 from commandbutton within w_plan_cuentas_sucursal
end type
type cb_3 from commandbutton within w_plan_cuentas_sucursal
end type
type st_1 from statictext within w_plan_cuentas_sucursal
end type
type st_empresa from statictext within w_plan_cuentas_sucursal
end type
type dw_3 from datawindow within w_plan_cuentas_sucursal
end type
type st_2 from statictext within w_plan_cuentas_sucursal
end type
type st_3 from statictext within w_plan_cuentas_sucursal
end type
type hpb_1 from hprogressbar within w_plan_cuentas_sucursal
end type
type hpb_2 from hprogressbar within w_plan_cuentas_sucursal
end type
type dw_suc from datawindow within w_plan_cuentas_sucursal
end type
type st_4 from statictext within w_plan_cuentas_sucursal
end type
type cb_4 from commandbutton within w_plan_cuentas_sucursal
end type
type cb_5 from commandbutton within w_plan_cuentas_sucursal
end type
type dw_4 from datawindow within w_plan_cuentas_sucursal
end type
type st_5 from statictext within w_plan_cuentas_sucursal
end type
type cb_6 from commandbutton within w_plan_cuentas_sucursal
end type
type cb_7 from commandbutton within w_plan_cuentas_sucursal
end type
type st_6 from statictext within w_plan_cuentas_sucursal
end type
type rb_2 from radiobutton within w_plan_cuentas_sucursal
end type
type rb_1 from radiobutton within w_plan_cuentas_sucursal
end type
type cbx_1 from checkbox within w_plan_cuentas_sucursal
end type
type cb_8 from commandbutton within w_plan_cuentas_sucursal
end type
end forward

global type w_plan_cuentas_sucursal from w_sheet_1_dw_maint
integer width = 6167
integer height = 2532
string title = "Autorizaci$$HEX1$$f300$$ENDHEX$$n de cuentas por sucursal"
long backcolor = 79741120
boolean ib_notautoretrieve = true
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
st_1 st_1
st_empresa st_empresa
dw_3 dw_3
st_2 st_2
st_3 st_3
hpb_1 hpb_1
hpb_2 hpb_2
dw_suc dw_suc
st_4 st_4
cb_4 cb_4
cb_5 cb_5
dw_4 dw_4
st_5 st_5
cb_6 cb_6
cb_7 cb_7
st_6 st_6
rb_2 rb_2
rb_1 rb_1
cbx_1 cbx_1
cb_8 cb_8
end type
global w_plan_cuentas_sucursal w_plan_cuentas_sucursal

type variables
boolean  ib_down 
long il_find
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();String ls_sucursal
//ls_sucursal = dw_2.getitemstring(1,"su_codigo")
dw_report.retrieve(str_appgeninfo.empresa,ls_sucursal)
return 1
end function

on w_plan_cuentas_sucursal.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_1=create st_1
this.st_empresa=create st_empresa
this.dw_3=create dw_3
this.st_2=create st_2
this.st_3=create st_3
this.hpb_1=create hpb_1
this.hpb_2=create hpb_2
this.dw_suc=create dw_suc
this.st_4=create st_4
this.cb_4=create cb_4
this.cb_5=create cb_5
this.dw_4=create dw_4
this.st_5=create st_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.st_6=create st_6
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cbx_1=create cbx_1
this.cb_8=create cb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_empresa
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.hpb_1
this.Control[iCurrent+11]=this.hpb_2
this.Control[iCurrent+12]=this.dw_suc
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.cb_4
this.Control[iCurrent+15]=this.cb_5
this.Control[iCurrent+16]=this.dw_4
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.cb_6
this.Control[iCurrent+19]=this.cb_7
this.Control[iCurrent+20]=this.st_6
this.Control[iCurrent+21]=this.rb_2
this.Control[iCurrent+22]=this.rb_1
this.Control[iCurrent+23]=this.cbx_1
this.Control[iCurrent+24]=this.cb_8
end on

on w_plan_cuentas_sucursal.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.st_empresa)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.hpb_1)
destroy(this.hpb_2)
destroy(this.dw_suc)
destroy(this.st_4)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.dw_4)
destroy(this.st_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.st_6)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cbx_1)
destroy(this.cb_8)
end on

event open;DataWindowChild   ldwc_aux

dw_report.SetTransObject(sqlca)
dw_1.setTransobject(sqlca)
dw_1.retrieve()

dw_datos.GetChild("su_codigo",ldwc_aux)
ldwc_aux.SetTransObject(sqlca)
ldwc_aux.Retrieve(str_appgeninfo.empresa)
dw_3.Insertrow(0)
dw_4.Insertrow(0)
dw_datos.SetRowfocusIndicator(hand!)
st_empresa.text = gs_empresa

//sucursales
dw_suc.setTransobject(sqlca)
dw_suc.retrieve()


call super::open
end event

event resize;return 1
end event

event ue_update;string ls_plcodigo, ls_sucodigo
long i,j,ll_new, ll_count
integer rtn,li_ban
integer lb_uno
lb_uno = 0
date ldt_hoy

select trunc(sysdate)
into :ldt_hoy
from dual;

//if rb_2.checked = true then 
//	//pasa todas las sucursales seleccionadas
//	for i = 1 to  dw_suc.Rowcount()
//		if dw_suc.IsSelected(i) Then
//			ls_sucodigo = dw_suc.object.su_codigo[i]
//			//dw_datos.retrieve(str_appgeninfo.empresa,ls_sucodigo)
//			//dw_2.setitem(dw_2.getrow(),"su_codigo",ls_sucodigo)
//
//			//aki inserta las cuentas seleccionadas
//				for j = 1 to  dw_1.Rowcount() 
//					if dw_1.IsSelected(j) Then
//						ls_plcodigo = dw_1.object.pl_codigo[j]
//						
//						//buscamos si ya existe la cuenta en esta sucursal para no insertar
//						  SELECT count(*)
//						  into :ll_count
//						  FROM co_plansuc 
//						  WHERE  em_codigo = :str_appgeninfo.empresa  AND  
//						  su_codigo = :ls_sucodigo and
//						  pl_codigo = :ls_plcodigo ;
//						  
//							if ll_count = 0 then 
////								lb_uno = 1
////								ll_new = dw_datos.insertrow(0)
////								dw_datos.scrolltorow(ll_new)
////								dw_datos.setitem(ll_new,"su_codigo",ls_sucodigo)
////								dw_datos.setitem(ll_new,"pl_codigo",ls_plcodigo)
//								insert into co_plansuc ( em_codigo, su_codigo, pl_codigo, ps_vigente, ps_fecvig ) 
//								values(:str_appgeninfo.empresa, :ls_sucodigo, :ls_plcodigo,'S', :ldt_hoy);
//								if sqlca.sqlcode <> 0 then
//									MessageBox("Error","Fallo insert co_plansuc: "+sqlca.sqlerrtext,StopSign!)
//									 ROLLBACK USING SQLCA;
//								end if
//							end if
//					end if	
//						hpb_2.setrange(0,dw_1.Rowcount())
//						hpb_2.Setstep = 1
//						hpb_2.StepIt ( )
//				next	
//					//grabar 
//						//if lb_uno = 1 then 
//						if rb_1.Checked = true then
//							rtn = dw_datos.update()
//							IF rtn = 1 THEN
//								  COMMIT USING SQLCA;
//							ELSE
//								  ROLLBACK USING SQLCA;
//							END IF
//						else
//							 COMMIT USING SQLCA;
//						end if
//						dw_datos.retrieve('2','1')
//
//		end if	
//	w_marco.setmicrohelp("Procesando transacci$$HEX1$$f300$$ENDHEX$$n...")
//	//hpb_1.maxposition = dw_suc.Rowcount()
//	hpb_1.setrange(0,dw_suc.Rowcount())
//	hpb_1.Setstep = 1
//	hpb_1.StepIt ( )
//	
//	next	
//	w_marco.setmicrohelp("Transacci$$HEX1$$f300$$ENDHEX$$n Exitosa......")
//else
	dw_datos.uf_updateCommit()
//end if
end event

event ue_retrieve;integer i
string ls_suc[]
for i = 1 to  dw_suc.Rowcount()
		if dw_suc.IsSelected(i) Then 
		ls_suc[i] = dw_suc.Object.su_codigo[i]
		end if
next
dw_datos.retrieve(str_appgeninfo.empresa,ls_suc)
end event

event ue_delete;Long ll_reg,i

ll_reg = dw_datos.rowcount()

for i = dw_datos.rowcount() to 1 step -1
	if dw_datos.Object.ps_vigente[i] = 'N' then
	dw_datos.deleterow(i)
    end if
next
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_plan_cuentas_sucursal
integer x = 2290
integer y = 684
integer width = 3799
integer height = 1368
integer taborder = 40
string dataobject = "d_plan_x_sucursal"
boolean hscrollbar = false
boolean border = true
boolean livescroll = false
end type

event dw_datos::updatestart;call super::updatestart;/**/
long ll_nreg,i
string ls_sucursal

//ll_nreg = this.rowcount()
//if rb_1.checked = true then
//	ls_sucursal = dw_2.getitemstring(1,"su_codigo")
//else 
//	ls_sucursal = dw_datos.getitemstring(1,"su_codigo")
//end if
//
//for i = 1 to ll_nreg
//	this.setitem(i,"em_codigo",str_appgeninfo.empresa)
////	if rb_1.enabled = true then
//		this.setitem(i,"su_codigo",ls_sucursal)
////	end if
//next	
return 0
end event

event dw_datos::clicked;call super::clicked;/*
If IsSelected(row) then
	This.SelectRow(row, FALSE)
else	
	This.SelectRow(row, TRUE)
End if
*/
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_plan_cuentas_sucursal
integer y = 228
integer width = 2921
integer height = 1528
integer taborder = 50
string dataobject = "d_rep_plan_cuentas_sucursal"
end type

type dw_1 from datawindow within w_plan_cuentas_sucursal
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
integer x = 23
integer y = 240
integer width = 2094
integer height = 1816
integer taborder = 20
string dragicon = "H:\pintulac\Imagenes\row.ico"
boolean bringtotop = true
string title = "none"
string dataobject = "d_plan_ctas"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_buttonup;ib_down = false
end event

event ue_buttondown;ib_down = true
end event

event ue_mousemove;////////////////////////////////////////////////////////////////////////
//// if left mouse button is down and user moves the mouse, initiate drag mode
////////////////////////////////////////////////////////////////////////
//
//string	ls_plcodigo,&
//			ls_col, &
//			ls_new_text
//int		li_row, &
//			li_pos
//
//// if pointer is positioned over an employee name, display message
//// that it is ok to drag here
//
//ls_col = this.GetObjectAtPointer() 
//
//if Len (ls_col) > 0 then
//	li_pos = Pos (ls_col, '~t')
//
//	// get the employee name from the row that was returned from the
//	// dwGetObjectAtPointer function.
//	if li_pos > 0 then
//		li_row = Integer (Right (ls_col, Len (ls_col) - li_pos))
//		ls_plcodigo = this.object.pl_codigo[li_row]
//	end if
//	ls_new_text =	'Mantenga presionado el bot$$HEX1$$f300$$ENDHEX$$n izquierdo del mouse para arrastrar ' + &
//						ls_plcodigo + &
//						' dentro del plan de cuentas por sucursal.'
//	if st_message.text <> ls_new_text then
//		st_message.text = ls_new_text
//	end if
//	
//	// if left mouse button is down, begin drag mode
//	if ib_down then
//		this.Drag (begin!)
//	end if
//else
//	if Len (st_message.text) > 0 then
//		st_message.text = ''
//	end if
//end if
return 1
end event

event clicked;
If IsSelected(row) then
	This.SelectRow(row, FALSE)
else	
	This.SelectRow(row, TRUE)
End if
end event

event rowfocuschanged;This.SetRowfocusIndicator(Hand!)
end event

type cb_1 from commandbutton within w_plan_cuentas_sucursal
integer x = 2139
integer y = 1072
integer width = 114
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;string ls_plcodigo
long i,ll_new,ll_reg

ll_reg = dw_datos.Rowcount()

for i = 1 to  ll_reg

	if  dw_datos.IsSelected(i) Then
	    dw_datos.Deleterow(i)
	end if
next	

end event

type cb_2 from commandbutton within w_plan_cuentas_sucursal
integer x = 485
integer y = 2096
integer width = 471
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleccionar todo"
end type

event clicked;
dw_1.selectrow(0,false)
end event

type cb_3 from commandbutton within w_plan_cuentas_sucursal
integer x = 27
integer y = 2096
integer width = 443
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleccionar todo"
end type

event clicked;


dw_1.SelectRow(0, true)
end event

type st_1 from statictext within w_plan_cuentas_sucursal
integer x = 37
integer y = 24
integer width = 457
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
string text = "Plan de Cuentas de:"
boolean focusrectangle = false
end type

type st_empresa from statictext within w_plan_cuentas_sucursal
integer x = 480
integer y = 20
integer width = 1312
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_plan_cuentas_sucursal
integer x = 439
integer y = 116
integer width = 1161
integer height = 84
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sle"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;string ls_data
long ll_nreg,ll_find



if not isnull(data )and data<>"" then
ls_data = data+'%'
else 
Setnull(ls_data)
end if
ll_nreg = dw_1.rowcount()
ll_find = dw_1.find("pl_codigo like'"+ls_data+"'",1,ll_nreg)
if ll_find <> 0 then
dw_1.selectrow(0,false)
dw_1.scrolltorow(ll_find)
dw_1.selectrow(ll_find,true)
else	
dw_1.selectrow(0,false)
end if
end event

type st_2 from statictext within w_plan_cuentas_sucursal
integer x = 37
integer y = 120
integer width = 389
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
string text = "Ubique la cuenta:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_plan_cuentas_sucursal
integer x = 27
integer y = 2276
integer width = 3369
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Si desea habilitar una cuenta a una sucursal. Recupere las cuentas de la sucursal, entonces seleccione la cuenta que desea y presione el boton mover."
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_plan_cuentas_sucursal
integer x = 27
integer y = 2340
integer width = 3337
integer height = 56
boolean bringtotop = true
end type

type hpb_2 from hprogressbar within w_plan_cuentas_sucursal
integer x = 3232
integer y = 2112
integer width = 2226
integer height = 60
boolean bringtotop = true
end type

type dw_suc from datawindow within w_plan_cuentas_sucursal
integer x = 2290
integer y = 96
integer width = 3159
integer height = 416
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_sucur_grid"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Long ll_nreg,i

if row <> 0 then
	If IsSelected(row) then
		This.SelectRow(row, FALSE)
	else	
		This.SelectRow(row, TRUE)
	End if
else
	if ib_down = true then
		ll_nreg = this.rowcount()
		for i= 1 to ll_nreg
			this.selectrow(i,false)
		next	
		ib_down = false
	else
		ll_nreg = this.rowcount()
		for i= 1 to ll_nreg
			this.selectrow(i,true)
		next	
		ib_down = true
	end if
end if


end event

type st_4 from statictext within w_plan_cuentas_sucursal
integer x = 2295
integer y = 612
integer width = 466
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
string text = "Cuentas autorizadas"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_plan_cuentas_sucursal
integer x = 2743
integer y = 2084
integer width = 471
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleccionar todo"
end type

event clicked;//dw_datos.SelectRow(0,false)

long i,ll_reg
ll_reg =dw_datos.rowcount()

for i = 1 to dw_datos.rowcount()
dw_datos.Object.ps_vigente[i] = 'N'
next
end event

type cb_5 from commandbutton within w_plan_cuentas_sucursal
integer x = 2290
integer y = 2084
integer width = 443
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleccionar todo"
end type

event clicked;long i,ll_reg
ll_reg =dw_datos.rowcount()

for i = 1 to dw_datos.rowcount()
dw_datos.Object.ps_vigente[i] = 'S'
next
end event

type dw_4 from datawindow within w_plan_cuentas_sucursal
integer x = 3675
integer y = 584
integer width = 1019
integer height = 84
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sle"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;string ls_data
long ll_nreg,ll_find



if not isnull(data )and data<>"" then
ls_data = data+'%'
else 
Setnull(ls_data)
end if
ll_nreg = dw_datos.rowcount()
ll_find = dw_datos.find("pl_codigo like'"+ls_data+"'",1,ll_nreg)
if ll_find <> 0 then
	il_find = ll_find
dw_datos.selectrow(0,false)
dw_datos.scrolltorow(ll_find)
dw_datos.selectrow(ll_find,true)
else	
dw_datos.selectrow(0,false)
end if
end event

type st_5 from statictext within w_plan_cuentas_sucursal
integer x = 3680
integer y = 516
integer width = 389
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
string text = "Ubique la cuenta:"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_plan_cuentas_sucursal
integer x = 4727
integer y = 580
integer width = 123
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;Integer ll_nreg,ll_find
String data,ls_data

data = dw_4.Object.columna[1]
if not isnull(data )and data<>"" then
ls_data = data+'%'
else 
Setnull(ls_data)
end if
ll_nreg = dw_datos.rowcount()
il_find = dw_datos.find("pl_codigo like'"+ls_data+"'",il_find+1,ll_nreg)
if il_find <> 0 then
dw_datos.selectrow(0,false)
dw_datos.scrolltorow(il_find)
dw_datos.selectrow(il_find,true)
else	
dw_datos.selectrow(0,false)
end if
end event

type cb_7 from commandbutton within w_plan_cuentas_sucursal
integer x = 2139
integer y = 1180
integer width = 114
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;string ls_plcodigo,ls_suc,ls_plnombre
long i,ll_new,j

SetPointer(Hourglass!)
for i = 1 to  dw_suc.Rowcount()
if dw_suc.IsSelected(i) Then 
	ls_suc = dw_suc.Object.su_codigo[i]
	
	for j = 1 to  dw_1.Rowcount()
		          if dw_1.IsSelected(j) Then
			          ls_plcodigo  = dw_1.object.pl_codigo[j]
					 ls_plnombre =	dw_1.object.pl_nombre[j] 
			   	     ll_new = dw_datos.insertrow(0)
					dw_datos.scrolltorow(ll_new)
					dw_datos.Setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
					dw_datos.setitem(ll_new,"pl_codigo",ls_plcodigo)
					dw_datos.setitem(ll_new,"pl_nombre",ls_plnombre)
					dw_datos.setitem(ll_new,"su_codigo",ls_suc)
				end if
	next
end if	
next	
SetPointer(Arrow!)
end event

type st_6 from statictext within w_plan_cuentas_sucursal
integer x = 2286
integer y = 24
integer width = 521
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
string text = "Seleccione la sucursal:"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_plan_cuentas_sucursal
boolean visible = false
integer x = 5079
integer y = 608
integer width = 343
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
string text = "none"
borderstyle borderstyle = styleraised!
end type

type rb_1 from radiobutton within w_plan_cuentas_sucursal
boolean visible = false
integer x = 5079
integer y = 528
integer width = 343
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
string text = "none"
borderstyle borderstyle = styleraised!
end type

type cbx_1 from checkbox within w_plan_cuentas_sucursal
integer x = 4379
integer y = 696
integer width = 73
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
end type

event clicked;Long ll_nreg,i
String ls_op
ll_nreg = dw_datos.rowcount()

if this.checked then
	ls_op = 'S'
else
	ls_op = 'N'
end if
for i= 1 to ll_nreg
dw_datos.object.ps_vigente[i] = ls_op
next	


end event

type cb_8 from commandbutton within w_plan_cuentas_sucursal
integer x = 3497
integer y = 2260
integer width = 942
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Plan de cuentas por empresa."
end type

event clicked;String ls_plcodigo,ls_vigente

Setpointer(Hourglass!)

DECLARE  C1 CURSOR FOR

SELECT PL_CODIGO,NVL(PS_VIGENTE,'N')
FROM CO_PLANSUC
WHERE EM_CODIGO = '1'
AND SU_CODIGO = '1';

OPEN C1;

FETCH C1 INTO :ls_plcodigo,:ls_vigente;

DO WHILE sqlca.sqlcode = 0
	
	UPDATE CO_PLACTA
	SET PL_VIGENTE = :ls_vigente
	WHERE EM_CODIGO = '1'
	AND PL_CODIGO = :ls_plcodigo;
	
	FETCH C1 INTO :ls_plcodigo,:ls_vigente;
	
LOOP   
CLOSE C1;
COMMIT;
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo se ha actualizado el plan de cuentas empresarial...!!!")
end event

