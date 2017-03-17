CREATE OR REPLACE PROCEDURE DINAMIC.SP_INV_ITEMS (av_empresa varchar2, av_codant varchar2,
ls_marca OUT VARCHAR2,li_ivaitem OUT NUMBER,lch_cambia OUT CHAR,ls_pepa OUT VARCHAR2,ls_codant OUT VARCHAR2,ls_nombre OUT VARCHAR2, lc_prefab OUT NUMBER, ls_valstk OUT CHAR, ic_costo OUT NUMBER, lch_kit OUT CHAR, ls_base OUT VARCHAR2,ls_medida OUT VARCHAR2,ls_presentacion OUT VARCHAR2) IS
tmpVar NUMBER;

BEGIN
   tmpVar := 0;
   
   
    select ma_codigo,it_tiemsec,it_preparado,it_codigo,it_codant, it_nombre, it_prefab, it_valstk,nvl(it_costo,0),it_kit,it_base,ub_codigo,decode(ub_codigo,'3','CANECA','6','GALON','7','LITRO','8','OCTAVO','1','UNIDAD','UNIDAD') 
    into ls_marca,li_ivaitem,lch_cambia,ls_pepa,ls_codant,ls_nombre, lc_prefab, ls_valstk, ic_costo, lch_kit, ls_base,ls_medida,ls_presentacion
    from in_item where em_codigo = av_empresa  and it_codant = av_codant; 

   if sql%notfound  then
 --      luego por codigo de barras
         select ma_codigo,it_tiemsec,it_preparado,it_codigo, it_codant, it_nombre, it_prefab, it_valstk,nvl(it_costo,0),it_kit,it_base,ub_codigo,decode(ub_codigo,'3','CANECA','6','GALON','7','LITRO','8','OCTAVO','1','UNIDAD','UNIDAD')
         into ls_marca,li_ivaitem,lch_cambia,ls_pepa,ls_codant,ls_nombre, lc_prefab, ls_valstk, ic_costo, lch_kit, ls_base,ls_medida,ls_presentacion
         from in_item  where em_codigo = av_empresa  and it_codbar = av_codant;
   end if;
  --
  
    
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END SP_INV_ITEMS;
/

