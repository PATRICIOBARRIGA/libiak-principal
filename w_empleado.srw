HA$PBExportHeader$w_empleado.srw
$PBExportComments$Si.Empleado de una sucursal
forward
global type w_empleado from w_sheet_master_tabpage_detail
end type
type dw_ubica from datawindow within w_empleado
end type
type dw_1 from datawindow within w_empleado
end type
type sle_1 from singlelineedit within w_empleado
end type
type st_1 from statictext within w_empleado
end type
type cbx_1 from checkbox within w_empleado
end type
end forward

global type w_empleado from w_sheet_master_tabpage_detail
integer x = 5
integer y = 220
integer width = 4571
integer height = 2804
string title = "Empleado"
event ue_consultar pbm_custom16
event ue_edit pbm_custom20
dw_ubica dw_ubica
dw_1 dw_1
sle_1 sle_1
st_1 st_1
cbx_1 cbx_1
end type
global w_empleado w_empleado

forward prototypes
public function integer wf_activacampos ()
public function integer wf_cambiacolor ()
end prototypes

event ue_consultar;dw_master.postevent(DoubleClicked!)
//dw_master.Object.w_observacion.text = '          '

end event

event ue_edit;/*Habilitar el datawindow para ingresar la clave para edicion*/

String     lch_cambio,ls_activo,ls_objeto
window lw_aux

lw_aux = getActiveSheet()
ls_objeto = lw_aux.classname()

select mn_activo
into :ls_activo
from sg_menu
where mn_opcion = :ls_objeto;

if ls_activo = 'S'  then
	openwithparm(w_response_clave,lw_aux)
	lch_cambio = message.stringParm
	If lch_cambio = 'S' then
	//activar campos	
	wf_activacampos()
	//cambiar el color
	wf_cambiacolor()
	end if
else
	wf_activacampos()
	//cambiar el color
	wf_cambiacolor()
end if
end event

public function integer wf_activacampos ();//Activa los campos de la cabecera
dw_master.Object.ep_nonom.Protect=0
dw_master.Object.ep_sexo.Protect=0
dw_master.Object.ep_nombre.Protect=0
dw_master.Object.ep_apepat.Protect=0
dw_master.Object.ep_apemat.Protect=0
dw_master.Object.ep_ci.Protect=0
dw_master.Object.ep_cedmil.Protect=0
dw_master.Object.ep_fecnac.Protect=0
dw_master.Object.pa_codigo.Protect=0
dw_master.Object.po_codigo.Protect=0
dw_master.Object.ct_codigo.Protect=0
dw_master.Object.ep_estcivil.Protect=0
dw_master.Object.ep_tipsan.Protect=0
dw_master.Object.ep_conyu.Protect=0
dw_master.Object.ep_calle1.Protect=0

dw_master.Object.ep_calle2.Protect=0
dw_master.Object.ep_telef.Protect=0
dw_master.Object.ep_celular.Protect=0
dw_master.Object.ep_instruc.Protect=0

dw_master.Object.ep_anios.Protect=0
dw_master.Object.ep_titulo.Protect=0
dw_master.Object.ep_fecafi.Protect=0
dw_master.Object.ep_numafil.Protect=0

dw_master.Object.ep_email.Protect=0
dw_master.Object.ep_fecent.Protect=0
dw_master.Object.ep_horent.Protect=0
dw_master.Object.ep_horsal.Protect=0
dw_master.Object.ep_fecsal.Protect=0

dw_master.Object.sa_login.Protect=0
dw_master.Object.ep_contrato.Protect=0
dw_master.Object.ep_bnfsocial.Protect=0
dw_master.Object.ep_iess.Protect=0

dw_master.Object.ep_sueldo.Protect=0
dw_master.Object.ep_valqui.Protect=0
dw_master.Object.ep_comision.Protect=0
dw_master.Object.ep_codsec.Protect=0

dw_master.Object.ep_ctabco.Protect=0
dw_master.Object.ep_clavnom.Protect=0
dw_master.Object.ep_saludo.Protect=0
dw_master.Object.su_codigo.Protect=0

dw_master.Object.cs_codigo.Protect=0
dw_master.Object.dt_codigo.Protect=0
dw_master.Object.bo_codigo.Protect=0
dw_master.Object.cr_codigo.Protect=0
dw_master.Object.ep_codjef.Protect=0
/*Activa Cargas familiares*/

tab_detail.tabpage_detail1.dw_detail1.Object.cf_nombre.Protect = 0
tab_detail.tabpage_detail1.dw_detail1.Object.cf_apelli.Protect= 0
tab_detail.tabpage_detail1.dw_detail1.Object.pf_codigo.Protect = 0
tab_detail.tabpage_detail1.dw_detail1.Object.cf_fecnac.protect = 0

/*Activa Permisos*/
tab_detail.tabpage_detail2.dw_detail2.Object.pe_tipo.Protect = 0
tab_detail.tabpage_detail2.dw_detail2.Object.pe_fecha.Protect= 0
tab_detail.tabpage_detail2.dw_detail2.Object.pe_causa.Protect = 0
//

/*Activa Vacaciones*/
tab_detail.tabpage_detail3.dw_detail3.Object.va_fecsal.Protect = 0
tab_detail.tabpage_detail3.dw_detail3.Object.va_fecing.Protect= 0
tab_detail.tabpage_detail3.dw_detail3.Object.va_observ.Protect = 0
tab_detail.tabpage_detail3.dw_detail3.Object.va_salio.Protect = 0

/*Activa Cursos*/
tab_detail.tabpage_detail4.dw_detail4.Object.cm_fecini.Protect = 0
tab_detail.tabpage_detail4.dw_detail4.Object.cm_fecfin.Protect= 0
tab_detail.tabpage_detail4.dw_detail4.Object.cm_valor.Protect = 0
tab_detail.tabpage_detail4.dw_detail4.Object.cm_nombre.Protect = 0
tab_detail.tabpage_detail4.dw_detail4.Object.cm_descri.Protect = 0
tab_detail.tabpage_detail4.dw_detail4.Object.cm_financia.Protect = 0
tab_detail.tabpage_detail4.dw_detail4.Object.cm_estado.Protect = 0


return 1
end function

public function integer wf_cambiacolor ();dw_master.Object.ep_nombre.background.color=rgb(255,255,255)
dw_master.Object.ep_apepat.background.color = rgb(255,255,255)
dw_master.Object.ep_apemat.background.color = rgb(255,255,255)
dw_master.Object.ep_ci.background.color = rgb(255,255,255)
dw_master.Object.ep_cedmil.background.color = rgb(255,255,255)
dw_master.Object.ep_fecnac.background.color = rgb(255,255,255)
dw_master.Object.pa_codigo.background.color = rgb(255,255,255)
dw_master.Object.po_codigo.background.color = rgb(255,255,255)
dw_master.Object.ct_codigo.background.color = rgb(255,255,255)
dw_master.Object.ep_estcivil.background.color = rgb(255,255,255)
dw_master.Object.ep_conyu.background.color = rgb(255,255,255)
dw_master.Object.ep_calle1.background.color = rgb(255,255,255)

dw_master.Object.ep_calle2.background.color = rgb(255,255,255)
dw_master.Object.ep_telef.background.color = rgb(255,255,255)
dw_master.Object.ep_celular.background.color = rgb(255,255,255)
dw_master.Object.ep_instruc.background.color = rgb(255,255,255)

dw_master.Object.ep_anios.background.color = rgb(255,255,255)
dw_master.Object.ep_titulo.background.color = rgb(255,255,255)
dw_master.Object.ep_fecafi.background.color = rgb(255,255,255)
dw_master.Object.ep_numafil.background.color = rgb(255,255,255)

dw_master.Object.ep_email.background.color = rgb(255,255,255)
dw_master.Object.ep_fecent.background.color = rgb(255,255,255)
dw_master.Object.ep_horsal.background.color = rgb(255,255,255)
dw_master.Object.ep_fecsal.background.color = rgb(255,255,255)

dw_master.Object.sa_login.background.color = rgb(255,255,255)
dw_master.Object.ep_contrato.background.color = rgb(255,255,255)

dw_master.Object.ep_sueldo.background.color = rgb(255,255,255)
dw_master.Object.ep_valqui.background.color = rgb(255,255,255)
dw_master.Object.ep_comision.background.color = rgb(255,255,255)
dw_master.Object.ep_codsec.background.color = rgb(255,255,255)

dw_master.Object.ep_ctabco.background.color = rgb(255,255,255)
dw_master.Object.ep_clavnom.background.color = rgb(255,255,255)
dw_master.Object.ep_saludo.background.color = rgb(255,255,255)
dw_master.Object.su_codigo.background.color = rgb(255,255,255)

dw_master.Object.cs_codigo.background.color = rgb(255,255,255)
dw_master.Object.dt_codigo.background.color = rgb(255,255,255)
dw_master.Object.bo_codigo.background.color = rgb(255,255,255)
dw_master.Object.cr_codigo.background.color = rgb(255,255,255)
dw_master.Object.ep_codjef.background.color = rgb(255,255,255)
/*Activa Cargas familiares*/

tab_detail.tabpage_detail1.dw_detail1.Object.cf_nombre.background.color = rgb(255,255,255)
tab_detail.tabpage_detail1.dw_detail1.Object.cf_apelli.background.color = rgb(255,255,255)
tab_detail.tabpage_detail1.dw_detail1.Object.pf_codigo.background.color = rgb(255,255,255)
tab_detail.tabpage_detail1.dw_detail1.Object.cf_fecnac.background.color = rgb(255,255,255)

/*Activa Permisos*/
tab_detail.tabpage_detail2.dw_detail2.Object.pe_tipo.background.color = rgb(255,255,255)
tab_detail.tabpage_detail2.dw_detail2.Object.pe_fecha.background.color = rgb(255,255,255)
tab_detail.tabpage_detail2.dw_detail2.Object.pe_causa.background.color = rgb(255,255,255)
//

/*Activa Vacaciones*/
tab_detail.tabpage_detail3.dw_detail3.Object.va_fecsal.background.color = rgb(255,255,255)
tab_detail.tabpage_detail3.dw_detail3.Object.va_fecing.background.color = rgb(255,255,255)
tab_detail.tabpage_detail3.dw_detail3.Object.va_observ.background.color = rgb(255,255,255)
tab_detail.tabpage_detail3.dw_detail3.Object.va_salio.background.color = rgb(255,255,255)

/*Activa Cursos*/
tab_detail.tabpage_detail4.dw_detail4.Object.cm_fecini.background.color = rgb(255,255,255)
tab_detail.tabpage_detail4.dw_detail4.Object.cm_fecfin.background.color = rgb(255,255,255)
tab_detail.tabpage_detail4.dw_detail4.Object.cm_valor.background.color = rgb(255,255,255)
tab_detail.tabpage_detail4.dw_detail4.Object.cm_nombre.background.color = rgb(255,255,255)
tab_detail.tabpage_detail4.dw_detail4.Object.cm_descri.background.color = rgb(255,255,255)
tab_detail.tabpage_detail4.dw_detail4.Object.cm_financia.background.color = rgb(255,255,255)
tab_detail.tabpage_detail4.dw_detail4.Object.cm_estado.background.color = rgb(255,255,255)

return 1
end function

event open;datawindowchild dwc
string ls_parametro[]

istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

f_recupera_empresa(dw_master,"su_codigo")
f_recupera_empresa(dw_master,"bo_codigo")
f_recupera_empresa(dw_master,"ep_codjef")
f_recupera_empresa(dw_master,"dt_codigo")
f_recupera_empresa(dw_master,"cs_codigo")
ls_parametro[1] = '593' //ecuador por default
f_recupera_datos(dw_master,"po_codigo",ls_parametro,1) 
ls_parametro[] ={'593','17'}//Pichincha por defaut
f_recupera_datos(dw_master,"ct_codigo",ls_parametro,2) 

call super::open

dw_master.is_SerialCodeColumn = "ep_codigo"
dw_master.is_SerialCodeType = "COD_EMP"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa

dw_master.ii_nrCols = 1
dw_master.is_connectionCols[1] = "ep_codigo"
tab_detail.tabpage_detail1.dw_detail1.is_connectionCols[1] = "ep_codigo"
tab_detail.tabpage_detail1.dw_detail1.uf_setArgTypes()
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[1] = "ep_codigo"
tab_detail.tabpage_detail2.dw_detail2.uf_setArgTypes()
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[1] = "ep_codigo"
tab_detail.tabpage_detail3.dw_detail3.uf_setArgTypes()
tab_detail.tabpage_detail4.dw_detail4.is_connectionCols[1] = "ep_codigo"
tab_detail.tabpage_detail4.dw_detail4.uf_setArgTypes()
dw_master.uf_retrieve(istr_argInformation)
//dw_master.uf_insertCurrentRow()
//dw_master.setFocus()


//Si quiero que se llene al arrancar el maestro y el detalle
dw_1.settransobject(sqlca)
dw_1.retrieve(str_appgeninfo.empresa)
end event

on w_empleado.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_1=create dw_1
this.sle_1=create sle_1
this.st_1=create st_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cbx_1
end on

on w_empleado.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cbx_1)
end on

event resize;int li_width, li_height
uo_dw_detail ldw_detail

li_width  = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_master.resize(li_width - dw_1.width - 180, dw_master.height)
this.setRedraw(True)
end event

event ue_retrieve;dw_1.retrieve(str_appgeninfo.empresa)
end event

type dw_master from w_sheet_master_tabpage_detail`dw_master within w_empleado
integer x = 1582
integer y = 88
integer width = 2903
integer height = 1776
integer taborder = 10
string dataobject = "d_empleado"
boolean hscrollbar = false
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;string ls_su_codigo, ls_pais[], ls,ls_pa_codigo,ls_po_codigo
DataWindowChild  ldwc_aux

accepttext()
CHOOSE CASE this.getcolumnname()
	CASE 'ep_nombre'
		this.SetItem(row,"em_codigo",str_appgeninfo.empresa)
	CASE "pa_codigo"
		ls_pa_codigo = this.GetText()
		ls_pais[1] = ls_pa_codigo
		f_recupera_datos(dw_master,"po_codigo",ls_pais,1)
		ls_po_codigo = this.getItemstring(row,"po_codigo")
		ls_pais[] = {ls_pa_codigo,ls_po_codigo}		
		f_recupera_datos(dw_master,"ct_codigo",ls_pais,2)
	CASE "po_codigo"
		ls_po_codigo = this.getItemstring(row,"po_codigo")
		ls_pa_codigo = this.getItemstring(row,"pa_codigo")
		ls_pais[] = {ls_pa_codigo,ls_po_codigo}
		f_recupera_datos(dw_master,"ct_codigo",ls_pais,2)		
	CASE 'su_codigo'
		ls_su_codigo = this.getText()
		ls = "su_codigo = " + "'" + ls_su_codigo 
		dw_master.getChild("bo_codigo", ldwc_aux)
		ldwc_aux.SetFilter(ls)
		ldwc_aux.Filter()				
END CHOOSE
end event

event dw_master::doubleclicked;call super::doubleclicked;//dw_master.SetFilter('')
//dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::itemfocuschanged;call super::itemfocuschanged;String ls_parametro[],ls_codpais ,ls_codprov
ls_parametro[] ={'593','17'}//Pichincha por defaut


ls_codpais  = this.Object.pa_codigo[row]
ls_codprov = this.Object.po_codigo[row]

ls_parametro[] = {ls_codpais,ls_codprov}
f_recupera_datos(dw_master,"ct_codigo",ls_parametro,2) 
end event

event dw_master::ue_preinsert;call super::ue_preinsert;wf_activacampos()
wf_cambiacolor()
end event

type dw_report from w_sheet_master_tabpage_detail`dw_report within w_empleado
integer taborder = 30
end type

type tab_detail from w_sheet_master_tabpage_detail`tab_detail within w_empleado
integer x = 1582
integer y = 1884
integer width = 2907
integer height = 784
integer taborder = 20
end type

type tabpage_detail1 from w_sheet_master_tabpage_detail`tabpage_detail1 within tab_detail
integer y = 112
integer width = 2871
integer height = 656
string text = "Cargas Familiares"
string picturename = "Custom037!"
string powertiptext = ""
end type

type dw_detail1 from w_sheet_master_tabpage_detail`dw_detail1 within tabpage_detail1
integer x = 0
integer y = 0
integer width = 2880
integer height = 820
string dataobject = "d_carga_familiar"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_detail1::updatestart;call super::updatestart;long ll_filas ,ll, li
string ls, ls_emp

ls_emp = dw_master.GetItemString(dw_master.GetRow(),'ep_codigo')
Select max(to_number(cf_codigo))
  into :ll
  from NO_CARFAM
 where ep_codigo = :ls_emp;
if isnull(ll) then ll= 0

ll_filas = this.RowCount()
SetPointer(HourGlass!)
for li = 1 to ll_filas
ls = this.GetItemString(li,'cf_codigo')
if isnull(ls) or ls = '' then
	ll++
   ls = string (ll)
   this.SetItem(li,'cf_codigo',ls)
end if
next
SetPointer(Arrow!)
end event

type tabpage_detail2 from w_sheet_master_tabpage_detail`tabpage_detail2 within tab_detail
integer y = 112
integer width = 2871
integer height = 656
string text = "Faltas/Permisos"
string picturename = "Run!"
long picturemaskcolor = 553648127
end type

type dw_detail2 from w_sheet_master_tabpage_detail`dw_detail2 within tabpage_detail2
integer x = 0
integer y = 0
integer width = 2875
integer height = 816
string dataobject = "d_faltaoatrazo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_detail2::updatestart;call super::updatestart;long ll_filas ,ll, li
string ls, ls_emp

ls_emp = dw_master.GetItemString(dw_master.GetRow(),'ep_codigo')
Select max(to_number(pe_codigo))
  into :ll
  from NO_FALTA
 where ep_codigo = :ls_emp;
if isnull(ll) then ll= 0
ll_filas = this.RowCount()
SetPointer(HourGlass!)
for li = 1 to ll_filas
ls = this.GetItemString(li,'pe_codigo')
if isnull(ls) or ls = '' then
	ll++
   ls = string (ll)
   this.SetItem(li,'pe_codigo',ls)
end if
next
SetPointer(Arrow!)

end event

type tabpage_detail3 from w_sheet_master_tabpage_detail`tabpage_detail3 within tab_detail
integer y = 112
integer width = 2871
integer height = 656
string text = "Vacaciones"
string picturename = "Custom010!"
long picturemaskcolor = 553648127
end type

type dw_detail3 from w_sheet_master_tabpage_detail`dw_detail3 within tabpage_detail3
integer x = 0
integer y = 0
integer width = 3387
integer height = 1292
string dataobject = "d_vacaciones"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_detail3::updatestart;call super::updatestart;long ll_filas ,ll, li
string ls, ls_emp

ls_emp = dw_master.GetItemString(dw_master.GetRow(),'ep_codigo')
Select max(to_number(va_codigo))
  into :ll
  from NO_VACACION
 where ep_codigo = :ls_emp;
if isnull(ll) then ll= 0

ll_filas = this.RowCount()
SetPointer(HourGlass!)
for li = 1 to ll_filas
ls = this.GetItemString(li,'va_codigo')
if isnull(ls) or ls = '' then
	ll++
   ls = string (ll)
   this.SetItem(li,'va_codigo',ls)
end if
next
SetPointer(Arrow!)

end event

type tabpage_detail4 from w_sheet_master_tabpage_detail`tabpage_detail4 within tab_detail
integer y = 112
integer width = 2871
integer height = 656
string text = "Cursos"
string picturename = "DosEdit5!"
long picturemaskcolor = 553648127
end type

type dw_detail4 from w_sheet_master_tabpage_detail`dw_detail4 within tabpage_detail4
integer x = 5
integer y = 0
integer width = 2866
integer height = 828
string dataobject = "d_cursos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_detail4::updatestart;call super::updatestart;long ll_filas ,ll, li
string ls, ls_emp

ls_emp = dw_master.GetItemString(dw_master.GetRow(),'ep_codigo')
Select max(to_number(cm_codigo))
  into :ll
  from NO_CURSO
 where ep_codigo = :ls_emp;
if isnull(ll) then ll= 0

ll_filas = this.RowCount()
SetPointer(HourGlass!)
for li = 1 to ll_filas
ls = this.GetItemString(li,'cm_codigo')
if isnull(ls) or ls = '' then
	ll++
   ls = string (ll)
   this.SetItem(li,'cm_codigo',ls)
end if
next
SetPointer(Arrow!)

end event

type dw_ubica from datawindow within w_empleado
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_downkey pbm_dwnkey
boolean visible = false
integer x = 521
integer y = 360
integer width = 2066
integer height = 304
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda de empleado"
string dataobject = "d_busca_empleado"
boolean livescroll = true
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls, ls_criterio, ls_tipo
long ll_found

ls_tipo = this.GetItemString(1,'tipo')
CHOOSE CASE this.GetColumnName()

	CASE 'codant'
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_codigo = " +  +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('ep_nombre')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_codigo like " +  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
    		   dw_master.SetColumn('ep_nombre')
				this.Visible = false	
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE
	CASE 'rucic'
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_ci = '"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('ep_nombre')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Cliente no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_ci like '"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
    		   dw_master.SetColumn('ep_nombre')
				this.Visible = false	
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE
	CASE 'nombre'
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_nombre = '"+ data + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('ep_nombre')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_nombre like '"+ data + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			   dw_master.SetColumn('ep_nombre')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE		
	CASE 'apellido'
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_apepat = "   +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('ep_nombre')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_apepat like '"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			   dw_master.SetColumn('ep_nombre')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE		
		
END CHOOSE
end event

event ue_downkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
//	dw_master.SetFilter('')
//	dw_master.Filter()
end if
end event

type dw_1 from datawindow within w_empleado
integer x = 69
integer y = 244
integer width = 1481
integer height = 2420
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_nomina_empleados"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;string ls, ls_criterio, ls_tipo
long ll_found
//
//ls_tipo = this.GetItemString(1,'tipo')


ls = this.object.ep_codigo[currentrow]
ls_criterio = "ep_codigo = " +  +"'"+ ls + "'"		
ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
if ll_found > 0 and not isnull(ll_found) then
dw_master.SetFocus()
dw_master.ScrollToRow(ll_found)
dw_master.SetRow(ll_found)
//dw_master.SetColumn('ep_nombre')
//this.Visible = false
//else
//messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
//return
end if
end event

event sqlpreview;Int rc
string ls_sqlorig,ls_sqlnew
string ls_addwhere =  "AND  ( "+ '"NO_EMPLE"."EP_FECSAL"' + "is NULL )"  

//" and ( ~~~"IN_ITEM~~~".~~~"CL_CODIGO~~~" like ~~~'"+ls_texto+"~~~')"



SetPointer(Hourglass!)

if cbx_1.checked then
	ls_sqlnew = sqlsyntax+ls_addwhere
	rc = dw_1.SetSqlPreview(ls_sqlnew)			
	IF rc = 1 THEN
	return 0
	ELSE
	MessageBox("Error", "Fallo Modify " )
	return 1
	END IF			
end if

dw_1.SetSqlPreview(sqlsyntax)
dw_1.setfocus()

setpointer(arrow!)
return 0



end event

type sle_1 from singlelineedit within w_empleado
integer x = 69
integer y = 136
integer width = 1467
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event modified;string ls_data
long ll_nreg,ll_find



if not isnull(this.text )and this.text<>"" then
ls_data = this.text+'%'
else 
Setnull(ls_data)
end if

ll_nreg = dw_1.rowcount()
ll_find = dw_1.find("c_nombre like'"+ls_data+"'",1,ll_nreg)
if ll_find <> 0 then
dw_1.selectrow(0,false)
dw_1.scrolltorow(ll_find)
dw_1.selectrow(ll_find,true)
dw_1.Setrow(ll_find)
else	
dw_1.selectrow(0,false)
end if
end event

type st_1 from statictext within w_empleado
integer x = 73
integer y = 76
integer width = 375
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
string text = "Ubicar empleado"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_empleado
integer x = 901
integer y = 52
integer width = 617
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
string text = "Solo personal activo"
end type

