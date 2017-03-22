HA$PBExportHeader$w_plan_cuentas.srw
$PBExportComments$Si. Vale
forward
global type w_plan_cuentas from w_sheet_1_dw_maint
end type
type sle_1 from singlelineedit within w_plan_cuentas
end type
type st_2 from statictext within w_plan_cuentas
end type
type st_3 from statictext within w_plan_cuentas
end type
type sle_2 from singlelineedit within w_plan_cuentas
end type
type st_4 from statictext within w_plan_cuentas
end type
type cb_1 from commandbutton within w_plan_cuentas
end type
type dw_1 from datawindow within w_plan_cuentas
end type
end forward

global type w_plan_cuentas from w_sheet_1_dw_maint
integer width = 5605
integer height = 1744
string title = "Plan de Cuentas"
sle_1 sle_1
st_2 st_2
st_3 st_3
sle_2 sle_2
st_4 st_4
cb_1 cb_1
dw_1 dw_1
end type
global w_plan_cuentas w_plan_cuentas

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();dw_report.SetTransObject(sqlca)				
dw_report.retrieve(str_appgeninfo.empresa)

return 1


end function

on w_plan_cuentas.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_2=create st_2
this.st_3=create st_3
this.sle_2=create sle_2
this.st_4=create st_4
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.sle_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_1
end on

on w_plan_cuentas.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_parametro[]
istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
ls_parametro[1] = str_appgeninfo.empresa
//dw_report.SetItem(1,"em_codigo",str_appgeninfo.empresa)
dw_1.SetTransObject(sqlca)
call super::open

end event

event ue_update;string ls_parametro [],ls_codigo_cuenta
int li_i,max,i
ls_parametro[1] = str_appgeninfo.empresa

for li_i = 1 to max
    ls_codigo_cuenta = dw_datos.GetItemString(li_i,"pl_codigo")
	 if isnull(ls_codigo_cuenta) or ls_codigo_cuenta = '' then
		 dw_datos.DeleteRow(li_i - i )
		 i=i+1	  
	 else
        dw_datos.SetItem(li_i - i ,"em_codigo",str_appgeninfo.empresa)
    end if
   next

max = dw_datos.rowcount()
if max = 0 then
   messageBox('Error','No se puede grabar no hay datos')
   return
end if	

call super::ue_update
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_plan_cuentas
integer y = 168
integer width = 5563
integer height = 1460
string dataobject = "d_plan_cuentas"
boolean border = true
end type

event dw_datos::itemchanged;call super::itemchanged;long    ll_filact,  ll_pospadre,ll_pos
string ls_empresa,ls_codactual,ls_codpadre
int       li_loncodactual, li_lonpadre, li_nivpadre



ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
ls_empresa = istr_argInformation.StringValue[1]

choose case lower(this.getColumnName())
	case "pl_codigo"
			ls_codactual = this.getText()
//			ll_pos = pos(ls_codactual,' ',1)
//			ls_codactual = mid(ls_codactual,1,ll_pos - 1)
			li_loncodactual = len(ls_codactual)
		  
		    If li_loncodactual > 1 then
			// hallar la longitud de los c$$HEX1$$f300$$ENDHEX$$digos en un nivel superior al mio
			select  ec_nivcta - 1 
               into      :li_nivpadre
               from     co_estcta
		     where  em_codigo = :ls_empresa
               and       ec_lontot    =  :li_loncodactual
			using    sqlca;

			if sqlca.sqlcode < 0 then
				messageBox("Error", "Longitud inv$$HEX1$$e100$$ENDHEX$$lida.")
				this.ib_inErrorCascade = True
				return(1)
			end if

			// ver si el padre esta en este datawindow
			select ec_lontot
			into :li_lonpadre
			from co_estcta
			where em_codigo = :ls_empresa
			and ec_nivcta = :li_nivpadre
			using sqlca;
	
			 ls_codpadre = left(ls_codactual, li_lonpadre)
			 this.SetItem(this.GetRow(),"pl_padre",ls_codpadre)

		end if
end choose
end event

event dw_datos::updatestart;call super::updatestart;Int i,ll_cont
String ls_codigo

//For i = 1 to This.RowCount()
//	  ls_codigo = This.GetItemString(i,"pl_codigo")
//	  
//	  SELECT count( * )
//	  INTO      :ll_cont
//	  FROM    CO_PLACTA
//	  WHERE pl_padre = :ls_codigo;
//	  
//	  If ll_cont > 0 &
//	  Then
//	  Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existe una cuenta Padre que no puede ser de MOVIMIENTO" +SQLCA.SQLERRTEXT)
//	  Rollback;
//	  Return 1
//       End if
//Next	
Return 0 
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;SetrowfocusIndicator(Hand!)
end event

event dw_datos::doubleclicked;call super::doubleclicked;if row <= 0 then return
dw_1.visible = true
dw_1.retrieve(this.Object.pl_codigo[row])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_plan_cuentas
integer x = 14
integer y = 12
integer width = 3648
integer height = 1620
string dataobject = "d_rep_plan_cuentas"
borderstyle borderstyle = styleraised!
end type

type sle_1 from singlelineedit within w_plan_cuentas
integer x = 2025
integer y = 40
integer width = 306
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_plan_cuentas
integer x = 1824
integer y = 48
integer width = 183
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_plan_cuentas
integer x = 2400
integer y = 48
integer width = 178
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_plan_cuentas
integer x = 2560
integer y = 40
integer width = 306
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_plan_cuentas
integer x = 18
integer y = 48
integer width = 1623
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Ingrese la fila de inicio y fin para generar los c$$HEX1$$f300$$ENDHEX$$digos de la cuentas padre"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_plan_cuentas
integer x = 3045
integer y = 32
integer width = 434
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar c$$HEX1$$f300$$ENDHEX$$digos"
end type

event clicked;//dw_datos.object.pl_padre.Original[] = dw_datos.object.pl_codigo.original[]
Integer li_fin,i,li_startrow, li_endrow
String ls_padre,ls_cta


li_startrow = Integer(sle_1.text)
li_endrow = Integer(sle_2.text)

for i = li_startrow to li_endrow
ls_cta = dw_datos.object.pl_codigo[i]
li_fin = lastpos(dw_datos.object.pl_codigo[i],'.') 

if li_fin = len(ls_cta) then
	ls_padre = mid(dw_datos.object.pl_codigo[i],1,li_fin - 3)
else
    ls_padre = mid(dw_datos.object.pl_codigo[i],1,li_fin)
end if
dw_datos.object.pl_padre[i] = ls_padre
next
end event

type dw_1 from datawindow within w_plan_cuentas
boolean visible = false
integer x = 1445
integer y = 516
integer width = 2377
integer height = 876
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobantes por cuenta"
string dataobject = "d_comprobantes_x_cta"
boolean controlmenu = true
boolean resizable = true
boolean livescroll = true
end type

