HA$PBExportHeader$w_cliente.srw
$PBExportComments$Clientes de una empresa
forward
global type w_cliente from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_cliente
end type
type sle_1 from singlelineedit within w_cliente
end type
type sle_2 from singlelineedit within w_cliente
end type
type st_1 from statictext within w_cliente
end type
type st_2 from statictext within w_cliente
end type
type sle_3 from singlelineedit within w_cliente
end type
type st_4 from statictext within w_cliente
end type
type dw_mov from datawindow within w_cliente
end type
type cb_1 from commandbutton within w_cliente
end type
type dw_1 from datawindow within w_cliente
end type
end forward

global type w_cliente from w_sheet_1_dw_maint
integer width = 5787
integer height = 2512
string title = "Cliente"
event ue_consultar ( )
dw_ubica dw_ubica
sle_1 sle_1
sle_2 sle_2
st_1 st_1
st_2 st_2
sle_3 sle_3
st_4 st_4
dw_mov dw_mov
cb_1 cb_1
dw_1 dw_1
end type
global w_cliente w_cliente

type variables
string is_mensaje
end variables

event ue_consultar();dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

on w_cliente.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_1=create st_1
this.st_2=create st_2
this.sle_3=create sle_3
this.st_4=create st_4
this.dw_mov=create dw_mov
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.sle_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.dw_mov
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_1
end on

on w_cliente.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_3)
destroy(this.st_4)
destroy(this.dw_mov)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_parametro[]



istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
f_recupera_empresa(dw_datos,"ca_codigo")

ls_parametro[1] = '593' //ecuador por default
f_recupera_datos(dw_datos,"po_codigo",ls_parametro,1) 
ls_parametro[] ={'593','17'}//Pichincha por defaut
f_recupera_datos(dw_datos,"ct_codigo",ls_parametro,2) 

f_recupera_empresa(dw_datos,"ep_codigo")
dw_datos.is_SerialCodeColumn = "ce_codigo"
dw_datos.is_SerialCodeType = "COD_CLI"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa



dw_1.SetTransObject(sqlca)

f_recupera_empresa(dw_1,"ca_codigo")
ls_parametro[1] = '593' //ecuador por default
f_recupera_datos(dw_1,"po_codigo",ls_parametro,1) 
ls_parametro[] ={'593','17'}//Pichincha por defaut
f_recupera_datos(dw_1,"ct_codigo",ls_parametro,2) 
f_recupera_empresa(dw_1,"ep_codigo")
f_recupera_empresa(dw_1,"ce_actividad")


//dw_1.retrieve(str_appgeninfo.empresa)
this.ib_notautoretrieve = true
call super::open
dw_datos.insertrow(0 )

MOVE(1,1)
end event

event ue_retrieve;//string ls_parametro[]
//istr_argInformation.nrArgs = 1
//istr_argInformation.argType[1] = "string"
//istr_argInformation.StringValue[1] = str_appgeninfo.empresa
//f_recupera_empresa(dw_datos,"ca_codigo")
//ls_parametro[1] = '1' //ecuador por default
//f_recupera_datos(dw_datos,"cu_codigo",ls_parametro,1) 
//f_recupera_datos(dw_datos,"ep_codigo",ls_parametro,1) 
return 1
end event

event ue_insert;string ls_codigo

dw_datos.Reset()
//select ep_codigo
//into :ls_codigo
//from no_emple
//where sa_login = :str_appgeninfo.username
//and em_codigo = :str_appgeninfo.empresa
//and su_codigo = :str_appgeninfo.sucursal;
//
//If sqlca.sqlcode =100 Then
//	messagebox("Error","Empleado no encontrado",stopsign!)
//	return 1
//End if

call super::ue_insert
dw_datos.setitem(dw_datos.getrow(),"ep_codigo",ls_codigo)
dw_datos.setitem(dw_datos.getrow(),"su_codigo",str_appgeninfo.sucursal)


end event

event resize;//dw_1.resize(this.workSpaceWidth() - 2*dw_1.x, this.workSpaceHeight() - 2*dw_1.y)
return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cliente
event ue_nextfield pbm_dwnprocessenter
integer x = 32
integer y = 120
integer width = 3520
integer height = 2264
string dataobject = "d_cliente"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
end type

event ue_nextfield;send(handle(this),256,9,long(0,0))
return 1
end event

event dw_datos::itemchanged;long ll_filact
string ls_pais[],ls_rucic,ls_tipo,ls_verifica,ls_null,ls_ruc,ls_pa_codigo,ls_po_codigo
decimal{2} lc_cupo, lc_saldo, lc_dif
integer li_rucic[],i,li_coefic[],li_producto,li_residuo,li_sumprod,li_verificador

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
setnull(ls_null)

If dwo.name = "ce_rucic" then
	ls_rucic = this.GetText()
	ls_tipo = this.getitemstring(row,"ce_tipo")

   choose case ls_tipo
	case 'N'
		If len(ls_rucic) <> 10 Then
			beep(1)
		   object.st_rucic.text = ls_rucic
			messagebox("Error","N$$HEX1$$fa00$$ENDHEX$$mero de digitos mal ingresado en CI debe ser 10",stopsign!)
			setitem(row,"ce_rucic",ls_null)
			return 1
		end if
		For i = 1 to 10
			li_rucic[i] = integer(mid(ls_rucic,i,1))
		Next				
		ls_verifica = mid(ls_rucic,1,2)
		if ls_verifica >='01' and ls_verifica <= '22' Then 
			ls_ruc = ls_ruc + ls_verifica
			ls_verifica = mid(ls_rucic,3,1)
			choose case ls_verifica
				case '0','1','2','3','4','5'
				ls_ruc = ls_ruc + ls_verifica + mid(ls_rucic,4,6)
				li_coefic[] = {2,1,2,1,2,1,2,1,2}
				for i = 1 to 9
				 li_producto = li_coefic[i] * li_rucic[i]
				 if li_producto > 9 then
					li_producto = li_producto - 9
				 end if
				 li_sumprod = li_sumprod + li_producto
				next
				li_residuo = mod(li_sumprod,10) 
				li_verificador = 10 - li_residuo
				If li_residuo = 0 Then
					ls_ruc = ls_ruc + '0'
				else
					ls_ruc = ls_ruc + string(li_verificador)
				end if								
			end choose
		end if			

		if ls_ruc <> ls_rucic Then 
			 beep(1)
			 object.st_rucic.text = ls_rucic
			 messagebox("Error","N$$HEX1$$fa00$$ENDHEX$$mero de C$$HEX1$$e900$$ENDHEX$$dula mal ingresado o no es correcto...verifique",stopsign!)
			 setitem(row,"ce_rucic",ls_null)
			 return 1
		End if
		object.st_rucic.text = ls_null
	case 'R','J'
		If len(ls_rucic) <> 13 Then
			beep(1)
		   object.st_rucic.text = ls_rucic
			messagebox("Error","N$$HEX1$$fa00$$ENDHEX$$mero de digitos mal ingresado en RUC debe ser 13",stopsign!)
			setitem(row,"ce_rucic",ls_null)
			return 1
		end if
		For i = 1 to 13
			li_rucic[i] = integer(mid(ls_rucic,i,1))
		Next		

			ls_verifica = mid(ls_rucic,1,2)
			if ls_verifica >='01' and ls_verifica <= '22' Then 
				ls_ruc = ls_ruc + ls_verifica
				ls_tipo = mid(ls_rucic,3,1)
				choose case ls_tipo
					case '9' 		//Sociedades Privadas
						ls_ruc = ls_ruc + ls_tipo + mid(ls_rucic,4,6)
						li_coefic[] = {4,3,2,7,6,5,4,3,2}
						for i = 1 to 9
						 li_producto = li_producto + (li_coefic[i] * li_rucic[i])
						next
						li_residuo = mod(li_producto,11) 
						li_verificador = 11 - li_residuo						
						If li_residuo = 0 Then
							ls_ruc = ls_ruc + '0001'
						else
							ls_ruc = ls_ruc + string(li_verificador)+'001'
						end if
					case '6' 		//Sociedades P$$HEX1$$fa00$$ENDHEX$$blicas
						ls_ruc = ls_ruc + ls_tipo + mid(ls_rucic,4,5)
						li_coefic[] = {3,2,7,6,5,4,3,2}
						for i = 1 to 8
						 li_producto = li_producto + (li_coefic[i] * li_rucic[i])
						next
						li_residuo = mod(li_producto,11) 
						li_verificador = 11 - li_residuo
						If li_residuo = 0 Then
							ls_ruc = ls_ruc + '00001'
						else
							ls_ruc = ls_ruc + string(li_verificador)+'0001'
						end if						
						
					case '0','1','2','3','4','5' //Personas Naturales
						 
						ls_ruc = ls_ruc + ls_tipo + mid(ls_rucic,4,6)
						li_coefic[] = {2,1,2,1,2,1,2,1,2}
						for i = 1 to 9
						 li_producto = li_coefic[i] * li_rucic[i]
						 if li_producto > 9 then
							li_producto = li_producto - 9
						 end if
						 li_sumprod = li_sumprod + li_producto
						next
						li_residuo = mod(li_sumprod,10) 
						li_verificador = 10 - li_residuo
						If li_residuo = 0 Then
							ls_ruc = ls_ruc + '0001'
						else
							ls_ruc = ls_ruc + string(li_verificador)+'001'
						end if												
			   end choose
				if ls_ruc <> ls_rucic Then 
					 beep(1)
				    object.st_rucic.text = ls_rucic					 
					 messagebox("Error","N$$HEX1$$fa00$$ENDHEX$$mero de RUC mal ingresado o no es correcto...verifique",stopsign!)
					 setitem(row,"ce_rucic",ls_null)					 
					 return 1
				End if				
			  object.st_rucic.text = ls_null
	      end if
    end choose
End if

If dwo.name = "pa_codigo" Then
		ls_pais[1] = this.GetText()
		f_recupera_datos(dw_datos,"po_codigo",ls_pais,1)
		ls_po_codigo = this.getItemstring(row,"po_codigo")
		ls_pais[] = {ls_pa_codigo,ls_po_codigo}		
		f_recupera_datos(dw_datos,"ct_codigo",ls_pais,2)
End if
If dwo.name = "po_codigo" Then
		accepttext()
		ls_po_codigo = this.getItemstring(row,"po_codigo")
		ls_pa_codigo = this.getItemstring(row,"pa_codigo")
		ls_pais[] = {ls_pa_codigo,ls_po_codigo}
		f_recupera_datos(dw_datos,"ct_codigo",ls_pais,2)
End if



If dwo.name = "ce_cupcre" Then
		lc_cupo = dec(this.GetText())
		lc_dif = lc_cupo - this.GetItemNumber(ll_filact,'ce_cupcre',primary!,true)
		lc_saldo = this.GetItemNumber(ll_filact,'ce_salcre',primary!,true)
		if isnull(lc_saldo) or lc_saldo = 0.00 then
			this.SetItem(ll_filact,'ce_salcre',lc_cupo)
		elseif  lc_dif <> 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n"," Ha realizado un cambio en el cupo del cliente...Recuerde actualizar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito...")
		     this.SetItem(ll_filact,'ce_salcre', lc_saldo + lc_dif)
		end if
end if

//If dwo.name = "ce_cupcre" Then
//		lc_cupo = dec(this.GetText())
//		lc_dif = lc_cupo - this.GetItemNumber(ll_filact,'ce_cupcre',primary!,true)
//	     if lc_dif <> 0 then
//			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n"," Ha realizado un cambio en el cupo del cliente...Recuerde actualizar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito...")
//		  end if
//end if
end event

event dw_datos::scrollvertical;call super::scrollvertical;long ll_filact
string ls_pais[]
ll_filact = this.GetRow()
if ll_filact > 0 then
ls_pais[1] = this.GetItemString(ll_filact,"pa_codigo")
f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
end if
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//long   ll_filact
//string ls_pais[]
//
//ll_filact = this.GetRow()
////if ll_filact > 0 then
////ls_pais[1] = this.object.pa_codigo[currentrow]
////f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
////end if
end event

event dw_datos::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"ce_fecha",f_hoy())


end event

event dw_datos::itemerror;call super::itemerror;return 1
end event

event dw_datos::retrieveend;call super::retrieveend;String ls_cargo
String  ls_campos[] = {'ce_facturar','ep_codigo','ce_estcre','ce_fecnac','ce_peso','ce_estatu','ce_hobby','ce_plazo','ce_cupcre','ce_exiva'}
String  ls_rol


SELECT RS_NOMBRE
into :ls_rol
FROM SG_ACCESO
WHERE em_codigo = :str_appgeninfo.empresa 
and SA_LOGIN = :str_appgeninfo.username;

if rowcount > 0 then
this.enabled = true	
ls_cargo = this.object.no_emple_cr_codigo[1]	

//Original
//if ls_rol <> 'CARTERA' and  ls_rol <> 'CARTERA_SUC' and ls_rol <> 'ADMINISTRADOR' then

if ls_rol <> 'ADMINISTRADOR' then
   if ls_cargo <> '2' then /*POS*/
		this.enabled = true      	
		f_inhabilita_campos(dw_datos,ls_campos)
   elseif ls_cargo = '2' then
  		this.enabled = false
   end if	
end if
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_cliente
integer x = 73
integer y = 648
integer taborder = 30
end type

type dw_ubica from datawindow within w_cliente
event ue_downkey pbm_dwnkey
boolean visible = false
integer x = 576
integer y = 1200
integer width = 2281
integer height = 288
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda de clientes"
string dataobject = "d_recupera_cliente"
boolean livescroll = true
end type

event ue_downkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_datos.SetFocus()
	dw_datos.SetFilter('')
	dw_datos.Filter()
end if
end event

event doubleclicked;dw_ubica.Visible = false
dw_datos.SetFocus()
dw_datos.SetFilter('')
dw_datos.Filter()
end event

event itemchanged;string ls_ruc,ls_verifica,ls_rucic,ls
int i,li_rucic[],li_coefic[],li_producto,li_residuo,li_sumprod,li_verificador
long ll_nreg

ls = this.getText()
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,ls)
If ll_nreg = 0 then return
ls_rucic = dw_datos.getitemstring(dw_datos.getrow(),"ce_rucic")


if f_valida_rucic(ls_rucic) = -1 then
	 beep(1)
	 messagebox("Error","N$$HEX1$$fa00$$ENDHEX$$mero de RUC mal ingresado o no es correcto...verifique",stopsign!)
	 return
end if



end event

type sle_1 from singlelineedit within w_cliente
integer x = 233
integer y = 24
integer width = 389
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "%"
end type

event modified;String ls_data,ls_cecodigo
Long ll_find,ll_reg

sle_2.text = ''
sle_3.text =''

ls_data = this.text
//ll_find = dw_1.find("ce_codigo like '"+ls_data+"'",1,dw_1.Rowcount())

//If ll_find <> 0 then 
//	dw_1.ScrollToRow(ll_find)
//	dw_1.SetRow(ll_find)
//end if

ll_reg = dw_1.retrieve(str_appgeninfo.empresa )
if ll_reg = 0 then return

dw_1.SetFilter("ce_codigo like '"+ls_data+"'")

dw_1.SetRedraw(false)
dw_1.Filter( )
dw_1.SetRedraw(true)

if dw_1.Rowcount( )= 0 then return 
dw_1.visible = true
ls_cecodigo = dw_1.getitemstring(1,"ce_codigo" )
dw_datos.retrieve(str_appgeninfo.empresa, ls_cecodigo )

end event

type sle_2 from singlelineedit within w_cliente
integer x = 827
integer y = 24
integer width = 494
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "%"
end type

event modified;String ls_data,ls_cecodigo
Long ll_find

sle_1.text = ''
sle_3.text = ''

ls_data = this.text

//ll_find = dw_1.find("ce_rucic like '"+ls_data+"'",1,dw_1.Rowcount())
//
//If ll_find <> 0 then 
//	dw_1.ScrollToRow(ll_find)
//	dw_1.SetRow(ll_find)
//end if
dw_1.retrieve(str_appgeninfo.empresa )
dw_1.SetFilter( "ce_rucic like '"+ls_data+"'" )
dw_1.Filter( )
if dw_1.Rowcount( )= 0 then return 
dw_1.visible = true
ls_cecodigo = dw_1.getitemstring(1,"ce_codigo" )

dw_datos.retrieve(str_appgeninfo.empresa, ls_cecodigo )

end event

type st_1 from statictext within w_cliente
integer x = 50
integer y = 36
integer width = 178
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Codigo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_cliente
integer x = 654
integer y = 32
integer width = 174
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "RUC/CI"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_cliente
integer x = 1627
integer y = 28
integer width = 1911
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "%"
end type

event modified;String ls_data,ls_cecodigo
Long ll_find

sle_1.text = ''
sle_2.text = ''

ls_data = this.text
//ls_filter= "ce_razons like '"+ls_data+"'"

//ll_find = dw_1.find("ce_razons like '"+ls_data+"'",1,dw_1.Rowcount())
//
//If ll_find <> 0 then 
//	dw_1.ScrollToRow(ll_find)
//	dw_1.SetRow(ll_find)
//end if
dw_1.retrieve(str_appgeninfo.empresa )
dw_1.SetFilter("cliente  like '"+ls_data+"'")
dw_1.Filter()
if dw_1.Rowcount( )= 0 then return 
dw_1.visible = true
ls_cecodigo = dw_1.getitemstring(1,"ce_codigo" )
dw_datos.retrieve(str_appgeninfo.empresa, ls_cecodigo )

end event

type st_4 from statictext within w_cliente
integer x = 1413
integer y = 36
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
string text = "Nombre"
boolean focusrectangle = false
end type

type dw_mov from datawindow within w_cliente
integer x = 3561
integer y = 120
integer width = 2181
integer height = 2264
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_movimientos_x_cliente_resumido"
boolean livescroll = true
end type

event constructor;this.SetTransObject(sqlca)
end event

event buttonclicked;
if dw_datos.getrow( ) = 0 then return
if dwo.name = 'b_1' then
	
dw_datos.Object.ce_salcre[ dw_datos.getrow( )  ] = this.Object.cc_salcre[1 ]
end if
end event

type cb_1 from commandbutton within w_cliente
integer x = 3561
integer y = 12
integer width = 1102
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver Movimientos del Cliente"
boolean flatstyle = true
end type

event clicked;String ls_codclie
Decimal lc_cupo

ls_codclie = dw_datos.Object.ce_codigo[ dw_datos.getrow( ) ]
lc_cupo = dw_datos.object.ce_cupcre[ dw_datos.getrow( ) ]
dw_mov.retrieve(str_appgeninfo.empresa,ls_codclie,lc_cupo )


end event

type dw_1 from datawindow within w_cliente
boolean visible = false
integer x = 2496
integer y = 200
integer width = 2857
integer height = 1256
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_um_cliente_tabular"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
end type

event doubleclicked;//String ls_colname
//Integer i,li_ColNbr
//This.AcceptText()
//ls_colname  = dwo.name
//li_ColNbr =  This.GetClickedColumn()
//
//CHOOSE CASE li_ColNbr
//		//Number
//    CASE 28,32,37,46,57
//        
//         for i = row to this.rowcount()
//		this.setitem(i,ls_colname,This.GetItemNumber(row,ls_colname,Primary!,false))
//	    next	
//		//DateTime
//	CASE 34,48
//		for i = row to this.rowcount()
//		this.setitem(i,ls_colname,This.GetItemDateTime(row,ls_colname,Primary!,false))
//	    next
//        //String
//    CASE ELSE
//		
//		for i = row to this.rowcount()
//		this.setitem(i,ls_colname,This.GetItemString(row,ls_colname,Primary!,false))
//		next	
//
//END CHOOSE
end event

event buttonclicked;
//string ls_rucic,ls
//int i
//long ll_nreg

//Permite editar el cliente
//if dwo.name = 'b_2' then
//	
//ls = this.getitemstring(row,"ce_codigo")
//ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,ls)
//If ll_nreg = 0 then return
//shl_1.text = 'Ver listado'
//dw_datos.bringtotop = true
//dw_datos.visible = true
//ls_rucic = dw_datos.getitemstring(dw_datos.getrow(),"ce_rucic")
//
//if f_valida_rucic(ls_rucic) = -1 then
//	 beep(1)
//	 messagebox("Error","N$$HEX1$$fa00$$ENDHEX$$mero de RUC mal ingresado o no es correcto...verifique",stopsign!)
//	 return
//end if
//end if
end event

event rowfocuschanged;String ls_cecodigo
integer li_reg

SetrowfocusIndicator(hand!)
dw_1.AcceptText( )
if currentrow = 0 then return
li_reg = dw_1.rowcount( )
ls_cecodigo = dw_1.getitemstring(currentrow,"ce_codigo" )
dw_datos.retrieve(str_appgeninfo.empresa, ls_cecodigo )
dw_mov.reset()
end event

event constructor;this.SetTransObject(sqlca)
end event

