HA$PBExportHeader$w_proveedor.srw
$PBExportComments$Si.Mantenimiento de proveedores.Vale
forward
global type w_proveedor from w_sheet_1_dw_maint
end type
type st_3 from statictext within w_proveedor
end type
type dw_detsri from datawindow within w_proveedor
end type
type dw_ubica from datawindow within w_proveedor
end type
type st_4 from statictext within w_proveedor
end type
type sle_1 from singlelineedit within w_proveedor
end type
type st_6 from statictext within w_proveedor
end type
type sle_2 from singlelineedit within w_proveedor
end type
type st_1 from statictext within w_proveedor
end type
type sle_3 from singlelineedit within w_proveedor
end type
type st_2 from statictext within w_proveedor
end type
type st_5 from statictext within w_proveedor
end type
type dw_mov from datawindow within w_proveedor
end type
type st_7 from statictext within w_proveedor
end type
type dw_vendedores from uo_dw_basic within w_proveedor
end type
type dw_1 from datawindow within w_proveedor
end type
type st_8 from statictext within w_proveedor
end type
type ln_1 from line within w_proveedor
end type
end forward

global type w_proveedor from w_sheet_1_dw_maint
integer width = 5979
integer height = 2488
string title = "Proveedor"
boolean resizable = false
boolean ib_notautoretrieve = true
event ue_consultar pbm_custom10
st_3 st_3
dw_detsri dw_detsri
dw_ubica dw_ubica
st_4 st_4
sle_1 sle_1
st_6 st_6
sle_2 sle_2
st_1 st_1
sle_3 sle_3
st_2 st_2
st_5 st_5
dw_mov dw_mov
st_7 st_7
dw_vendedores dw_vendedores
dw_1 dw_1
st_8 st_8
ln_1 ln_1
end type
global w_proveedor w_proveedor

type variables
Datawindowchild idwc_fp,idwc_gc
boolean ib_flag
end variables

forward prototypes
public subroutine wf_dw_query_mode ()
public subroutine wf_dw_retrieve_mode ()
end prototypes

event ue_consultar;dw_datos.SetFilter('')
dw_datos.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

public subroutine wf_dw_query_mode ();//  (Query Mode)

//Turn on DataWindow Query (Criteria Specification) Mode
//dw_2.Object.datawindow.querymode= 'yes'

//Set focus into the DataWindow
//dw_2.SetFocus ()

//Change Text of Button to allow Retrieval
//st_action.Text = "Recuperar"

//change datawindow heading to reflect query mode
//st_dw_mode.text  = "Modo de Consulta"

end subroutine

public subroutine wf_dw_retrieve_mode ();// Retrieve from Criteria

// Don't redraw until retrieval is finished
//dw_2.SetRedraw (FALSE)
//
////	Turn off DataWindow Query (Criteria-specification) Mode
//dw_2.Object.datawindow.querymode = 'no'
//
////	Retrieve, then redraw
//dw_2.Retrieve (str_appgeninfo.empresa)
//dw_2.SetRedraw (TRUE)

//Change Text of Button to allow Query Mode Again 
//st_action.Text = "Consultar"

//change datawindow heading to reflect retrieved data
//st_dw_mode.text = "Datos recuperados basados en el criterio de b$$HEX1$$fa00$$ENDHEX$$squeda:"
end subroutine

on w_proveedor.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_detsri=create dw_detsri
this.dw_ubica=create dw_ubica
this.st_4=create st_4
this.sle_1=create sle_1
this.st_6=create st_6
this.sle_2=create sle_2
this.st_1=create st_1
this.sle_3=create sle_3
this.st_2=create st_2
this.st_5=create st_5
this.dw_mov=create dw_mov
this.st_7=create st_7
this.dw_vendedores=create dw_vendedores
this.dw_1=create dw_1
this.st_8=create st_8
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_detsri
this.Control[iCurrent+3]=this.dw_ubica
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.sle_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.dw_mov
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.dw_vendedores
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.ln_1
end on

on w_proveedor.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_detsri)
destroy(this.dw_ubica)
destroy(this.st_4)
destroy(this.sle_1)
destroy(this.st_6)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.sle_3)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.dw_mov)
destroy(this.st_7)
destroy(this.dw_vendedores)
destroy(this.dw_1)
destroy(this.st_8)
destroy(this.ln_1)
end on

event open;string ls_parametro[]

//istr_argInformation.nrArgs = 1
//istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa


ls_parametro[1] = '593' //ecuador por default

f_recupera_datos(dw_datos,"cu_codigo",ls_parametro,1)
f_recupera_datos(dw_report,"cu_codigo",ls_parametro,1)
f_recupera_empresa(dw_datos,"rf_codigo")
f_recupera_empresa(dw_datos,"rf_codigo2")
f_recupera_empresa(dw_datos,"fp_codigo")
f_recupera_empresa(dw_datos,"gt_codigo")
f_recupera_empresa(dw_datos,"gt_codigo_1")
f_recupera_empresa(dw_datos,"if_codigo")



dw_report.SetTransObject(sqlca)
dw_datos.SetTransObject(sqlca)

dw_datos.InsertRow(0)

dw_datos.is_SerialCodeColumn    = "pv_codigo"
dw_datos.is_SerialCodeType       = "COD_PRO"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa


dw_datos.Getchild("fp_codigo",idwc_fp)
idwc_fp.setTransObject(sqlca)
idwc_fp.setfilter("fp_string like '%C%'")
idwc_fp.filter()


dw_datos.GetChild("gt_codigo",idwc_gc)
idwc_gc.SetTransObject(sqlca)
idwc_gc.SetFilter("md_codigo = 'CXP' ")
idwc_gc.Filter()



dw_1.SetTransObject(sqlca)




st_1.bringtoTop = true


call super::open
end event

event ue_insert;graphicObject lgo_curObject
long ll_curRow
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_insertCurrentRow()


end event

event ue_firstrow;graphicObject lgo_curObject
long ll_curRow
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_firstRow()


end event

event ue_delete;graphicObject lgo_curObject
long ll_curRow
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_deleteCurrentRow()
end event

event ue_lastrow;graphicObject lgo_curObject
long ll_curRow
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_lastRow()
end event

event ue_nextrow;graphicObject lgo_curObject
long ll_curRow
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_nextRow()
end event

event ue_print;Long ll_row
String ls_pvcodigo

ll_row = dw_datos.getrow()
if ll_row = 0 then return
ls_pvcodigo = dw_datos.getitemstring(ll_row,"pv_codigo")
dw_report.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_report.print()
end event

event resize;//dw_1.resize(this.workSpaceWidth() - 200, dw_1.Height)
//dw_datos.resize(this.workSpaceWidth() - 200, dw_datos.Height)
//dw_sri.resize(this.workSpaceWidth() - 200,dw_sri.Height)
//dw_detsri.resize(this.workSpaceWidth() - 200,dw_sri.height)
return 1
end event

event ue_retrieve;return 1
end event

event activate;call super::activate;move(1,1)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_proveedor
integer x = 23
integer y = 696
integer width = 3387
integer height = 1700
string title = "Proveedor"
string dataobject = "d_proveedor"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_datos::itemchanged;long ll_filact
string ls_pais[], ls_null, ls_prov,ls_origen,ls_swift

this.accepttext()
this.SetItem(row,"em_codigo",istr_argInformation.StringValue[1])

CHOOSE CASE this.GetColumnName()
	CASE "pa_codigo"
		ls_pais[1] = this.GetText()
		setnull(ls_null)
		this.SetItem(row,"cu_codigo",ls_null)
		f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
	CASE "pv_rucci"
		
          ls_origen = this.object.pv_origen[row]
      	
		if ls_origen = 'N' then		/*Prov: Nacional*/
			/*Validar el Ruc o CI*/
			if f_valida_rucic(data) < 0 then 
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ruc o CI no v$$HEX1$$e100$$ENDHEX$$lido")
				Return 1
			end if	
					
			
			select pv_rucci
			into:ls_prov
			from in_prove
			where pv_rucci = :data;
			If sqlca.sqlcode <> 100 Then
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este n$$HEX1$$fa00$$ENDHEX$$mero de RUC ya fue ingresado")
				return 1
			End if
		end if	
		
	CASE "pv_tipcta"
		setnull(ls_null)
		if data = '00' then
		this.setitem(row,"pv_numcta",ls_null)
		end if
		
	CASE "if_codigo"
		select if_swift into :ls_swift from pr_instfin where if_codigo = :data;
		this.setitem(row,"swift",ls_swift)
	
END CHOOSE
		
end event

event dw_datos::scrollvertical;call super::scrollvertical;//long ll_filact
//string ls_pais[]
//ll_filact = this.GetRow()
//if ll_filact > 0 then
//ls_pais[1] = this.GetItemString(ll_filact,"pa_codigo")
//f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
//end if
end event

event dw_datos::itemerror;return 1

end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//Recuperar el detalle de los documentos por proveedor
string ls_pvcodigo


ls_pvcodigo = this.object.pv_codigo[currentrow]
if isnull(ls_pvcodigo ) or ls_pvcodigo = "" then return

dw_detsri.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_proveedor
integer x = 4631
integer y = 1392
integer width = 361
integer taborder = 30
string dataobject = "d_proveedor_prn"
end type

type st_3 from statictext within w_proveedor
integer x = 27
integer y = 24
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Buscar por:"
boolean focusrectangle = false
end type

type dw_detsri from datawindow within w_proveedor
integer x = 3429
integer y = 100
integer width = 2523
integer height = 676
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_legales_x_prov_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;this.SetTransObject(sqlca)
end event

event buttonclicked;String  ls_sec,ls_pvcodigo
Long ll_row

if dwo.name = 'b_1' then
	ll_row = dw_datos.getrow()
	if ll_row = 0 then return -1
	
	ls_pvcodigo   =  dw_datos.Object.pv_codigo[ll_row]
	if isnull(ls_pvcodigo) or ls_pvcodigo = '' then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha seleccionado ningun proveedor.....Por favor verifique...!")
		return -1
	else
		this.Object.pv_codigo[ll_row ]  =  ls_pvcodigo
	end if
end if

//if dwo.name = 'b_3' then
//	
//     ls_pvcodigo   =  dw_datos.Object.pv_codigo[ll_row]
//	if isnull(ls_pvcodigo) or ls_pvcodigo = '' then
//		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha seleccionado ningun proveedor.....Por favor verifique...!")
//		return -1
//	end if
//	if this.update(true, false ) = 1 then
//		commit;
//		this.retrieve(str_appgeninfo.empresa,ls_pvcodigo )
//		else
//		rollback;
//	end if
//end if

end event

event itemchanged;String ls_pvcodigo
integer li_secini





//Validar n$$HEX1$$fa00$$ENDHEX$$mero de autorizaci$$HEX1$$f300$$ENDHEX$$n por documento y por proveedor




//Validar rango de secuencia por documento y por proveedor

//IF dwo.name = 'dc_tipodoc' then
//	ls_pvcodigo = dw_datos.object.pv_codigo[dw_datos.getrow()]
//	SELECT MAX(DC_SECFIN)  + 1 
//	INTO    :li_secini
//	FROM   IN_DOCPRO
//	WHERE DC_TIPODOC = :data
//	AND      PV_CODIGO = :ls_pvcodigo;
//
//     if li_secini  = 0 or isnull(li_secini) then li_secini = 1
//	this.object.dc_secini[row] = li_secini
//end if


if dwo.name = 'dc_fecemi' then
	if date(data) >= date(this.object.dc_fecven[row]) then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas inv$$HEX1$$e100$$ENDHEX$$lido")
	return 1
	end if
end if


if dwo.name = 'dc_fecven' then
	if date(data) <= date(this.object.dc_fecemi[row]) then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas inv$$HEX1$$e100$$ENDHEX$$lido")
	return 1
	end if
end if
end event

event updatestart;String ls_proveedor
integer li,ll,li_row,li_cod

li_row = this.getrow()

if li_row = 0 then return 1
for li = 1 to this.rowcount()
	     li_cod = this.GetItemNumber(li,'id')
		 if isnull(li_cod) or li_cod = 0 then
			 select nvl(max( id ),0 ) +1
			 into :ll
			 from in_docpro;
			 this.SetItem(li,'id',ll  ) 
		end if
next
return 0
end event

type dw_ubica from datawindow within w_proveedor
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 357
integer y = 1436
integer width = 2199
integer height = 388
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda de Proveedores"
string dataobject = "d_busca_prov"
boolean livescroll = true
end type

event ue_dwnkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
     dw_datos.SetFocus()
	dw_datos.SetFilter('')
	dw_datos.Filter()
end if
end event

event itemchanged;string ls_criterio, ls_tipo
long ll_found,ll_nreg

ls_tipo = this.GetItemString(1,'tipo')
ll_nreg = dw_datos.RowCount()
If dwo.name = 'codant' Then
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "pv_codigo = '" + data +"'"		
				ll_found = dw_datos.Find(ls_criterio,1,ll_nreg)
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('pv_codigo')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Proveedor no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "pv_codigo like '" + data + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
    		          dw_datos.SetColumn('pv_codigo')
				this.Visible = false	
				dw_datos.ScrollToRow(dw_datos.GetRow())
			    dw_datos.SetRow(dw_datos.GetRow())				
             END CHOOSE
	End if
If dwo.name = 'rucic' Then
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "pv_rucci = '" + data +"'"		
				ll_found = dw_datos.Find(ls_criterio,1,ll_nreg)
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('pv_rucci')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Proveedor no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "pv_rucci like '"+ data + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
    		   		dw_datos.SetColumn('pv_rucci')
				this.Visible = false	
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())				
            END CHOOSE
	End if
If dwo.name = 'nombre' Then
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "pv_nombre = '"+data + "'"		
				ll_found = dw_datos.Find(ls_criterio,1,ll_nreg)
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('pv_nombre')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Proveedor no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "pv_nombre like '"+ data + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
			     dw_datos.SetColumn('pv_nombre')
				this.Visible = false				
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())				
               END CHOOSE
End If

If dwo.name = 'apellido' Then
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "pv_apelli = '"+ data + "'"		
				ll_found = dw_datos.Find(ls_criterio,1,ll_nreg)
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('pv_apelli')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Proveedor no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "pv_apelli like '"+ data + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
			   dw_datos.SetColumn('pv_apelli')
				this.Visible = false				
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())				
              END CHOOSE
End if
If dwo.name = 'razon_social' Then
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "pv_razons = '"+ data + "'"		
				ll_found = dw_datos.Find(ls_criterio,1,ll_nreg)
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('pv_razons')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Proveedor no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "pv_razons like'"+ data + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
			     dw_datos.SetColumn('pv_razons')
				this.Visible = false				
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())		
		END CHOOSE
End if
end event

event doubleclicked;dw_ubica.Visible = false
dw_datos.SetFocus()
dw_datos.SetFilter('')
dw_datos.Filter()
end event

type st_4 from statictext within w_proveedor
integer x = 1061
integer y = 24
integer width = 206
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "RUC/CI :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_proveedor
integer x = 626
integer y = 16
integer width = 393
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "%"
borderstyle borderstyle = stylelowered!
end type

event modified;String ls_pvcodigo

SetPointer(Hourglass!)
dw_1.retrieve(str_appgeninfo.empresa)
dw_1.Setfilter("pv_codigo like '"+sle_1.text+"'")
dw_1.Filter()

if dw_1.rowcount() <=  0 then return
dw_1.visible = true
dw_1.bringtoTop = true

ls_pvcodigo = dw_1.object.pv_codigo[1]
if isnull(ls_pvcodigo ) or ls_pvcodigo = "" then return
dw_datos.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_detsri.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_mov.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_vendedores.Retrieve(ls_pvcodigo)


SetPointer(Arrow!)
end event

event getfocus;String ls_nulo


Setnull(ls_nulo)
sle_2.text = ls_nulo
sle_3.text = ls_nulo
end event

type st_6 from statictext within w_proveedor
integer x = 411
integer y = 24
integer width = 197
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$digo:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_proveedor
integer x = 1248
integer y = 16
integer width = 411
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
string text = "%"
borderstyle borderstyle = stylelowered!
end type

event modified;String ls_pvcodigo

Setpointer(Hourglass!)
dw_1.retrieve(str_appgeninfo.empresa)
dw_1.Setfilter("pv_rucci like '"+sle_2.text+"'")
dw_1.Filter()


if dw_1.rowcount() <=  0 then return
dw_1.visible = true
dw_1.bringtoTop = true

ls_pvcodigo = dw_1.object.pv_codigo[1]
if isnull(ls_pvcodigo ) or ls_pvcodigo = "" then return
dw_datos.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_detsri.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_mov.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_vendedores.Retrieve(ls_pvcodigo)
Setpointer(Arrow!)
end event

event getfocus;String ls_nulo


Setnull(ls_nulo)
sle_1.text = ls_nulo
sle_3.text = ls_nulo
end event

type st_1 from statictext within w_proveedor
integer x = 3447
integer y = 1676
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Vendedores"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_proveedor
integer x = 1961
integer y = 16
integer width = 1435
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
string text = "%"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;String ls_pvcodigo,ls


ls  = sle_3.text 

SetPointer(HourGlass!)
dw_1.retrieve(str_appgeninfo.empresa)
dw_1.SetFilter("(UPPER(pv_razons)  like '"+ls+"') or (UPPER(pv_apelli) like '"+ls+"') or( UPPER(pv_nombre) like '"+ls+"')")
dw_1.Filter()

if dw_1.rowcount() <=  0 then return
dw_1.visible = true
dw_1.bringtoTop = true

ls_pvcodigo = dw_1.object.pv_codigo[1]
if isnull(ls_pvcodigo ) or ls_pvcodigo = "" then return
dw_datos.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_detsri.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_mov.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_vendedores.Retrieve(ls_pvcodigo)
SetPointer(Arrow!)






end event

event getfocus;String ls_nulo


Setnull(ls_nulo)
sle_1.text = ls_nulo
sle_2.text = ls_nulo
end event

type st_2 from statictext within w_proveedor
integer x = 1705
integer y = 24
integer width = 242
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Proveedor:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_proveedor
integer x = 3433
integer y = 28
integer width = 453
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Documentos legales"
boolean focusrectangle = false
end type

type dw_mov from datawindow within w_proveedor
integer x = 3429
integer y = 852
integer width = 2523
integer height = 792
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_movimientos_x_prov_resumido"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type st_7 from statictext within w_proveedor
integer x = 3442
integer y = 780
integer width = 599
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Movimientos del Proveedor"
boolean focusrectangle = false
end type

type dw_vendedores from uo_dw_basic within w_proveedor
event ue_keydown pbm_dwnkey
integer x = 3429
integer y = 1744
integer width = 2523
integer height = 644
integer taborder = 2
boolean bringtotop = true
string title = "Vendedores del Proveedor"
string dataobject = "d_vendedores_proveedor"
boolean hscrollbar = false
boolean livescroll = false
end type

event updatestart;call super::updatestart;String ls_cod,ls_proveedor
integer li,ll,li_row

li_row = dw_datos.getrow()

if li_row = 0 then return 1
for li = 1 to this.rowcount()
	     this.object.pv_codigo[li] =  dw_datos.GetItemString(li_row,'pv_codigo')
	     ls_cod = this.GetItemString(li,'vp_codigo')
		 if isnull(ls_cod) or ls_cod = '' then
			 select nvl(max(to_number(vp_codigo)),0) +1
			 into :ll
			 from in_venpro
			 where pv_codigo = :ls_proveedor;
			 this.SetItem(li,'vp_codigo',string(ll))
		end if
next
return 0
end event

event constructor;call super::constructor;this.SetTransObject(sqlca)
end event

type dw_1 from datawindow within w_proveedor
integer x = 14
integer y = 140
integer width = 3397
integer height = 536
integer taborder = 20
boolean bringtotop = true
string title = "Listado de Proveedores"
string dataobject = "d_lista_proveedores"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;
//Recuperar el detalle de los documentos por proveedor
string ls_pvcodigo


SetRowfocusIndicator(hand!)
if currentrow = 0 then return

ls_pvcodigo = this.object.pv_codigo[currentrow]
if isnull(ls_pvcodigo ) or ls_pvcodigo = "" then return
dw_datos.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_detsri.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_mov.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
dw_vendedores.Retrieve(ls_pvcodigo)


end event

event doubleclicked;String ls_colname
Integer i,li_ColNbr

This.AcceptText()
ls_colname  = dwo.name
li_ColNbr =  This.GetClickedColumn()

		
for i = row to this.rowcount()
this.setitem(i,ls_colname,This.GetItemString(row,ls_colname,Primary!,false))
next	


end event

type st_8 from statictext within w_proveedor
integer x = 41
integer y = 696
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

type ln_1 from line within w_proveedor
long linecolor = 128
integer linethickness = 4
integer beginx = 23
integer beginy = 112
integer endx = 3392
integer endy = 112
end type

