HA$PBExportHeader$a_empresa.sra
$PBExportComments$Generated Application Object
forward
global type a_empresa from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
s_appgeninfo  str_appgeninfo // username, db, etc.
s_prodparam  str_prodparam //parametros para busqueda
s_cliparam str_cliparam //oarametros busqueda clientes
s_pedido  str_pedido[]    //para capturar desde maxmin y generar la orden de compra

boolean gb_por_consulta = false, gb_inserta = false
boolean gb_codigo_numerico = false
string  gs_titulo_marco   // titulo del marco
string gs_estado
string  gs_empresa,gs_su_nombre,gs_bo_nombre,gs_empleado,gs_resolucion
datetime   gdt_mescerrado
int gi_print = 0
boolean gb_producto_lista_cambiado = FALSE
s_old_item   str_old_item
boolean gb_producto_lista = FALSE
boolean cantidad_producto_ubica= FALSE
datastore  gds_pedido,gds_importacion
nvo_bubblehelp gnv_help

end variables
global type a_empresa from application
string appname = "a_empresa"
string microhelpdefault = "Listo"
string displayname = "DynaSif"
end type
global a_empresa a_empresa

type prototypes
//playsound
//FUNCTION boolean sndPlaySoundA (string SoundName, uint Flags) LIBRARY "WINMM.DLL"
//FUNCTION uint waveOutGetNumDevs () LIBRARY "WINMM.DLL"
end prototypes

on a_empresa.create
appname="a_empresa"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on a_empresa.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event systemerror;Open (w_system_error)
end event

event open;gnv_help = Create nvo_bubblehelp


if f_opendbapp(w_marco, "DynaSif.INI") = -1 then halt
//validar que la version sea la version pagada



opensheet(w_fondo,w_marco,6,layered!)

end event

