select mv_costo,mv_fecha from in_movim where (mv_fecha = (select max(mv_fecha) from in_movim where it_codigo = 818) ) and it_codigo = 818

SELECT p.MEMBSHIP_ID
FROM user_payments as p
WHERE USER_ID = 1 AND PAYM_DATE = (
    SELECT MAX(p2.PAYM_DATE)
    FROM user_payments as p2
    WHERE p2.USER_ID = p.USER_ID
)