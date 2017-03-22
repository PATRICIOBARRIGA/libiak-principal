HA$PBExportHeader$w_obsequio.srw
$PBExportComments$Permite registrar los Obsequios entregados a clientes fijos y clientes eventuales
forward
global type w_obsequio from w_sheet_1_dw_maint
end type
type rr_1 from roundrectangle within w_obsequio
end type
type cbx_cliente_antiguo from checkbox within w_obsequio
end type
type cbx_cliente_nuevo from checkbox within w_obsequio
end type
end forward

global type w_obsequio from w_sheet_1_dw_maint
integer x = 5
integer y = 400
integer width = 2926
integer height = 1580
string title = "Registro de Obsequios"
long backcolor = 79741120
rr_1 rr_1
cbx_cliente_antiguo cbx_cliente_antiguo
cbx_cliente_nuevo cbx_cliente_nuevo
end type
global w_obsequio w_obsequio

type variables
integer  ii_cliente = 1
end variables

on w_obsequio.create
int iCurrent
call super::create
this.rr_1=create rr_1
this.cbx_cliente_antiguo=create cbx_cliente_antiguo
this.cbx_cliente_nuevo=create cbx_cliente_nuevo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rr_1
this.Control[iCurrent+2]=this.cbx_cliente_antiguo
this.Control[iCurrent+3]=this.cbx_cliente_nuevo
end on

on w_obsequio.destroy
call super::destroy
destroy(this.rr_1)
destroy(this.cbx_cliente_antiguo)
destroy(this.cbx_cliente_nuevo)
end on

event open;//istr_argInformation.nrArgs = 1
//istr_argInformation.argType[1] = "string"
//istr_argInformation.stringValue[1]="0602089930"

//dw_datos.insertrow(0)
ib_notautoretrieve = true
call w_sheet_1_dw_maint :: open
ib_notautoretrieve = false
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_obsequio
integer x = 73
integer y = 296
integer width = 2665
integer height = 1128
string dataobject = "dw_obsequio"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////
// Evento : Itemchanged 
// Descripci$$HEX1$$f300$$ENDHEX$$n : Permite cuando se cambie el cliente o el n$$HEX1$$fa00$$ENDHEX$$mero 
//               de c$$HEX1$$e900$$ENDHEX$$dula traer datos relacionados. Si se trae datos
//               y la opcion es entregado se deshabilita la opcion
// Realizado : Hugo Orozco
// Fecha de Creaci$$HEX1$$f300$$ENDHEX$$n : 1998/11/09
// Fecha de Modificaci$$HEX1$$f300$$ENDHEX$$n : 1998/12/09  15:06
///////////////////////////////////////////////////////////////////

string ls_ruc_ci,ls_nombre,ls_apellido,ls_codigo,ls_logo
string ls_direccion,ls_telefono
integer li_filas,li_respuesta

if getcolumnName() = "ob_codigo" and (ii_cliente = 1) then
	ls_codigo = data
	SELECT "FA_CLIEN"."CE_RUCIC"
     INTO :ls_ruc_ci
     FROM "FA_CLIEN"  
    WHERE "FA_CLIEN"."CE_CODIGO" = :data   ;
	if sqlca.sqlcode < 0 then
		messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","No se pudo Recuperar CI/RUC del cliente.")
		return	
	end if
	li_filas = retrieve(ls_ruc_ci)
	if li_filas <= 0 then
		li_respuesta = messagebox("Pregunta...","No est$$HEX2$$e1002000$$ENDHEX$$registrado el cliente en la lista de Obsequios. Desea Registrarlo ahora?.",Question!,Yesno!,2)
		if li_respuesta = 1 then
			SELECT "FA_CLIEN"."CE_RUCIC",   
   		       "FA_CLIEN"."CE_NOMBRE",   
         		 "FA_CLIEN"."CE_APELLI",
					 "FA_CLIEN"."CE_CADOM1",
					 "FA_CLIEN"."CE_TELDOM"
		     INTO :ls_ruc_ci,  
   		       :ls_nombre,   
		          :ls_apellido,
					 :ls_direccion,
					 :ls_telefono
      	FROM "FA_CLIEN"  
	      WHERE "FA_CLIEN"."CE_CODIGO" = :data   ;
		   if sqlca.sqlcode < 0 then
				messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","No se pudo Recuperar la Informaci$$HEX1$$f300$$ENDHEX$$n del cliente.")
				return	
			 end if
			insertrow(0)
			setitem(row,"ob_login",sqlca.logid)			
			setitem(row,"ob_codigo",ls_codigo)			
			setitem(row,"ob_cedula",ls_ruc_ci)
			setitem(row,"ob_nombre",ls_nombre)
			setitem(row,"ob_apellido",ls_apellido)
			setitem(row,"ob_direccion",ls_direccion)
			setitem(row,"ob_telefono",ls_telefono)
			setitem(row,"ob_fecha",today())
			setitem(row,"ob_estado",'EN')
		else
			close(w_obsequio)
		end if
	else
		if GetItemString(row,"ob_estado")='EN' then
			settaborder("ob_estado",0)
		else
			settaborder("ob_estado",50)
		end if
	end if
end if

if getcolumnName() = "ob_cedula" and (ii_cliente = 2) then
	ls_ruc_ci = data
	li_filas = retrieve(ls_ruc_ci)
	if li_filas <= 0 then
		li_respuesta = messagebox("Pregunta...","No est$$HEX2$$e1002000$$ENDHEX$$registrado el cliente en la lista de Obsequios. Desea Registrarlo ahora?.",Question!,Yesno!,2)
		if li_respuesta = 1 then
			insertrow(0)
			setitem(row,"ob_login",sqlca.logid)			
			setitem(row,"ob_cedula",ls_ruc_ci)
			setitem(row,"ob_estado",'EN')
			setitem(row,"ob_fecha",today())
			SetColumn(1)
		else
			close(w_obsequio)
		end if
	else
		if GetItemString(row,"ob_estado")='EN' then
			settaborder("ob_estado",0)
			dw_datos.SetTabOrder("ob_cedula",0)
			dw_datos.SetTabOrder("ob_nombre",0)
			dw_datos.SetTabOrder("ob_apellido",0)
			dw_datos.SetTabOrder("ob_direccion",0)
			dw_datos.SetTabOrder("ob_telefono",0)
		else
			dw_datos.SetTabOrder("ob_cedula",20)
			dw_datos.SetTabOrder("ob_nombre",30)
			dw_datos.SetTabOrder("ob_apellido",40)
			dw_datos.SetTabOrder("ob_direccion",50)
			dw_datos.SetTabOrder("ob_telefono",60)
			settaborder("ob_estado",70)
		end if
	end if
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_obsequio
end type

type rr_1 from roundrectangle within w_obsequio
integer linethickness = 5
long fillcolor = 67108864
integer x = 73
integer y = 36
integer width = 2665
integer height = 236
integer cornerheight = 41
integer cornerwidth = 42
end type

type cbx_cliente_antiguo from checkbox within w_obsequio
integer x = 334
integer y = 116
integer width = 521
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Cliente &Fijo :"
boolean lefttext = true
end type

event clicked;IF cbx_cliente_antiguo.checked = true THEN
	cbx_cliente_nuevo.checked = false
	ii_cliente = 1
	dw_datos.reset()
	dw_datos.insertrow(0)
	dw_datos.SetTabOrder("ob_codigo",10)
	dw_datos.SetTabOrder("ob_cedula",0)
	dw_datos.SetTabOrder("ob_nombre",0)
	dw_datos.SetTabOrder("ob_apellido",0)
	dw_datos.SetTabOrder("ob_direccion",0)
	dw_datos.SetTabOrder("ob_telefono",0)
	dw_datos.settaborder("ob_estado",70)
END IF
end event

type cbx_cliente_nuevo from checkbox within w_obsequio
event clicked pbm_bnclicked
integer x = 1915
integer y = 116
integer width = 585
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Cliente &Eventual :"
boolean lefttext = true
end type

event clicked;string ls_nulo

SetNull ( ls_nulo )
IF cbx_cliente_nuevo.checked = true THEN
	cbx_cliente_antiguo.checked = false
	ii_cliente = 2
	dw_datos.reset()
	dw_datos.insertrow(0)
	dw_datos.SetTabOrder("ob_codigo",0)
	dw_datos.SetTabOrder("ob_cedula",20)
	dw_datos.SetTabOrder("ob_nombre",30)
	dw_datos.SetTabOrder("ob_apellido",40)
	dw_datos.SetTabOrder("ob_direccion",50)
	dw_datos.SetTabOrder("ob_telefono",60)
	dw_datos.settaborder("ob_estado",70)
	
END IF

end event

