//select pv_codigo,co_facpro, mp_valor,mp_saldo,c.mp_codigo,c.tv_codigo,c.tv_tipo,(select sum(nvl(cx_valdeb,0)) from cp_cruce x where x.mp_codigo = c.mp_codigo and x.tv_codigo = c.tv_codigo and x.tv_tipo = c.tv_tipo)
//from cp_movim c where tv_tipo = 'C' order by pv_codigo;


select mp_codigo,tv_codigo,tv_tipo,co_facpro,pv_codigo from cp_movim c where tv_tipo = 'C'
and (mp_codigo,tv_codigo,tv_tipo) not in (select mp_codigo,tv_codigo,tv_tipo from cp_cruce where tv_tipodeb = 'D');