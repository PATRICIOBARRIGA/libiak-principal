select i.it_codigo,i.it_codant,i.it_nombre ,
(select sum(decode ( tm_ioe,'I',mv_cantid,'E',mv_cantid*-1)) from in_movim m  where m.it_codigo = i.it_codigo and trunc(m.mv_fecha) < '31-JUL-2015' group by m.it_codigo)
from in_item i