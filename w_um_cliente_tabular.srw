HA$PBExportHeader$w_um_cliente_tabular.srw
$PBExportComments$1
forward
global type w_um_cliente_tabular from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_um_cliente_tabular
end type
end forward

global type w_um_cliente_tabular from w_sheet_1_dw_maint
integer width = 3287
integer height = 2424
string title = "Cliente"
long backcolor = 67108864
event ue_consultar ( )
dw_ubica dw_ubica
end type
global w_um_cliente_tabular w_um_cliente_tabular

type variables
string is_mensaje
datawindowChild  idwc_aux
end variables

event ue_consultar();dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

on w_um_cliente_tabular.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
end on

on w_um_cliente_tabular.destroy
call super::destroy
destroy(this.dw_ubica)
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




dw_datos.Getchild("ce_estatu",idwc_aux)
idwc_aux.SetTransObject(sqlca)
idwc_aux.retrieve('593')

f_recupera_empresa(dw_datos,"ep_codigo")
dw_datos.is_SerialCodeColumn = "ce_codigo"
dw_datos.is_SerialCodeType = "COD_CLI"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
this.ib_notautoretrieve = true
call super::open
end event

event ue_insert;string ls_codigo

dw_datos.Reset()
 select ep_codigo
 into :ls_codigo
from no_emple
where sa_login = :str_appgeninfo.username
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal;
If sqlca.sqlcode =100 Then
	messagebox("Error","Empleado no encontrado",stopsign!)
	return 1
End if

call super::ue_insert
dw_datos.setitem(dw_datos.getrow(),"ep_codigo",ls_codigo)
dw_datos.setitem(dw_datos.getrow(),"su_codigo",str_appgeninfo.sucursal)


end event

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.empresa)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_um_cliente_tabular
event ue_nextfield pbm_dwnprocessenter
integer x = 23
integer y = 16
integer width = 3214
integer height = 2280
string dataobject = "d_um_cliente_tabular"
boolean hsplitscroll = true
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

//If dwo.name = "ce_estatu" Then
//	idwc_aux.SetFilter("")
//	idwc_aux.filter()
////		accepttext()
////		ls_po_codigo = this.getItemstring(row,"po_codigo")
////		ls_pa_codigo = this.getItemstring(row,"pa_codigo")
////		ls_pais[] = {ls_pa_codigo}
////		f_recupera_datos(dw_datos,"ce_estatu",ls_pais,1)
//End if


If dwo.name = "ce_cupcre" Then
		lc_cupo = dec(this.GetText())
		lc_dif = lc_cupo - this.GetItemNumber(ll_filact,'ce_cupcre',primary!,true)
		lc_saldo = this.GetItemNumber(ll_filact,'ce_salcre',primary!,true)
		if isnull(lc_saldo) or lc_saldo = 0.00 then
			this.SetItem(ll_filact,'ce_salcre',lc_cupo)
		else
			this.SetItem(ll_filact,'ce_salcre', lc_saldo + lc_dif)
		end if
end if


end event

event dw_datos::scrollvertical;call super::scrollvertical;long ll_filact
string ls_pais[]
ll_filact = this.GetRow()
if ll_filact > 0 then
ls_pais[1] = this.GetItemString(ll_filact,"pa_codigo")
f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
end if
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;long   ll_filact
string ls_pais[]
ll_filact = this.GetRow()
if ll_filact > 0 then
ls_pais[1] = this.GetItemString(ll_filact,"pa_codigo")
f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
end if
end event

event dw_datos::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"ce_fecha",f_hoy())


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
if ls_rol <> 'CARTERA' and  ls_rol <> 'CARTERA_SUC' and ls_rol <> 'ADMINISTRADOR' then
   if ls_cargo <> '2' then /*POS*/
   this.enabled = true      	
   f_inhabilita_campos(dw_datos,ls_campos)
   elseif ls_cargo = '2' then
   this.enabled = false
   end if	
end if
end if
/****************/

String ls_cecodigo
Dec{2} lc_saldo
Long ll_row

ll_row = this.getrow()
if ll_row = 0 then return
ls_cecodigo = this.object.ce_codigo[ll_row]

select sum(mt_saldo)
into :lc_saldo
from cc_movim 
where em_codigo = :str_appgeninfo.empresa
and tt_ioe = 'D'
and ce_codigo = :ls_cecodigo;

this.object.saldopendiente[ll_row] = lc_saldo

end event

event dw_datos::itemfocuschanged;call super::itemfocuschanged;String ls_po_codigo,ls_pa_codigo
String ls_pais[]
int li_reg

If dwo.name = "ct_codigo" Then
		accepttext()
		ls_po_codigo = this.getItemstring(row,"po_codigo")
		ls_pa_codigo = this.getItemstring(row,"pa_codigo")
		ls_pais[] = {ls_pa_codigo,ls_po_codigo}
		f_recupera_datos(dw_datos,"ct_codigo",ls_pais,2)
End if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_um_cliente_tabular
integer x = 1819
integer y = 1768
integer width = 562
integer height = 96
integer taborder = 30
end type

type dw_ubica from datawindow within w_um_cliente_tabular
event ue_downkey pbm_dwnkey
boolean visible = false
integer x = 1097
integer y = 572
integer width = 1271
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

