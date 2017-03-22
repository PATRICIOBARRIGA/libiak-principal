HA$PBExportHeader$w_bodega.srw
$PBExportComments$Ingreso de bodegas o secciones de una empresa del sistema
forward
global type w_bodega from w_sheet_1_dw_maint
end type
end forward

global type w_bodega from w_sheet_1_dw_maint
int Width=2743
int Height=585
boolean TitleBar=true
string Title="Bodega o Secci$$HEX1$$f300$$ENDHEX$$n"
long BackColor=1090519039
end type
global w_bodega w_bodega

forward prototypes
public subroutine wf_crea_bodega (string as_bodega)
end prototypes

public subroutine wf_crea_bodega (string as_bodega);string  ls_sucursal,ls_bodega
declare c1 cursor for
  select su_codigo,bo_codigo
    from in_bode
	where em_codigo = :str_appgeninfo.empresa
	  and bo_codigo <> :as_bodega;


open c1;
do
  fetch c1 into :ls_sucursal,:ls_bodega;
  if sqlca.sqlcode <> 0 then exit
  INSERT INTO "PR_NUMTRANS" ("EM_CODIGO","SU_CODENV","BO_CODENV","SU_CODIGO",
                             "BO_CODIGO","NT_NUMERO","NT_NUMRECEP" )  
  VALUES (:str_appgeninfo.empresa,:str_appgeninfo.sucursal,   
          :as_bodega,:ls_sucursal,:ls_bodega,1,1 );
  INSERT INTO "PR_NUMTRANS" ("EM_CODIGO","SU_CODENV","BO_CODENV","SU_CODIGO",
                             "BO_CODIGO","NT_NUMERO","NT_NUMRECEP" )  
  VALUES (:str_appgeninfo.empresa,:ls_sucursal,   
          :ls_bodega,:str_appgeninfo.sucursal,:as_bodega,1,1 );
loop while TRUE;
close c1;

insert into in_itebod(it_codigo,em_codigo,su_codigo,bo_codigo,ib_stock,
	                   ib_stkini,ib_fecini,ib_fecusa,ib_fecuig,ib_ubica,
							 ib_reorden,ib_stkmax,ib_stkmin)
		select it_codigo,em_codigo,su_codigo,:as_bodega,0,0,sysdate,null,null,
		       null,0,0,0
		  from in_itesucur
		 where em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :str_appgeninfo.sucursal
		   and it_codigo in ( select it_codigo
			                     from in_itesucur
									  where em_codigo = :str_appgeninfo.empresa
									    and su_codigo = :str_appgeninfo.sucursal
									  minus
									 select it_codigo
									   from in_itebod
									  where em_codigo = :str_appgeninfo.empresa
									    and su_codigo = :str_appgeninfo.sucursal
										 and bo_codigo = :ls_bodega);
end subroutine

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
f_recupera_empresa(dw_datos,"su_codigo") 
dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "bo_codigo"
dw_datos.is_SerialCodeType = "COD_BODE"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open

end event

event ue_retrieve;call super::ue_retrieve;f_recupera_empresa(dw_datos,"su_codigo")
end event

on w_bodega.create
call w_sheet_1_dw_maint::create
end on

on w_bodega.destroy
call w_sheet_1_dw_maint::destroy
end on

event ue_update;call super::ue_update;string  ls_bodega


ls_bodega = dw_datos.GetItemString(dw_datos.GetRow(),"bo_codigo")
wf_crea_bodega(ls_bodega)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_bodega
int Y=1
int Width=2707
int Height=481
string DataObject="d_bodega"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_bodega
boolean BringToTop=true
end type

