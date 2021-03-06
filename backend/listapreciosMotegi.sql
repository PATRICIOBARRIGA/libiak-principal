  SELECT "IN_ITEM"."EM_CODIGO",   
         "IN_ITEM"."IT_CODIGO",   
         "IN_ITEM"."CL_CODIGO",   
         "IN_ITEM"."IT_CODBAR",   
         "IN_ITEM"."IT_CODANT",   
         "IN_ITEM"."IT_NOMBRE",   
         "IN_ITEM"."IT_PRECIO",   
         "IN_CLASE_A"."CL_CODPAD",   
         "IN_CLASE_B"."CL_DESCRI",   
         "PR_EMPRE"."EM_NOMBRE",   
         "IN_ITEBOD"."IB_STOCK",   
         "IN_ITEM"."FB_CODIGO",   
         "IN_ITEM"."MA_CODIGO",
         "IN_DESCITEM"."TD_CODIGO",
         "IN_TIPPRE"."TD_DESC1",
((("IN_ITEM"."IT_PRECIO"*(1-"IN_TIPPRE"."TD_DESC1"/100))*(1-"IN_TIPPRE"."TD_DESC2"/100))*(1-"IN_TIPPRE"."TD_DESC3"/100))*0.95*(select pr_valor + 1  from pr_param where pr_nombre = 'IVA')  PCD,
((("IN_ITEM"."IT_PRECIO"*(1-"IN_TIPPRE"."TD_DESC1"/100))*(1-"IN_TIPPRE"."TD_DESC2"/100))*(1-"IN_TIPPRE"."TD_DESC3"/100))*(select pr_valor + 1  from pr_param where pr_nombre = 'IVA')
    FROM "IN_ITEM",   
         "IN_CLASE" "IN_CLASE_A",   
         "IN_CLASE" "IN_CLASE_B",   
         "PR_EMPRE",   
         "IN_ITEBOD" ,
         "IN_DESCITEM",
         "IN_TIPPRE"
   WHERE ("IN_DESCITEM"."TD_CODIGO"= "IN_TIPPRE"."TD_CODIGO") and 
		("IN_DESCITEM"."IT_CODIGO"= "IN_ITEM"."IT_CODIGO") and 
		( "IN_ITEM"."EM_CODIGO" = "IN_CLASE_A"."EM_CODIGO" ) and  
         ( "IN_ITEM"."CL_CODIGO" = "IN_CLASE_A"."CL_CODIGO" ) and  
         ( "IN_CLASE_A"."CL_CODPAD" = "IN_CLASE_B"."CL_CODIGO" ) and  
         ( "IN_CLASE_A"."EM_CODIGO" = "IN_CLASE_B"."EM_CODIGO" ) and  
         ( "IN_CLASE_B"."EM_CODIGO" = "PR_EMPRE"."EM_CODIGO" ) and  
         ( "IN_ITEBOD"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO" ) and  
         ( "IN_ITEBOD"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO" ) and  
         ( ( "IN_ITEM"."EM_CODIGO" = 1 ) AND  
         ( "IN_ITEM"."IT_IMPRIMIR" = 'S' ) AND  
         ( "IN_ITEBOD"."SU_CODIGO" = 1 ) AND  
         ( "IN_ITEBOD"."BO_CODIGO" = 1 ) )  ;