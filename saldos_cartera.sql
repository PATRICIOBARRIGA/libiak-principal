select mt_codigo,mt_valor,mt_saldo ,tt_codigo,tt_ioe,em_codigo,su_codigo, (select sum(cr_valdeb) from cc_cruce c where c.tt_coddeb = deb.tt_codigo and c.tt_ioedeb=deb.tt_ioe and c.mt_coddeb = deb.mt_codigo 
and c.em_codigo = deb.em_codigo and c.su_codigo = deb.su_codigo
group by mt_coddeb,tt_ioedeb,tt_coddeb)
from cc_movim deb
where tt_ioe='D';