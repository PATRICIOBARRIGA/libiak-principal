HA$PBExportHeader$w_recibir_recepciones_compra.srw
$PBExportComments$Si.
forward
global type w_recibir_recepciones_compra from w_response_basic
end type
type st_1 from statictext within w_recibir_recepciones_compra
end type
type p_1 from picture within w_recibir_recepciones_compra
end type
type dw_1 from datawindow within w_recibir_recepciones_compra
end type
type dw_2 from datawindow within w_recibir_recepciones_compra
end type
end forward

global type w_recibir_recepciones_compra from w_response_basic
integer width = 1998
integer height = 484
string title = "Importar Compras"
st_1 st_1
p_1 p_1
dw_1 dw_1
dw_2 dw_2
end type
global w_recibir_recepciones_compra w_recibir_recepciones_compra

on w_recibir_recepciones_compra.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
end on

on w_recibir_recepciones_compra.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type pb_cancel from w_response_basic`pb_cancel within w_recibir_recepciones_compra
integer x = 1047
integer y = 220
integer width = 398
integer height = 100
integer taborder = 50
string text = "&No"
string picturename = ""
end type

event pb_cancel::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_recibir_recepciones_compra
integer x = 590
integer y = 220
integer width = 398
integer height = 96
integer taborder = 40
string text = "&Si"
string picturename = ""
end type

event pb_ok::clicked;call super::clicked;string    ls_nombre_archivo,ls_sucursal,ls_estado
long      ll_num_reg,ll_i,ll_contador,ll_numero,ll_num_compra

ls_nombre_archivo = 'Archivos\Cab_nrc'+str_appgeninfo.sucursal+'.TXT'
dw_response.SetTransObject(sqlca)
ll_num_reg = dw_response.ImportFile(ls_nombre_archivo)
for ll_i = 1 to ll_num_reg
	ls_sucursal = dw_response.GetItemString(ll_i,"su_codigo")
	ll_numero = dw_response.GetItemNumber(ll_i,"co_numero")
	ls_estado = dw_response.GetItemString(ll_i,"ec_codigo")
	if ls_estado = '0' then //la recepci$$HEX1$$f300$$ENDHEX$$n de compra fue anulada
	   select co_numero
		  into :ll_num_compra
		  from in_compra
		 where ec_codigo = '3'
		   and em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :ls_sucursal
			and co_numpad = :ll_numero
			and ec_codpad = '2';
		if sqlca.sqlcode = 0 and not isnull(ll_num_compra) then //encontro una compra para anular
			f_anula_compra(ll_num_compra)
	   end if
		select count(*)
		  into :ll_contador
		  from in_compra
		 where ec_codigo = '2'
		   and em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :ls_sucursal
			and co_numero = :ll_numero;
		if ll_contador > 0 then
			delete from in_detco
		    where ec_codigo = '2'
			   and em_codigo = :str_appgeninfo.empresa
		      and su_codigo = :ls_sucursal
				and bo_codigo = :str_appgeninfo.seccion
				and co_numero = :ll_numero;

			delete from in_compra
			 where ec_codigo = '2'
			   and em_codigo = :str_appgeninfo.empresa
		      and su_codigo = :ls_sucursal                                                                                                              
				and co_numero = :ll_numero;
		end if
	end if
next
dw_response.Update()
commit;


ls_nombre_archivo = 'Archivos\Det_nrc'+str_appgeninfo.sucursal+'.TXT'
dw_1.SetTransObject(sqlca)
dw_1.ImportFile(ls_nombre_archivo)
dw_1.Update()
commit;


close(parent)
end event

type dw_response from w_response_basic`dw_response within w_recibir_recepciones_compra
boolean visible = false
integer x = 59
integer y = 396
integer width = 338
integer height = 72
boolean enabled = false
string dataobject = "d_archivo_plano_cab_compra"
end type

type st_1 from statictext within w_recibir_recepciones_compra
integer x = 261
integer y = 64
integer width = 1691
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean enabled = false
string text = "Ejecutar el proceso de actualizaci$$HEX1$$f300$$ENDHEX$$n de recepciones de compra"
boolean focusrectangle = false
end type

type p_1 from picture within w_recibir_recepciones_compra
integer x = 59
integer y = 56
integer width = 169
integer height = 148
boolean bringtotop = true
string picturename = "Imagenes\Question.Gif"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_recibir_recepciones_compra
boolean visible = false
integer x = 485
integer y = 396
integer width = 338
integer height = 72
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_det_compra"
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_recibir_recepciones_compra
boolean visible = false
integer x = 905
integer y = 396
integer width = 338
integer height = 72
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_detalle_nota_recepcion_compra"
boolean border = false
end type

