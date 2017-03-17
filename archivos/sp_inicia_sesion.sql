string ls_nombre,ls_clave,ls_dbms,ls_server,ls_database,ls_estado
string ls_emp_abr, ls_emp_nombre,  ls_emp_apellido  
string ls_nomempre,ls_seccion, ls_codigo, ls_tipo,ls_caja
boolean lb_res
date ld_fecanu

datetime  ld_hoy 


if dw_login.AcceptText() = -1 then return

str_appgeninfo.dbms      = dw_login.getitemstring(1,"dbms")
str_appgeninfo.servername= dw_login.getitemstring(1,"server")
str_appgeninfo.username  = dw_login.getitemstring(1,"nombre")
str_appgeninfo.password  = dw_login.getitemstring(1,"clave")
str_appgeninfo.estado    = dw_login.getitemstring(1,"estado")

-- Se conecta al oracle con la clave registrada en la base
lb_res = f_db_connect(sqlca,str_appgeninfo.username,str_appgeninfo.password,str_appgeninfo.dbms,str_appgeninfo.servername,"")

If lb_res = False Then
        MessageBox("ERROR","No se ha podido conectar con la base de datos",StopSign!)
        dw_login.setfocus()
        dw_login.selecttext(1,len(dw_login.getitemstring(1,"clave")))
        ii_intentos++
        return
End If

--Trial
String ls_pepa
Datetime ldt_fecserver    

SELECT TRUNC(SYSDATE) into  :ldt_fecserver FROM DUAL;
/*
//if daysafter(date(ls_pepa),date(ldt_fecserver)) > 30 then
//Messagebox("Atención","Ha caducado el tiempo de prueba....si desea continuar usando la versión por favor ponganse en contacto con su proveedor....~n~r~n~rContacto: Patricio Barriga~n~rMovil: 095616851~n~rOficina:3201823~n~rQuito-Ecuador.",Exclamation!)
//halt close
//end if
*/

    
    
/*    
str_appgeninfo.caja    = dw_login.getitemstring(1,"caja")
str_appgeninfo.empresa = dw_login.getitemstring(1,"empresa")
str_appgeninfo.sucursal= dw_login.getitemstring(1,"sucursal")
str_appgeninfo.databasename=dw_login.getitemstring(1,"database")
*/

--SetPointer(HourGlass!)
--//select em_codigo,su_codigo,sa_tipo,sa_seccion,sa_login
select sa_tipo,sa_login into :ls_tipo,:ls_nombre from sg_acceso where sa_login = :str_appgeninfo.username;
--//and sa_activo = 'S'
--//and sa_pos = 'S';

    
---//    cj_fecanu into ld_fecanu
    
    select cj_caja,bo_codigo     into :ls_caja,:ls_seccion    
    from fa_caja
    where cj_caja = :str_appgeninfo.caja
    and em_codigo = :str_appgeninfo.empresa
    and su_codigo = :str_appgeninfo.sucursal;
        
    select su_nombre
    into :gs_su_nombre
    from pr_sucur
    where em_codigo = :str_appgeninfo.empresa
    and su_codigo = :str_appgeninfo.sucursal;
    
    select bo_nombre
    into :gs_bo_nombre
    from in_bode
    where em_codigo = :str_appgeninfo.empresa
    and su_codigo = :str_appgeninfo.sucursal
    and bo_codigo = :ls_seccion;
    
--//    disconnect using sqlca;         
 end if


--// Encuentra datos del usuario de nómina
--//22-06-2008
SELECT EP_SALUDO, EP_NOMBRE, EP_APEPAT, EP_CODIGO 
INTO :ls_emp_abr, :ls_emp_nombre, :ls_emp_apellido, :ls_codigo 
FROM  NO_EMPLE  
WHERE SA_LOGIN  = :ls_nombre
AND   EM_CODIGO = :str_appgeninfo.empresa;



--// encuentra datos de la caja
SELECT CJ_NOMBRE, CJ_MINCHE, CJ_MAXCHE,   
              CJ_VUELCHE, CJ_MINTAR, CJ_MAXTAR
INTO :caja.nombre, :caja.ch_min, :caja.ch_max,   
          :caja.ch_vuelto, :caja.tj_min, :caja.tj_max
FROM FA_CAJA
WHERE CJ_CAJA = :str_appgeninfo.caja  
AND  EM_CODIGO = :str_appgeninfo.empresa 
AND SU_CODIGO = :str_appgeninfo.sucursal 
AND CJ_ESTADO = 'L' ;
/*
if sqlca.sqlcode = 100 then
    ii_intentos ++
    MessageBox("Error","La caja ya se encuentra ocupada, esta situación no es normal.~r~n"+& 
                  "Comuniquese con el SUPERVISOR", StopSign!)        
    disconnect using sqlca;
    return
end if
*/
--if f_sqlca_status(sqlca,'Determinar opciones de la caja') < 1 then return

-- Bloquea la caja
UPDATE FA_CAJA
SET    CJ_ESTADO = 'U',
        CJ_FECCAM = sysdate
WHERE ( CJ_CAJA = :str_appgeninfo.caja ) AND  
( EM_CODIGO = :str_appgeninfo.empresa) AND
( SU_CODIGO = :str_appgeninfo.sucursal);

--if f_sqlca_status(sqlca,'Bloquear la caja') < 1 then return
--commit using sqlca;


Select em_nombre
into :ls_nomempre
from pr_empre
where em_codigo = :str_appgeninfo.empresa;

if f_sqlca_status(sqlca,'Determinar nombre de la empresa') < 1 then return

ib_abierta = True

--llena la estructura de la caja
caja.caja = str_appgeninfo.caja
caja.fecanu = ld_fecanu

--//llena la estructura del usuario
usuario.usuario = ls_nombre
usuario.clave = ls_clave
usuario.ep_codigo = ls_codigo
usuario.nombres = trim(ls_emp_nombre)+' '+trim(ls_emp_apellido)
usuario.abreviado = ls_emp_abr

--//llena la estructura de la aplicación
str_appgeninfo.seccion = ls_seccion
str_appgeninfo.nempresa = ls_nomempre
str_appgeninfo.nsucursal = gs_su_nombre
str_appgeninfo.nseccion = gs_bo_nombre

parent.title = "Espere Por Favor ..."
open(w_marco_sp)

//SETEO DE ULTIMA CAJA
setprofilestring(str_appgeninfo.ini_file,"Opciones","caja",caja.caja)
w_marco_sp.title =  st_1.text+" "+"Tintes 2013"+" "+right(st_2.text,12)+" - "+str_appgeninfo.nempresa+'/'+str_appgeninfo.nsucursal+'/'+str_appgeninfo.nseccion+'/'+caja.caja+" "+caja.nombre+ " - "+usuario.nombres

if isvalid(w_bienvenida) then close(w_bienvenida)

close(w_acceso)
