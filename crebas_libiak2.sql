--
-- Create Schema Script 
--   Database Version   : 11.2.0.1.0 
--   Toad Version       : 10.6.1.3 
--   DB Connect String  : CNXLOCAL 
--   Schema             : DINAMIC 
--   Script Created by  : DINAMIC 
--   Script Created at  : 09/07/2013 0:04:35 
--   Physical Location  :  
--   Notes              :  
--

-- Object Counts: 
--   Roles: 1           Sys Privs: 202      Roles: 16           Obj Privs: 0 
--   Users: 1           Sys Privs: 4        Roles: 1            Tablespace Quotas: 1 
-- 
--   Directories: 0 
--   Functions: 2       Lines of Code: 47 
--   Indexes: 274       Columns: 685        
--   Object Privileges: 152 
--   Packages: 1        Lines of Code: 15 
--   Procedures: 8      Lines of Code: 780 
--   Sequences: 1 
--   Synonyms: 161 
--   Tables: 170        Columns: 1984       Lob Segments: 1     Constraints: 359    
--   Triggers: 1 
--   Views: 1           Columns: 69         


-- "Set define off" turns off substitution variables. 
Set define off; 
--
-- DINAMIC  (User) 
--
CREATE USER DINAMIC
  IDENTIFIED BY <password>
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 1 Role for DINAMIC 
  GRANT DBA TO DINAMIC WITH ADMIN OPTION;
  ALTER USER DINAMIC DEFAULT ROLE ALL;
  -- 4 System Privileges for DINAMIC 
  GRANT ALTER ANY OUTLINE TO DINAMIC;
  GRANT CREATE ANY OUTLINE TO DINAMIC;
  GRANT UNLIMITED TABLESPACE TO DINAMIC WITH ADMIN OPTION;
  GRANT DROP ANY OUTLINE TO DINAMIC;
  -- 1 Tablespace Quota for DINAMIC 
  ALTER USER DINAMIC QUOTA UNLIMITED ON USERS;


--
-- DOCPRO  (Sequence) 
--
CREATE SEQUENCE DINAMIC.DOCPRO
  START WITH 53
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


--
-- FA_CAJA  (Table) 
--
CREATE TABLE DINAMIC.FA_CAJA
(
  CJ_CAJA     VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  BO_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CJ_ESTADO   CHAR(1 BYTE)                      NOT NULL,
  CJ_FECCAM   DATE                              NOT NULL,
  CJ_MINCHE   NUMBER(14,2)                      NOT NULL,
  CJ_MAXCHE   NUMBER(14,2)                      NOT NULL,
  CJ_VUELCHE  NUMBER(14,2)                      NOT NULL,
  CJ_MINTAR   NUMBER(14,2)                      NOT NULL,
  CJ_MAXTAR   NUMBER(14,2)                      NOT NULL,
  CJ_VERMENS  CHAR(1 BYTE),
  CJ_MENSAJE  VARCHAR2(200 BYTE),
  CJ_NOMBRE   VARCHAR2(50 BYTE),
  CJ_NUEVOS   CHAR(1 BYTE),
  CJ_TICKET   FLOAT(126),
  ESTADO      VARCHAR2(1 BYTE),
  SERIE       VARCHAR2(20 BYTE),
  CJ_PREIMP   VARCHAR2(13 BYTE),
  CJ_NAUT     VARCHAR2(10 BYTE),
  CJ_FECANU   DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_CIECAJA  (Table) 
--
CREATE TABLE DINAMIC.FA_CIECAJA
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CI_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CJ_CAJA       VARCHAR2(20 BYTE)               NOT NULL,
  EP_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  IF_CODIGO     VARCHAR2(20 BYTE),
  CI_FECIE      DATE,
  CI_FECHA      DATE                            NOT NULL,
  CI_TVENTA     NUMBER(14,2)                    NOT NULL,
  CI_EFECTIVO   NUMBER(14,2),
  CI_CHEQUEF    NUMBER(14,2),
  CI_CHEQUEP    NUMBER(14,2),
  CI_NCREDITO   NUMBER(14,2),
  CI_TARJETAC   NUMBER(14,2),
  CI_RETENCION  NUMBER(14,2),
  CI_AUTOCON    NUMBER(14,2),
  CI_OTRASFP    NUMBER(14,2),
  ESTADO        VARCHAR2(1 BYTE),
  CI_DEPOSITOP  VARCHAR2(60 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_CLACLI  (Table) 
--
CREATE TABLE DINAMIC.FA_CLACLI
(
  CA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CA_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_DCTOCLI  (Table) 
--
CREATE TABLE DINAMIC.FA_DCTOCLI
(
  DC_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DC_DESCRI  VARCHAR2(30 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_ENTREGA  (Table) 
--
CREATE TABLE DINAMIC.FA_ENTREGA
(
  ES_CODIGO    VARCHAR2(20 BYTE),
  BO_CODENV    VARCHAR2(20 BYTE)                NOT NULL,
  VE_NUMERO    NUMBER(38),
  IT_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  DV_SECUE     NUMBER(38),
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  BO_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EB_CANTIDAD  NUMBER(9,3)                      NOT NULL,
  EB_PROCESA   CHAR(1 BYTE)                     NOT NULL,
  EB_ENTREGA   CHAR(1 BYTE),
  ESTADO       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_ESTADO  (Table) 
--
CREATE TABLE DINAMIC.FA_ESTADO
(
  ES_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  ES_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ES_DESCAR  CHAR(1 BYTE)                       NOT NULL,
  ES_SIGLA   CHAR(3 BYTE)                       NOT NULL,
  ES_NUMLI   NUMBER,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_REFERENCIA  (Table) 
--
CREATE TABLE DINAMIC.FA_REFERENCIA
(
  COD_CLIE     VARCHAR2(20 BYTE)                NOT NULL,
  REFERENCIA   VARCHAR2(200 BYTE)               NOT NULL,
  REFERENCIA2  VARCHAR2(200 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_SRIVENTAS  (Table) 
--
CREATE TABLE DINAMIC.FA_SRIVENTAS
(
  RI_CALLE               VARCHAR2(255 BYTE),
  RI_FVENTA              DATE,
  RI_INTERSEC            VARCHAR2(255 BYTE),
  RI_PROPIETARIO         VARCHAR2(255 BYTE),
  RI_TIPOCOMPROBANTE     NUMBER(1),
  RI_NUMERO              VARCHAR2(255 BYTE),
  RI_NUMDOC              VARCHAR2(255 BYTE),
  RI_CAMVCPN             VARCHAR2(255 BYTE)     NOT NULL,
  RI_RUC                 VARCHAR2(13 BYTE),
  RI_PVENTA              VARCHAR2(25 BYTE)      NOT NULL,
  RI_TELEFONO            VARCHAR2(20 BYTE)      NOT NULL,
  RI_TIPOIDENTIFICACION  VARCHAR2(1 BYTE)       NOT NULL,
  RI_SERIALVIN           VARCHAR2(25 BYTE)      NOT NULL,
  RI_CODPROVINCIA        VARCHAR2(20 BYTE),
  RI_TIPODIRECCION       VARCHAR2(255 BYTE),
  RI_AUTORIZACION        NUMBER(13),
  RI_ESTABLECIMIENTO     VARCHAR2(3 BYTE),
  RI_PTOEMISCOMPTE       VARCHAR2(3 BYTE),
  RI_NROFACTURA          NUMBER(13),
  RI_TIPOTELEFONO        VARCHAR2(10 BYTE),
  RI_RUCREGISTRADOR      VARCHAR2(13 BYTE),
  RI_ESTADO              VARCHAR2(1 BYTE),
  RI_CODPAIS             VARCHAR2(20 BYTE),
  RI_CODCANTON           VARCHAR2(20 BYTE),
  SU_CODIGO              VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_TIPCLI  (Table) 
--
CREATE TABLE DINAMIC.FA_TIPCLI
(
  TC_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TC_DESCRI  VARCHAR2(30 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_COESTADO  (Table) 
--
CREATE TABLE DINAMIC.IN_COESTADO
(
  EC_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EC_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_COSTO  (Table) 
--
CREATE TABLE DINAMIC.IN_COSTO
(
  EM_CODIGO         VARCHAR2(20 BYTE)           NOT NULL,
  SU_CODIGO         VARCHAR2(20 BYTE)           NOT NULL,
  IT_CODIGO         VARCHAR2(20 BYTE)           NOT NULL,
  CT_FECHA          DATE                        NOT NULL,
  CT_CANTVEND       NUMBER(12,3),
  CT_COSTVEND       NUMBER(16,4),
  CT_COSTPROM       NUMBER(16,4),
  CT_CANTPOS        NUMBER(12,3),
  CT_CANTFACT       NUMBER(12,3),
  CT_COSTPOS        NUMBER(16,4),
  CT_COSTFACT       NUMBER(16,4),
  CT_DEVPOS         NUMBER(16,4),
  CT_DEVFACT        NUMBER(16,4),
  CT_DEVALPOS       NUMBER(16,4),
  CT_DEVALFACT      NUMBER(16,4),
  CT_STOCK          NUMBER(10),
  CT_COSTPROMEXIST  NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DOCPRO  (Table) 
--
CREATE TABLE DINAMIC.IN_DOCPRO
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PV_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  DC_TIPODOC  VARCHAR2(3 BYTE)                  NOT NULL,
  DC_FECEMI   DATE,
  DC_NAUT     VARCHAR2(10 BYTE),
  DC_SECINI   VARCHAR2(10 BYTE),
  DC_SECFIN   VARCHAR2(10 BYTE),
  DC_PTOEMI   VARCHAR2(3 BYTE),
  DC_ESTAB    VARCHAR2(3 BYTE),
  DC_CODPRN   VARCHAR2(20 BYTE),
  DC_FECVEN   DATE,
  DC_AUTIMP   VARCHAR2(10 BYTE),
  ID          NUMBER
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_FORMULAS  (Table) 
--
CREATE TABLE DINAMIC.IN_FORMULAS
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FB_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_NOMBRE  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_CR      NUMBER(3),
  FO_CG      NUMBER(3),
  FO_CB      NUMBER(3),
  IT_BASE    VARCHAR2(2 BYTE)                   NOT NULL,
  FO_TOTAL   NUMBER(12,2),
  FO_A       NUMBER(6,2),
  FO_B       NUMBER(6,2),
  FO_C       NUMBER(6,2),
  FO_D       NUMBER(6,2),
  FO_E       NUMBER(6,2),
  FO_F       NUMBER(6,2),
  FO_I       NUMBER(6,2),
  FO_K       NUMBER(6,2),
  FO_L       NUMBER(6,2),
  FO_R       NUMBER(6,2),
  FO_T       NUMBER(6,2),
  FO_V       NUMBER(6,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_FORPARAM  (Table) 
--
CREATE TABLE DINAMIC.IN_FORPARAM
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_CODPAR  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_NOMBRE  VARCHAR2(12 BYTE)                  NOT NULL,
  FO_DESCRI  VARCHAR2(50 BYTE),
  FO_VALOR   NUMBER(10,4)                       NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITEMRES  (Table) 
--
CREATE TABLE DINAMIC.IN_ITEMRES
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  IT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CO_CODIGO     VARCHAR2(20 BYTE),
  CL_CODIGO     VARCHAR2(20 BYTE),
  FB_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  UB_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  MA_CODIGO     VARCHAR2(20 BYTE),
  PA_CODIGO     VARCHAR2(20 BYTE),
  IT_CODBAR     VARCHAR2(13 BYTE),
  IT_CODANT     VARCHAR2(20 BYTE),
  IT_NOMBRE     VARCHAR2(50 BYTE)               NOT NULL,
  IT_COSINI     NUMBER(16,4)                    NOT NULL,
  IT_COSTO      NUMBER(16,4)                    NOT NULL,
  IT_PRECIO     NUMBER(14,2)                    NOT NULL,
  IT_PREFAB     NUMBER(14,2),
  IT_PESO       NUMBER(12,3),
  IT_MEDIDA     VARCHAR2(15 BYTE),
  IT_IMAGEN     VARCHAR2(50 BYTE),
  IT_TIEMSEC    NUMBER(12,6),
  IT_GARANT     NUMBER,
  IT_VALSTK     CHAR(1 BYTE),
  IT_KIT        CHAR(1 BYTE),
  IT_DESCORG    VARCHAR2(50 BYTE),
  IT_IMPRIMIR   CHAR(1 BYTE),
  IT_PREPARADO  CHAR(1 BYTE),
  IT_NOMCORTO   VARCHAR2(15 BYTE),
  ESTADO        VARCHAR2(1 BYTE),
  IT_FECHA      DATE,
  IT_BASE       VARCHAR2(2 BYTE),
  IT_FECCAM     DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          3M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_RECPAG  (Table) 
--
CREATE TABLE DINAMIC.IN_RECPAG
(
  EC_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CO_NUMERO   NUMBER(38)                        NOT NULL,
  DP_NUMERO   NUMBER(10)                        NOT NULL,
  FP_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  DP_FECHA    DATE                              NOT NULL,
  DP_FECPAGO  DATE                              NOT NULL,
  DP_VALOR    NUMBER(14,2)                      NOT NULL,
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_TIPRELITEM  (Table) 
--
CREATE TABLE DINAMIC.IN_TIPRELITEM
(
  TR_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TR_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- AN_RETAIR  (Table) 
--
CREATE TABLE DINAMIC.AN_RETAIR
(
  NUMRUC             VARCHAR2(13 BYTE)          NOT NULL,
  ANIO               VARCHAR2(4 BYTE)           NOT NULL,
  MES                VARCHAR2(2 BYTE)           NOT NULL,
  TPIDPROV           VARCHAR2(2 BYTE)           NOT NULL,
  IDPROV             VARCHAR2(13 BYTE)          NOT NULL,
  TIPOCOMP           VARCHAR2(2 BYTE)           NOT NULL,
  AUT                VARCHAR2(10 BYTE)          NOT NULL,
  ESTAB              VARCHAR2(3 BYTE)           NOT NULL,
  PTOEMI             VARCHAR2(3 BYTE)           NOT NULL,
  SEC                VARCHAR2(9 BYTE)           NOT NULL,
  FECHAEMICOM        DATE                       NOT NULL,
  CODRETAIR          VARCHAR2(3 BYTE)           NOT NULL,
  PORCENTAJE         NUMBER(5)                  NOT NULL,
  BASE0              NUMBER(12,2)               NOT NULL,
  BASEGRAV           NUMBER(12,2)               NOT NULL,
  BASENOGRAV         NUMBER(12,2)               NOT NULL,
  VALRETAIR          NUMBER(12,2)               NOT NULL,
  AUTRET             VARCHAR2(10 BYTE),
  ESTABRET           VARCHAR2(3 BYTE),
  PTOEMIRET          VARCHAR2(3 BYTE),
  SECRET             VARCHAR2(9 BYTE),
  FECHAEMIRET        DATE,
  BASEIMPAIR         NUMBER(14,2),
  AUTRET1            VARCHAR2(10 BYTE),
  ESTABRET1          VARCHAR2(3 BYTE),
  PTOEMIRET1         VARCHAR2(3 BYTE),
  SECRET1            VARCHAR2(9 BYTE),
  FECHAEMIRET1       DATE,
  CODSUSTENTO        VARCHAR2(2 BYTE),
  BASENOGRAIVA       NUMBER(12,2),
  BASEIMPONIBLE      NUMBER(12,2),
  BASEIMPGRAV        NUMBER(12,2),
  MONTOICE           NUMBER(12,2),
  MONTOIVA           NUMBER(12,2),
  VALORRETBIENES     NUMBER(12,2),
  VALORRETSERVICIOS  NUMBER(12,2),
  VALORRETSERV100    NUMBER(12,2),
  DOCMODIFICADO      VARCHAR2(2 BYTE),
  ESTABMODIFICADO    VARCHAR2(3 BYTE),
  POTEMIMODIFICADO   VARCHAR2(3 BYTE),
  SECMODIFICADO      VARCHAR2(9 BYTE),
  AUTMODIFICADO      VARCHAR2(10 BYTE),
  FECHAREGISTRO      DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_CABCOBT  (Table) 
--
CREATE TABLE DINAMIC.CB_CABCOBT
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BT_FECHA   DATE,
  CN_CODIGO  VARCHAR2(20 BYTE),
  BT_TOTAL   NUMBER(10,2),
  ESTADO     CHAR(1 BYTE),
  BT_FCRUCE  DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_CUENTIPO  (Table) 
--
CREATE TABLE DINAMIC.CB_CUENTIPO
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CUENTA     VARCHAR2(20 BYTE)                  NOT NULL,
  TIPO       VARCHAR2(10 BYTE)                  NOT NULL,
  TIPO_CD    CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_DETCOBT  (Table) 
--
CREATE TABLE DINAMIC.CB_DETCOBT
(
  BT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PT_SECUE   VARCHAR2(20 BYTE)                  NOT NULL,
  FP_CODIGO  VARCHAR2(20 BYTE),
  IF_CODIGO  VARCHAR2(20 BYTE),
  PT_NUMDOC  VARCHAR2(20 BYTE),
  PT_VALOR   NUMBER(9,2),
  PT_CONTAB  CHAR(1 BYTE),
  ESTADO     CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_TARJETAS  (Table) 
--
CREATE TABLE DINAMIC.CB_TARJETAS
(
  CT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_FECHA   DATE,
  CT_TIPO    CHAR(1 BYTE),
  IF_CODIGO  VARCHAR2(20 BYTE),
  CT_NUMDOC  VARCHAR2(20 BYTE),
  CT_TOTAL   NUMBER(10,2),
  ESTADO     CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_TIPO  (Table) 
--
CREATE TABLE DINAMIC.CB_TIPO
(
  TN_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TN_IOE     CHAR(1 BYTE)                       NOT NULL,
  TN_DESCRI  VARCHAR2(20 BYTE)                  NOT NULL,
  TN_ACTIVA  CHAR(1 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_RETEN  (Table) 
--
CREATE TABLE DINAMIC.CC_RETEN
(
  RF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  RF_NOMBRE  VARCHAR2(100 BYTE)                 NOT NULL,
  RF_PROCEN  NUMBER(5,2)                        NOT NULL,
  RF_ACTIVA  CHAR(1 BYTE),
  PL_CODIGO  VARCHAR2(20 BYTE),
  EM_CODIGO  VARCHAR2(20 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  RF_TIPO    VARCHAR2(10 BYTE),
  RF_SECUE   NUMBER(5),
  FP_CODIGO  VARCHAR2(20 BYTE),
  RF_GRUPO   VARCHAR2(30 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_CABAUT  (Table) 
--
CREATE TABLE DINAMIC.CO_CABAUT
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TI_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_OBSERV  VARCHAR2(80 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  CR_CODIGO  VARCHAR2(20 BYTE),
  CT_NOMBRE  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_CABREP  (Table) 
--
CREATE TABLE DINAMIC.CO_CABREP
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CR_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CR_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- AN_COMPRAS  (Table) 
--
CREATE TABLE DINAMIC.AN_COMPRAS
(
  CODSUSTENTO        VARCHAR2(2 BYTE),
  TPIDPROV           VARCHAR2(2 BYTE),
  IDPROV             VARCHAR2(13 BYTE),
  TIPOCOMPROBANTE    VARCHAR2(2 BYTE),
  FECHAREGISTRO      DATE,
  ESTABLECIMIENTO    VARCHAR2(3 BYTE),
  PUNTOEMSION        VARCHAR2(3 BYTE),
  SECUENCIAL         VARCHAR2(9 BYTE),
  FECHAEMISION       DATE,
  AUTORIZACION       VARCHAR2(10 BYTE),
  BASENOGRAIVA       NUMBER(12,2),
  BASEIMPONIBLE      NUMBER(12,2),
  BASEIMPGRAV        NUMBER(12,2),
  MONTOICE           NUMBER(12,2),
  MONTOIVA           NUMBER(12,2),
  VALORRETBIENES     NUMBER(12,2),
  VALORRETSERVICIOS  NUMBER(12,2),
  VALORRETSERV100    NUMBER(12,2),
  CODRETAIR          VARCHAR2(5 BYTE),
  BASEIMPAIR         NUMBER(12,2),
  PORCENTAJEAIR      NUMBER(5,3),
  VALRETAIR          NUMBER(12,2),
  ESTABRETENCION1    VARCHAR2(3 BYTE),
  PTOEMIRETENCION1   VARCHAR2(3 BYTE),
  SECRETENCION1      VARCHAR2(9 BYTE),
  AUTRETENCION1      VARCHAR2(10 BYTE),
  FECHAEMIRET1       DATE,
  DOCMODIFICADO      VARCHAR2(2 BYTE),
  ESTABMODIFICADO    VARCHAR2(3 BYTE),
  PTOEMIMODIFICADO   VARCHAR2(3 BYTE),
  SECMODIFICADO      VARCHAR2(9 BYTE),
  AUTMODIFICADO      VARCHAR2(10 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- AN_VENTAS  (Table) 
--
CREATE TABLE DINAMIC.AN_VENTAS
(
  TPIDCLIENTE         VARCHAR2(2 BYTE),
  IDCLIENTE           VARCHAR2(13 BYTE),
  TIPOCOMPROBANTE     VARCHAR2(2 BYTE),
  NUMEROCOMPROBANTES  VARCHAR2(12 BYTE),
  BASENOGRAIVA        NUMBER(12,2),
  BASEIMPONIBLE       NUMBER(12,2),
  BASEIMPGRAV         NUMBER(12,2),
  MONTOIVA            NUMBER(12,2),
  VALORRETIVA         NUMBER(12,2),
  VALORRETRENTA       NUMBER(12,2),
  ANIO                VARCHAR2(4 BYTE),
  MES                 VARCHAR2(2 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- AN_ANULADOS  (Table) 
--
CREATE TABLE DINAMIC.AN_ANULADOS
(
  TIPOCOMPROBANTE   VARCHAR2(2 BYTE),
  ESTABLECIMIENTO   VARCHAR2(3 BYTE),
  PUNTOEMISION      VARCHAR2(3 BYTE),
  SECUENCIALINICIO  VARCHAR2(9 BYTE),
  SECUENCIALFIN     VARCHAR2(9 BYTE),
  AUTORIZACION      VARCHAR2(10 BYTE),
  ANIO              VARCHAR2(4 BYTE),
  MES               VARCHAR2(2 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- AN_TIPCOM  (Table) 
--
CREATE TABLE DINAMIC.AN_TIPCOM
(
  TC_CODIGO    VARCHAR2(2 BYTE),
  TC_DESCRI    VARCHAR2(150 BYTE),
  TC_SIGLA     VARCHAR2(3 BYTE),
  TC_SECTRANS  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_CONDORMIX  (Table) 
--
CREATE TABLE DINAMIC.TMP_CONDORMIX
(
  ID           VARCHAR2(20 BYTE)                NOT NULL,
  CODIGO       VARCHAR2(20 BYTE)                NOT NULL,
  DESCRIPCION  VARCHAR2(100 BYTE)               NOT NULL,
  BASE         VARCHAR2(5 BYTE)                 NOT NULL,
  TINTE        VARCHAR2(10 BYTE)                NOT NULL,
  CANTIDAD_GL  FLOAT(126)                       NOT NULL,
  CANTIDAD_T   FLOAT(126)                       NOT NULL,
  SEC          NUMBER(5)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RES  (Table) 
--
CREATE TABLE DINAMIC.RES
(
  RS_NOMBRE  VARCHAR2(20 BYTE)                  NOT NULL,
  RS_ACTIVO  VARCHAR2(10 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_UBICA  (Table) 
--
CREATE TABLE DINAMIC.IN_UBICA
(
  IB_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  IB_CODPAD     VARCHAR2(20 BYTE),
  IB_DESCRI     VARCHAR2(20 BYTE)               NOT NULL,
  IB_MEDIDAS    NUMBER(9)                       NOT NULL,
  IB_CAPACIDAD  NUMBER(9)                       NOT NULL,
  ESTADO        CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_UNIBAS  (Table) 
--
CREATE TABLE DINAMIC.IN_UNIBAS
(
  UB_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  UB_NOMBRE  VARCHAR2(30 BYTE)                  NOT NULL,
  UB_SIGLA   CHAR(3 BYTE)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- KITS  (Table) 
--
CREATE TABLE DINAMIC.KITS
(
  CODIGO  VARCHAR2(10 BYTE)                     NOT NULL,
  CODANT  VARCHAR2(20 BYTE)                     NOT NULL,
  NOMBRE  VARCHAR2(50 BYTE)                     NOT NULL,
  COSTO   NUMBER(14,2)                          NOT NULL,
  PVP     NUMBER(14,2)                          NOT NULL,
  KIT     VARCHAR2(1 BYTE)                      NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_CARGO  (Table) 
--
CREATE TABLE DINAMIC.NO_CARGO
(
  CR_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CR_DESCRI  VARCHAR2(80 BYTE)                  NOT NULL,
  CR_OBSERV  VARCHAR2(80 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_PARENT  (Table) 
--
CREATE TABLE DINAMIC.NO_PARENT
(
  PF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PF_DESCRI  VARCHAR2(20 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_RUBRO  (Table) 
--
CREATE TABLE DINAMIC.NO_RUBRO
(
  RU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  RU_NOMBRE  VARCHAR2(50 BYTE)                  NOT NULL,
  RU_SIGLA   CHAR(3 BYTE)                       NOT NULL,
  RU_IOE     CHAR(1 BYTE)                       NOT NULL,
  RU_FOV     CHAR(1 BYTE)                       NOT NULL,
  RU_TIPCAM  CHAR(1 BYTE)                       NOT NULL,
  RU_TIPO    CHAR(1 BYTE),
  RU_ABREVI  VARCHAR2(50 BYTE)                  NOT NULL,
  RU_FECMAX  DATE,
  RU_FECPAG  DATE,
  RU_SEC     NUMBER(12),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_SUBRUB  (Table) 
--
CREATE TABLE DINAMIC.NO_SUBRUB
(
  RU_CODPAD  VARCHAR2(20 BYTE)                  NOT NULL,
  RU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SR_ACTIVO  CHAR(1 BYTE)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_TIPPRES  (Table) 
--
CREATE TABLE DINAMIC.NO_TIPPRES
(
  TP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TP_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_CTRPRD  (Table) 
--
CREATE TABLE DINAMIC.PD_CTRPRD
(
  CR_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CR_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_ORDPRD  (Table) 
--
CREATE TABLE DINAMIC.PD_ORDPRD
(
  OR_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  BO_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  OR_FECHA     DATE,
  OR_OBSERV    VARCHAR2(200 BYTE),
  OR_CANTID    NUMBER(5),
  IT_CODIGO    VARCHAR2(20 BYTE),
  CE_CODIGO    VARCHAR2(20 BYTE),
  OR_LOTE      NUMBER(10),
  OR_FECINI    DATE,
  OR_FECFIN    DATE,
  OR_FECENT    DATE,
  OR_ESPECIF   VARCHAR2(200 BYTE),
  OR_VALMPD    NUMBER(16,4),
  OR_VALMOD    NUMBER(16,4),
  OR_VALCPD    NUMBER(16,4),
  OR_VALCIF    NUMBER(16,4),
  OR_VALCDF    NUMBER(16,4),
  OR_VALGST    NUMBER(16,4),
  OR_UTILIDAD  NUMBER(16,4),
  OR_PRECIO    NUMBER(16,4),
  OR_ESTADO    VARCHAR2(1 BYTE),
  PE_CODIGO    VARCHAR2(20 BYTE),
  DP_SECUE     NUMBER(5),
  OR_CANTPRD   NUMBER(14,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_PEDIDO  (Table) 
--
CREATE TABLE DINAMIC.PD_PEDIDO
(
  PE_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PE_FECHA   DATE,
  PE_OBSERV  VARCHAR2(200 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  CE_CODIGO  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_RECETA  (Table) 
--
CREATE TABLE DINAMIC.PD_RECETA
(
  RT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE),
  SU_CODIGO   VARCHAR2(20 BYTE),
  BO_CODIGO   VARCHAR2(20 BYTE),
  RT_FECHA    DATE,
  RT_OBSERV   VARCHAR2(200 BYTE),
  ESTADO      VARCHAR2(1 BYTE),
  IT_CODIGO   VARCHAR2(20 BYTE),
  RT_CANTID   NUMBER(16,4),
  RQ_CANTID2  NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_REQMAT  (Table) 
--
CREATE TABLE DINAMIC.PD_REQMAT
(
  RM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE),
  SU_CODIGO  VARCHAR2(20 BYTE),
  BO_CODIGO  VARCHAR2(20 BYTE),
  RM_FECHA   DATE,
  RM_OBSERV  VARCHAR2(200 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  OR_CODIGO  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_GRUPCONT  (Table) 
--
CREATE TABLE DINAMIC.PR_GRUPCONT
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  MD_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  GT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  GT_DESCRI   VARCHAR2(20 BYTE)                 NOT NULL,
  PL_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PL_CODIGO1  VARCHAR2(20 BYTE),
  PL_CODIGO2  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_INSTFIN  (Table) 
--
CREATE TABLE DINAMIC.PR_INSTFIN
(
  IF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IF_NOMBRE  VARCHAR2(50 BYTE)                  NOT NULL,
  IF_TIPO    CHAR(1 BYTE)                       NOT NULL,
  IF_MINIMO  NUMBER(14,2)                       NOT NULL,
  IF_MAXIMO  NUMBER(14,2)                       NOT NULL,
  IF_ACTIVA  CHAR(1 BYTE)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_MODSYS  (Table) 
--
CREATE TABLE DINAMIC.PR_MODSYS
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MD_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MD_DESCRI  VARCHAR2(50 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_NUMEROS  (Table) 
--
CREATE TABLE DINAMIC.PR_NUMEROS
(
  MN_NUMERO  NUMBER(5)                          NOT NULL,
  MN_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_NUMSUC  (Table) 
--
CREATE TABLE DINAMIC.PR_NUMSUC
(
  PS_VALOR   NUMBER(12)                         NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PR_NOMBRE  VARCHAR2(10 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PS_NAUT    VARCHAR2(10 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_PAIS  (Table) 
--
CREATE TABLE DINAMIC.PR_PAIS
(
  PA_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PA_NOMBRE   VARCHAR2(30 BYTE)                 NOT NULL,
  PA_NACIONA  VARCHAR2(30 BYTE)                 NOT NULL,
  ESTADO      VARCHAR2(1 BYTE),
  PA_CODALT   VARCHAR2(20 BYTE)                 NOT NULL,
  PA_SIGLA    VARCHAR2(2 BYTE)                  NOT NULL,
  PA_DIGITOS  NUMBER(2)                         NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_PREMIOS  (Table) 
--
CREATE TABLE DINAMIC.PR_PREMIOS
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PE_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PE_MIN     NUMBER(14),
  PE_MAX     NUMBER(14),
  STOCK      NUMBER(14)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_PROV  (Table) 
--
CREATE TABLE DINAMIC.PR_PROV
(
  PA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PO_NOMBRE  VARCHAR2(20 BYTE)                  NOT NULL,
  PO_REGION  VARCHAR2(2 BYTE)                   NOT NULL,
  PO_ZONA    VARCHAR2(2 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RP_MAX_MIN  (Table) 
--
CREATE TABLE DINAMIC.RP_MAX_MIN
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MM_60      NUMBER(8)                          NOT NULL,
  MM_30      NUMBER(8)                          NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SG_AUDIT  (Table) 
--
CREATE TABLE DINAMIC.SG_AUDIT
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SD_TABLA   VARCHAR2(20 BYTE)                  NOT NULL,
  SD_CAMPO   VARCHAR2(20 BYTE)                  NOT NULL,
  SA_LOGIN   VARCHAR2(20 BYTE)                  NOT NULL,
  SD_FECHA   DATE                               NOT NULL,
  SD_VALOLD  VARCHAR2(80 BYTE),
  SD_VALNEW  VARCHAR2(80 BYTE),
  SD_REFER   VARCHAR2(50 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SG_MENU  (Table) 
--
CREATE TABLE DINAMIC.SG_MENU
(
  MN_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MN_PADRE   VARCHAR2(20 BYTE),
  MN_OPCION  VARCHAR2(40 BYTE)                  NOT NULL,
  MN_NOMBRE  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SG_ROL  (Table) 
--
CREATE TABLE DINAMIC.SG_ROL
(
  RS_NOMBRE  VARCHAR2(20 BYTE)                  NOT NULL,
  RS_ACTIVO  VARCHAR2(10 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SG_ROLMENU  (Table) 
--
CREATE TABLE DINAMIC.SG_ROLMENU
(
  MN_CODIGO      VARCHAR2(20 BYTE)              NOT NULL,
  RS_NOMBRE      VARCHAR2(20 BYTE)              NOT NULL,
  RM_HABILITADO  CHAR(1 BYTE)                   NOT NULL,
  ESTADO         VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_CLI  (Table) 
--
CREATE TABLE DINAMIC.TMP_CLI
(
  CODIGO  VARCHAR2(10 BYTE)                     NOT NULL,
  RUCIC   VARCHAR2(13 BYTE),
  RAZONS  VARCHAR2(100 BYTE),
  DIR     VARCHAR2(100 BYTE),
  FONO    VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_CXC  (Table) 
--
CREATE TABLE DINAMIC.TMP_CXC
(
  SEC      NUMBER(5)                            NOT NULL,
  FECHA    DATE,
  CODCLI   VARCHAR2(20 BYTE),
  NUMFACT  VARCHAR2(20 BYTE),
  VALOR    NUMBER(14,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_ITEMS  (Table) 
--
CREATE TABLE DINAMIC.TMP_ITEMS
(
  I_CODIGO  VARCHAR2(20 BYTE),
  I_CODANT  VARCHAR2(20 BYTE),
  I_NOMBRE  VARCHAR2(150 BYTE),
  I_FAB     VARCHAR2(20 BYTE),
  I_COSTO   NUMBER(14,2),
  I_PRECIO  NUMBER(14,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_KITS  (Table) 
--
CREATE TABLE DINAMIC.TMP_KITS
(
  CODIGO    VARCHAR2(20 BYTE)                   NOT NULL,
  K_CODANT  VARCHAR2(20 BYTE)                   NOT NULL,
  K_NOMBRE  VARCHAR2(80 BYTE)                   NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_REL  (Table) 
--
CREATE TABLE DINAMIC.TMP_REL
(
  SEC          VARCHAR2(10 BYTE)                NOT NULL,
  CODIGO       VARCHAR2(20 BYTE)                NOT NULL,
  CODIGOATOMO  VARCHAR2(20 BYTE)                NOT NULL,
  EQUIVALEN    NUMBER(14,2)                     NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TMP_RELITEM  (Table) 
--
CREATE TABLE DINAMIC.TMP_RELITEM
(
  TR_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IT_CODIGO1  VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  RI_CANTID   NUMBER(9,3),
  RI_OBSERV   VARCHAR2(30 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- X_ITEM  (Table) 
--
CREATE TABLE DINAMIC.X_ITEM
(
  I_CODIGO      VARCHAR2(20 BYTE)               NOT NULL,
  I_CODANT      VARCHAR2(20 BYTE),
  I_NOMBRE      VARCHAR2(100 BYTE),
  I_FABRICANTE  VARCHAR2(100 BYTE),
  I_PRECIO      NUMBER(16,4),
  I_COSTUNI     NUMBER(16,4),
  I_MEDIDA      VARCHAR2(2 BYTE),
  COD_DEPT      VARCHAR2(4 BYTE),
  NOM_DEPT      VARCHAR2(50 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_FORTINTE  (Table) 
--
CREATE TABLE DINAMIC.IN_FORTINTE
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_NOMBRE  VARCHAR2(50 BYTE),
  FO_DESCRI  VARCHAR2(50 BYTE),
  FO_VALOR   NUMBER(16,4)                       NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FO_SECUE   NUMBER(5),
  FT_COLUMN  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_TINTE  (Table) 
--
CREATE TABLE DINAMIC.IN_TINTE
(
  FT_CODIGO  VARCHAR2(10 BYTE)                  NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FT_COLUMN  VARCHAR2(20 BYTE),
  FT_OBSERV  VARCHAR2(150 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- QUEST_SL_TEMP_EXPLAIN1  (Table) 
--
CREATE GLOBAL TEMPORARY TABLE DINAMIC.QUEST_SL_TEMP_EXPLAIN1
(
  STATEMENT_ID       VARCHAR2(30 BYTE),
  PLAN_ID            NUMBER,
  TIMESTAMP          DATE,
  REMARKS            VARCHAR2(4000 BYTE),
  OPERATION          VARCHAR2(30 BYTE),
  OPTIONS            VARCHAR2(255 BYTE),
  OBJECT_NODE        VARCHAR2(128 BYTE),
  OBJECT_OWNER       VARCHAR2(30 BYTE),
  OBJECT_NAME        VARCHAR2(30 BYTE),
  OBJECT_ALIAS       VARCHAR2(65 BYTE),
  OBJECT_INSTANCE    INTEGER,
  OBJECT_TYPE        VARCHAR2(30 BYTE),
  OPTIMIZER          VARCHAR2(255 BYTE),
  SEARCH_COLUMNS     NUMBER,
  ID                 INTEGER,
  PARENT_ID          INTEGER,
  DEPTH              INTEGER,
  POSITION           INTEGER,
  COST               INTEGER,
  CARDINALITY        INTEGER,
  BYTES              INTEGER,
  OTHER_TAG          VARCHAR2(255 BYTE),
  PARTITION_START    VARCHAR2(255 BYTE),
  PARTITION_STOP     VARCHAR2(255 BYTE),
  PARTITION_ID       INTEGER,
  OTHER              LONG,
  OTHER_XML          CLOB,
  DISTRIBUTION       VARCHAR2(30 BYTE),
  CPU_COST           INTEGER,
  IO_COST            INTEGER,
  TEMP_SPACE         INTEGER,
  ACCESS_PREDICATES  VARCHAR2(4000 BYTE),
  FILTER_PREDICATES  VARCHAR2(4000 BYTE),
  PROJECTION         VARCHAR2(4000 BYTE),
  TIME               NUMBER(20,2),
  QBLOCK_NAME        VARCHAR2(30 BYTE)
)
ON COMMIT PRESERVE ROWS;


--
-- CC_COMISIONES  (Table) 
--
CREATE TABLE DINAMIC.CC_COMISIONES
(
  TT_CODDEB   VARCHAR2(20 BYTE)                 NOT NULL,
  TT_IOEDEB   CHAR(1 BYTE)                      NOT NULL,
  MT_CODDEB   VARCHAR2(20 BYTE)                 NOT NULL,
  TT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TT_IOE      CHAR(1 BYTE)                      NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  MT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CR_FECHA    DATE                              NOT NULL,
  CR_VALDEB   NUMBER(14,2),
  CR_VALCRE   NUMBER(14,2),
  ESTADO      VARCHAR2(1 BYTE),
  CH_NUMERO   VARCHAR2(20 BYTE),
  CH_FECEFEC  DATE,
  FP_CODIGO   VARCHAR2(20 BYTE),
  SECUENCIAL  NUMBER(5)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CONDORMIX  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CONDORMIX ON DINAMIC.TMP_CONDORMIX
(SEC)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_DCTOCLI  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_DCTOCLI ON DINAMIC.FA_DCTOCLI
(DC_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_INDOCPRO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_INDOCPRO ON DINAMIC.IN_DOCPRO
(ID)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_COMISIONES  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_COMISIONES ON DINAMIC.CC_COMISIONES
(SECUENCIAL)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_AN_VENTAS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_AN_VENTAS ON DINAMIC.AN_VENTAS
(ANIO, MES, TPIDCLIENTE, IDCLIENTE, TIPOCOMPROBANTE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_AN_RETAIR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_AN_RETAIR ON DINAMIC.AN_RETAIR
(NUMRUC, ANIO, MES, TPIDPROV, IDPROV, 
TIPOCOMP, AUT, ESTAB, PTOEMI, SEC, 
FECHAEMICOM, CODRETAIR)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_CABCOBT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_CABCOBT ON DINAMIC.CB_CABCOBT
(BT_CODIGO, EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CUENTIPO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CUENTIPO ON DINAMIC.CB_CUENTIPO
(CUENTA, TIPO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_DETCOBT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_DETCOBT ON DINAMIC.CB_DETCOBT
(BT_CODIGO, EM_CODIGO, PT_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_TARJETAS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_TARJETAS ON DINAMIC.CB_TARJETAS
(CT_CODIGO, EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_TIPO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_TIPO ON DINAMIC.CB_TIPO
(TN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CC_RETEN  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CC_RETEN ON DINAMIC.CC_RETEN
(RF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FKIDX_RETENCTACON  (Index) 
--
CREATE INDEX DINAMIC.FKIDX_RETENCTACON ON DINAMIC.CC_RETEN
(EM_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_CABAUT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_CABAUT ON DINAMIC.CO_CABAUT
(EM_CODIGO, SU_CODIGO, CT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CABREP  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CABREP ON DINAMIC.CO_CABREP
(EM_CODIGO, CR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_CAJA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_CAJA ON DINAMIC.FA_CAJA
(EM_CODIGO, SU_CODIGO, CJ_CAJA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- BODEGA_SECCION_FK  (Index) 
--
CREATE INDEX DINAMIC.BODEGA_SECCION_FK ON DINAMIC.FA_CAJA
(EM_CODIGO, SU_CODIGO, BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_CLACLI  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_CLACLI ON DINAMIC.FA_CLACLI
(CA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_CLASE_CLIENTE_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_CLASE_CLIENTE_FK ON DINAMIC.FA_CLACLI
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_ESTADO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_ESTADO ON DINAMIC.FA_ESTADO
(ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_RF  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_RF ON DINAMIC.FA_REFERENCIA
(COD_CLIE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_TIPCLI  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_TIPCLI ON DINAMIC.FA_TIPCLI
(TC_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_COESTADO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_COESTADO ON DINAMIC.IN_COESTADO
(EC_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_COSTO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_COSTO ON DINAMIC.IN_COSTO
(EM_CODIGO, SU_CODIGO, IT_CODIGO, CT_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          896K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_INFORMULAS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_INFORMULAS ON DINAMIC.IN_FORMULAS
(FO_CODIGO, EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_FORMPARAM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_FORMPARAM ON DINAMIC.IN_FORPARAM
(EM_CODIGO, FO_CODPAR)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_ITEMRES  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_ITEMRES ON DINAMIC.IN_ITEMRES
(EM_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_TIPRELITEM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_TIPRELITEM ON DINAMIC.IN_TIPRELITEM
(TR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_UNIBAS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_UNIBAS ON DINAMIC.IN_UNIBAS
(UB_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_KIT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_KIT ON DINAMIC.KITS
(CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_CARGO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_CARGO ON DINAMIC.NO_CARGO
(CR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_PARENT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_PARENT ON DINAMIC.NO_PARENT
(PF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_RUBRO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_RUBRO ON DINAMIC.NO_RUBRO
(RU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_RUBRO_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_RUBRO_FK ON DINAMIC.NO_RUBRO
(EM_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_SUBRUB  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_SUBRUB ON DINAMIC.NO_SUBRUB
(RU_CODPAD, RU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_TIPPRES  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_TIPPRES ON DINAMIC.NO_TIPPRES
(TP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CTRPRD  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CTRPRD ON DINAMIC.PD_CTRPRD
(CR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_ORDPRD  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_ORDPRD ON DINAMIC.PD_ORDPRD
(OR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_PEDIDO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_PEDIDO ON DINAMIC.PD_PEDIDO
(PE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_RECETA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_RECETA ON DINAMIC.PD_RECETA
(RT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_REQMAT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_REQMAT ON DINAMIC.PD_REQMAT
(RM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_GRUPCONT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_GRUPCONT ON DINAMIC.PR_GRUPCONT
(GT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_INSTFIN  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_INSTFIN ON DINAMIC.PR_INSTFIN
(IF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_INST_FINAN_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_INST_FINAN_FK ON DINAMIC.PR_INSTFIN
(EM_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_MODSYS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_MODSYS ON DINAMIC.PR_MODSYS
(MD_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_NUMSUC  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_NUMSUC ON DINAMIC.PR_NUMSUC
(SU_CODIGO, PR_NOMBRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_PAIS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_PAIS ON DINAMIC.PR_PAIS
(PA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PREMIO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PREMIO ON DINAMIC.PR_PREMIOS
(EM_CODIGO, SU_CODIGO, PE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PROV  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PROV ON DINAMIC.PR_PROV
(PA_CODIGO, PO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_MAX_MIN  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_MAX_MIN ON DINAMIC.RP_MAX_MIN
(EM_CODIGO, SU_CODIGO, BO_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_SG_MENU  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_SG_MENU ON DINAMIC.SG_MENU
(MN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- OPCION_MENU_PADRE_FK  (Index) 
--
CREATE INDEX DINAMIC.OPCION_MENU_PADRE_FK ON DINAMIC.SG_MENU
(MN_PADRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_SG_ROL  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_SG_ROL ON DINAMIC.SG_ROL
(RS_NOMBRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_SG_ROLMENU  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_SG_ROLMENU ON DINAMIC.SG_ROLMENU
(MN_CODIGO, RS_NOMBRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CLI  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CLI ON DINAMIC.TMP_CLI
(CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CXC  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CXC ON DINAMIC.TMP_CXC
(SEC)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_I  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_I ON DINAMIC.TMP_ITEMS
(I_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_K  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_K ON DINAMIC.TMP_KITS
(CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_REL  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_REL ON DINAMIC.TMP_REL
(SEC)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_TINTE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_TINTE ON DINAMIC.IN_TINTE
(FT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_FORTINTE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_FORTINTE ON DINAMIC.IN_FORTINTE
(EM_CODIGO, FO_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- AN_TIPCOM_PK  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.AN_TIPCOM_PK ON DINAMIC.AN_TIPCOM
(TC_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_AN_ANULADOS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_AN_ANULADOS ON DINAMIC.AN_ANULADOS
(ANIO, MES, TIPOCOMPROBANTE, ESTABLECIMIENTO, PUNTOEMISION, 
SECUENCIALINICIO, SECUENCIALFIN, AUTORIZACION)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTAS_X_COBRAR_PKG  (Package) 
--
CREATE OR REPLACE PACKAGE DINAMIC.CUENTAS_X_COBRAR_PKG AS
/******************************************************************************
   NAME:       CUENTAS_X_COBRAR_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        11/03/2013      Patricio       1. Created this package.
******************************************************************************/

  
  PROCEDURE CXC_ANULAMOVCREDITO_PRC(Param1 IN NUMBER);

END CUENTAS_X_COBRAR_PKG;
/


--
-- SP_COMISIONES  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.sp_comisiones IS
tmpVar NUMBER;

/******************************************************************************
   NAME:       sp_comisiones
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/06/2013   Patricio       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_comisiones
      Sysdate:         24/06/2013
      Date and Time:   24/06/2013, 22:41:16, and 24/06/2013 22:41:16
      Username:        Patricio (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/

CURSOR C_PAGOS IS
SELECT mt_codigo
FROM CC_CHEQUE
WHERE TRUNC(CH_FECHA) = trunc(sysdate);

CURSOR C_CRUCE IS
SELECT mt_coddeb
FROM CC_CRUCE
WHERE MT_CODIGO = :nromov;

BEGIN
tmpVar := 0;
/*
for reg1 in c_pago loop
                
                 salcre = reg1.ch_valor;
                --recorrer cruces 
                
                for reg2 in c_cruces loop
                
                     saldodeb = reg2.cx_valdeb;
                     if saldodeb >0 then
                             if salcre > saldodeb
                               
                                 abono= saldodeb;  
                                 INSERT INTO CC_COMISIONES()
                                 VALUES();
                                 saldodeb = saldodeb  - abono;
                                 saldocre = saldocre - abono;
                             else
                             
                                 --insertar y poner forma de pago 
                                 abono = saldocre;
                                 INSERT INTO CC_COMISIONES()
                                 VALUES();
                                 saldodeb = saldodeb  - abono;
                                 saldocre = saldocre - abono;
                                 
                             end if;
                     end if;
                loop;
loop;
*/

 EXCEPTION
 
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END sp_comisiones;
/


--
-- CREARTABLADELOG  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.creartabladelog IS
tmpVar NUMBER;
sql_str  VARCHAR(1000);
/******************************************************************************
   NAME:       creartabladelog
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2013   Patricio       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     creartabladelog
      Sysdate:         10/04/2013
      Date and Time:   10/04/2013, 11:11:49, and 10/04/2013 11:11:49
      Username:        Patricio (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/


BEGIN
   tmpVar := 0;
    sql_str := 'CREATE TABLE DINAMIC.LOG_BAJAS_TBL (CODERR NUMBER(7),DESCRIPCION VARCHAR2(1000),FECHA DATE)';
    EXECUTE IMMEDIATE sql_str; 
        
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END creartabladelog;
/


--
-- F_VALRUCCI  (Function) 
--
CREATE OR REPLACE FUNCTION DINAMIC."F_VALRUCCI" ( ce_rucic
    VARCHAR2 )
return VARCHAR2
as
rucci VARCHAR2(13);
begin
select decode( length(ce_rucic),
	10,		decode( least(to_number(substr(ce_rucic,1,2)),22)||substr(ce_rucic,10,1),		to_number(substr(ce_rucic,1,2))||to_number(			ceil((decode(substr(ce_rucic,1,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,1,1)*2)+substr(ce_rucic,2,1)+decode(substr(ce_rucic,3,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,3,1)*2)+substr(ce_rucic,4,1)+decode(substr(ce_rucic,5,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,5,1)*2)+substr(ce_rucic,6,1)+decode(substr(ce_rucic,7,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,7,1)*2)+substr(ce_rucic,8,1)+decode(substr(ce_rucic,9,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,9,1)*2))/10)*10				- (decode(substr(ce_rucic,1,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,1,1)*2)+substr(ce_rucic,2,1)+decode(substr(ce_rucic,3,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,3,1)*2)+substr(ce_rucic,4,1)+decode(substr(ce_rucic,5,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,5,1)*2)+substr(ce_rucic,6,1)+decode(substr(ce_rucic,7,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,7,1)*2)+substr(ce_rucic,8,1)+decode(substr(ce_rucic,9,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,9,1)*2))),		ce_rucic,9999999999999),
	13,		decode( substr(ce_rucic,3,1),
			9,				decode( least(to_number(substr(ce_rucic,1,2)),22)||substr(ce_rucic,10,1)||'001',				to_number(substr(ce_rucic,1,2))||to_number(					 ceil(((substr(ce_rucic,1,1)*4)+(substr(ce_rucic,2,1)*3)+(substr(ce_rucic,3,1)*2)+(substr(ce_rucic,4,1)*7)+(substr(ce_rucic,5,1)*6)+(substr(ce_rucic,6,1)*5)+(substr(ce_rucic,7,1)*4)+(substr(ce_rucic,8,1)*3)+(substr(ce_rucic,9,1)*2))/11)*11						 - ((substr(ce_rucic,1,1)*4)+(substr(ce_rucic,2,1)*3)+(substr(ce_rucic,3,1)*2)+(substr(ce_rucic,4,1)*7)+(substr(ce_rucic,5,1)*6)+(substr(ce_rucic,6,1)*5)+(substr(ce_rucic,7,1)*4)+(substr(ce_rucic,8,1)*3)+(substr(ce_rucic,9,1)*2)))||					substr(ce_rucic,-3),				ce_rucic,9999999999999),
			6,				decode( least(to_number(substr(ce_rucic,1,2)),22)||substr(ce_rucic,9,1)||'0001',				to_number(substr(ce_rucic,1,2))||to_number(					 ceil(((substr(ce_rucic,1,1)*3)+(substr(ce_rucic,2,1)*2)+(substr(ce_rucic,3,1)*7)+(substr(ce_rucic,4,1)*6)+(substr(ce_rucic,5,1)*5)+(substr(ce_rucic,6,1)*4)+(substr(ce_rucic,7,1)*3)+(substr(ce_rucic,8,1)*2))/11)*11						 - ((substr(ce_rucic,1,1)*3)+(substr(ce_rucic,2,1)*2)+(substr(ce_rucic,3,1)*7)+(substr(ce_rucic,4,1)*6)+(substr(ce_rucic,5,1)*5)+(substr(ce_rucic,6,1)*4)+(substr(ce_rucic,7,1)*3)+(substr(ce_rucic,8,1)*2)))||					substr(ce_rucic,-4),				ce_rucic,9999999999999),
			decode( least(to_number(substr(ce_rucic,1,2)),22)||substr(ce_rucic,10,1)||'001',         to_number(substr(ce_rucic,1,2))||to_number(				ceil((decode(substr(ce_rucic,1,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,1,1)*2)+substr(ce_rucic,2,1)+decode(substr(ce_rucic,3,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,3,1)*2)+substr(ce_rucic,4,1)+decode(substr(ce_rucic,5,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,5,1)*2)+substr(ce_rucic,6,1)+decode(substr(ce_rucic,7,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,7,1)*2)+substr(ce_rucic,8,1)+decode(substr(ce_rucic,9,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,9,1)*2))/10)*10				   - (decode(substr(ce_rucic,1,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,1,1)*2)+substr(ce_rucic,2,1)+decode(substr(ce_rucic,3,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,3,1)*2)+substr(ce_rucic,4,1)+decode(substr(ce_rucic,5,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,5,1)*2)+substr(ce_rucic,6,1)+decode(substr(ce_rucic,7,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,7,1)*2)+substr(ce_rucic,8,1)+decode(substr(ce_rucic,9,1),5,1,6,3,7,5,8,7,9,9,substr(ce_rucic,9,1)*2)))||					substr(ce_rucic,-3),			ce_rucic,9999999999999)),
	9999999999999)
	into rucci
from dual;
RETURN rucci;
EXCEPTION
WHEN OTHERS THEN
 RETURN '9999999999999';

end;
/


--
-- F_CODBAR  (Function) 
--
CREATE OR REPLACE FUNCTION DINAMIC."F_CODBAR"  (it_codbar VARCHAR2) 
return VARCHAR2 
as 
codbar VARCHAR2(16); 
begin 
select decode(substr(it_codbar,1,1),0,'!',1,'"',2,'#',3,'$',4,'p',5,'&',6,'''',7,'(',8,')','*')|| 
decode(substr(it_codbar,2,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')|| 
decode(substr(it_codbar,1,1), 
0,		decode(substr(it_codbar,3,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,4,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,5,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,6,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,7,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J'), 
1,		decode(substr(it_codbar,3,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,4,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,5,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,6,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,7,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z'), 
2,		decode(substr(it_codbar,3,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,4,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,5,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,6,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,7,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z'), 
3,		decode(substr(it_codbar,3,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,4,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,5,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,6,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,7,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J'), 
4,		decode(substr(it_codbar,3,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,4,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,5,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,6,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,7,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z'), 
5,		decode(substr(it_codbar,3,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,4,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,5,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,6,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,7,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z'), 
6,		decode(substr(it_codbar,3,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,4,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,5,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,6,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,7,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J'), 
7,		decode(substr(it_codbar,3,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,4,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,5,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,6,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,7,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z'), 
8,		decode(substr(it_codbar,3,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,4,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,5,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,6,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,7,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J'), 
9,		decode(substr(it_codbar,3,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,4,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,5,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J')||	decode(substr(it_codbar,6,1),0,'Q',1,'R',2,'S',3,'T',4,'U',5,'V',6,'W',7,'X',8,'Y','Z')||	decode(substr(it_codbar,7,1),0,'A',1,'B',2,'C',3,'D',4,'E',5,'F',6,'G',7,'H',8,'I','J') 
)|| 
'|'|| 
substr(it_codbar,8,6)|| 
']' 
into codbar 
from dual; 
RETURN codbar; 
end;
/


--
-- SEQ_INDOCPRO  (Trigger) 
--
CREATE OR REPLACE TRIGGER DINAMIC.seq_indocpro
BEFORE INSERT
ON DINAMIC.IN_DOCPRO 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DISABLE
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        15/04/2013      Patricio       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         15/04/2013
      Date and Time:   15/04/2013, 16:12:07, and 15/04/2013 16:12:07
      Username:        Patricio (set in TOAD Options, Proc Templates)
      Table Name:      IN_DOCPRO (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   SELECT docpro.NEXTVAL INTO tmpVar FROM dual;
   :NEW.id:= tmpVar;
   
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/


--
-- SG_ROLMENU  (Synonym) 
--
CREATE PUBLIC SYNONYM SG_ROLMENU FOR DINAMIC.SG_ROLMENU;


--
-- SG_ROL  (Synonym) 
--
CREATE PUBLIC SYNONYM SG_ROL FOR DINAMIC.SG_ROL;


--
-- SG_MENU  (Synonym) 
--
CREATE PUBLIC SYNONYM SG_MENU FOR DINAMIC.SG_MENU;


--
-- SG_AUDIT  (Synonym) 
--
CREATE PUBLIC SYNONYM SG_AUDIT FOR DINAMIC.SG_AUDIT;


--
-- RP_MAX_MIN  (Synonym) 
--
CREATE PUBLIC SYNONYM RP_MAX_MIN FOR DINAMIC.RP_MAX_MIN;


--
-- PR_PROV  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_PROV FOR DINAMIC.PR_PROV;


--
-- PR_PREMIOS  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_PREMIOS FOR DINAMIC.PR_PREMIOS;


--
-- PR_PAIS  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_PAIS FOR DINAMIC.PR_PAIS;


--
-- PR_NUMSUC  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_NUMSUC FOR DINAMIC.PR_NUMSUC;


--
-- PR_NUMEROS  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_NUMEROS FOR DINAMIC.PR_NUMEROS;


--
-- PR_MODSYS  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_MODSYS FOR DINAMIC.PR_MODSYS;


--
-- PR_INSTFIN  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_INSTFIN FOR DINAMIC.PR_INSTFIN;


--
-- PR_GRUPCONT  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_GRUPCONT FOR DINAMIC.PR_GRUPCONT;


--
-- PD_REQMAT  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_REQMAT FOR DINAMIC.PD_REQMAT;


--
-- PD_RECETA  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_RECETA FOR DINAMIC.PD_RECETA;


--
-- PD_PEDIDO  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_PEDIDO FOR DINAMIC.PD_PEDIDO;


--
-- PD_ORDPRD  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_ORDPRD FOR DINAMIC.PD_ORDPRD;


--
-- PD_CTRPRD  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_CTRPRD FOR DINAMIC.PD_CTRPRD;


--
-- NO_TIPPRES  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_TIPPRES FOR DINAMIC.NO_TIPPRES;


--
-- NO_SUBRUB  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_SUBRUB FOR DINAMIC.NO_SUBRUB;


--
-- NO_RUBRO  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_RUBRO FOR DINAMIC.NO_RUBRO;


--
-- NO_PARENT  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_PARENT FOR DINAMIC.NO_PARENT;


--
-- NO_CARGO  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_CARGO FOR DINAMIC.NO_CARGO;


--
-- KITS  (Synonym) 
--
CREATE PUBLIC SYNONYM KITS FOR DINAMIC.KITS;


--
-- IN_UNIBAS  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_UNIBAS FOR DINAMIC.IN_UNIBAS;


--
-- IN_UBICA  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_UBICA FOR DINAMIC.IN_UBICA;


--
-- IN_TIPRELITEM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_TIPRELITEM FOR DINAMIC.IN_TIPRELITEM;


--
-- IN_TINTE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_TINTE FOR DINAMIC.IN_TINTE;


--
-- IN_RECPAG  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_RECPAG FOR DINAMIC.IN_RECPAG;


--
-- IN_ITEMRES  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITEMRES FOR DINAMIC.IN_ITEMRES;


--
-- IN_FORTINTE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_FORTINTE FOR DINAMIC.IN_FORTINTE;


--
-- IN_FORPARAM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_FORPARAM FOR DINAMIC.IN_FORPARAM;


--
-- IN_FORMULAS  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_FORMULAS FOR DINAMIC.IN_FORMULAS;


--
-- IN_DOCPRO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_DOCPRO FOR DINAMIC.IN_DOCPRO;


--
-- IN_COSTO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_COSTO FOR DINAMIC.IN_COSTO;


--
-- IN_COESTADO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_COESTADO FOR DINAMIC.IN_COESTADO;


--
-- FA_TIPCLI  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_TIPCLI FOR DINAMIC.FA_TIPCLI;


--
-- FA_SRIVENTAS  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_SRIVENTAS FOR DINAMIC.FA_SRIVENTAS;


--
-- FA_REFERENCIA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_REFERENCIA FOR DINAMIC.FA_REFERENCIA;


--
-- FA_ESTADO  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_ESTADO FOR DINAMIC.FA_ESTADO;


--
-- FA_ENTREGA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_ENTREGA FOR DINAMIC.FA_ENTREGA;


--
-- FA_DCTOCLI  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_DCTOCLI FOR DINAMIC.FA_DCTOCLI;


--
-- FA_CLACLI  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_CLACLI FOR DINAMIC.FA_CLACLI;


--
-- FA_CIECAJA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_CIECAJA FOR DINAMIC.FA_CIECAJA;


--
-- FA_CAJA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_CAJA FOR DINAMIC.FA_CAJA;


--
-- CO_CABREP  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_CABREP FOR DINAMIC.CO_CABREP;


--
-- CO_CABAUT  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_CABAUT FOR DINAMIC.CO_CABAUT;


--
-- CC_RETEN  (Synonym) 
--
CREATE PUBLIC SYNONYM CC_RETEN FOR DINAMIC.CC_RETEN;


--
-- CC_COMISIONES  (Synonym) 
--
CREATE PUBLIC SYNONYM CC_COMISIONES FOR DINAMIC.CC_COMISIONES;


--
-- CB_TIPO  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_TIPO FOR DINAMIC.CB_TIPO;


--
-- CB_TARJETAS  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_TARJETAS FOR DINAMIC.CB_TARJETAS;


--
-- CB_DETCOBT  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_DETCOBT FOR DINAMIC.CB_DETCOBT;


--
-- CB_CUENTIPO  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_CUENTIPO FOR DINAMIC.CB_CUENTIPO;


--
-- CB_CABCOBT  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_CABCOBT FOR DINAMIC.CB_CABCOBT;


--
-- AN_VENTAS  (Synonym) 
--
CREATE PUBLIC SYNONYM AN_VENTAS FOR DINAMIC.AN_VENTAS;


--
-- AN_TIPCOM  (Synonym) 
--
CREATE PUBLIC SYNONYM AN_TIPCOM FOR DINAMIC.AN_TIPCOM;


--
-- AN_RETAIR  (Synonym) 
--
CREATE PUBLIC SYNONYM AN_RETAIR FOR DINAMIC.AN_RETAIR;


--
-- AN_COMPRAS  (Synonym) 
--
CREATE PUBLIC SYNONYM AN_COMPRAS FOR DINAMIC.AN_COMPRAS;


--
-- AN_ANULADOS  (Synonym) 
--
CREATE PUBLIC SYNONYM AN_ANULADOS FOR DINAMIC.AN_ANULADOS;


--
-- CO_DETREP  (Table) 
--
CREATE TABLE DINAMIC.CO_DETREP
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  CR_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  DR_COLUMNA   VARCHAR2(20 BYTE)                NOT NULL,
  DR_ETIQUETA  VARCHAR2(2 BYTE)                 NOT NULL,
  DR_OBS       VARCHAR2(50 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_EQUIVALENCIA  (Table) 
--
CREATE TABLE DINAMIC.IN_EQUIVALENCIA
(
  UB_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  UB_CODEQU  VARCHAR2(20 BYTE)                  NOT NULL,
  EQ_VALOR   NUMBER(12,6)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_DETTAR  (Table) 
--
CREATE TABLE DINAMIC.CB_DETTAR
(
  CT_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  DT_SECUE     VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE),
  RP_NUMERO    VARCHAR2(20 BYTE),
  DT_NUMDOC    VARCHAR2(20 BYTE),
  FP_CODIGO    VARCHAR2(20 BYTE),
  VE_NUMERO    NUMBER,
  DT_VALOR     NUMBER(9,2),
  DT_SALDO     NUMBER(9,2),
  DT_COMISION  NUMBER(9,2),
  DT_INTERES   NUMBER(9,2),
  ESTADO       CHAR(1 BYTE),
  ES_CODIGO    VARCHAR2(20 BYTE),
  BO_CODIGO    VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_CARFAM  (Table) 
--
CREATE TABLE DINAMIC.NO_CARFAM
(
  CF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CF_NOMBRE  VARCHAR2(25 BYTE)                  NOT NULL,
  CF_APELLI  VARCHAR2(25 BYTE)                  NOT NULL,
  CF_FECNAC  DATE                               NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_RUBCAL  (Table) 
--
CREATE TABLE DINAMIC.NO_RUBCAL
(
  RU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  RC_FECINI     DATE,
  RC_FECFIN     DATE,
  RC_VALNUM     NUMBER(14,2),
  RC_VALSUP     NUMBER(14,2),
  RC_VALINF     NUMBER(14,2),
  RC_PORCEN     NUMBER(9,6),
  RC_SMVS       NUMBER(12,10),
  RC_SN         NUMBER(12,10),
  ESTADO        VARCHAR2(1 BYTE),
  RC_DIAS_ANIO  CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_DETPED  (Table) 
--
CREATE TABLE DINAMIC.PD_DETPED
(
  PE_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DP_SECUE   NUMBER(5)                          NOT NULL,
  DP_CANTID  NUMBER(16,4),
  ESTADO     VARCHAR2(1 BYTE),
  IT_CODIGO  VARCHAR2(20 BYTE),
  OR_CODIGO  VARCHAR2(20 BYTE),
  DP_PVP     NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_DETREQ  (Table) 
--
CREATE TABLE DINAMIC.PD_DETREQ
(
  RM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  RE_SECUE     NUMBER(5)                        NOT NULL,
  IT_CODIGO    VARCHAR2(20 BYTE),
  RE_CANTID    NUMBER(16,4),
  ESTADO       VARCHAR2(1 BYTE),
  RE_CANTDESP  NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_DETRTA  (Table) 
--
CREATE TABLE DINAMIC.PD_DETRTA
(
  RT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  RQ_SECUE    NUMBER(5)                         NOT NULL,
  IT_CODIGO1  VARCHAR2(20 BYTE),
  RQ_CANTID   NUMBER(16,4),
  ESTADO      VARCHAR2(1 BYTE),
  RQ_CANTID2  NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_ORDCIF  (Table) 
--
CREATE TABLE DINAMIC.PD_ORDCIF
(
  OR_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CF_SECUE      VARCHAR2(20 BYTE)               NOT NULL,
  CF_FECHA      DATE,
  CF_TASA       NUMBER(14,2),
  CF_PARAMETRO  VARCHAR2(50 BYTE),
  CF_VALOR      NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_ORDMOD  (Table) 
--
CREATE TABLE DINAMIC.PD_ORDMOD
(
  OR_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  MO_SECUE     VARCHAR2(20 BYTE)                NOT NULL,
  MO_FECHA     DATE,
  MO_NROHORAS  NUMBER(5),
  MO_VALHORA   NUMBER(16,4),
  MO_VALOR     NUMBER(16,4),
  ESTADO       VARCHAR2(1 BYTE),
  CR_CODIGO    VARCHAR2(20 BYTE)                NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PD_ORDMPD  (Table) 
--
CREATE TABLE DINAMIC.PD_ORDMPD
(
  OR_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DR_SECUE   NUMBER(5)                          NOT NULL,
  DR_NRODOC  VARCHAR2(20 BYTE),
  DR_VALOR   NUMBER(16,4),
  ESTADO     VARCHAR2(1 BYTE),
  DR_FECHA   DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_CANTON  (Table) 
--
CREATE TABLE DINAMIC.PR_CANTON
(
  PA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_NOMBRE  VARCHAR2(30 BYTE)                  NOT NULL,
  ESTADO     CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_CIUDAD  (Table) 
--
CREATE TABLE DINAMIC.PR_CIUDAD
(
  PA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CU_NOMBRE  VARCHAR2(20 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_EMPRE  (Table) 
--
CREATE TABLE DINAMIC.PR_EMPRE
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_NOMBRE  VARCHAR2(50 BYTE)                  NOT NULL,
  EM_NOMREP  VARCHAR2(25 BYTE)                  NOT NULL,
  EM_APEREP  VARCHAR2(25 BYTE)                  NOT NULL,
  EM_NOMPRE  VARCHAR2(25 BYTE)                  NOT NULL,
  EM_APEPRE  VARCHAR2(25 BYTE)                  NOT NULL,
  EM_NOMCON  VARCHAR2(25 BYTE)                  NOT NULL,
  EM_APECON  VARCHAR2(25 BYTE)                  NOT NULL,
  EM_RUC     VARCHAR2(13 BYTE)                  NOT NULL,
  EM_CALLE1  VARCHAR2(50 BYTE)                  NOT NULL,
  EM_CALLE2  VARCHAR2(50 BYTE),
  EM_NUMPAT  VARCHAR2(20 BYTE),
  EM_TELEF1  VARCHAR2(9 BYTE)                   NOT NULL,
  EM_TELEF2  VARCHAR2(9 BYTE),
  EM_TELEF3  VARCHAR2(9 BYTE),
  EM_FAX     VARCHAR2(9 BYTE),
  EM_EMAIL   VARCHAR2(50 BYTE),
  EM_DESCR   VARCHAR2(50 BYTE),
  EM_LOGO    VARCHAR2(50 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_PARAM  (Table) 
--
CREATE TABLE DINAMIC.PR_PARAM
(
  PR_NOMBRE    VARCHAR2(10 BYTE)                NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  PR_DESCRI    VARCHAR2(20 BYTE)                NOT NULL,
  PR_VALOR     NUMBER(14,2)                     NOT NULL,
  PR_LETRAS    VARCHAR2(100 BYTE),
  PR_VALDEC    NUMBER(14,8),
  PR_TIPO      VARCHAR2(20 BYTE),
  ESTADO       VARCHAR2(1 BYTE),
  PR_SUCURSAL  CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_SUCUR  (Table) 
--
CREATE TABLE DINAMIC.PR_SUCUR
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_NOMBRE   VARCHAR2(50 BYTE)                 NOT NULL,
  SU_CALLE1   VARCHAR2(50 BYTE)                 NOT NULL,
  SU_CALLE2   VARCHAR2(50 BYTE),
  SU_TELEF1   VARCHAR2(9 BYTE)                  NOT NULL,
  SU_TELEF2   VARCHAR2(9 BYTE),
  SU_FAX      VARCHAR2(9 BYTE),
  SU_NOMREP   VARCHAR2(25 BYTE)                 NOT NULL,
  SU_APEREP   VARCHAR2(25 BYTE)                 NOT NULL,
  SU_RUC      VARCHAR2(13 BYTE),
  SU_JUZGADO  VARCHAR2(30 BYTE),
  ESTADO      VARCHAR2(1 BYTE),
  SU_CIUDAD   VARCHAR2(80 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SG_ACCESO  (Table) 
--
CREATE TABLE DINAMIC.SG_ACCESO
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SA_LOGIN     VARCHAR2(20 BYTE)                NOT NULL,
  RS_NOMBRE    VARCHAR2(20 BYTE)                NOT NULL,
  SA_PASSWD    VARCHAR2(8 BYTE)                 NOT NULL,
  SA_FECHA     DATE                             NOT NULL,
  SA_ACTIVO    CHAR(1 BYTE)                     NOT NULL,
  SA_TIPO      CHAR(1 BYTE)                     NOT NULL,
  SA_SECCION   VARCHAR2(20 BYTE)                NOT NULL,
  ESTADO       VARCHAR2(1 BYTE),
  SA_VERCOST   CHAR(1 BYTE)                     NOT NULL,
  SA_CAMBPRE   CHAR(1 BYTE)                     NOT NULL,
  SA_REIMP     CHAR(1 BYTE)                     NOT NULL,
  SA_ANULA     CHAR(1 BYTE)                     NOT NULL,
  SA_PROCESO   CHAR(1 BYTE)                     NOT NULL,
  SA_POS       CHAR(1 BYTE)                     NOT NULL,
  SA_PASSEDIT  VARCHAR2(10 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_DETTAR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_DETTAR ON DINAMIC.CB_DETTAR
(CT_CODIGO, EM_CODIGO, DT_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_DETREP  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_DETREP ON DINAMIC.CO_DETREP
(EM_CODIGO, CR_CODIGO, DR_COLUMNA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_EQUIVALENCIA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_EQUIVALENCIA ON DINAMIC.IN_EQUIVALENCIA
(UB_CODIGO, UB_CODEQU)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_CARFAM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_CARFAM ON DINAMIC.NO_CARFAM
(EP_CODIGO, CF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PARENTEZCO_CARGA_FK  (Index) 
--
CREATE INDEX DINAMIC.PARENTEZCO_CARGA_FK ON DINAMIC.NO_CARFAM
(PF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_CARGA_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_CARGA_FK ON DINAMIC.NO_CARFAM
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_RUBCAL  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_RUBCAL ON DINAMIC.NO_RUBCAL
(RU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_DETPED  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_DETPED ON DINAMIC.PD_DETPED
(PE_CODIGO, DP_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATIONSHIP_2_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATIONSHIP_2_FK ON DINAMIC.PD_DETPED
(PE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_DETREQ  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_DETREQ ON DINAMIC.PD_DETREQ
(RM_CODIGO, RE_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATIONSHIP_1_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATIONSHIP_1_FK ON DINAMIC.PD_DETREQ
(RM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_DETRTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_DETRTA ON DINAMIC.PD_DETRTA
(RT_CODIGO, RQ_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATIONSHIP_3_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATIONSHIP_3_FK ON DINAMIC.PD_DETRTA
(RT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_ORDCIF  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_ORDCIF ON DINAMIC.PD_ORDCIF
(OR_CODIGO, CF_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATIONSHIP_4_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATIONSHIP_4_FK ON DINAMIC.PD_ORDCIF
(OR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATIONSHIP_6_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATIONSHIP_6_FK ON DINAMIC.PD_ORDMOD
(OR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PD_ORDMPD  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PD_ORDMPD ON DINAMIC.PD_ORDMPD
(OR_CODIGO, DR_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATIONSHIP_5_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATIONSHIP_5_FK ON DINAMIC.PD_ORDMPD
(OR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CANTON  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CANTON ON DINAMIC.PR_CANTON
(PA_CODIGO, PO_CODIGO, CT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_CIUDAD  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_CIUDAD ON DINAMIC.PR_CIUDAD
(PA_CODIGO, CU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_EMPRE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_EMPRE ON DINAMIC.PR_EMPRE
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CIUDAD_EMPRESA_FK  (Index) 
--
CREATE INDEX DINAMIC.CIUDAD_EMPRESA_FK ON DINAMIC.PR_EMPRE
(PA_CODIGO, CU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_PARAM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_PARAM ON DINAMIC.PR_PARAM
(PR_NOMBRE, EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_PARAMETRO_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_PARAMETRO_FK ON DINAMIC.PR_PARAM
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_SUCUR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_SUCUR ON DINAMIC.PR_SUCUR
(EM_CODIGO, SU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_SG_ACCESO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_SG_ACCESO ON DINAMIC.SG_ACCESO
(EM_CODIGO, SU_CODIGO, SA_LOGIN)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- ROL_USUARIO_FK  (Index) 
--
CREATE INDEX DINAMIC.ROL_USUARIO_FK ON DINAMIC.SG_ACCESO
(RS_NOMBRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SG_ACCESO  (Synonym) 
--
CREATE PUBLIC SYNONYM SG_ACCESO FOR DINAMIC.SG_ACCESO;


--
-- PR_SUCUR  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_SUCUR FOR DINAMIC.PR_SUCUR;


--
-- PR_PARAM  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_PARAM FOR DINAMIC.PR_PARAM;


--
-- PR_EMPRE  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_EMPRE FOR DINAMIC.PR_EMPRE;


--
-- PR_CIUDAD  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_CIUDAD FOR DINAMIC.PR_CIUDAD;


--
-- PR_CANTON  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_CANTON FOR DINAMIC.PR_CANTON;


--
-- PD_ORDMPD  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_ORDMPD FOR DINAMIC.PD_ORDMPD;


--
-- PD_ORDMOD  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_ORDMOD FOR DINAMIC.PD_ORDMOD;


--
-- PD_ORDCIF  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_ORDCIF FOR DINAMIC.PD_ORDCIF;


--
-- PD_DETRTA  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_DETRTA FOR DINAMIC.PD_DETRTA;


--
-- PD_DETREQ  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_DETREQ FOR DINAMIC.PD_DETREQ;


--
-- PD_DETPED  (Synonym) 
--
CREATE PUBLIC SYNONYM PD_DETPED FOR DINAMIC.PD_DETPED;


--
-- NO_RUBCAL  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_RUBCAL FOR DINAMIC.NO_RUBCAL;


--
-- NO_CARFAM  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_CARFAM FOR DINAMIC.NO_CARFAM;


--
-- IN_EQUIVALENCIA  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_EQUIVALENCIA FOR DINAMIC.IN_EQUIVALENCIA;


--
-- CO_DETREP  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_DETREP FOR DINAMIC.CO_DETREP;


--
-- CB_DETTAR  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_DETTAR FOR DINAMIC.CB_DETTAR;


--
-- CO_ESTCTA  (Table) 
--
CREATE TABLE DINAMIC.CO_ESTCTA
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EC_LONTOT    NUMBER                           NOT NULL,
  EC_NIVCTA    NUMBER                           NOT NULL,
  EC_AUXILIAR  CHAR(1 BYTE)                     NOT NULL,
  ESTADO       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_PLACTA  (Table) 
--
CREATE TABLE DINAMIC.CO_PLACTA
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PL_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PL_PADRE      VARCHAR2(20 BYTE),
  PL_MAYOR      CHAR(1 BYTE)                    NOT NULL,
  PL_SALINI     NUMBER(14,2)                    NOT NULL,
  PL_SALDEB     NUMBER(14,2)                    NOT NULL,
  PL_SALCRE     NUMBER(14,2)                    NOT NULL,
  PL_SALDO      NUMBER(14,2)                    NOT NULL,
  PL_CENCOS     CHAR(1 BYTE)                    NOT NULL,
  PL_NOMBRE     VARCHAR2(100 BYTE)              NOT NULL,
  PL_CONSOLIDA  CHAR(1 BYTE)                    NOT NULL,
  PL_VIGENTE    VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_PLANSUC  (Table) 
--
CREATE TABLE DINAMIC.CO_PLANSUC
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PL_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PS_SALINI   NUMBER(14,2)                      NOT NULL,
  PS_DEBITO   NUMBER(14,2)                      NOT NULL,
  PS_CREDIT   NUMBER(14,2)                      NOT NULL,
  PS_SALDO    NUMBER(14,2),
  PS_VIGENTE  CHAR(1 BYTE)                      NOT NULL,
  PS_FECVIG   DATE                              NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_SALCTA  (Table) 
--
CREATE TABLE DINAMIC.CO_SALCTA
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SC_MES     NUMBER(38)                         NOT NULL,
  SC_ANIO    NUMBER(38)                         NOT NULL,
  SC_SALINI  NUMBER(14,2)                       NOT NULL,
  SC_SALDEB  NUMBER(14,2)                       NOT NULL,
  SC_SALCRE  NUMBER(14,2)                       NOT NULL,
  SC_SALFIN  NUMBER(14,2)                       NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_TIPCOM  (Table) 
--
CREATE TABLE DINAMIC.CO_TIPCOM
(
  TI_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TI_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  TI_SIGLA   CHAR(3 BYTE)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CP_TIPMOV  (Table) 
--
CREATE TABLE DINAMIC.CP_TIPMOV
(
  TV_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TV_TIPO    CHAR(1 BYTE)                       NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TV_DEXCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_CLIEN  (Table) 
--
CREATE TABLE DINAMIC.FA_CLIEN
(
  CE_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CA_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PA_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EP_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  TC_CODIGO     VARCHAR2(20 BYTE),
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CE_TIPO       CHAR(1 BYTE),
  CE_NOMBRE     VARCHAR2(80 BYTE),
  CE_APELLI     VARCHAR2(80 BYTE),
  CE_RAZONS     VARCHAR2(80 BYTE),
  CE_RUCIC      VARCHAR2(13 BYTE)               NOT NULL,
  CE_NOMREP     VARCHAR2(25 BYTE),
  CE_APEREP     VARCHAR2(25 BYTE),
  CE_CADOM1     VARCHAR2(80 BYTE),
  CE_CADOM2     VARCHAR2(80 BYTE),
  CE_SECDOM     VARCHAR2(80 BYTE),
  CE_CAOFI1     VARCHAR2(80 BYTE),
  CE_CAOF2      VARCHAR2(80 BYTE),
  CE_SECOFI     VARCHAR2(80 BYTE),
  CE_CAENT1     VARCHAR2(80 BYTE),
  CE_CAENT2     VARCHAR2(80 BYTE),
  CE_SECENT     VARCHAR2(80 BYTE),
  CE_TELDOM     VARCHAR2(9 BYTE),
  CE_TELOFI     VARCHAR2(9 BYTE),
  CE_TELBOD     VARCHAR2(9 BYTE),
  CE_FAX        VARCHAR2(9 BYTE),
  CE_EMAIL      VARCHAR2(50 BYTE),
  CE_CUPCRE     NUMBER(14,2),
  CE_CONTESP    CHAR(1 BYTE),
  CE_EXIVA      CHAR(1 BYTE),
  CE_HOBBY      VARCHAR2(50 BYTE),
  CE_PESO       NUMBER(12,3),
  CE_ESTATU     VARCHAR2(8 BYTE),
  CE_FECNAC     DATE,
  CE_UBIGEO     VARCHAR2(50 BYTE),
  CE_FIRMA      VARCHAR2(50 BYTE),
  CE_PLAZO      NUMBER,
  CE_ESTCRE     VARCHAR2(1 BYTE),
  CE_FACTURAR   VARCHAR2(1 BYTE),
  CE_PAGADOR    VARCHAR2(50 BYTE),
  CE_DIASPAGO   VARCHAR2(50 BYTE),
  CE_ACTIVIDAD  VARCHAR2(20 BYTE),
  CE_REFBOD     VARCHAR2(50 BYTE),
  CE_HORBOD     VARCHAR2(50 BYTE),
  CE_HOROFI     VARCHAR2(50 BYTE),
  CE_SALCRE     NUMBER(14,2),
  ESTADO        VARCHAR2(1 BYTE),
  CE_FECHA      DATE,
  CE_ACTIVO     CHAR(1 BYTE),
  SU_CODIGO     VARCHAR2(20 BYTE),
  CE_CAMBVEN    VARCHAR2(1 BYTE),
  CT_CODIGO     VARCHAR2(20 BYTE),
  PO_CODIGO     VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_CTACLI  (Table) 
--
CREATE TABLE DINAMIC.FA_CTACLI
(
  IF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CS_NUMERO  VARCHAR2(20 BYTE)                  NOT NULL,
  CE_CODIGO  VARCHAR2(20 BYTE),
  CS_VALCHE  NUMBER(14,2)                       NOT NULL,
  CS_VALPRO  NUMBER(14,2)                       NOT NULL,
  CS_NUMCHE  NUMBER(38)                         NOT NULL,
  CS_NUMPRO  NUMBER(38)                         NOT NULL,
  CS_ESTADO  CHAR(1 BYTE)                       NOT NULL,
  ESTADO     CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_FORMPAG  (Table) 
--
CREATE TABLE DINAMIC.FA_FORMPAG
(
  FP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  FP_DESCRI    VARCHAR2(50 BYTE)                NOT NULL,
  FP_STRING    VARCHAR2(8 BYTE)                 NOT NULL,
  FP_UTILIZA   VARCHAR2(8 BYTE)                 NOT NULL,
  FP_MINIMO    NUMBER(14,2)                     NOT NULL,
  FP_MAXIMO    NUMBER(14,2)                     NOT NULL,
  FP_COMISION  NUMBER(6,3)                      NOT NULL,
  FP_INTERES   NUMBER(8,5)                      NOT NULL,
  FP_PLAZO     FLOAT(126),
  FP_DESCUE    CHAR(1 BYTE),
  FP_ACUMULA   VARCHAR2(20 BYTE),
  FP_DESCORTA  VARCHAR2(19 BYTE),
  FP_NUMPAG    NUMBER(10),
  ESTADO       VARCHAR2(1 BYTE),
  PL_CODIGO    VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_TIPMOVCA  (Table) 
--
CREATE TABLE DINAMIC.FA_TIPMOVCA
(
  TJ_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TJ_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  TJ_SIGLA   CHAR(3 BYTE)                       NOT NULL,
  TJ_IOE     CHAR(1 BYTE)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_BODE  (Table) 
--
CREATE TABLE DINAMIC.IN_BODE
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  BO_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  BO_NOMBRE    VARCHAR2(50 BYTE)                NOT NULL,
  BO_NOMREP    VARCHAR2(25 BYTE)                NOT NULL,
  BO_APEREP    VARCHAR2(25 BYTE)                NOT NULL,
  BO_CALLE1    VARCHAR2(50 BYTE)                NOT NULL,
  BO_CALLE2    VARCHAR2(50 BYTE),
  BO_TRANSFER  NUMBER(14,2),
  BO_RECEP     NUMBER(14,2),
  ESTADO       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_CABPREP  (Table) 
--
CREATE TABLE DINAMIC.IN_CABPREP
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  BO_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PR_NUMERO   VARCHAR2(20 BYTE)                 NOT NULL,
  PR_FECHA    DATE                              NOT NULL,
  PR_OBSERVA  VARCHAR2(80 BYTE),
  ESTADO      VARCHAR2(1 BYTE),
  PR_CONTAB   CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_CLASE  (Table) 
--
CREATE TABLE DINAMIC.IN_CLASE
(
  CL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CL_CODPAD  VARCHAR2(20 BYTE),
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE),
  CL_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_FABRICANTE  (Table) 
--
CREATE TABLE DINAMIC.IN_FABRICANTE
(
  FB_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  FB_NOMBRE  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_HTLABELS  (Table) 
--
CREATE TABLE DINAMIC.IN_HTLABELS
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  LH_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  LH_DESCRI   VARCHAR2(50 BYTE)                 NOT NULL,
  LH_VIGENTE  CHAR(1 BYTE)                      NOT NULL,
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_MARCA  (Table) 
--
CREATE TABLE DINAMIC.IN_MARCA
(
  MA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MA_DESCRI  VARCHAR2(40 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_PROVE  (Table) 
--
CREATE TABLE DINAMIC.IN_PROVE
(
  PV_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PA_CODIGO   VARCHAR2(20 BYTE),
  CU_CODIGO   VARCHAR2(20 BYTE),
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PV_TIPO     CHAR(1 BYTE)                      NOT NULL,
  PV_RAZONS   VARCHAR2(50 BYTE),
  PV_NOMREP   VARCHAR2(25 BYTE),
  PV_APEREP   VARCHAR2(25 BYTE),
  PV_NOMBRE   VARCHAR2(25 BYTE),
  PV_APELLI   VARCHAR2(25 BYTE),
  PV_CARACT   CHAR(1 BYTE)                      NOT NULL,
  PV_CALLE1   VARCHAR2(50 BYTE)                 NOT NULL,
  PV_CALLE2   VARCHAR2(50 BYTE),
  PV_CA1BOD   VARCHAR2(50 BYTE),
  PV_CA2BOD   VARCHAR2(50 BYTE),
  PV_TELEF1   VARCHAR2(9 BYTE)                  NOT NULL,
  PV_TELEF2   VARCHAR2(9 BYTE),
  PV_FAX      VARCHAR2(9 BYTE),
  PV_EMAIL    VARCHAR2(50 BYTE),
  PV_NOMGER   VARCHAR2(25 BYTE),
  PV_APEGER   VARCHAR2(25 BYTE),
  PV_FECING   DATE,
  PV_HORARIO  VARCHAR2(20 BYTE),
  PV_RUCCI    VARCHAR2(14 BYTE)                 NOT NULL,
  PV_OBSERV   VARCHAR2(100 BYTE),
  ESTADO      VARCHAR2(1 BYTE),
  PV_TIPCAN   CHAR(1 BYTE),
  PV_TIPCTA   CHAR(2 BYTE),
  PV_NUMCTA   VARCHAR2(15 BYTE),
  PV_BENEFIC  VARCHAR2(40 BYTE),
  PV_ACTIVO   CHAR(1 BYTE),
  PV_CONTESP  CHAR(1 BYTE),
  RF_CODIGO   VARCHAR2(20 BYTE),
  RF_CODIGO2  VARCHAR2(20 BYTE),
  PV_SERV     CHAR(1 BYTE),
  FP_CODIGO   VARCHAR2(20 BYTE),
  PV_ORIGEN   VARCHAR2(1 BYTE),
  GT_CODIGO   VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_TIMOV  (Table) 
--
CREATE TABLE DINAMIC.IN_TIMOV
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TM_IOE     CHAR(1 BYTE)                       NOT NULL,
  TM_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  TM_SIGLA   CHAR(3 BYTE)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_TIPPRE  (Table) 
--
CREATE TABLE DINAMIC.IN_TIPPRE
(
  TD_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TD_DESCRI   VARCHAR2(50 BYTE)                 NOT NULL,
  TD_DESC1    NUMBER(7,2)                       NOT NULL,
  TD_DESC2    NUMBER(7,2)                       NOT NULL,
  TD_DESC3    NUMBER(7,2)                       NOT NULL,
  TD_VIGENTE  CHAR(1 BYTE)                      NOT NULL,
  TD_MODULO   CHAR(5 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_CRUCE  (Table) 
--
CREATE TABLE DINAMIC.CB_CRUCE
(
  CT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DT_SECUE   VARCHAR2(20 BYTE)                  NOT NULL,
  BT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CB_VALCRE  NUMBER(9,2),
  CB_FECHA   DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_CTAINS  (Table) 
--
CREATE TABLE DINAMIC.CB_CTAINS
(
  IF_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CN_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PL_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CN_NUMERO   VARCHAR2(20 BYTE)                 NOT NULL,
  CN_DESCRI   VARCHAR2(50 BYTE),
  CN_SUCUR    VARCHAR2(50 BYTE)                 NOT NULL,
  CN_NOMEJEC  VARCHAR2(25 BYTE),
  CN_APEEJEC  VARCHAR2(25 BYTE),
  CN_FECINI   DATE                              NOT NULL,
  CN_ACTIVA   CHAR(1 BYTE)                      NOT NULL,
  CN_SALDO    NUMBER(14,2),
  CN_SALINI   NUMBER(14,2),
  CN_NUMCHE   NUMBER(20),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_EGRESO  (Table) 
--
CREATE TABLE DINAMIC.CB_EGRESO
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EG_NUMERO    VARCHAR2(20 BYTE)                NOT NULL,
  IF_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  CN_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EG_FECHA     DATE                             NOT NULL,
  EG_VALOR     NUMBER(14,2)                     NOT NULL,
  EG_BASIMP    NUMBER(14,2)                     NOT NULL,
  EG_VALRET    NUMBER(14,2)                     NOT NULL,
  EG_OBSERV    VARCHAR2(2000 BYTE),
  TN_CODIGO    VARCHAR2(20 BYTE),
  EG_VALLET    VARCHAR2(130 BYTE)               NOT NULL,
  EG_NUMCHE    VARCHAR2(50 BYTE),
  EG_FECANU    DATE,
  EG_CONCILIA  CHAR(1 BYTE),
  EG_DEBITO    NUMBER(14,2)                     NOT NULL,
  EG_CREDITO   NUMBER(14,2)                     NOT NULL,
  RF_CODIGO    VARCHAR2(20 BYTE),
  EG_ORDENDE   VARCHAR2(80 BYTE),
  EG_ND        CHAR(1 BYTE),
  EG_TOTFAC    NUMBER(14,2),
  EG_DSCTO     NUMBER(14,2),
  EG_ANULADO   VARCHAR2(50 BYTE),
  EG_RUCCI     VARCHAR2(20 BYTE),
  EG_CARGO     NUMBER(14,2),
  EG_FECEGR    DATE,
  ESTADO       VARCHAR2(1 BYTE),
  EG_CONTAB    CHAR(1 BYTE),
  CP_NUMERO    NUMBER(38),
  SA_LOGIN     VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_INGRESO  (Table) 
--
CREATE TABLE DINAMIC.CB_INGRESO
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  IG_NUMERO    VARCHAR2(20 BYTE)                NOT NULL,
  IF_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  CN_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  RF_CODIGO    VARCHAR2(20 BYTE),
  TN_CODIGO    VARCHAR2(20 BYTE),
  IG_FECHA     DATE                             NOT NULL,
  IG_VALOR     NUMBER(14,2)                     NOT NULL,
  IG_VALRET    NUMBER(14,2),
  IG_VALTOT    NUMBER(14,2)                     NOT NULL,
  IG_DEPOSIT   VARCHAR2(20 BYTE),
  IG_CONCILIA  CHAR(1 BYTE),
  IG_OBSERV    VARCHAR2(80 BYTE),
  ESTADO       VARCHAR2(1 BYTE),
  IG_NUMING    VARCHAR2(20 BYTE),
  IG_CONTAB    CHAR(1 BYTE),
  IG_NC        CHAR(1 BYTE),
  SA_LOGIN     VARCHAR2(20 BYTE),
  IG_ANULADO   CHAR(1 BYTE),
  IG_FECANU    DATE,
  CP_NUMERO    VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_TIPO  (Table) 
--
CREATE TABLE DINAMIC.CC_TIPO
(
  TT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TT_IOE      CHAR(1 BYTE)                      NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TT_DESCRI   VARCHAR2(40 BYTE)                 NOT NULL,
  TT_AUTOMAT  CHAR(1 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_CABCOM  (Table) 
--
CREATE TABLE DINAMIC.CO_CABCOM
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TI_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CP_NUMERO   NUMBER(38)                        NOT NULL,
  CP_FECHA    DATE                              NOT NULL,
  CP_SALDO    NUMBER(14,2)                      NOT NULL,
  CP_DEBITO   NUMBER(14,2)                      NOT NULL,
  CP_CREDITO  NUMBER(14,2)                      NOT NULL,
  CP_OBSERV   VARCHAR2(80 BYTE),
  CP_MAYOR    CHAR(1 BYTE)                      NOT NULL,
  CP_NUMCOMP  VARCHAR2(20 BYTE),
  CP_PREIMP   VARCHAR2(20 BYTE),
  CP_DOCBAN   VARCHAR2(20 BYTE),
  SA_LOGIN    VARCHAR2(20 BYTE),
  CP_ANULADO  CHAR(1 BYTE),
  CP_FECANU   DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_CENCOS  (Table) 
--
CREATE TABLE DINAMIC.CO_CENCOS
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CS_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CS_DESCRI  VARCHAR2(20 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_COMAUT  (Table) 
--
CREATE TABLE DINAMIC.CO_COMAUT
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_COLUM   VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CT_DEBCRE  CHAR(1 BYTE)                       NOT NULL,
  CT_DESCRI  VARCHAR2(30 BYTE),
  ESTADO     VARCHAR2(20 BYTE),
  CS_CODIGO  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_DETCOM  (Table) 
--
CREATE TABLE DINAMIC.CO_DETCOM
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TI_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CP_NUMERO   NUMBER(38)                        NOT NULL,
  PL_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CS_CODIGO   VARCHAR2(20 BYTE),
  DT_SECUE    VARCHAR2(20 BYTE)                 NOT NULL,
  DT_SIGNO    CHAR(1 BYTE)                      NOT NULL,
  DT_VALOR    NUMBER(14,2)                      NOT NULL,
  DT_DETALLE  VARCHAR2(500 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_PLANIFF  (Table) 
--
CREATE TABLE DINAMIC.CO_PLANIFF
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PI_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PI_PADRE      VARCHAR2(20 BYTE),
  PI_MAYOR      CHAR(1 BYTE),
  PI_SALINI     NUMBER(14,2),
  PI_SALDEB     NUMBER(14,2),
  PI_SALCRE     NUMBER(14,2),
  PI_SALDO      NUMBER(14,2),
  PI_CENCOS     CHAR(1 BYTE),
  PI_NOMBRE     VARCHAR2(100 BYTE),
  PI_CONSOLIDA  CHAR(1 BYTE),
  PI_VIGENTE    VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_CABNIFF  (Table) 
--
CREATE TABLE DINAMIC.CO_CABNIFF
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TI_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CI_NUMERO   NUMBER(38)                        NOT NULL,
  CI_FECHA    DATE                              NOT NULL,
  CI_SALDO    NUMBER(14,2)                      NOT NULL,
  CI_DEBITO   NUMBER(14,2)                      NOT NULL,
  CI_CREDITO  NUMBER(14,2)                      NOT NULL,
  CI_OBSERV   VARCHAR2(80 BYTE),
  CI_MAYOR    CHAR(1 BYTE)                      NOT NULL,
  CI_NUMCOMP  VARCHAR2(20 BYTE),
  CI_PREIMP   VARCHAR2(20 BYTE),
  CI_DOCBAN   VARCHAR2(20 BYTE),
  SA_LOGIN    VARCHAR2(20 BYTE),
  CI_ANULADO  CHAR(1 BYTE),
  CI_FECANU   DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CO_DETNIFF  (Table) 
--
CREATE TABLE DINAMIC.CO_DETNIFF
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TI_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CI_NUMERO   NUMBER(38)                        NOT NULL,
  PI_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CS_CODIGO   VARCHAR2(20 BYTE),
  DI_SECUE    VARCHAR2(20 BYTE)                 NOT NULL,
  DI_SIGNO    CHAR(1 BYTE)                      NOT NULL,
  DI_VALOR    NUMBER(14,2)                      NOT NULL,
  DI_DETALLE  VARCHAR2(500 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_TOMFIS  (Table) 
--
CREATE TABLE DINAMIC.IN_TOMFIS
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  BO_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TS_NUMERO   VARCHAR2(20 BYTE)                 NOT NULL,
  TS_FECHA    DATE                              NOT NULL,
  TS_PROCESO  CHAR(1 BYTE)                      NOT NULL,
  TS_OBSERV   VARCHAR2(30 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_VENPRO  (Table) 
--
CREATE TABLE DINAMIC.IN_VENPRO
(
  PV_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  VP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  VP_NOMVP   VARCHAR2(25 BYTE)                  NOT NULL,
  VP_APEVP   VARCHAR2(25 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_DEPARTA  (Table) 
--
CREATE TABLE DINAMIC.NO_DEPARTA
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DT_DESCRI  VARCHAR2(20 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_EMPLE  (Table) 
--
CREATE TABLE DINAMIC.NO_EMPLE
(
  EP_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PA_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CU_CODIGO     VARCHAR2(20 BYTE),
  CR_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EP_CODJEF     VARCHAR2(20 BYTE),
  EM_CODIGO     VARCHAR2(20 BYTE),
  SU_CODIGO     VARCHAR2(20 BYTE),
  DT_CODIGO     VARCHAR2(20 BYTE),
  BO_CODIGO     VARCHAR2(20 BYTE),
  SA_LOGIN      VARCHAR2(20 BYTE),
  EP_NOMBRE     VARCHAR2(25 BYTE)               NOT NULL,
  EP_APEPAT     VARCHAR2(25 BYTE)               NOT NULL,
  EP_APEMAT     VARCHAR2(25 BYTE),
  EP_FECNAC     DATE                            NOT NULL,
  EP_CI         VARCHAR2(11 BYTE)               NOT NULL,
  EP_CEDMIL     VARCHAR2(12 BYTE),
  EP_NUMAFIL    VARCHAR2(15 BYTE),
  EP_NUMCAR     NUMBER,
  EP_SEXO       CHAR(1 BYTE)                    NOT NULL,
  EP_CALLE1     VARCHAR2(50 BYTE)               NOT NULL,
  EP_CALLE2     VARCHAR2(50 BYTE),
  EP_TELEF      VARCHAR2(9 BYTE),
  EP_CONYU      VARCHAR2(25 BYTE),
  EP_TIPSAN     VARCHAR2(5 BYTE),
  EP_INSTRUC    CHAR(1 BYTE)                    NOT NULL,
  EP_TITULO     VARCHAR2(50 BYTE),
  EP_ANIOS      NUMBER,
  EP_SUELDO     NUMBER(14,2)                    NOT NULL,
  EP_COMISION   NUMBER(7,2),
  EP_NONOM      CHAR(1 BYTE),
  EP_VALQUI     NUMBER(14,2)                    NOT NULL,
  EP_FECENT     DATE                            NOT NULL,
  EP_FECSAL     DATE,
  EP_SALUDO     VARCHAR2(25 BYTE),
  EP_IMAGEN     VARCHAR2(80 BYTE),
  EP_HORENT     DATE,
  EP_HORSAL     DATE,
  EP_CLAVNOM    VARCHAR2(30 BYTE),
  EP_FECAFI     DATE,
  ESTADO        VARCHAR2(1 BYTE),
  EP_CTABCO     VARCHAR2(12 BYTE),
  EP_CODSEC     VARCHAR2(20 BYTE),
  EP_EMAIL      VARCHAR2(50 BYTE),
  PO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CS_CODIGO     VARCHAR2(20 BYTE),
  EP_ESTCIVIL   VARCHAR2(1 BYTE),
  EP_CONTRATO   VARCHAR2(1 BYTE),
  EP_BNFSOCIAL  VARCHAR2(1 BYTE),
  EP_CELULAR    VARCHAR2(9 BYTE),
  EP_IESS       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_FALTA  (Table) 
--
CREATE TABLE DINAMIC.NO_FALTA
(
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PE_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PE_TIPO    CHAR(1 BYTE)                       NOT NULL,
  PE_FECHA   DATE                               NOT NULL,
  PE_CAUSA   VARCHAR2(80 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_PRESTAMO  (Table) 
--
CREATE TABLE DINAMIC.NO_PRESTAMO
(
  EP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  PP_NUMERO    VARCHAR2(20 BYTE)                NOT NULL,
  RU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  PP_FECHA     DATE                             NOT NULL,
  PP_CUOTAS    NUMBER(38)                       NOT NULL,
  PP_VALOR     NUMBER(14,2)                     NOT NULL,
  PP_SALDO     NUMBER(14,2)                     NOT NULL,
  PP_INTERES   NUMBER(14,2),
  TP_CODIGO    VARCHAR2(20 BYTE),
  PP_ESTADO    CHAR(10 BYTE)                    NOT NULL,
  PP_OBSERV    VARCHAR2(50 BYTE),
  ESTADO       VARCHAR2(1 BYTE),
  PP_PAGADO    CHAR(1 BYTE),
  PP_NROGUIA   NUMBER(14,2),
  PP_FECENVIO  DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_VACACION  (Table) 
--
CREATE TABLE DINAMIC.NO_VACACION
(
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  VA_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  VA_FECSAL  DATE                               NOT NULL,
  VA_FECING  DATE                               NOT NULL,
  VA_SALIO   CHAR(1 BYTE),
  VA_OBSERV  VARCHAR2(80 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_COLOR  (Table) 
--
CREATE TABLE DINAMIC.PR_COLOR
(
  CO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CO_DESCRI  VARCHAR2(50 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PR_NUMTRANS  (Table) 
--
CREATE TABLE DINAMIC.PR_NUMTRANS
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODENV    VARCHAR2(20 BYTE)                NOT NULL,
  BO_CODENV    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  BO_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  NT_NUMERO    NUMBER(38),
  NT_NUMRECEP  FLOAT(126),
  ESTADO       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TS_INGRESO  (Table) 
--
CREATE TABLE DINAMIC.TS_INGRESO
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TE_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  ES_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TE_FECHA   DATE                               NOT NULL,
  TE_NOMBRE  VARCHAR2(60 BYTE)                  NOT NULL,
  TE_CONCEP  VARCHAR2(80 BYTE)                  NOT NULL,
  TE_TOTAL   NUMBER(14,2)                       NOT NULL,
  TE_PROCE   CHAR(1 BYTE),
  ESTADO     VARCHAR2(10 BYTE),
  TE_CONTAB  CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_CTACLI  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_CTACLI ON DINAMIC.FA_CTACLI
(IF_CODIGO, CS_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CLIENTE_CTASCOR_FK  (Index) 
--
CREATE INDEX DINAMIC.CLIENTE_CTASCOR_FK ON DINAMIC.FA_CTACLI
(CE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_CRUCE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_CRUCE ON DINAMIC.CB_CRUCE
(CT_CODIGO, EM_CODIGO, DT_SECUE, BT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_CTAINS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_CTAINS ON DINAMIC.CB_CTAINS
(IF_CODIGO, CN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SUCURSAL_CUENTA_INS_FK  (Index) 
--
CREATE INDEX DINAMIC.SUCURSAL_CUENTA_INS_FK ON DINAMIC.CB_CTAINS
(EM_CODIGO, SU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_CTA_INST_FINAN_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_CTA_INST_FINAN_FK ON DINAMIC.CB_CTAINS
(EM_CODIGO, SU_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CTA_INST_FINAN_EGRESO_FK  (Index) 
--
CREATE INDEX DINAMIC.CTA_INST_FINAN_EGRESO_FK ON DINAMIC.CB_EGRESO
(IF_CODIGO, CN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CONCEPTO_EGRESO_FK  (Index) 
--
CREATE INDEX DINAMIC.CONCEPTO_EGRESO_FK ON DINAMIC.CB_EGRESO
(TN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RETENCION_EGRESO_FK  (Index) 
--
CREATE INDEX DINAMIC.RETENCION_EGRESO_FK ON DINAMIC.CB_EGRESO
(RF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_EGRESOS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_EGRESOS ON DINAMIC.CB_EGRESO
(EM_CODIGO, SU_CODIGO, EG_NUMERO, EG_ND)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_EGRESO  (Index) 
--
CREATE INDEX DINAMIC.PK_CB_EGRESO ON DINAMIC.CB_EGRESO
(EM_CODIGO, SU_CODIGO, EG_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_INGRESO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_INGRESO ON DINAMIC.CB_INGRESO
(EM_CODIGO, SU_CODIGO, IG_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_INST_INGRESO_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_INST_INGRESO_FK ON DINAMIC.CB_INGRESO
(IF_CODIGO, CN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATION_41159_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATION_41159_FK ON DINAMIC.CB_INGRESO
(RF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CONCEPTO_INGRESO_FK  (Index) 
--
CREATE INDEX DINAMIC.CONCEPTO_INGRESO_FK ON DINAMIC.CB_INGRESO
(TN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- DEPOSITO_DUP_IDX  (Index) 
--
CREATE INDEX DINAMIC.DEPOSITO_DUP_IDX ON DINAMIC.CB_INGRESO
(EM_CODIGO, IG_DEPOSIT)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CC_TIPO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CC_TIPO ON DINAMIC.CC_TIPO
(TT_CODIGO, TT_IOE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_TIPO_MOV_CXC_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_TIPO_MOV_CXC_FK ON DINAMIC.CC_TIPO
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_CABCOM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_CABCOM ON DINAMIC.CO_CABCOM
(EM_CODIGO, SU_CODIGO, TI_CODIGO, CP_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IDX_FECHA  (Index) 
--
CREATE INDEX DINAMIC.IDX_FECHA ON DINAMIC.CO_CABCOM
(CP_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_CENCOS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_CENCOS ON DINAMIC.CO_CENCOS
(EM_CODIGO, CS_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_COMAUT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_COMAUT ON DINAMIC.CO_COMAUT
(EM_CODIGO, SU_CODIGO, CT_CODIGO, CT_COLUM, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_DETCOM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_DETCOM ON DINAMIC.CO_DETCOM
(EM_CODIGO, SU_CODIGO, TI_CODIGO, CP_NUMERO, PL_CODIGO, 
DT_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          832K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CENTRO_COSTOS_DETALLE_FK  (Index) 
--
CREATE INDEX DINAMIC.CENTRO_COSTOS_DETALLE_FK ON DINAMIC.CO_DETCOM
(CS_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IDX_SALDOINI  (Index) 
--
CREATE INDEX DINAMIC.IDX_SALDOINI ON DINAMIC.CO_DETCOM
(EM_CODIGO, SU_CODIGO, PL_CODIGO, CS_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          640K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_ESTCTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_ESTCTA ON DINAMIC.CO_ESTCTA
(EM_CODIGO, EC_LONTOT)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_PLACTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_PLACTA ON DINAMIC.CO_PLACTA
(EM_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PLAN_CUENTAS_HIJOS_FK  (Index) 
--
CREATE INDEX DINAMIC.PLAN_CUENTAS_HIJOS_FK ON DINAMIC.CO_PLACTA
(EM_CODIGO, PL_PADRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_PLANSUC  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_PLANSUC ON DINAMIC.CO_PLANSUC
(EM_CODIGO, SU_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_SALCTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_SALCTA ON DINAMIC.CO_SALCTA
(EM_CODIGO, SU_CODIGO, PL_CODIGO, SC_MES, SC_ANIO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CO_TIPCOM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CO_TIPCOM ON DINAMIC.CO_TIPCOM
(TI_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_TIPO_COMPROB_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_TIPO_COMPROB_FK ON DINAMIC.CO_TIPCOM
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CP_TIPMOV  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CP_TIPMOV ON DINAMIC.CP_TIPMOV
(TV_CODIGO, TV_TIPO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_TIPO_MOV_CXP_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_TIPO_MOV_CXP_FK ON DINAMIC.CP_TIPMOV
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_CLIEN  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_CLIEN ON DINAMIC.FA_CLIEN
(CE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CLASE_CLIENTE_FK  (Index) 
--
CREATE INDEX DINAMIC.CLASE_CLIENTE_FK ON DINAMIC.FA_CLIEN
(CA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CIUDAD_CLIENTE_FK  (Index) 
--
CREATE INDEX DINAMIC.CIUDAD_CLIENTE_FK ON DINAMIC.FA_CLIEN
(PA_CODIGO, CU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_CLIENTE_IDX  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_CLIENTE_IDX ON DINAMIC.FA_CLIEN
(EM_CODIGO, EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TIPO_CLIENTE_FK  (Index) 
--
CREATE INDEX DINAMIC.TIPO_CLIENTE_FK ON DINAMIC.FA_CLIEN
(TC_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- UK_RUCCI  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.UK_RUCCI ON DINAMIC.FA_CLIEN
(CE_RUCIC)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_FORMPAG  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_FORMPAG ON DINAMIC.FA_FORMPAG
(FP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_FORMAS_PAGO_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_FORMAS_PAGO_FK ON DINAMIC.FA_FORMPAG
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_TIPMOVCA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_TIPMOVCA ON DINAMIC.FA_TIPMOVCA
(TJ_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_TIPO_MOV_CAJA_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_TIPO_MOV_CAJA_FK ON DINAMIC.FA_TIPMOVCA
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_BODE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_BODE ON DINAMIC.IN_BODE
(EM_CODIGO, SU_CODIGO, BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_CABPREP  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_CABPREP ON DINAMIC.IN_CABPREP
(EM_CODIGO, SU_CODIGO, BO_CODIGO, PR_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_CLASE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_CLASE ON DINAMIC.IN_CLASE
(CL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CLASE_CLASE_FK  (Index) 
--
CREATE INDEX DINAMIC.CLASE_CLASE_FK ON DINAMIC.IN_CLASE
(CL_CODPAD)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_CLASES_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_CLASES_FK ON DINAMIC.IN_CLASE
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PLAN_CTAS_CLASE_FK  (Index) 
--
CREATE INDEX DINAMIC.PLAN_CTAS_CLASE_FK ON DINAMIC.IN_CLASE
(EM_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_FABRICANTE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_FABRICANTE ON DINAMIC.IN_FABRICANTE
(FB_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_FABRICANTE_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_FABRICANTE_FK ON DINAMIC.IN_FABRICANTE
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_HTLABELS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_HTLABELS ON DINAMIC.IN_HTLABELS
(EM_CODIGO, LH_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_MARCA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_MARCA ON DINAMIC.IN_MARCA
(MA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_PROVE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_PROVE ON DINAMIC.IN_PROVE
(PV_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_PROVEEDOR_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_PROVEEDOR_FK ON DINAMIC.IN_PROVE
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CIUDAD_PROVEEDOR_FK  (Index) 
--
CREATE INDEX DINAMIC.CIUDAD_PROVEEDOR_FK ON DINAMIC.IN_PROVE
(PA_CODIGO, CU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- UK_RUCCI_PROVE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.UK_RUCCI_PROVE ON DINAMIC.IN_PROVE
(PV_RUCCI)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_TIMOV  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_TIMOV ON DINAMIC.IN_TIMOV
(EM_CODIGO, TM_CODIGO, TM_IOE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_TIPPRE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_TIPPRE ON DINAMIC.IN_TIPPRE
(TD_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_TIPO_DESCUENTO_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_TIPO_DESCUENTO_FK ON DINAMIC.IN_TIPPRE
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_TOMFIS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_TOMFIS ON DINAMIC.IN_TOMFIS
(EM_CODIGO, SU_CODIGO, BO_CODIGO, TS_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_VENPRO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_VENPRO ON DINAMIC.IN_VENPRO
(PV_CODIGO, VP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_DEPARTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_DEPARTA ON DINAMIC.NO_DEPARTA
(EM_CODIGO, DT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_EMPLE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_EMPLE ON DINAMIC.NO_EMPLE
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUIDAD_EMPLEADO_FK  (Index) 
--
CREATE INDEX DINAMIC.CUIDAD_EMPLEADO_FK ON DINAMIC.NO_EMPLE
(PA_CODIGO, CU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CARGO_EMPLEADO_FK  (Index) 
--
CREATE INDEX DINAMIC.CARGO_EMPLEADO_FK ON DINAMIC.NO_EMPLE
(CR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_JEFE_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_JEFE_FK ON DINAMIC.NO_EMPLE
(EP_CODJEF)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- DEPARTAMENTO_EMPLEADO_FK  (Index) 
--
CREATE INDEX DINAMIC.DEPARTAMENTO_EMPLEADO_FK ON DINAMIC.NO_EMPLE
(EM_CODIGO, SU_CODIGO, DT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- BODEGA_SECCION_EMPLEADO_FK  (Index) 
--
CREATE INDEX DINAMIC.BODEGA_SECCION_EMPLEADO_FK ON DINAMIC.NO_EMPLE
(BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SEGURIDAD_EMPLEADO_FK  (Index) 
--
CREATE INDEX DINAMIC.SEGURIDAD_EMPLEADO_FK ON DINAMIC.NO_EMPLE
(SA_LOGIN)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_EMPLEADO_IDX  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_EMPLEADO_IDX ON DINAMIC.NO_EMPLE
(EP_CODIGO, EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- UK_CI_EMPLE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.UK_CI_EMPLE ON DINAMIC.NO_EMPLE
(EP_CI)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_FALTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_FALTA ON DINAMIC.NO_FALTA
(EP_CODIGO, PE_CODIGO, PE_TIPO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_PRESTAMO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_PRESTAMO ON DINAMIC.NO_PRESTAMO
(EP_CODIGO, PP_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RUBRO_PRESTAMO_FK  (Index) 
--
CREATE INDEX DINAMIC.RUBRO_PRESTAMO_FK ON DINAMIC.NO_PRESTAMO
(RU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TIPO_PRESTAMO_FK  (Index) 
--
CREATE INDEX DINAMIC.TIPO_PRESTAMO_FK ON DINAMIC.NO_PRESTAMO
(TP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_VACACION  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_VACACION ON DINAMIC.NO_VACACION
(EP_CODIGO, VA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_COLOR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_COLOR ON DINAMIC.PR_COLOR
(CO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPRESA_COLOR_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPRESA_COLOR_FK ON DINAMIC.PR_COLOR
(EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PR_NUMTRANS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PR_NUMTRANS ON DINAMIC.PR_NUMTRANS
(EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_TS_INGRESO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_TS_INGRESO ON DINAMIC.TS_INGRESO
(EM_CODIGO, SU_CODIGO, TE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_PLANNIF  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_PLANNIF ON DINAMIC.CO_PLANIFF
(EM_CODIGO, PI_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CABNIFF  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CABNIFF ON DINAMIC.CO_CABNIFF
(EM_CODIGO, SU_CODIGO, TI_CODIGO, CI_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_DETNIFF  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_DETNIFF ON DINAMIC.CO_DETNIFF
(EM_CODIGO, SU_CODIGO, TI_CODIGO, CI_NUMERO, PI_CODIGO, 
DI_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SP_CAMBIADESUC_ASIENTOS  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.SP_CAMBIADESUC_ASIENTOS (ai_cadena VARCHAR,ao_codigo_error out NUMBER,ao_mensaje_error out VARCHAR) IS

tmpVar NUMBER;
x_actualizar EXCEPTION;

TYPE cur_typ IS REF CURSOR;
c_cursor                     cur_typ;

TYPE T_asientocontable IS RECORD (  em_codigo co_cabcom.em_codigo%TYPE,
                                          su_codigo co_cabcom.su_codigo%TYPE,
                                          cp_numero co_cabcom.cp_numero%TYPE) ;
                                    
r_asiento  T_asientocontable;

v_query                      VARCHAR2 (10000);
-------------------------------------------------------------------------------------------------------------------

BEGIN

  DBMS_APPLICATION_INFO.set_module ('PKG_BAJASNEW', 'PROCESAR_BAJAS_INGRESADAS PRC');

  v_query := ai_cadena;

  OPEN c_cursor FOR v_query;

  LOOP

     FETCH c_cursor INTO r_asiento;

     EXIT WHEN c_cursor%NOTFOUND;
     
            --Cambia de estado de NOTA DE CREDITO a FACTURA
            INSERT INTO CO_CABCOM(
            SELECT
              EM_CODIGO ,
              2,
              TI_CODIGO,
              CP_NUMERO,
              CP_FECHA ,
              CP_SALDO ,
              CP_DEBITO,
              CP_CREDITO,
              CP_OBSERV ,
              CP_MAYOR  ,
              CP_NUMCOMP ,
              CP_PREIMP   ,
              CP_DOCBAN   ,
              SA_LOGIN    ,
              CP_ANULADO  ,
              CP_FECANU   
            FROM CO_CABCOM
            WHERE CP_NUMERO = r_asiento.cp_numero
            AND EM_CODIGO = r_asiento.em_codigo
            AND SU_CODIGO = r_asiento.su_codigo);

            -- Si levanta una excepcion

            UPDATE co_detcom
            SET su_codigo = 2
            WHERE cp_numero = r_asiento.cp_numero
            AND em_codigo = r_asiento.em_codigo
            AND su_codigo = r_asiento.su_codigo;

            IF SQL%NOTFOUND THEN
            RAISE x_actualizar;
            END IF;


            --Eliminar el registro que esta marcado como ANULADO estado = '6'
            DELETE FROM CO_CABCOM
            WHERE  EM_CODIGO = r_asiento.em_codigo
            AND SU_CODIGO = r_asiento.su_codigo
            AND CP_NUMERO = r_asiento.cp_numero;
            IF SQL%NOTFOUND THEN
            RAISE x_actualizar;
            END IF;
  
  END LOOP;

 CLOSE c_cursor;
            
 --COMMIT;     

EXCEPTION
     WHEN NO_DATA_FOUND THEN
          ao_codigo_error := '0';
          ao_mensaje_error := SUBSTR (SQLERRM, 1, 4000);
     WHEN x_actualizar THEN
         ao_codigo_error := '0';
         ao_mensaje_error := SUBSTR (SQLERRM, 1, 4000);
         ROLLBACK;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
          ao_codigo_error := '0';
          ao_mensaje_error := SUBSTR (SQLERRM, 1, 4000);
          ROLLBACK;
       
  
       
END SP_CAMBIADESUC_ASIENTOS;
/


--
-- TS_INGRESO  (Synonym) 
--
CREATE PUBLIC SYNONYM TS_INGRESO FOR DINAMIC.TS_INGRESO;


--
-- PR_NUMTRANS  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_NUMTRANS FOR DINAMIC.PR_NUMTRANS;


--
-- PR_COLOR  (Synonym) 
--
CREATE PUBLIC SYNONYM PR_COLOR FOR DINAMIC.PR_COLOR;


--
-- NO_VACACION  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_VACACION FOR DINAMIC.NO_VACACION;


--
-- NO_PRESTAMO  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_PRESTAMO FOR DINAMIC.NO_PRESTAMO;


--
-- NO_FALTA  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_FALTA FOR DINAMIC.NO_FALTA;


--
-- NO_EMPLE  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_EMPLE FOR DINAMIC.NO_EMPLE;


--
-- NO_DEPARTA  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_DEPARTA FOR DINAMIC.NO_DEPARTA;


--
-- IN_VENPRO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_VENPRO FOR DINAMIC.IN_VENPRO;


--
-- IN_TOMFIS  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_TOMFIS FOR DINAMIC.IN_TOMFIS;


--
-- IN_TIPPRE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_TIPPRE FOR DINAMIC.IN_TIPPRE;


--
-- IN_TIMOV  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_TIMOV FOR DINAMIC.IN_TIMOV;


--
-- IN_PROVE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_PROVE FOR DINAMIC.IN_PROVE;


--
-- IN_MARCA  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_MARCA FOR DINAMIC.IN_MARCA;


--
-- IN_HTLABELS  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_HTLABELS FOR DINAMIC.IN_HTLABELS;


--
-- IN_FABRICANTE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_FABRICANTE FOR DINAMIC.IN_FABRICANTE;


--
-- IN_CLASE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_CLASE FOR DINAMIC.IN_CLASE;


--
-- IN_CABPREP  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_CABPREP FOR DINAMIC.IN_CABPREP;


--
-- IN_BODE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_BODE FOR DINAMIC.IN_BODE;


--
-- FA_TIPMOVCA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_TIPMOVCA FOR DINAMIC.FA_TIPMOVCA;


--
-- FA_FORMPAG  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_FORMPAG FOR DINAMIC.FA_FORMPAG;


--
-- FA_CTACLI  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_CTACLI FOR DINAMIC.FA_CTACLI;


--
-- FA_CLIEN  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_CLIEN FOR DINAMIC.FA_CLIEN;


--
-- CP_TIPMOV  (Synonym) 
--
CREATE PUBLIC SYNONYM CP_TIPMOV FOR DINAMIC.CP_TIPMOV;


--
-- CO_TIPCOM  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_TIPCOM FOR DINAMIC.CO_TIPCOM;


--
-- CO_SALCTA  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_SALCTA FOR DINAMIC.CO_SALCTA;


--
-- CO_PLANSUC  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_PLANSUC FOR DINAMIC.CO_PLANSUC;


--
-- CO_PLANIFF  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_PLANIFF FOR DINAMIC.CO_PLANIFF;


--
-- CO_PLACTA  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_PLACTA FOR DINAMIC.CO_PLACTA;


--
-- CO_ESTCTA  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_ESTCTA FOR DINAMIC.CO_ESTCTA;


--
-- CO_DETNIFF  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_DETNIFF FOR DINAMIC.CO_DETNIFF;


--
-- CO_DETCOM  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_DETCOM FOR DINAMIC.CO_DETCOM;


--
-- CO_COMAUT  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_COMAUT FOR DINAMIC.CO_COMAUT;


--
-- CO_CENCOS  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_CENCOS FOR DINAMIC.CO_CENCOS;


--
-- CO_CABNIFF  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_CABNIFF FOR DINAMIC.CO_CABNIFF;


--
-- CO_CABCOM  (Synonym) 
--
CREATE PUBLIC SYNONYM CO_CABCOM FOR DINAMIC.CO_CABCOM;


--
-- CC_TIPO  (Synonym) 
--
CREATE PUBLIC SYNONYM CC_TIPO FOR DINAMIC.CC_TIPO;


--
-- CB_INGRESO  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_INGRESO FOR DINAMIC.CB_INGRESO;


--
-- CB_EGRESO  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_EGRESO FOR DINAMIC.CB_EGRESO;


--
-- CB_CTAINS  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_CTAINS FOR DINAMIC.CB_CTAINS;


--
-- CB_CRUCE  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_CRUCE FOR DINAMIC.CB_CRUCE;


--
-- CP_MOVIM  (Table) 
--
CREATE TABLE DINAMIC.CP_MOVIM
(
  TV_CODIGO        VARCHAR2(20 BYTE)            NOT NULL,
  TV_TIPO          CHAR(1 BYTE)                 NOT NULL,
  EM_CODIGO        VARCHAR2(20 BYTE)            NOT NULL,
  SU_CODIGO        VARCHAR2(20 BYTE)            NOT NULL,
  MP_CODIGO        VARCHAR2(20 BYTE)            NOT NULL,
  PV_CODIGO        VARCHAR2(20 BYTE)            NOT NULL,
  EC_CODIGO        VARCHAR2(50 BYTE),
  CO_NUMERO        NUMBER,
  RF_CODIGO        VARCHAR2(20 BYTE),
  MP_FECHA         DATE                         NOT NULL,
  MP_VALOR         NUMBER(14,2)                 NOT NULL,
  MP_VALRET        NUMBER(14,2)                 NOT NULL,
  MP_SALDO         NUMBER(14,2)                 NOT NULL,
  ESTADO           VARCHAR2(1 BYTE),
  MP_CONTAB        CHAR(1 BYTE),
  MP_TRANSPORTE    NUMBER(14,2),
  EG_NUMERO        VARCHAR2(20 BYTE),
  CO_FACPRO        VARCHAR2(25 BYTE),
  MP_BASEIMP       NUMBER(14,2),
  MP_OBSERV        VARCHAR2(100 BYTE),
  CP_NUMERO        VARCHAR2(20 BYTE),
  MP_NOTAND        NUMBER(14,2),
  MP_RETIVA        NUMBER(14,2),
  MP_IVAND         NUMBER(14,2),
  MP_RETEN         NUMBER(14,2),
  MP_PREIMP        VARCHAR2(13 BYTE),
  MP_NAUT          VARCHAR2(10 BYTE),
  MP_FECEMISION    DATE,
  MP_RFTEND        NUMBER(14,2),
  MP_RIVAND        NUMBER(14,2),
  MP_MONTOICE      NUMBER(14,2),
  MP_TIPOIVA       VARCHAR2(2 BYTE),
  MP_CODTRIBU      VARCHAR2(2 BYTE),
  SA_LOGIN         VARCHAR2(20 BYTE),
  MP_TIPODOC       VARCHAR2(2 BYTE),
  MP_DOCDEVIVA     VARCHAR2(2 BYTE),
  MP_TIPIDPRV      VARCHAR2(2 BYTE),
  MP_DOCNROEST     VARCHAR2(3 BYTE),
  MP_DOCNROPTO     VARCHAR2(3 BYTE),
  MP_DOCNROSEC     VARCHAR2(9 BYTE),
  MP_FECCADUCI     DATE,
  MP_BSEIMPTRF0    NUMBER(14,2),
  MP_CODPCTIVA     CHAR(1 BYTE),
  MP_BSEIMPICE     NUMBER(14,2),
  MP_CODPCTICE     CHAR(1 BYTE),
  MP_BIEMNTIVA     NUMBER(14,2),
  MP_BIEPCTIVA     CHAR(1 BYTE),
  MP_BIEVLRRET     NUMBER(14,2),
  MP_SRVMNTIVA     NUMBER(14,2),
  MP_SRVPCTIVA     CHAR(1 BYTE),
  MP_SRVVLRRET     NUMBER(14,2),
  MP_MODTIPODOC    VARCHAR2(2 BYTE),
  MP_MODNROEST     VARCHAR2(3 BYTE),
  MP_MODNROPTO     VARCHAR2(3 BYTE),
  MP_MODNROSEC     VARCHAR2(9 BYTE),
  MP_MODFECEMI     DATE,
  MP_MODNAUT       VARCHAR2(10 BYTE),
  MP_FECLIQUI      DATE,
  MP_RFDODIST      VARCHAR2(3 BYTE),
  MP_RFDOANIO      VARCHAR2(4 BYTE),
  MP_RFDOREGI      VARCHAR2(2 BYTE),
  MP_RFDOCORR      VARCHAR2(6 BYTE),
  MP_RFDOVERIF     VARCHAR2(1 BYTE),
  MP_VALORCIF      NUMBER(14,2),
  MP_CODPCTFTE     VARCHAR2(20 BYTE),
  MP_FECPAGO       DATE,
  MP_NROREPOS      VARCHAR2(10 BYTE),
  MP_FECREG        DATE,
  MP_AUTRET        VARCHAR2(10 BYTE),
  MP_PTOEMIRET     VARCHAR2(3 BYTE),
  MP_ESTABRET      VARCHAR2(3 BYTE),
  MP_SECRET        VARCHAR2(9 BYTE),
  MP_FECEMIRET     DATE,
  MP_AUTRET1       VARCHAR2(10 BYTE),
  MP_PTOEMIRET1    VARCHAR2(3 BYTE),
  MP_ESTABRET1     VARCHAR2(3 BYTE),
  MP_SECRET1       VARCHAR2(9 BYTE),
  MP_FECEMIRET1    DATE,
  MP_RETIVABIENES  NUMBER(12,2),
  MP_RETIVASERV    NUMBER(12,2),
  MP_RETIVA100     NUMBER(12,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          960K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CP_PAGO  (Table) 
--
CREATE TABLE DINAMIC.CP_PAGO
(
  TV_CODIGO      VARCHAR2(20 BYTE)              NOT NULL,
  TV_TIPO        CHAR(1 BYTE)                   NOT NULL,
  EM_CODIGO      VARCHAR2(20 BYTE)              NOT NULL,
  SU_CODIGO      VARCHAR2(20 BYTE)              NOT NULL,
  MP_CODIGO      VARCHAR2(20 BYTE)              NOT NULL,
  PM_SECUENCIA   NUMBER(38)                     NOT NULL,
  PM_FECHA       DATE                           NOT NULL,
  PM_VALOR       NUMBER(14,2)                   NOT NULL,
  PM_FECPA       DATE,
  PM_INTER       NUMBER(14,2),
  PM_CXP         CHAR(1 BYTE),
  IF_CODIGO      VARCHAR2(20 BYTE),
  CN_CODIGO      VARCHAR2(20 BYTE),
  PM_DESCUE      NUMBER(14,2),
  ESTADO         VARCHAR2(1 BYTE),
  FP_CODIGO      VARCHAR2(20 BYTE),
  PM_NUMDOC      VARCHAR2(20 BYTE),
  PM_PREIMP      VARCHAR2(13 BYTE),
  PM_NAUT        VARCHAR2(10 BYTE),
  PM_EMISION     DATE,
  PM_CODPCT      VARCHAR2(20 BYTE),
  PM_BSEIMP      NUMBER(14,2),
  PM_PORCTJE     NUMBER(5,2),
  PM_NROEST      VARCHAR2(3 BYTE),
  PM_NROPTO      VARCHAR2(3 BYTE),
  PM_NROSEC      VARCHAR2(7 BYTE),
  PM_AUTRET1     VARCHAR2(10 BYTE),
  PM_ESTABRET1   VARCHAR2(3 BYTE),
  PM_PTOEMIRET1  VARCHAR2(3 BYTE),
  PM_SECRET1     VARCHAR2(9 BYTE),
  PM_FECEMIRET1  DATE,
  PL_CODIGO      VARCHAR2(20 BYTE),
  PM_BASE0       NUMBER(14,2),
  PM_BASEGRAV    NUMBER(14,2),
  PM_BASENOGRAV  NUMBER(14,2),
  PM_CODPCTIVA   NUMBER(14,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_CIERRE  (Table) 
--
CREATE TABLE DINAMIC.FA_CIERRE
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CI_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CJ_CAJA    VARCHAR2(20 BYTE)                  NOT NULL,
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CI_FECHA   DATE                               NOT NULL,
  CI_FECCIE  DATE                               NOT NULL,
  CN_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CI_TOTREC  NUMBER(14,2)                       NOT NULL,
  CI_SOBRA   NUMBER(14,2)                       NOT NULL,
  CI_FALTA   NUMBER(14,2)                       NOT NULL,
  CI_CONTAB  CHAR(1 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_GUIA  (Table) 
--
CREATE TABLE DINAMIC.FA_GUIA
(
  GU_NUMERO    VARCHAR2(20 BYTE)                NOT NULL,
  EP_CODIGO    VARCHAR2(20 BYTE),
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  GU_FECHA     DATE                             NOT NULL,
  GU_VEHICULO  VARCHAR2(50 BYTE)                NOT NULL,
  GU_OBSERV    VARCHAR2(80 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_MOVCAJA  (Table) 
--
CREATE TABLE DINAMIC.FA_MOVCAJA
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MC_NUMERO  NUMBER                             NOT NULL,
  CJ_CAJA    VARCHAR2(20 BYTE)                  NOT NULL,
  TJ_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MC_FECHA   DATE                               NOT NULL,
  MC_VALOR   NUMBER(14,2)                       NOT NULL,
  MC_COMENT  VARCHAR2(50 BYTE),
  MC_HORA    DATE,
  ESTADO     VARCHAR2(1 BYTE),
  VE_NUMERO  FLOAT(126)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_VENTA  (Table) 
--
CREATE TABLE DINAMIC.FA_VENTA
(
  ES_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  VE_NUMERO     NUMBER                          NOT NULL,
  CJ_CAJA       VARCHAR2(20 BYTE),
  CE_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EP_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  VE_NUMPRE     VARCHAR2(20 BYTE),
  VE_FECHA      DATE                            NOT NULL,
  VE_HORA       DATE,
  VE_SUBTOT     NUMBER(14,2)                    NOT NULL,
  VE_DESCUE     NUMBER(14,2)                    NOT NULL,
  VE_NETO       NUMBER(14,2)                    NOT NULL,
  VE_IVA        NUMBER(14,2)                    NOT NULL,
  VE_CARGO      NUMBER(14,2)                    NOT NULL,
  VE_VALPAG     NUMBER(14,2)                    NOT NULL,
  VE_OBSERV     VARCHAR2(100 BYTE),
  VE_LEYENDA    VARCHAR2(300 BYTE),
  VE_EFECTIVO   NUMBER(14,2),
  VE_VALOTROS   NUMBER(14,2),
  VE_CAMBIO     NUMBER(14,2),
  VE_PREANT     VARCHAR2(20 BYTE),
  VE_VALLETRAS  VARCHAR2(300 BYTE),
  VE_MOTIVO     CHAR(1 BYTE),
  ESTADO        VARCHAR2(1 BYTE),
  GU_NUMERO     VARCHAR2(20 BYTE),
  VE_CONTAB     CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_CABAJUS  (Table) 
--
CREATE TABLE DINAMIC.IN_CABAJUS
(
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  AJ_NUMERO  VARCHAR2(20 BYTE)                  NOT NULL,
  TM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TM_IOE     CHAR(1 BYTE)                       NOT NULL,
  EP_CODIGO  VARCHAR2(20 BYTE),
  AJ_FECHA   DATE                               NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  AJ_OBSERV  VARCHAR2(80 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  AJ_CONTAB  CHAR(1 BYTE),
  AJ_ESTADO  CHAR(1 BYTE),
  OR_CODIGO  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_COMPRA  (Table) 
--
CREATE TABLE DINAMIC.IN_COMPRA
(
  EC_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  CO_NUMERO    NUMBER(38)                       NOT NULL,
  PV_CODIGO    VARCHAR2(20 BYTE),
  VP_CODIGO    VARCHAR2(20 BYTE),
  CO_FACPRO    VARCHAR2(25 BYTE),
  CO_FECHA     DATE                             NOT NULL,
  CO_FECREP    DATE,
  CO_SUBTOT    NUMBER(14,2)                     NOT NULL,
  CO_IVA       NUMBER(14,2)                     NOT NULL,
  CO_DESCUP    NUMBER(7,4)                      NOT NULL,
  CO_TOTAL     NUMBER(14,2)                     NOT NULL,
  EC_CODPAD    VARCHAR2(20 BYTE),
  CO_NUMPAD    NUMBER(38),
  CO_COMPLETA  CHAR(1 BYTE),
  FP_CODIGO    VARCHAR2(20 BYTE),
  CO_TRANSPOR  NUMBER(14,2),
  CO_FECENT    DATE,
  CO_ENVIADA   VARCHAR2(1 BYTE),
  CO_ENCXP     CHAR(1 BYTE),
  CO_OBSERV    VARCHAR2(80 BYTE),
  ESTADO       VARCHAR2(1 BYTE),
  CO_RUCSUC    VARCHAR2(20 BYTE),
  CO_CONTAB    CHAR(1 BYTE),
  CO_SUBTRF0   NUMBER(14,2),
  CP_NUMERO    NUMBER(38)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITEM  (Table) 
--
CREATE TABLE DINAMIC.IN_ITEM
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  IT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CO_CODIGO     VARCHAR2(20 BYTE),
  CL_CODIGO     VARCHAR2(20 BYTE),
  FB_CODIGO     VARCHAR2(20 BYTE),
  UB_CODIGO     VARCHAR2(20 BYTE),
  MA_CODIGO     VARCHAR2(20 BYTE),
  PA_CODIGO     VARCHAR2(20 BYTE),
  IT_CODBAR     VARCHAR2(13 BYTE),
  IT_CODANT     VARCHAR2(20 BYTE)               NOT NULL,
  IT_NOMBRE     VARCHAR2(50 BYTE)               NOT NULL,
  IT_COSINI     NUMBER(16,4),
  IT_COSTO      NUMBER(16,4),
  IT_PRECIO     NUMBER(14,2),
  IT_PREFAB     NUMBER(14,2),
  IT_PESO       NUMBER(12,3),
  IT_MEDIDA     VARCHAR2(15 BYTE),
  IT_IMAGEN     VARCHAR2(50 BYTE),
  IT_TIEMSEC    NUMBER(12,6),
  IT_GARANT     NUMBER,
  IT_VALSTK     CHAR(1 BYTE),
  IT_KIT        CHAR(1 BYTE),
  IT_DESCORG    VARCHAR2(50 BYTE),
  IT_IMPRIMIR   CHAR(1 BYTE),
  IT_PREPARADO  CHAR(1 BYTE),
  IT_NOMCORTO   VARCHAR2(15 BYTE),
  ESTADO        VARCHAR2(1 BYTE),
  IT_FECHA      DATE,
  IT_BASE       VARCHAR2(2 BYTE),
  IT_FECCAM     DATE,
  IT_COSTPROM   NUMBER(16,4),
  GT_CODIGO     VARCHAR2(20 BYTE),
  IT_COSTTOTAL  NUMBER(16,4),
  IT_STKINI     NUMBER(14,2),
  IT_PRECIOFOB  NUMBER(16,4),
  IT_STATUS     VARCHAR2(1 BYTE),
  IT_MARGEN     FLOAT(126)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          3M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITEPRO  (Table) 
--
CREATE TABLE DINAMIC.IN_ITEPRO
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  PV_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IP_FECINI  DATE,
  IP_FECUCO  DATE,
  IP_CANUCO  NUMBER(9,3),
  IP_CODPRO  VARCHAR2(25 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  IP_PLISTA  NUMBER(16,4),
  IP_DESC1   NUMBER(6,2),
  IP_DESC2   NUMBER(6,2),
  IP_DESC3   NUMBER(6,2),
  IP_EAN     VARCHAR2(13 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITESUCUR  (Table) 
--
CREATE TABLE DINAMIC.IN_ITESUCUR
(
  IT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IT_STKINI   NUMBER(10,3)                      NOT NULL,
  IT_STKREAL  NUMBER(10,3)                      NOT NULL,
  IT_STOCK    NUMBER(10,3)                      NOT NULL,
  IT_STKDIS   NUMBER(10,3)                      NOT NULL,
  IT_COSULT   NUMBER(14,2)                      NOT NULL,
  IT_RECARGO  NUMBER(14,2),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITETAR  (Table) 
--
CREATE TABLE DINAMIC.IN_ITETAR
(
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IF_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IT_DESC    NUMBER(5,2)                        NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_PREPARADO  (Table) 
--
CREATE TABLE DINAMIC.IN_PREPARADO
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  PR_NUMERO     VARCHAR2(20 BYTE)               NOT NULL,
  PR_SECUENCIA  NUMBER(38)                      NOT NULL,
  IT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  IT_CODPREP    VARCHAR2(20 BYTE)               NOT NULL,
  PR_CANTIDAD   NUMBER(9,3)                     NOT NULL,
  ESTADO        VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_RELITEM  (Table) 
--
CREATE TABLE DINAMIC.IN_RELITEM
(
  TR_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IT_CODIGO1  VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  RI_CANTID   NUMBER(9,3),
  RI_OBSERV   VARCHAR2(30 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_DETEGR  (Table) 
--
CREATE TABLE DINAMIC.CB_DETEGR
(
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EG_NUMERO  VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DG_NUMERO  NUMBER(38)                         NOT NULL,
  DG_SIGNO   CHAR(1 BYTE)                       NOT NULL,
  DG_VALOR   NUMBER(14,2)                       NOT NULL,
  DG_OBSERV  VARCHAR2(2000 BYTE),
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  ESTADO     VARCHAR2(2 BYTE),
  CS_CODIGO  VARCHAR2(20 BYTE),
  EG_ND      CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CB_DETING  (Table) 
--
CREATE TABLE DINAMIC.CB_DETING
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  IG_NUMERO  VARCHAR2(20 BYTE)                  NOT NULL,
  PL_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DI_SECUE   FLOAT(126)                         NOT NULL,
  DI_VALOR   NUMBER(14,2)                       NOT NULL,
  DI_SIGNO   CHAR(1 BYTE)                       NOT NULL,
  DI_OBSERV  VARCHAR2(80 BYTE),
  ESTADO     VARCHAR2(1 BYTE),
  CS_CODIGO  VARCHAR2(20 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_MOVIM  (Table) 
--
CREATE TABLE DINAMIC.CC_MOVIM
(
  TT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TT_IOE     CHAR(1 BYTE)                       NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  RF_CODIGO  VARCHAR2(20 BYTE),
  CE_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  ES_CODIGO  VARCHAR2(20 BYTE),
  BO_CODIGO  VARCHAR2(20 BYTE),
  VE_NUMERO  NUMBER(10),
  IG_NUMERO  NUMBER(10),
  MT_VALOR   NUMBER(14,2)                       NOT NULL,
  MT_FECHA   DATE                               NOT NULL,
  MT_VALRET  NUMBER(14,2)                       NOT NULL,
  MT_SALDO   NUMBER(14,2)                       NOT NULL,
  MT_CTACOR  VARCHAR2(20 BYTE),
  MT_VALIVA  NUMBER(14,2),
  ESTADO     VARCHAR2(1 BYTE),
  MT_CTACLI  VARCHAR2(20 BYTE),
  MT_NUMCH   VARCHAR2(20 BYTE),
  IF_CODIGO  VARCHAR2(20 BYTE),
  MT_CONTAB  CHAR(1 BYTE),
  MT_PREIMP  VARCHAR2(13 BYTE),
  MT_NAUT    VARCHAR2(10 BYTE),
  MT_FECVEN  DATE,
  MT_KIT     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          896K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_TRANSFER  (Table) 
--
CREATE TABLE DINAMIC.IN_TRANSFER
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODENV     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODENV     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  TF_TICKET     VARCHAR2(20 BYTE)               NOT NULL,
  TF_NUMERO     VARCHAR2(20 BYTE)               NOT NULL,
  TF_FECHA      DATE                            NOT NULL,
  TF_HORA       DATE                            NOT NULL,
  EP_CODIGO     VARCHAR2(20 BYTE),
  TF_ACEPTADA   CHAR(1 BYTE),
  TF_NUMENVIO   VARCHAR2(20 BYTE),
  ESTADO        VARCHAR2(1 BYTE),
  TF_CONTAB     CHAR(1 BYTE),
  TF_FECPEDIDO  DATE,
  TF_OBSERVA    VARCHAR2(80 BYTE),
  TF_NUMGUIA    VARCHAR2(10 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_ASISTENCIA  (Table) 
--
CREATE TABLE DINAMIC.NO_ASISTENCIA
(
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  AS_FECHA     DATE                             NOT NULL,
  AS_IN        DATE,
  AS_INCAL     DATE,
  AS_OUT1      DATE,
  AS_OUT1CAL   DATE,
  AS_IN1       DATE,
  AS_IN1CAL    DATE,
  AS_OUT       DATE,
  AS_OUTCAL    DATE,
  AS_OUTP      DATE,
  AS_INP       DATE,
  AS_LUNCH     CHAR(1 BYTE),
  AS_PAGOH     CHAR(1 BYTE),
  AS_JORNADA   CHAR(1 BYTE),
  AS_TERMINAL  VARCHAR2(20 BYTE),
  AS_FERIADO   CHAR(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_CABROL  (Table) 
--
CREATE TABLE DINAMIC.NO_CABROL
(
  EP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  RR_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  RR_FECHA     DATE                             NOT NULL,
  RR_HORAS     NUMBER(14,2)                     NOT NULL,
  RR_TOTINGR   NUMBER(14,2)                     NOT NULL,
  RR_TOTEGRE   NUMBER(14,2)                     NOT NULL,
  RR_LIQUIDO   NUMBER(14,2)                     NOT NULL,
  RR_TIPO      CHAR(1 BYTE)                     NOT NULL,
  RR_PAGADO    CHAR(1 BYTE),
  ESTADO       VARCHAR2(1 BYTE),
  RR_CONTAB    CHAR(1 BYTE),
  RR_OBSERV    VARCHAR2(50 BYTE),
  CS_CODIGO    VARCHAR2(20 BYTE),
  RR_ENVIO     CHAR(1 BYTE),
  RR_NROGUIA   NUMBER(14,2),
  RR_FECENVIO  DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_CURSO  (Table) 
--
CREATE TABLE DINAMIC.NO_CURSO
(
  EP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  CM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  CM_FECINI    DATE                             NOT NULL,
  CM_FECFIN    DATE                             NOT NULL,
  CM_VALOR     NUMBER(14,2)                     NOT NULL,
  CM_DURACION  NUMBER(38)                       NOT NULL,
  CM_NOMBRE    VARCHAR2(20 BYTE)                NOT NULL,
  CM_DESCRI    VARCHAR2(80 BYTE),
  CM_ESTADO    CHAR(1 BYTE),
  CM_FINANCIA  CHAR(1 BYTE)                     NOT NULL,
  ESTADO       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_DETPAG  (Table) 
--
CREATE TABLE DINAMIC.NO_DETPAG
(
  EP_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  PP_NUMERO   VARCHAR2(20 BYTE)                 NOT NULL,
  DP_NUMERO   NUMBER(38)                        NOT NULL,
  DP_VALCUO   NUMBER(14,2)                      NOT NULL,
  DP_FECPAG   DATE                              NOT NULL,
  DP_CUOCANC  CHAR(1 BYTE)                      NOT NULL,
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NO_ROLPAGO  (Table) 
--
CREATE TABLE DINAMIC.NO_ROLPAGO
(
  EP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  RU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  LQ_VALOR   NUMBER(14,2)                       NOT NULL,
  LQ_NUMHOR  NUMBER(14,2)                       NOT NULL,
  RR_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  LQ_TOTAL   NUMBER(14,2)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TS_DETING  (Table) 
--
CREATE TABLE DINAMIC.TS_DETING
(
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TE_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  DT_NUMDOC   VARCHAR2(20 BYTE)                 NOT NULL,
  DT_VALEFE   NUMBER(14,2),
  DT_VALCHE   NUMBER(14,2),
  DT_VALCHD   NUMBER(14,2),
  DT_VALDEP   NUMBER(14,2),
  DT_VALVOU   NUMBER(14,2),
  DT_VALOTR1  NUMBER(14,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_DETALLE_EGRESO_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_DETALLE_EGRESO_FK ON DINAMIC.CB_DETEGR
(EM_CODIGO, SU_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_DETEGR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_DETEGR ON DINAMIC.CB_DETEGR
(SU_CODIGO, EG_NUMERO, PL_CODIGO, DG_NUMERO, EM_CODIGO, 
EG_ND)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CB_DETING  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CB_DETING ON DINAMIC.CB_DETING
(EM_CODIGO, SU_CODIGO, IG_NUMERO, PL_CODIGO, DI_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_DETALLE_ING_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_DETALLE_ING_FK ON DINAMIC.CB_DETING
(EM_CODIGO, SU_CODIGO, PL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CC_MOVIM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CC_MOVIM ON DINAMIC.CC_MOVIM
(TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RETENCION_MOVIMIENTO_FK  (Index) 
--
CREATE INDEX DINAMIC.RETENCION_MOVIMIENTO_FK ON DINAMIC.CC_MOVIM
(RF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CLIENTE_MOVIMIENTO_FK  (Index) 
--
CREATE INDEX DINAMIC.CLIENTE_MOVIMIENTO_FK ON DINAMIC.CC_MOVIM
(CE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_MOVIM_IDX_1  (Index) 
--
CREATE INDEX DINAMIC.CC_MOVIM_IDX_1 ON DINAMIC.CC_MOVIM
(EM_CODIGO, SU_CODIGO, BO_CODIGO, ES_CODIGO, VE_NUMERO, 
CE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_MOVIM_IDX_2  (Index) 
--
CREATE INDEX DINAMIC.CC_MOVIM_IDX_2 ON DINAMIC.CC_MOVIM
(EM_CODIGO, SU_CODIGO, BO_CODIGO, ES_CODIGO, TT_IOE, 
MT_SALDO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- DEB_VS_CRED_IDX  (Index) 
--
CREATE INDEX DINAMIC.DEB_VS_CRED_IDX ON DINAMIC.CC_MOVIM
(TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- VENTA_MOVINMIENTO_FK  (Index) 
--
CREATE INDEX DINAMIC.VENTA_MOVINMIENTO_FK ON DINAMIC.CC_MOVIM
(ES_CODIGO, BO_CODIGO, VE_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- INGRESO_MOV_CXC_FK  (Index) 
--
CREATE INDEX DINAMIC.INGRESO_MOV_CXC_FK ON DINAMIC.CC_MOVIM
(IG_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CP_MOVIM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CP_MOVIM ON DINAMIC.CP_MOVIM
(TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RETENCION_MOVIM_CXP_FK  (Index) 
--
CREATE INDEX DINAMIC.RETENCION_MOVIM_CXP_FK ON DINAMIC.CP_MOVIM
(RF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CP_PAGO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CP_PAGO ON DINAMIC.CP_PAGO
(TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO, 
PM_SECUENCIA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CUENTA_INST_PAGO_CXP_FK  (Index) 
--
CREATE INDEX DINAMIC.CUENTA_INST_PAGO_CXP_FK ON DINAMIC.CP_PAGO
(IF_CODIGO, CN_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_CIERRE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_CIERRE ON DINAMIC.FA_CIERRE
(EM_CODIGO, SU_CODIGO, CI_CODIGO, CJ_CAJA, EP_CODIGO, 
CI_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_GUIA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_GUIA ON DINAMIC.FA_GUIA
(GU_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_GUIA_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_GUIA_FK ON DINAMIC.FA_GUIA
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_MOVCAJA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_MOVCAJA ON DINAMIC.FA_MOVCAJA
(EM_CODIGO, SU_CODIGO, CJ_CAJA, MC_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_MOVCAJA_IDX  (Index) 
--
CREATE INDEX DINAMIC.FA_MOVCAJA_IDX ON DINAMIC.FA_MOVCAJA
(EM_CODIGO, SU_CODIGO, CJ_CAJA, TJ_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CAJA_MOV_CAJA_FK  (Index) 
--
CREATE INDEX DINAMIC.CAJA_MOV_CAJA_FK ON DINAMIC.FA_MOVCAJA
(EM_CODIGO, SU_CODIGO, CJ_CAJA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- TIPO_MOVIMIENTO_CAJA_FK  (Index) 
--
CREATE INDEX DINAMIC.TIPO_MOVIMIENTO_CAJA_FK ON DINAMIC.FA_MOVCAJA
(TJ_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_MOV_CAJA_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_MOV_CAJA_FK ON DINAMIC.FA_MOVCAJA
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_VENTA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_VENTA ON DINAMIC.FA_VENTA
(ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_VENTA_IDX1  (Index) 
--
CREATE INDEX DINAMIC.FA_VENTA_IDX1 ON DINAMIC.FA_VENTA
(EM_CODIGO, SU_CODIGO, VE_NUMERO, ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_VENTA_IDX4  (Index) 
--
CREATE INDEX DINAMIC.FA_VENTA_IDX4 ON DINAMIC.FA_VENTA
(EM_CODIGO, SU_CODIGO, ES_CODIGO, VE_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CAJA_VENTA_FK  (Index) 
--
CREATE INDEX DINAMIC.CAJA_VENTA_FK ON DINAMIC.FA_VENTA
(EM_CODIGO, SU_CODIGO, CJ_CAJA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SIF_GUIA_IDX2  (Index) 
--
CREATE INDEX DINAMIC.SIF_GUIA_IDX2 ON DINAMIC.FA_VENTA
(GU_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CLIENTE_VENTA_FK  (Index) 
--
CREATE INDEX DINAMIC.CLIENTE_VENTA_FK ON DINAMIC.FA_VENTA
(CE_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_VENTA_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_VENTA_FK ON DINAMIC.FA_VENTA
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_CABAJUS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_CABAJUS ON DINAMIC.IN_CABAJUS
(SU_CODIGO, BO_CODIGO, AJ_NUMERO, TM_CODIGO, TM_IOE, 
EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RESPONSABLE_AJUSTE_FK  (Index) 
--
CREATE INDEX DINAMIC.RESPONSABLE_AJUSTE_FK ON DINAMIC.IN_CABAJUS
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_COMPRA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_COMPRA ON DINAMIC.IN_COMPRA
(EC_CODIGO, EM_CODIGO, SU_CODIGO, CO_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- COMPRA_IDX  (Index) 
--
CREATE INDEX DINAMIC.COMPRA_IDX ON DINAMIC.IN_COMPRA
(EM_CODIGO, SU_CODIGO, EC_CODIGO, CO_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PROVEEDOR_COMPRA_FK  (Index) 
--
CREATE INDEX DINAMIC.PROVEEDOR_COMPRA_FK ON DINAMIC.IN_COMPRA
(PV_CODIGO, VP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- COMPRA_COMPRA_FK  (Index) 
--
CREATE INDEX DINAMIC.COMPRA_COMPRA_FK ON DINAMIC.IN_COMPRA
(EC_CODPAD, CO_NUMPAD)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FORMA_PAGO_COMPRA_FK  (Index) 
--
CREATE INDEX DINAMIC.FORMA_PAGO_COMPRA_FK ON DINAMIC.IN_COMPRA
(FP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_ITEM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_ITEM ON DINAMIC.IN_ITEM
(EM_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- NOMBRE_IDX  (Index) 
--
CREATE INDEX DINAMIC.NOMBRE_IDX ON DINAMIC.IN_ITEM
(EM_CODIGO, IT_NOMBRE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CLASE_ITEM_FK  (Index) 
--
CREATE INDEX DINAMIC.CLASE_ITEM_FK ON DINAMIC.IN_ITEM
(CL_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- MARCA_IDX  (Index) 
--
CREATE INDEX DINAMIC.MARCA_IDX ON DINAMIC.IN_ITEM
(MA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- UK_CODANT  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.UK_CODANT ON DINAMIC.IN_ITEM
(IT_CODANT)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_ITEPRO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_ITEPRO ON DINAMIC.IN_ITEPRO
(EM_CODIGO, IT_CODIGO, PV_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_ITESUCUR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_ITESUCUR ON DINAMIC.IN_ITESUCUR
(EM_CODIGO, SU_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- COSTO_SUCURSAL_IDX  (Index) 
--
CREATE INDEX DINAMIC.COSTO_SUCURSAL_IDX ON DINAMIC.IN_ITESUCUR
(EM_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_ITETAR  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_ITETAR ON DINAMIC.IN_ITETAR
(IT_CODIGO, IF_CODIGO, EM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_PREPARADO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_PREPARADO ON DINAMIC.IN_PREPARADO
(EM_CODIGO, SU_CODIGO, BO_CODIGO, PR_NUMERO, PR_SECUENCIA, 
IT_CODIGO, IT_CODPREP)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_RELITEM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_RELITEM ON DINAMIC.IN_RELITEM
(TR_CODIGO, IT_CODIGO1, EM_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_TRANSFER  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_TRANSFER ON DINAMIC.IN_TRANSFER
(EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO, 
TF_TICKET)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CAB_TRANS_IDX  (Index) 
--
CREATE INDEX DINAMIC.CAB_TRANS_IDX ON DINAMIC.IN_TRANSFER
(EM_CODIGO, SU_CODIGO, BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- EMPLEADO_TRANSFERENCIA_FK  (Index) 
--
CREATE INDEX DINAMIC.EMPLEADO_TRANSFERENCIA_FK ON DINAMIC.IN_TRANSFER
(EP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_ASISTENCIA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_ASISTENCIA ON DINAMIC.NO_ASISTENCIA
(EM_CODIGO, EP_CODIGO, AS_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_CABROL  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_CABROL ON DINAMIC.NO_CABROL
(EP_CODIGO, RR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_CURSO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_CURSO ON DINAMIC.NO_CURSO
(EP_CODIGO, CM_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_DETPAG  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_DETPAG ON DINAMIC.NO_DETPAG
(EP_CODIGO, PP_NUMERO, DP_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_NO_ROLPAGO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_NO_ROLPAGO ON DINAMIC.NO_ROLPAGO
(EP_CODIGO, RU_CODIGO, RR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RUBRO_ROL_IDX  (Index) 
--
CREATE INDEX DINAMIC.RUBRO_ROL_IDX ON DINAMIC.NO_ROLPAGO
(RR_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_TS_DETING  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_TS_DETING ON DINAMIC.TS_DETING
(EM_CODIGO, SU_CODIGO, TE_CODIGO, DT_NUMDOC)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SP_CAMBIADESUC_MOVBANCOS  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.SP_CAMBIADESUC_MOVBANCOS (ai_cadena VARCHAR,
ao_codigo_error out NUMBER,ao_mensaje_error out varchar) IS

tmpVar NUMBER;
x_actualizar EXCEPTION;
x_asientos   EXCEPTION;


TYPE cur_typ IS REF CURSOR;
c_cursor                     cur_typ;

TYPE T_ingreso IS RECORD ( em_codigo cb_ingreso.em_codigo%TYPE,
                                          su_codigo cb_ingreso.su_codigo%TYPE,
                                          ig_numero cb_ingreso.ig_numero%TYPE,
                                          cp_numero cb_ingreso.cp_numero%TYPE) ;
                                    
r_ingreso  T_ingreso;

v_query                      VARCHAR2 (1000);
v_asiento                    VARCHAR2(1000);       

BEGIN
      
  DBMS_APPLICATION_INFO.set_module ('PKG_BAJASNEW', 'PROCESAR_BAJAS_INGRESADAS PRC');
  v_query := ai_cadena;

  OPEN c_cursor FOR v_query;

  LOOP

     FETCH c_cursor INTO r_ingreso;

     EXIT WHEN c_cursor%NOTFOUND;
     
                INSERT INTO CB_INGRESO
                (SELECT EM_CODIGO ,
                  2 ,
                  IG_NUMERO    ,
                  IF_CODIGO  ,
                  CN_CODIGO,
                  RF_CODIGO,
                  TN_CODIGO   ,
                  IG_FECHA ,
                  IG_VALOR,
                  IG_VALRET,
                  IG_VALTOT,
                  IG_DEPOSIT ,
                  IG_CONCILIA ,
                  IG_OBSERV,
                  ESTADO,
                  IG_NUMING ,
                  IG_CONTAB,
                  IG_NC,
                  SA_LOGIN,
                  IG_ANULADO ,
                  IG_FECANU,
                  CP_NUMERO
                FROM CB_INGRESO
                WHERE IG_NUMERO = r_ingreso.ig_numero
                AND EM_CODIGO = r_ingreso.em_codigo
                AND SU_CODIGO = r_ingreso.su_codigo);

                -- Si levanta una excepcion

                UPDATE CB_DETING
                SET SU_CODIGO = 2
                WHERE IG_NUMERO = r_ingreso.ig_numero
                AND EM_CODIGO = r_ingreso.em_codigo
                AND SU_CODIGO = r_ingreso.su_codigo;


                IF SQL%NOTFOUND THEN
                RAISE x_actualizar;
                END IF;


                --Eliminar el registro que esta marcado como ANULADO estado = '6'
                DELETE FROM CB_INGRESO
                WHERE  EM_CODIGO = r_ingreso.em_codigo
                AND SU_CODIGO = r_ingreso.su_codigo
                AND IG_NUMERO = r_ingreso.ig_numero;
                IF SQL%NOTFOUND THEN
                RAISE x_actualizar;
                END IF;
                  

                --Actualiza el comprobante contable asociado

                v_asiento := 'SELECT EM_CODIGO,SU_CODIGO,CP_NUMERO FROM CO_CABCOM WHERE CP_NUMERO = '||r_ingreso.cp_numero;
                
                sp_cambiadesuc_asientos ( v_asiento,ao_codigo_error, ao_mensaje_error);
                
                IF ao_codigo_error = '0' THEN
                RAISE x_asientos;
                END IF;
                
               COMMIT;    
                
  END LOOP;

  CLOSE c_cursor;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
          ao_codigo_error := '0';
          ao_mensaje_error := SUBSTR (SQLERRM, 1, 4000);
          
     WHEN x_actualizar THEN
          ao_codigo_error := '0';
          
          ao_mensaje_error := SUBSTR (SQLERRM, 1, 4000);
          ROLLBACK;
          
    WHEN x_asientos THEN
      ao_mensaje_error := 'Problemas al actualizar el asiento contable '||ao_mensaje_error;     
      ROLLBACK;
    
          
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
          ROLLBACK;
       
   
       
END SP_CAMBIADESUC_MOVBANCOS;
/


--
-- TS_DETING  (Synonym) 
--
CREATE PUBLIC SYNONYM TS_DETING FOR DINAMIC.TS_DETING;


--
-- NO_ROLPAGO  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_ROLPAGO FOR DINAMIC.NO_ROLPAGO;


--
-- NO_DETPAG  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_DETPAG FOR DINAMIC.NO_DETPAG;


--
-- NO_CURSO  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_CURSO FOR DINAMIC.NO_CURSO;


--
-- NO_CABROL  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_CABROL FOR DINAMIC.NO_CABROL;


--
-- NO_ASISTENCIA  (Synonym) 
--
CREATE PUBLIC SYNONYM NO_ASISTENCIA FOR DINAMIC.NO_ASISTENCIA;


--
-- IN_TRANSFER  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_TRANSFER FOR DINAMIC.IN_TRANSFER;


--
-- IN_RELITEM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_RELITEM FOR DINAMIC.IN_RELITEM;


--
-- IN_PREPARADO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_PREPARADO FOR DINAMIC.IN_PREPARADO;


--
-- IN_ITETAR  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITETAR FOR DINAMIC.IN_ITETAR;


--
-- IN_ITESUCUR  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITESUCUR FOR DINAMIC.IN_ITESUCUR;


--
-- IN_ITEPRO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITEPRO FOR DINAMIC.IN_ITEPRO;


--
-- IN_ITEM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITEM FOR DINAMIC.IN_ITEM;


--
-- IN_COMPRA  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_COMPRA FOR DINAMIC.IN_COMPRA;


--
-- IN_CABAJUS  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_CABAJUS FOR DINAMIC.IN_CABAJUS;


--
-- FA_VENTA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_VENTA FOR DINAMIC.FA_VENTA;


--
-- FA_MOVCAJA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_MOVCAJA FOR DINAMIC.FA_MOVCAJA;


--
-- FA_GUIA  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_GUIA FOR DINAMIC.FA_GUIA;


--
-- FA_CIERRE  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_CIERRE FOR DINAMIC.FA_CIERRE;


--
-- CP_PAGO  (Synonym) 
--
CREATE PUBLIC SYNONYM CP_PAGO FOR DINAMIC.CP_PAGO;


--
-- CP_MOVIM  (Synonym) 
--
CREATE PUBLIC SYNONYM CP_MOVIM FOR DINAMIC.CP_MOVIM;


--
-- CC_MOVIM  (Synonym) 
--
CREATE PUBLIC SYNONYM CC_MOVIM FOR DINAMIC.CC_MOVIM;


--
-- CB_DETING  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_DETING FOR DINAMIC.CB_DETING;


--
-- CB_DETEGR  (Synonym) 
--
CREATE PUBLIC SYNONYM CB_DETEGR FOR DINAMIC.CB_DETEGR;


--
-- CP_CABDEB  (Table) 
--
CREATE TABLE DINAMIC.CP_CABDEB
(
  TV_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  TV_TIPO      CHAR(1 BYTE)                     NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  MP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  DP_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  DP_TIPO      CHAR(1 BYTE)                     NOT NULL,
  DP_FECHA     DATE                             NOT NULL,
  DP_CONCEPTO  VARCHAR2(100 BYTE)               NOT NULL,
  DP_VALOR     NUMBER(14,2)                     NOT NULL,
  ESTADO       VARCHAR2(1 BYTE),
  DP_IVA       NUMBER(14,2)                     NOT NULL,
  DP_NETO      NUMBER(14,2)                     NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CP_CRUCE  (Table) 
--
CREATE TABLE DINAMIC.CP_CRUCE
(
  TV_CODDEB   VARCHAR2(20 BYTE)                 NOT NULL,
  TV_TIPODEB  CHAR(1 BYTE)                      NOT NULL,
  MP_CODDEB   VARCHAR2(20 BYTE)                 NOT NULL,
  TV_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  TV_TIPO     CHAR(1 BYTE)                      NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  MP_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  CX_FECHA    DATE                              NOT NULL,
  CX_VALCRE   NUMBER(14,2)                      NOT NULL,
  CX_VALDEB   NUMBER(14,2)                      NOT NULL,
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CP_DETDEB  (Table) 
--
CREATE TABLE DINAMIC.CP_DETDEB
(
  TV_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TV_TIPO    CHAR(1 BYTE)                       NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DD_SECUE   VARCHAR2(20 BYTE)                  NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DD_CANTID  NUMBER(12)                         NOT NULL,
  DD_VALOR   NUMBER(16,4)                       NOT NULL,
  DD_TOTAL   NUMBER(14,2)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_DETDEVOL  (Table) 
--
CREATE TABLE DINAMIC.FA_DETDEVOL
(
  ES_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  EM_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  SU_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  BO_CODIGO    VARCHAR2(20 BYTE)                NOT NULL,
  VE_NUMERO    NUMBER(38)                       NOT NULL,
  VE_NUMDEVOL  VARCHAR2(20 BYTE)                NOT NULL,
  VE_DESDEVO   NUMBER(14,2)                     NOT NULL,
  VE_IVADEVO   NUMBER(14,2)                     NOT NULL,
  VE_SUBDEVO   NUMBER(14,2)                     NOT NULL,
  VE_VALDEVO   NUMBER(14,2)                     NOT NULL,
  VE_SALDEVO   NUMBER(14,2)                     NOT NULL,
  VE_FECDEVO   DATE                             NOT NULL,
  VE_FECSALDO  DATE,
  ESTADO       VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_DETVE  (Table) 
--
CREATE TABLE DINAMIC.FA_DETVE
(
  ES_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  BO_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  VE_NUMERO   NUMBER                            NOT NULL,
  IT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  DV_SECUE    NUMBER                            NOT NULL,
  DV_CANTID   NUMBER(9,3)                       NOT NULL,
  DV_CANDES   NUMBER(9,3)                       NOT NULL,
  DV_PRECIO   NUMBER(14,2)                      NOT NULL,
  DV_DESC1    NUMBER(7,2)                       NOT NULL,
  DV_DESC2    NUMBER(7,2)                       NOT NULL,
  DV_DESC3    NUMBER(7,2)                       NOT NULL,
  DV_DESCUE   NUMBER(14,2),
  DV_TOTAL    NUMBER(14,2)                      NOT NULL,
  DV_ENTREGA  CHAR(1 BYTE),
  DV_DEVOLU   NUMBER(9,3),
  DV_YANC     CHAR(1 BYTE),
  DV_DFECHA   DATE,
  VE_NUMNC    VARCHAR2(20 BYTE),
  DV_FALTA    NUMBER(12,3),
  ESTADO      VARCHAR2(1 BYTE),
  DV_MOTOR    VARCHAR2(30 BYTE),
  DV_CHASIS   VARCHAR2(35 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_RECPAG  (Table) 
--
CREATE TABLE DINAMIC.FA_RECPAG
(
  ES_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  VE_NUMERO  NUMBER(10)                         NOT NULL,
  RP_NUMERO  NUMBER(10)                         NOT NULL,
  IF_CODIGO  VARCHAR2(20 BYTE),
  FP_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  RP_NUMDOC  VARCHAR2(20 BYTE),
  RP_NUMCTA  VARCHAR2(20 BYTE),
  RP_FECHA   DATE                               NOT NULL,
  RP_FECVEN  DATE                               NOT NULL,
  RP_VALOR   NUMBER(14,2)                       NOT NULL,
  RP_COMEN   VARCHAR2(50 BYTE),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DESCITEM  (Table) 
--
CREATE TABLE DINAMIC.IN_DESCITEM
(
  TD_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  ES_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  DI_VIGENTE  CHAR(1 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DETTRANS  (Table) 
--
CREATE TABLE DINAMIC.IN_DETTRANS
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODENV  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODENV  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TF_TICKET  VARCHAR2(20 BYTE)                  NOT NULL,
  DF_SECUEN  VARCHAR2(20 BYTE)                  NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DF_CANTID  NUMBER(9,3)                        NOT NULL,
  ESTADO     VARCHAR2(1 BYTE),
  DF_COSTO   NUMBER(16,4),
  DF_STOCK   NUMBER(10,3),
  DF_STKPED  NUMBER(10,3),
  DF_MOTOR   VARCHAR2(30 BYTE),
  DF_CHASIS  VARCHAR2(25 BYTE),
  DF_RAMV    VARCHAR2(12 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_HOJTEC  (Table) 
--
CREATE TABLE DINAMIC.IN_HOJTEC
(
  HT_CODHOJA  VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE),
  IT_CODIGO   VARCHAR2(20 BYTE),
  MA_CODIGO   VARCHAR2(20 BYTE),
  HT_VIGENTE  CHAR(1 BYTE),
  HT_XPROD    CHAR(1 BYTE)                      NOT NULL,
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_HTITEM  (Table) 
--
CREATE TABLE DINAMIC.IN_HTITEM
(
  HT_CODHOJA  VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  LH_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  HI_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  HI_DESCRI   VARCHAR2(50 BYTE),
  HI_TEXTO    VARCHAR2(150 BYTE),
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITEBOD  (Table) 
--
CREATE TABLE DINAMIC.IN_ITEBOD
(
  IT_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  EM_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  SU_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  BO_CODIGO   VARCHAR2(20 BYTE)                 NOT NULL,
  IB_STOCK    NUMBER(10,3)                      NOT NULL,
  IB_STKINI   NUMBER(10,3)                      NOT NULL,
  IB_FECINI   DATE                              NOT NULL,
  IB_FECUSA   DATE,
  IB_FECUIG   DATE,
  IB_UBICA    VARCHAR2(50 BYTE),
  IB_REORDEN  NUMBER(9,3)                       NOT NULL,
  IB_STKMAX   NUMBER(9,3)                       NOT NULL,
  IB_STKMIN   NUMBER(9,3)                       NOT NULL,
  ESTADO      VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          832K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITEDET  (Table) 
--
CREATE TABLE DINAMIC.IN_ITEDET
(
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DI_REF1    VARCHAR2(30 BYTE)                  NOT NULL,
  DI_REF2    VARCHAR2(30 BYTE)                  NOT NULL,
  DI_REF3    VARCHAR2(30 BYTE)                  NOT NULL,
  DI_REF4    VARCHAR2(4 BYTE)                   NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DI_DOCREF  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODDES  VARCHAR2(20 BYTE),
  CO_RECEP   VARCHAR2(20 BYTE)                  NOT NULL,
  VE_NUMERO  VARCHAR2(20 BYTE),
  TF_NUMERO  VARCHAR2(20 BYTE),
  CO_NUMERO  VARCHAR2(20 BYTE),
  PV_CODIGO  VARCHAR2(20 BYTE),
  IT_CODANT  VARCHAR2(20 BYTE)                  NOT NULL,
  ESTADO     CHAR(1 BYTE)                       NOT NULL,
  DI_SECUEN  NUMBER(5)                          NOT NULL,
  DI_FECHA   DATE
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_ITEEMP  (Table) 
--
CREATE TABLE DINAMIC.IN_ITEEMP
(
  EM_CODIGO  VARCHAR2(20 BYTE),
  IT_CODIGO  VARCHAR2(20 BYTE),
  IT_FECHA   DATE,
  IT_STKINI  NUMBER(12),
  IT_COSINI  NUMBER(16,4),
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_MOVIM  (Table) 
--
CREATE TABLE DINAMIC.IN_MOVIM
(
  TM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  TM_IOE        CHAR(1 BYTE)                    NOT NULL,
  IT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  MV_NUMERO     VARCHAR2(20 BYTE)               NOT NULL,
  MV_CANTID     NUMBER(10,3)                    NOT NULL,
  MV_COSTO      NUMBER(16,4)                    NOT NULL,
  MV_FECHA      DATE,
  MV_OBSERV     VARCHAR2(80 BYTE),
  MV_USADO      CHAR(1 BYTE)                    NOT NULL,
  VE_NUMERO     NUMBER,
  ES_CODIGO     VARCHAR2(20 BYTE),
  ESTADO        VARCHAR2(1 BYTE),
  MV_CONTAB     CHAR(1 BYTE),
  MV_COSTPROM   NUMBER(16,4),
  MV_COSTTRANS  NUMBER(16,4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          4M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_CHEQUE  (Table) 
--
CREATE TABLE DINAMIC.CC_CHEQUE
(
  TT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  TT_IOE        CHAR(1 BYTE)                    NOT NULL,
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  MT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CH_SECUE      NUMBER(38)                      NOT NULL,
  IF_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CH_CUENTA     VARCHAR2(20 BYTE),
  CH_NUMERO     VARCHAR2(20 BYTE),
  CH_FECHA      DATE                            NOT NULL,
  CH_VALOR      NUMBER(14,2)                    NOT NULL,
  CH_INTERES    NUMBER(14,2),
  CH_FECINTE    DATE,
  CH_PENDIENTE  CHAR(1 BYTE),
  ESTADO        VARCHAR2(1 BYTE),
  IG_NUMERO     NUMBER(10),
  CH_FECEFEC    DATE,
  FP_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CH_PREIMP     VARCHAR2(13 BYTE),
  CH_NAUT       VARCHAR2(10 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_CRUCE  (Table) 
--
CREATE TABLE DINAMIC.CC_CRUCE
(
  TT_CODDEB  VARCHAR2(20 BYTE)                  NOT NULL,
  TT_IOEDEB  CHAR(1 BYTE)                       NOT NULL,
  MT_CODDEB  VARCHAR2(20 BYTE)                  NOT NULL,
  TT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  TT_IOE     CHAR(1 BYTE)                       NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  MT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  CR_FECHA   DATE                               NOT NULL,
  CR_VALDEB  NUMBER(14,2)                       NOT NULL,
  CR_VALCRE  NUMBER(14,2)                       NOT NULL,
  ESTADO     VARCHAR2(1 BYTE),
  CH_NUMERO  VARCHAR2(9 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CC_CHEQUE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CC_CHEQUE ON DINAMIC.CC_CHEQUE
(TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO, 
CH_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- INST_FINANCIERA_CHEQUE_FK  (Index) 
--
CREATE INDEX DINAMIC.INST_FINANCIERA_CHEQUE_FK ON DINAMIC.CC_CHEQUE
(IF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CC_CRUCE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CC_CRUCE ON DINAMIC.CC_CRUCE
(TT_CODDEB, TT_IOEDEB, MT_CODDEB, TT_CODIGO, TT_IOE, 
EM_CODIGO, SU_CODIGO, MT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          384K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- DEBVSCRE_IDX  (Index) 
--
CREATE INDEX DINAMIC.DEBVSCRE_IDX ON DINAMIC.CC_CRUCE
(TT_IOEDEB, MT_CODDEB, TT_IOE, EM_CODIGO, SU_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CC_CRUCE_IDX_1  (Index) 
--
CREATE INDEX DINAMIC.CC_CRUCE_IDX_1 ON DINAMIC.CC_CRUCE
(TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- DEB_IDX  (Index) 
--
CREATE INDEX DINAMIC.DEB_IDX ON DINAMIC.CC_CRUCE
(EM_CODIGO, SU_CODIGO, TT_CODDEB, TT_IOEDEB, MT_CODDEB)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CP_CABDEB  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CP_CABDEB ON DINAMIC.CP_CABDEB
(TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO, 
DP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CP_CRUCE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CP_CRUCE ON DINAMIC.CP_CRUCE
(TV_CODDEB, TV_TIPODEB, MP_CODDEB, TV_CODIGO, TV_TIPO, 
EM_CODIGO, SU_CODIGO, MP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IDX_CXP_CRUCE  (Index) 
--
CREATE INDEX DINAMIC.IDX_CXP_CRUCE ON DINAMIC.CP_CRUCE
(TV_CODIGO, TV_TIPO, MP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_CP_DETDEB  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_CP_DETDEB ON DINAMIC.CP_DETDEB
(TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO, 
DP_CODIGO, DD_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_DETDEVOL  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_DETDEVOL ON DINAMIC.FA_DETDEVOL
(ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO, 
VE_NUMDEVOL)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_DETVE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_DETVE ON DINAMIC.FA_DETVE
(ES_CODIGO, BO_CODIGO, VE_NUMERO, IT_CODIGO, EM_CODIGO, 
SU_CODIGO, DV_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_DETVE_IDX1  (Index) 
--
CREATE INDEX DINAMIC.FA_DETVE_IDX1 ON DINAMIC.FA_DETVE
(EM_CODIGO, SU_CODIGO, VE_NUMERO, ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_DETVE_IDX2  (Index) 
--
CREATE INDEX DINAMIC.FA_DETVE_IDX2 ON DINAMIC.FA_DETVE
(EM_CODIGO, SU_CODIGO, BO_CODIGO, ES_CODIGO, VE_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_DETVE_IDX3  (Index) 
--
CREATE INDEX DINAMIC.FA_DETVE_IDX3 ON DINAMIC.FA_DETVE
(EM_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_FA_RECPAG  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_FA_RECPAG ON DINAMIC.FA_RECPAG
(ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO, 
RP_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FORMA_PAGO_RECEPCION_PAGO_FK  (Index) 
--
CREATE INDEX DINAMIC.FORMA_PAGO_RECEPCION_PAGO_FK ON DINAMIC.FA_RECPAG
(FP_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_RECPAG_IDX  (Index) 
--
CREATE INDEX DINAMIC.FA_RECPAG_IDX ON DINAMIC.FA_RECPAG
(EM_CODIGO, SU_CODIGO, ES_CODIGO, FP_CODIGO, RP_FECVEN, 
RP_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          768K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- FA_RECPAG_IDX2  (Index) 
--
CREATE INDEX DINAMIC.FA_RECPAG_IDX2 ON DINAMIC.FA_RECPAG
(EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO, ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- INSTITUCION_FINAC_PAGO_FK  (Index) 
--
CREATE INDEX DINAMIC.INSTITUCION_FINAC_PAGO_FK ON DINAMIC.FA_RECPAG
(IF_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_DESCITEM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_DESCITEM ON DINAMIC.IN_DESCITEM
(TD_CODIGO, EM_CODIGO, IT_CODIGO, ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          960K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- ESTADO_VTA_DESCUENTO_FK  (Index) 
--
CREATE INDEX DINAMIC.ESTADO_VTA_DESCUENTO_FK ON DINAMIC.IN_DESCITEM
(ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_DETTRANS  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_DETTRANS ON DINAMIC.IN_DETTRANS
(EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO, 
TF_TICKET, DF_SECUEN, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_HOJTEC  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_HOJTEC ON DINAMIC.IN_HOJTEC
(HT_CODHOJA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- ITEM_HOJA_TECNICA_FK  (Index) 
--
CREATE INDEX DINAMIC.ITEM_HOJA_TECNICA_FK ON DINAMIC.IN_HOJTEC
(EM_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- RELATION_53610_FK  (Index) 
--
CREATE INDEX DINAMIC.RELATION_53610_FK ON DINAMIC.IN_HOJTEC
(MA_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_HTITEM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_HTITEM ON DINAMIC.IN_HTITEM
(HT_CODHOJA, EM_CODIGO, LH_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_ITEBOD  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_ITEBOD ON DINAMIC.IN_ITEBOD
(IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          768K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- INDX_H1  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.INDX_H1 ON DINAMIC.IN_ITEBOD
(EM_CODIGO, SU_CODIGO, BO_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_ITEDET  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_ITEDET ON DINAMIC.IN_ITEDET
(EM_CODIGO, SU_CODIGO, DI_REF1)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_ITEEMP  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_ITEEMP ON DINAMIC.IN_ITEEMP
(EM_CODIGO, IT_CODIGO, IT_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_MOVIM  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_MOVIM ON DINAMIC.IN_MOVIM
(TM_CODIGO, TM_IOE, IT_CODIGO, EM_CODIGO, SU_CODIGO, 
BO_CODIGO, MV_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_MOVIM_IDX_EMSUBOFE  (Index) 
--
CREATE INDEX DINAMIC.IN_MOVIM_IDX_EMSUBOFE ON DINAMIC.IN_MOVIM
(EM_CODIGO, SU_CODIGO, BO_CODIGO, MV_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_MOVIM_IDX_1  (Index) 
--
CREATE INDEX DINAMIC.IN_MOVIM_IDX_1 ON DINAMIC.IN_MOVIM
(EM_CODIGO, SU_CODIGO, IT_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_MOVIM_IDX_2  (Index) 
--
CREATE INDEX DINAMIC.IN_MOVIM_IDX_2 ON DINAMIC.IN_MOVIM
(EM_CODIGO, SU_CODIGO, TM_CODIGO, TM_IOE, VE_NUMERO, 
ES_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_MOVIM_IDX_FECHA  (Index) 
--
CREATE INDEX DINAMIC.IN_MOVIM_IDX_FECHA ON DINAMIC.IN_MOVIM
(MV_FECHA)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          896K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- SP_REVERSA_ANULACION_VENTA  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.SP_REVERSA_ANULACION_VENTA (ai_cadena VARCHAR2 ,ao_codigo_error out NUMBER,ao_mensaje_error out varchar) IS

TYPE cur_typ IS REF CURSOR;
c_cursor                     cur_typ;

TYPE T_ventas IS RECORD (  es_codigo   fa_venta.es_codigo%TYPE,
                                          em_codigo fa_venta.em_codigo%TYPE,
                                          su_codigo fa_venta.su_codigo%TYPE,
                                          bo_codigo  fa_venta.bo_codigo%TYPE,
                                          ve_numero  fa_venta.ve_numero%TYPE) ;
                                    
r_ventas  T_ventas;

v_query                      VARCHAR2 (10000);
v_itcodigo_atomo         VARCHAR2(20);
fallo_actualizar            EXCEPTION;
--v_factura_anulada       VARCHAR2(20);

cursor c_detalleventa is
            select i.it_codigo itcodigo, i.it_kit kit,d.dv_candes candes,i.it_costo costo
            from fa_detve d, in_item i
            where i.it_codigo = d.it_codigo 
            and d.es_codigo  =  r_ventas.es_codigo
            and d.em_codigo =  r_ventas.em_codigo
            and d.su_codigo  =  r_ventas.su_codigo
            and d.bo_codigo  =  r_ventas.bo_codigo
            and d.ve_numero = r_ventas.ve_numero;

------------------------------------------------------------------------------------------------------------------------      
BEGIN

  DBMS_APPLICATION_INFO.set_module ('PKG_BAJASNEW', 'PROCESAR_BAJAS_INGRESADAS PRC');

  v_query := ai_cadena;

  OPEN c_cursor FOR v_query;

  LOOP

     FETCH c_cursor INTO r_ventas;

     EXIT WHEN c_cursor%NOTFOUND;
--Cambia de estado de NOTA DE CREDITO a FACTURA

            INSERT INTO FA_VENTA(ES_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO,CJ_CAJA,CE_CODIGO,EP_CODIGO,VE_NUMPRE,VE_FECHA,VE_HORA,VE_SUBTOT,VE_DESCUE,
            VE_NETO,VE_IVA,VE_CARGO,VE_VALPAG,VE_OBSERV,VE_LEYENDA,VE_EFECTIVO,VE_VALOTROS,VE_CAMBIO,VE_PREANT,VE_VALLETRAS,VE_MOTIVO,
            ESTADO,GU_NUMERO,VE_CONTAB)
            SELECT DECODE(r_ventas.es_codigo,5,1,6,2),EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO,CJ_CAJA,CE_CODIGO,EP_CODIGO,VE_NUMPRE,VE_FECHA,VE_HORA,VE_SUBTOT,VE_DESCUE,
            VE_NETO,VE_IVA,VE_CARGO,VE_VALPAG,VE_OBSERV,VE_LEYENDA,VE_EFECTIVO,VE_VALOTROS,VE_CAMBIO,VE_PREANT,VE_VALLETRAS,VE_MOTIVO,
            ESTADO,GU_NUMERO,VE_CONTAB
            FROM FA_VENTA
            WHERE VE_NUMERO = r_ventas.ve_numero
            AND ES_CODIGO = r_ventas.es_codigo
            AND EM_CODIGO = r_ventas.em_codigo
            AND SU_CODIGO = r_ventas.su_codigo
            AND BO_CODIGO = r_ventas.bo_codigo;
            -- Si levanta una excepcion

            UPDATE FA_DETVE
            SET ES_CODIGO = decode(r_ventas.es_codigo,5,1,6,2)
            WHERE VE_NUMERO = r_ventas.ve_numero
            AND ES_CODIGO = r_ventas.es_codigo
            AND EM_CODIGO = r_ventas.em_codigo
            AND SU_CODIGO = r_ventas.su_codigo
            AND BO_CODIGO = r_ventas.bo_codigo;

            IF SQL%NOTFOUND THEN
            RAISE fallo_actualizar;
            END IF;

            UPDATE FA_RECPAG
            SET ES_CODIGO =  decode(r_ventas.es_codigo,5,1,6,2)
            WHERE VE_NUMERO = r_ventas.ve_numero
            AND ES_CODIGO = r_ventas.es_codigo
            AND EM_CODIGO = r_ventas.em_codigo
            AND SU_CODIGO = r_ventas.su_codigo
            AND BO_CODIGO = r_ventas.bo_codigo;

            IF SQL%NOTFOUND THEN
            RAISE fallo_actualizar;
            END IF;


            --Eliminar el registro que esta marcado como ANULADO estado = '6'
            DELETE FROM FA_VENTA
            WHERE ES_CODIGO =  r_ventas.es_codigo
            AND EM_CODIGO     =  r_ventas.em_codigo
            AND SU_CODIGO     =  r_ventas.su_codigo
            AND BO_CODIGO     =  r_ventas.bo_codigo
            AND VE_NUMERO    =  r_ventas.ve_numero;
            IF SQL%NOTFOUND THEN
            RAISE fallo_actualizar;
            END IF;
              

            --Ingresa items en el kardex con fecha de la factura tanto kits como atomos

            
           -- Se procesa todos los registros recuperados en el cursor
            for  reg1 in c_detalleventa loop
                    --1  Si es KIT tambien inserta el KIT
                                            --asignar secuencial de mov de inv
                        IF reg1.kit = 'S' then                    
                                            
                                 SELECT IT_CODIGO
                                 INTO v_itcodigo_atomo
                                 FROM IN_RELITEM
                                 WHERE IT_CODIGO1 = reg1.itcodigo;
                            /*    
                                IF v_itcodigo_atomo <> NULL THEN
                                                    
                                INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,IT_CODIGO,IT_COSTO)
                                VALUES(2,'E',reg1.em_codigo,reg1.su_codigo,reg1.bo_codigo,nro,v_itcodigo_atomo,reg1.costo);
                            

                                INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,IT_CODIGO,IT_COSTO)
                                VALUES(2,'E',reg1.em_codigo,reg1.su_codigo,reg1.bo_codigo,nro,reg1.itcodigo,reg1.costo);
                        else
                               INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,IT_CODIGO,IT_COSTO)
                                VALUES(2,'E',reg1.em_codigo,reg1.su_codigo,reg1.bo_codigo,nro,reg1.itcodigo,reg1.costo);                       
                        end if;
                        */ 
                        end if;
            end loop;
            

            --Crea nuevamente la cuenta por cobrar si la factura es al por mayor.       

  END LOOP;

  CLOSE c_cursor;

  ao_codigo_error := '1';
  ao_mensaje_error := NULL;
  
EXCEPTION
      WHEN fallo_actualizar THEN
          rollback;
     WHEN OTHERS THEN
         ao_codigo_error := '0';
         ao_mensaje_error := 'Error Proceso Reversar Anulación. ' || SUBSTR (SQLERRM, 1, 4000);
  
END SP_REVERSA_ANULACION_VENTA;
/


--
-- SP_RECALCULAR_STOCK  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.SP_RECALCULAR_STOCK IS
tmpVar NUMBER;
v_stockbodega   in_itebod.ib_stock%TYPE;
v_stocksucursal  in_itesucur.it_stock%TYPE;


CURSOR c_inbode IS 
SELECT it_codigo,em_codigo,su_codigo,bo_codigo
FROM   IN_ITEBOD
WHERE em_codigo = '1' 
ORDER BY su_codigo,bo_codigo,it_codigo;


CURSOR c_itsucur IS
SELECT it_codigo,em_codigo,su_codigo
FROM IN_ITESUCUR
WHERE em_codigo = '1'
ORDER BY su_codigo,it_codigo;

/*---------------------------------------------------------------------------------*/

BEGIN
   tmpVar := 0;
   v_stockbodega := 0;
   v_stocksucursal := 0;
   
   for reg1  in c_inbode loop
   
                select nvl(sum(decode(tm_ioe,'I',nvl(mv_cantid,0),'E',nvl(mv_cantid,0) * -1,0)),0)
                into v_stockbodega
                from in_movim
                where em_codigo = reg1.em_codigo
                and su_codigo = reg1.su_codigo
                and bo_codigo = reg1.bo_codigo
                and it_codigo  = reg1.it_codigo;
                            
                IF SQL%NOTFOUND THEN
                    v_stockbodega := 0;
                END IF; 
                                       
                update in_itebod
                set ib_stock = v_stockbodega
                where em_codigo = reg1.em_codigo
                and su_codigo = reg1.su_codigo
                and bo_codigo = reg1.bo_codigo
                and it_codigo = reg1.it_codigo;
     
   end loop; 
   
   
   for reg2 in c_itsucur loop
                select nvl(sum(decode(tm_ioe,'I',mv_cantid,'E',mv_cantid * -1,0)),0)
                into v_stocksucursal
                from in_movim
                where em_codigo = reg2.em_codigo
                and su_codigo = reg2.su_codigo
                and it_codigo  = reg2.it_codigo;
                
                if SQL%NOTFOUND then
                v_stocksucursal := 0;
                end if;
                                  
                update in_itesucur
                set it_stock = v_stocksucursal, 
                     it_stkreal = v_stocksucursal,
                     it_stkdis = v_stocksucursal
                where em_codigo = reg2.em_codigo
                and su_codigo = reg2.su_codigo
                and it_codigo = reg2.it_codigo;
                
   end loop;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       ROLLBACK;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
      ROLLBACK;
END SP_RECALCULAR_STOCK;
/


--
-- SP_DESCARGA_STOCK  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.sp_descarga_stock (as_item varchar,as_atomo varchar,ach_kit varchar ,
                                                                                           as_empresa varchar, as_sucursal varchar,as_bodega varchar,
                                                                                           ac_cantatomo number,ad_cantidad number) IS
tmpVar NUMBER;

BEGIN
   tmpVar := 0;
  
--descarga stock sucursal
   
if ach_kit = 'S' then

    update in_itesucur
    set  it_stock   = it_stock    - (ad_cantidad * ac_cantatomo),
          it_stkreal = it_stkreal - (ad_cantidad * ac_cantatomo),
          it_stkdis  = it_stkdis  -  (ad_cantidad * ac_cantatomo)        
    where it_codigo   = as_atomo
    and    em_codigo = as_empresa
    and    su_codigo  = as_sucursal;
   
    update in_itebod
    set ib_stock = ib_stock - (ad_cantidad * ac_cantatomo)
    where it_codigo = as_atomo
    and em_codigo = as_empresa
    and su_codigo  = as_sucursal
    and bo_codigo  = as_bodega;
    
    --Ingresa el movimiento al kardex del atomo
     
     INSERT INTO "IN_MOVIM"  
         ( "TM_CODIGO",  
           "TM_IOE",   
           "IT_CODIGO",   
           "EM_CODIGO",   
           "SU_CODIGO",   
           "BO_CODIGO",   
           "MV_NUMERO",   
           "MV_CANTID",   
           "MV_COSTO",   
           "MV_FECHA",   
           "MV_OBSERV",   
           "MV_USADO",   
           "VE_NUMERO",   
           "ES_CODIGO",   
           "ESTADO",   
           "MV_CONTAB",   
           "MV_COSTPROM",   
           "MV_COSTTRANS" )  
  VALUES ( '2',   
           'E',   
           as_item,   
           as_empresa,   
           as_sucursal,   
           as_bodega,   
           'num_movim',   
           ad_cantidad,   
           0,   
           sysdate,   
           'Factura. Venta',   
          null,   
           'num_factura',   
           '1',   
           null,   
           null,   
           0,   
           0)  ;
    
     
end if  ;

--descarga el stock de la sucursal
update in_itesucur
set it_stock  = it_stock - ad_cantidad,
    it_stkreal = it_stkreal - ad_cantidad,
    it_stkdis  = it_stkdis - ad_cantidad
where it_codigo = as_item
and em_codigo  = as_empresa
and su_codigo   = as_sucursal;

--descarga stock bodega
update in_itebod
set ib_stock = ib_stock - ad_cantidad
where it_codigo = as_item
and em_codigo = as_empresa
and su_codigo =  as_sucursal
and bo_codigo =  as_bodega;

-- Ingresa el movimiento al KARDEX del 



  
EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END sp_descarga_stock;
/


--
-- SP_CAMBIAAFACTURA  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DINAMIC.SP_CAMBIAAFACTURA (ai_cadena VARCHAR2 ,ao_codigo_error out NUMBER,ao_mensaje_error out varchar) IS


TYPE cur_typ IS REF CURSOR;

c_cursor                     cur_typ;
r_ventas                     fa_venta%ROWTYPE;
v_query                      VARCHAR2 (10000);
fallo_actualizar            EXCEPTION;

cursor c_detalleventa is
            select i.it_codigo,i.it_kit,d.dv_candes 
            from fa_detve d, in_item i
            where i.it_codigo = d.it_codigo
            and d.es_codigo  =  r_ventas.es_codigo
            and d.em_codigo =  r_ventas.em_codigo
            and d.su_codigo  =  r_ventas.su_codigo
            and d.bo_codigo  =  r_ventas.bo_codigo
            and d.ve_numero = r_ventas.ve_numero;

------------------------------------------------------------------------------------------------------------------------      
BEGIN

  DBMS_APPLICATION_INFO.set_module ('PKG_BAJASNEW', 'PROCESAR_BAJAS_INGRESADAS PRC');

  v_query := ai_cadena;

  OPEN c_cursor FOR v_query;

  LOOP

     FETCH c_cursor INTO r_ventas;

     EXIT WHEN c_cursor%NOTFOUND;
--Cambia de estado de NOTA DE CREDITO a FACTURA

            INSERT INTO FA_VENTA(ES_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO,CJ_CAJA,CE_CODIGO,EP_CODIGO,VE_NUMPRE,VE_FECHA,VE_HORA,VE_SUBTOT,VE_DESCUE,
            VE_NETO,VE_IVA,VE_CARGO,VE_VALPAG,VE_OBSERV,VE_LEYENDA,VE_EFECTIVO,VE_VALOTROS,VE_CAMBIO,VE_PREANT,VE_VALLETRAS,VE_MOTIVO,
            ESTADO,GU_NUMERO,VE_CONTAB)
            SELECT DECODE(r_ventas.es_codigo,5,1,6,2),EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO,CJ_CAJA,CE_CODIGO,EP_CODIGO,VE_NUMPRE,VE_FECHA,VE_HORA,VE_SUBTOT,VE_DESCUE,
            VE_NETO,VE_IVA,VE_CARGO,VE_VALPAG,VE_OBSERV,VE_LEYENDA,VE_EFECTIVO,VE_VALOTROS,VE_CAMBIO,VE_PREANT,VE_VALLETRAS,VE_MOTIVO,
            ESTADO,GU_NUMERO,VE_CONTAB
            FROM FA_VENTA
            WHERE VE_NUMERO = r_ventas.ve_numero
            AND ES_CODIGO = r_ventas.es_codigo
            AND EM_CODIGO = r_ventas.em_codigo
            AND SU_CODIGO = r_ventas.su_codigo
            AND BO_CODIGO = r_ventas.bo_codigo;
            -- Si levanta una excepcion

            UPDATE FA_DETVE
            SET ES_CODIGO = decode(r_ventas.es_codigo,5,1,6,2)
            WHERE VE_NUMERO = r_ventas.ve_numero
            AND ES_CODIGO = r_ventas.es_codigo
            AND EM_CODIGO = r_ventas.em_codigo
            AND SU_CODIGO = r_ventas.su_codigo
            AND BO_CODIGO = r_ventas.bo_codigo;

            IF SQL%NOTFOUND THEN
            RAISE fallo_actualizar;
            END IF;

            UPDATE FA_RECPAG
            SET ES_CODIGO =  decode(r_ventas.es_codigo,5,1,6,2)
            WHERE VE_NUMERO = r_ventas.ve_numero
            AND ES_CODIGO = r_ventas.es_codigo
            AND EM_CODIGO = r_ventas.em_codigo
            AND SU_CODIGO = r_ventas.su_codigo
            AND BO_CODIGO = r_ventas.bo_codigo;

            IF SQL%NOTFOUND THEN
            RAISE fallo_actualizar;
            END IF;


            --Eliminar el registro que esta marcado como ANULADO estado = '6'
            DELETE FROM FA_VENTA
            WHERE ES_CODIGO =  r_ventas.es_codigo
            AND EM_CODIGO     =  r_ventas.em_codigo
            AND SU_CODIGO     =  r_ventas.su_codigo
            AND BO_CODIGO     =  r_ventas.bo_codigo
            AND VE_NUMERO    =  r_ventas.ve_numero;
            IF SQL%NOTFOUND THEN
            RAISE fallo_actualizar;
            END IF;
              

            --Ingresa items en el kardex con fecha de la factura tanto kits como atomos

            /*
           -- Se procesa todos los registros recuperados en el cursor
            For  reg1 in c_detalleventa loop
                    --1  Si es KIT tambien inserta el KIT
                    if ls_kit = ''S"  then

                    --asignar secuencial de mov de inv
                    INSERT INTO IN_MOVIM

                    --asignar sec de mov de inv
                    INSERT INTO IN_MOVIM 
                    else

                    --2.Inserta el atomo solamente
                    --asignar sec de mov de inv
                    INSERT INTO IN_MOVIM
                    end if;
            end loop;
            */

            --Crea nuevamente la cuenta por cobrar si la factura es al por mayor.       

  END LOOP;

  CLOSE c_cursor;

  ao_codigo_error := '1';
  ao_mensaje_error := NULL;
  
EXCEPTION
     WHEN OTHERS THEN
         ao_codigo_error := '0';
         ao_mensaje_error := 'Error Proceso Reversar Anulación. ' || SUBSTR (SQLERRM, 1, 4000);
END;
/


--
-- FACTURA  (View) 
--
CREATE OR REPLACE FORCE VIEW DINAMIC.FACTURA
(ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO, 
 CJ_CAJA, CE_CODIGO, EP_CODIGO, VE_NUMPRE, VE_FECHA, 
 VE_HORA, VE_SUBTOT, VE_DESCUE, VE_NETO, VE_IVA, 
 VE_CARGO, VE_VALPAG, VE_OBSERV, VE_LEYENDA, VE_EFECTIVO, 
 VE_VALOTROS, VE_CAMBIO, VE_MOTIVO, VE_PREANT, VE_VALLETRAS, 
 DV_SECUE, DV_CANDES, DV_PRECIO, DV_DESC1, DV_DESC2, 
 DV_DESC3, DV_TOTAL, DV_MOTOR, DV_CHASIS, CL_CODIGO, 
 IT_CODANT, IT_NOMBRE, CE_TELBOD, CE_RUCIC, CE_NOMREP, 
 CE_APEREP, CE_ACTIVIDAD, CE_NOMBRE, CE_APELLI, CE_TIPO, 
 CE_RAZONS, CE_HORBOD, CE_REFBOD, CE_CADOM1, CE_CADOM2, 
 CE_SECDOM, CE_CAOFI1, CE_CAOF2, CE_SECOFI, CE_CAENT1, 
 CE_CAENT2, CE_SECENT, CE_TELDOM, CE_TELOFI, TC_CODIGO, 
 SU_CIUDAD, SU_RUC, SU_CALLE1, SU_CALLE2, SU_JUZGADO, 
 EM_RUC, EM_NOMBRE, EP_SALUDO, EP_APEPAT)
AS 
SELECT "FA_VENTA"."ES_CODIGO",
       "FA_VENTA"."EM_CODIGO",
       "FA_VENTA"."SU_CODIGO",
       "FA_VENTA"."BO_CODIGO",
       "FA_VENTA"."VE_NUMERO",
       "FA_VENTA"."CJ_CAJA",
       "FA_VENTA"."CE_CODIGO",
       "FA_VENTA"."EP_CODIGO",
       "FA_VENTA"."VE_NUMPRE",
       "FA_VENTA"."VE_FECHA",
       "FA_VENTA"."VE_HORA",
       "FA_VENTA"."VE_SUBTOT",
       "FA_VENTA"."VE_DESCUE",
       "FA_VENTA"."VE_NETO",
       "FA_VENTA"."VE_IVA",
       "FA_VENTA"."VE_CARGO",
       "FA_VENTA"."VE_VALPAG",
       "FA_VENTA"."VE_OBSERV",
       "FA_VENTA"."VE_LEYENDA",
       "FA_VENTA"."VE_EFECTIVO",
       "FA_VENTA"."VE_VALOTROS",
       "FA_VENTA"."VE_CAMBIO",
       "FA_VENTA"."VE_MOTIVO",
       "FA_VENTA"."VE_PREANT",
       "FA_VENTA"."VE_VALLETRAS",
       "FA_DETVE"."DV_SECUE",
       "FA_DETVE"."DV_CANDES",
       "FA_DETVE"."DV_PRECIO",
       "FA_DETVE"."DV_DESC1",
       "FA_DETVE"."DV_DESC2",
       "FA_DETVE"."DV_DESC3",
       "FA_DETVE"."DV_TOTAL",
       "FA_DETVE"."DV_MOTOR",
       "FA_DETVE"."DV_CHASIS",
       "IN_ITEM"."CL_CODIGO",
       "IN_ITEM"."IT_CODANT",
       "IN_ITEM"."IT_NOMBRE",
       "FA_CLIEN"."CE_TELBOD",
       "FA_CLIEN"."CE_RUCIC",
       "FA_CLIEN"."CE_NOMREP",
       "FA_CLIEN"."CE_APEREP",
       "FA_CLIEN"."CE_ACTIVIDAD",
       "FA_CLIEN"."CE_NOMBRE",
       "FA_CLIEN"."CE_APELLI",
       "FA_CLIEN"."CE_TIPO",
       "FA_CLIEN"."CE_RAZONS",
       "FA_CLIEN"."CE_HORBOD",
       "FA_CLIEN"."CE_REFBOD",
       "FA_CLIEN"."CE_CADOM1",
       "FA_CLIEN"."CE_CADOM2",
       "FA_CLIEN"."CE_SECDOM",
       "FA_CLIEN"."CE_CAOFI1",
       "FA_CLIEN"."CE_CAOF2",
       "FA_CLIEN"."CE_SECOFI",
       "FA_CLIEN"."CE_CAENT1",
       "FA_CLIEN"."CE_CAENT2",
       "FA_CLIEN"."CE_SECENT",
       "FA_CLIEN"."CE_TELDOM",
       "FA_CLIEN"."CE_TELOFI",
       "FA_CLIEN"."TC_CODIGO",
       "PR_SUCUR"."SU_CIUDAD",
       "PR_SUCUR"."SU_RUC",
       "PR_SUCUR"."SU_CALLE1",
       "PR_SUCUR"."SU_CALLE2",
       "PR_SUCUR"."SU_JUZGADO",
       "PR_EMPRE"."EM_RUC",
       "PR_EMPRE"."EM_NOMBRE",
       "NO_EMPLE"."EP_SALUDO",
       "NO_EMPLE"."EP_APEPAT"
  FROM "FA_VENTA",
       "FA_CLIEN",
       "NO_EMPLE",
       "FA_DETVE",
       "IN_ITEM",
       "PR_EMPRE",
       "PR_SUCUR"
 WHERE     "NO_EMPLE"."EP_CODIGO" = "FA_VENTA"."EP_CODIGO"
       AND "FA_VENTA"."CE_CODIGO" = "FA_CLIEN"."CE_CODIGO"
       AND "FA_DETVE"."ES_CODIGO" = "FA_VENTA"."ES_CODIGO"
       AND "FA_DETVE"."EM_CODIGO" = "FA_VENTA"."EM_CODIGO"
       AND "FA_DETVE"."SU_CODIGO" = "FA_VENTA"."SU_CODIGO"
       AND "FA_DETVE"."BO_CODIGO" = "FA_VENTA"."BO_CODIGO"
       AND "FA_DETVE"."VE_NUMERO" = "FA_VENTA"."VE_NUMERO"
       AND "IN_ITEM"."IT_CODIGO" = "FA_DETVE"."IT_CODIGO"
       AND "PR_EMPRE"."EM_CODIGO" = "FA_VENTA"."EM_CODIGO"
       AND "PR_SUCUR"."SU_CODIGO" = "FA_VENTA"."SU_CODIGO";


--
-- IN_MOVIM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_MOVIM FOR DINAMIC.IN_MOVIM;


--
-- IN_ITEEMP  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITEEMP FOR DINAMIC.IN_ITEEMP;


--
-- IN_ITEDET  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITEDET FOR DINAMIC.IN_ITEDET;


--
-- IN_ITEBOD  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_ITEBOD FOR DINAMIC.IN_ITEBOD;


--
-- IN_HTITEM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_HTITEM FOR DINAMIC.IN_HTITEM;


--
-- IN_HOJTEC  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_HOJTEC FOR DINAMIC.IN_HOJTEC;


--
-- IN_DETTRANS  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_DETTRANS FOR DINAMIC.IN_DETTRANS;


--
-- IN_DESCITEM  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_DESCITEM FOR DINAMIC.IN_DESCITEM;


--
-- FA_RECPAG  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_RECPAG FOR DINAMIC.FA_RECPAG;


--
-- FA_DETVE  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_DETVE FOR DINAMIC.FA_DETVE;


--
-- FA_DETDEVOL  (Synonym) 
--
CREATE PUBLIC SYNONYM FA_DETDEVOL FOR DINAMIC.FA_DETDEVOL;


--
-- FACTURA  (Synonym) 
--
CREATE PUBLIC SYNONYM FACTURA FOR DINAMIC.FACTURA;


--
-- CP_DETDEB  (Synonym) 
--
CREATE PUBLIC SYNONYM CP_DETDEB FOR DINAMIC.CP_DETDEB;


--
-- CP_CRUCE  (Synonym) 
--
CREATE PUBLIC SYNONYM CP_CRUCE FOR DINAMIC.CP_CRUCE;


--
-- CP_CABDEB  (Synonym) 
--
CREATE PUBLIC SYNONYM CP_CABDEB FOR DINAMIC.CP_CABDEB;


--
-- CC_CRUCE  (Synonym) 
--
CREATE PUBLIC SYNONYM CC_CRUCE FOR DINAMIC.CC_CRUCE;


--
-- CC_CHEQUE  (Synonym) 
--
CREATE PUBLIC SYNONYM CC_CHEQUE FOR DINAMIC.CC_CHEQUE;


--
-- IN_AJUSTE  (Table) 
--
CREATE TABLE DINAMIC.IN_AJUSTE
(
  AJ_NUMERO     VARCHAR2(20 BYTE)               NOT NULL,
  TM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  TM_IOE        CHAR(1 BYTE)                    NOT NULL,
  IT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  DA_CANTIDAD   NUMBER(16,4)                    NOT NULL,
  DA_SECUEN     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  ESTADO        VARCHAR2(1 BYTE),
  DA_ESTADO     CHAR(1 BYTE),
  OR_CODIGO     VARCHAR2(20 BYTE),
  DA_COSTO      NUMBER(16,4),
  DA_CANTIDAD2  NUMBER(14,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DETCO  (Table) 
--
CREATE TABLE DINAMIC.IN_DETCO
(
  EM_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  SU_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  BO_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  IT_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  EC_CODIGO     VARCHAR2(20 BYTE)               NOT NULL,
  CO_NUMERO     NUMBER(38)                      NOT NULL,
  DC_SECUE      NUMBER(38)                      NOT NULL,
  DC_CANTID     NUMBER(9,3)                     NOT NULL,
  DC_COSTO      NUMBER(16,4)                    NOT NULL,
  DC_DESC1      NUMBER(5,2)                     NOT NULL,
  DC_DESC2      NUMBER(5,2)                     NOT NULL,
  DC_DESC3      NUMBER(5,2)                     NOT NULL,
  DC_SUBTOT     NUMBER(14,2)                    NOT NULL,
  DC_TOTAL      NUMBER(14,2)                    NOT NULL,
  DC_UTILIDAD   NUMBER(5,2)                     NOT NULL,
  DC_PREACT     NUMBER(14,2)                    NOT NULL,
  DC_NUEPRE     NUMBER(14,2)                    NOT NULL,
  DC_ACTUALIZA  CHAR(1 BYTE)                    NOT NULL,
  DC_SALDO      NUMBER(9,3),
  ESTADO        VARCHAR2(1 BYTE),
  DC_DEVOLU     NUMBER(9),
  DC_DFECHA     DATE,
  DC_NUMND      VARCHAR2(20 BYTE),
  DC_TOTDEV     NUMBER(9),
  CO_NUMPAD     NUMBER(38)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          896K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DETTOMA  (Table) 
--
CREATE TABLE DINAMIC.IN_DETTOMA
(
  TS_NUMERO  VARCHAR2(20 BYTE)                  NOT NULL,
  IT_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  EM_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  SU_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  BO_CODIGO  VARCHAR2(20 BYTE)                  NOT NULL,
  DS_SECUE   VARCHAR2(20 BYTE)                  NOT NULL,
  DS_CANTID  NUMBER(9,3)                        NOT NULL,
  ESTADO     VARCHAR2(1 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_AJUSTE  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_AJUSTE ON DINAMIC.IN_AJUSTE
(AJ_NUMERO, TM_CODIGO, TM_IOE, IT_CODIGO, DA_SECUEN, 
SU_CODIGO, EM_CODIGO, BO_CODIGO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_DETCO  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_DETCO ON DINAMIC.IN_DETCO
(EM_CODIGO, SU_CODIGO, BO_CODIGO, IT_CODIGO, EC_CODIGO, 
CO_NUMERO, DC_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          640K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DETCO_IDX  (Index) 
--
CREATE INDEX DINAMIC.IN_DETCO_IDX ON DINAMIC.IN_DETCO
(EM_CODIGO, SU_CODIGO, EC_CODIGO, CO_NUMERO)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- PK_IN_DETTOMA  (Index) 
--
CREATE UNIQUE INDEX DINAMIC.PK_IN_DETTOMA ON DINAMIC.IN_DETTOMA
(TS_NUMERO, IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, 
DS_SECUE)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          192K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- IN_DETTOMA  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_DETTOMA FOR DINAMIC.IN_DETTOMA;


--
-- IN_DETCO  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_DETCO FOR DINAMIC.IN_DETCO;


--
-- IN_AJUSTE  (Synonym) 
--
CREATE PUBLIC SYNONYM IN_AJUSTE FOR DINAMIC.IN_AJUSTE;


-- 
-- Non Foreign Key Constraints for Table FA_CAJA 
-- 
ALTER TABLE DINAMIC.FA_CAJA ADD (
  CONSTRAINT PK_FA_CAJA
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, CJ_CAJA)
  USING INDEX DINAMIC.PK_FA_CAJA);


-- 
-- Non Foreign Key Constraints for Table FA_CLACLI 
-- 
ALTER TABLE DINAMIC.FA_CLACLI ADD (
  CONSTRAINT PK_FA_CLACLI
  PRIMARY KEY
  (CA_CODIGO)
  USING INDEX DINAMIC.PK_FA_CLACLI);


-- 
-- Non Foreign Key Constraints for Table FA_DCTOCLI 
-- 
ALTER TABLE DINAMIC.FA_DCTOCLI ADD (
  CONSTRAINT PK_FA_DCTOCLI
  PRIMARY KEY
  (DC_CODIGO)
  USING INDEX DINAMIC.PK_FA_DCTOCLI);


-- 
-- Non Foreign Key Constraints for Table FA_ESTADO 
-- 
ALTER TABLE DINAMIC.FA_ESTADO ADD (
  CONSTRAINT PK_FA_ESTADO
  PRIMARY KEY
  (ES_CODIGO)
  USING INDEX DINAMIC.PK_FA_ESTADO);


-- 
-- Non Foreign Key Constraints for Table FA_REFERENCIA 
-- 
ALTER TABLE DINAMIC.FA_REFERENCIA ADD (
  CONSTRAINT PK_RF
  PRIMARY KEY
  (COD_CLIE)
  USING INDEX DINAMIC.PK_RF);


-- 
-- Non Foreign Key Constraints for Table FA_TIPCLI 
-- 
ALTER TABLE DINAMIC.FA_TIPCLI ADD (
  CONSTRAINT PK_FA_TIPCLI
  PRIMARY KEY
  (TC_CODIGO)
  USING INDEX DINAMIC.PK_FA_TIPCLI);


-- 
-- Non Foreign Key Constraints for Table IN_COESTADO 
-- 
ALTER TABLE DINAMIC.IN_COESTADO ADD (
  CONSTRAINT PK_IN_COESTADO
  PRIMARY KEY
  (EC_CODIGO)
  USING INDEX DINAMIC.PK_IN_COESTADO);


-- 
-- Non Foreign Key Constraints for Table IN_COSTO 
-- 
ALTER TABLE DINAMIC.IN_COSTO ADD (
  CONSTRAINT PK_IN_COSTO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, IT_CODIGO, CT_FECHA)
  USING INDEX DINAMIC.PK_IN_COSTO);


-- 
-- Non Foreign Key Constraints for Table IN_DOCPRO 
-- 
ALTER TABLE DINAMIC.IN_DOCPRO ADD (
  CONSTRAINT PK_INDOCPRO
  PRIMARY KEY
  (ID)
  USING INDEX DINAMIC.PK_INDOCPRO);


-- 
-- Non Foreign Key Constraints for Table IN_FORMULAS 
-- 
ALTER TABLE DINAMIC.IN_FORMULAS ADD (
  CONSTRAINT PK_INFORMULAS
  PRIMARY KEY
  (FO_CODIGO, EM_CODIGO)
  USING INDEX DINAMIC.PK_INFORMULAS);


-- 
-- Non Foreign Key Constraints for Table IN_FORPARAM 
-- 
ALTER TABLE DINAMIC.IN_FORPARAM ADD (
  CONSTRAINT PK_IN_FORMPARAM
  PRIMARY KEY
  (EM_CODIGO, FO_CODPAR)
  USING INDEX DINAMIC.PK_IN_FORMPARAM);


-- 
-- Non Foreign Key Constraints for Table IN_ITEMRES 
-- 
ALTER TABLE DINAMIC.IN_ITEMRES ADD (
  CONSTRAINT PK_ITEMRES
  PRIMARY KEY
  (EM_CODIGO, IT_CODIGO)
  USING INDEX DINAMIC.PK_ITEMRES);


-- 
-- Non Foreign Key Constraints for Table IN_TIPRELITEM 
-- 
ALTER TABLE DINAMIC.IN_TIPRELITEM ADD (
  CONSTRAINT PK_IN_TIPRELITEM
  PRIMARY KEY
  (TR_CODIGO)
  USING INDEX DINAMIC.PK_IN_TIPRELITEM);


-- 
-- Non Foreign Key Constraints for Table AN_RETAIR 
-- 
ALTER TABLE DINAMIC.AN_RETAIR ADD (
  CONSTRAINT PK_AN_RETAIR
  PRIMARY KEY
  (NUMRUC, ANIO, MES, TPIDPROV, IDPROV, TIPOCOMP, AUT, ESTAB, PTOEMI, SEC, FECHAEMICOM, CODRETAIR)
  USING INDEX DINAMIC.PK_AN_RETAIR);


-- 
-- Non Foreign Key Constraints for Table CB_CABCOBT 
-- 
ALTER TABLE DINAMIC.CB_CABCOBT ADD (
  CONSTRAINT PK_CB_CABCOBT
  PRIMARY KEY
  (BT_CODIGO, EM_CODIGO)
  USING INDEX DINAMIC.PK_CB_CABCOBT);


-- 
-- Non Foreign Key Constraints for Table CB_CUENTIPO 
-- 
ALTER TABLE DINAMIC.CB_CUENTIPO ADD (
  CONSTRAINT PK_CUENTIPO
  PRIMARY KEY
  (CUENTA, TIPO)
  USING INDEX DINAMIC.PK_CUENTIPO);


-- 
-- Non Foreign Key Constraints for Table CB_DETCOBT 
-- 
ALTER TABLE DINAMIC.CB_DETCOBT ADD (
  CONSTRAINT PK_CB_DETCOBT
  PRIMARY KEY
  (BT_CODIGO, EM_CODIGO, PT_SECUE)
  USING INDEX DINAMIC.PK_CB_DETCOBT);


-- 
-- Non Foreign Key Constraints for Table CB_TARJETAS 
-- 
ALTER TABLE DINAMIC.CB_TARJETAS ADD (
  CONSTRAINT PK_CB_TARJETAS
  PRIMARY KEY
  (CT_CODIGO, EM_CODIGO)
  USING INDEX DINAMIC.PK_CB_TARJETAS);


-- 
-- Non Foreign Key Constraints for Table CB_TIPO 
-- 
ALTER TABLE DINAMIC.CB_TIPO ADD (
  CONSTRAINT PK_CB_TIPO
  PRIMARY KEY
  (TN_CODIGO)
  USING INDEX DINAMIC.PK_CB_TIPO);


-- 
-- Non Foreign Key Constraints for Table CC_RETEN 
-- 
ALTER TABLE DINAMIC.CC_RETEN ADD (
  CONSTRAINT PK_CC_RETEN
  PRIMARY KEY
  (RF_CODIGO)
  USING INDEX DINAMIC.PK_CC_RETEN);


-- 
-- Non Foreign Key Constraints for Table CO_CABAUT 
-- 
ALTER TABLE DINAMIC.CO_CABAUT ADD (
  CONSTRAINT PK_CO_CABAUT
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, CT_CODIGO)
  USING INDEX DINAMIC.PK_CO_CABAUT);


-- 
-- Non Foreign Key Constraints for Table CO_CABREP 
-- 
ALTER TABLE DINAMIC.CO_CABREP ADD (
  CONSTRAINT PK_CABREP
  PRIMARY KEY
  (EM_CODIGO, CR_CODIGO)
  USING INDEX DINAMIC.PK_CABREP);


-- 
-- Non Foreign Key Constraints for Table AN_VENTAS 
-- 
ALTER TABLE DINAMIC.AN_VENTAS ADD (
  CONSTRAINT PK_AN_VENTAS
  PRIMARY KEY
  (ANIO, MES, TPIDCLIENTE, IDCLIENTE, TIPOCOMPROBANTE)
  USING INDEX DINAMIC.PK_AN_VENTAS);


-- 
-- Non Foreign Key Constraints for Table AN_ANULADOS 
-- 
ALTER TABLE DINAMIC.AN_ANULADOS ADD (
  CONSTRAINT PK_AN_ANULADOS
  PRIMARY KEY
  (ANIO, MES, TIPOCOMPROBANTE, ESTABLECIMIENTO, PUNTOEMISION, SECUENCIALINICIO, SECUENCIALFIN, AUTORIZACION)
  USING INDEX DINAMIC.PK_AN_ANULADOS);


-- 
-- Non Foreign Key Constraints for Table AN_TIPCOM 
-- 
ALTER TABLE DINAMIC.AN_TIPCOM ADD (
  CONSTRAINT AN_TIPCOM_PK
  PRIMARY KEY
  (TC_CODIGO)
  USING INDEX DINAMIC.AN_TIPCOM_PK);


-- 
-- Non Foreign Key Constraints for Table TMP_CONDORMIX 
-- 
ALTER TABLE DINAMIC.TMP_CONDORMIX ADD (
  CONSTRAINT PK_CONDORMIX
  PRIMARY KEY
  (SEC)
  USING INDEX DINAMIC.PK_CONDORMIX);


-- 
-- Non Foreign Key Constraints for Table IN_UNIBAS 
-- 
ALTER TABLE DINAMIC.IN_UNIBAS ADD (
  CONSTRAINT PK_IN_UNIBAS
  PRIMARY KEY
  (UB_CODIGO)
  USING INDEX DINAMIC.PK_IN_UNIBAS);


-- 
-- Non Foreign Key Constraints for Table KITS 
-- 
ALTER TABLE DINAMIC.KITS ADD (
  CONSTRAINT PK_KIT
  PRIMARY KEY
  (CODIGO)
  USING INDEX DINAMIC.PK_KIT);


-- 
-- Non Foreign Key Constraints for Table NO_CARGO 
-- 
ALTER TABLE DINAMIC.NO_CARGO ADD (
  CONSTRAINT PK_NO_CARGO
  PRIMARY KEY
  (CR_CODIGO)
  USING INDEX DINAMIC.PK_NO_CARGO);


-- 
-- Non Foreign Key Constraints for Table NO_PARENT 
-- 
ALTER TABLE DINAMIC.NO_PARENT ADD (
  CONSTRAINT PK_NO_PARENT
  PRIMARY KEY
  (PF_CODIGO)
  USING INDEX DINAMIC.PK_NO_PARENT);


-- 
-- Non Foreign Key Constraints for Table NO_RUBRO 
-- 
ALTER TABLE DINAMIC.NO_RUBRO ADD (
  CONSTRAINT PK_NO_RUBRO
  PRIMARY KEY
  (RU_CODIGO)
  USING INDEX DINAMIC.PK_NO_RUBRO);


-- 
-- Non Foreign Key Constraints for Table NO_SUBRUB 
-- 
ALTER TABLE DINAMIC.NO_SUBRUB ADD (
  CONSTRAINT PK_NO_SUBRUB
  PRIMARY KEY
  (RU_CODPAD, RU_CODIGO)
  USING INDEX DINAMIC.PK_NO_SUBRUB);


-- 
-- Non Foreign Key Constraints for Table NO_TIPPRES 
-- 
ALTER TABLE DINAMIC.NO_TIPPRES ADD (
  CONSTRAINT PK_NO_TIPPRES
  PRIMARY KEY
  (TP_CODIGO)
  USING INDEX DINAMIC.PK_NO_TIPPRES);


-- 
-- Non Foreign Key Constraints for Table PD_CTRPRD 
-- 
ALTER TABLE DINAMIC.PD_CTRPRD ADD (
  CONSTRAINT PK_CTRPRD
  PRIMARY KEY
  (CR_CODIGO)
  USING INDEX DINAMIC.PK_CTRPRD);


-- 
-- Non Foreign Key Constraints for Table PD_ORDPRD 
-- 
ALTER TABLE DINAMIC.PD_ORDPRD ADD (
  CONSTRAINT PK_PD_ORDPRD
  PRIMARY KEY
  (OR_CODIGO)
  USING INDEX DINAMIC.PK_PD_ORDPRD);


-- 
-- Non Foreign Key Constraints for Table PD_PEDIDO 
-- 
ALTER TABLE DINAMIC.PD_PEDIDO ADD (
  CONSTRAINT PK_PD_PEDIDO
  PRIMARY KEY
  (PE_CODIGO)
  USING INDEX DINAMIC.PK_PD_PEDIDO);


-- 
-- Non Foreign Key Constraints for Table PD_RECETA 
-- 
ALTER TABLE DINAMIC.PD_RECETA ADD (
  CONSTRAINT PK_PD_RECETA
  PRIMARY KEY
  (RT_CODIGO)
  USING INDEX DINAMIC.PK_PD_RECETA);


-- 
-- Non Foreign Key Constraints for Table PD_REQMAT 
-- 
ALTER TABLE DINAMIC.PD_REQMAT ADD (
  CONSTRAINT PK_PD_REQMAT
  PRIMARY KEY
  (RM_CODIGO)
  USING INDEX DINAMIC.PK_PD_REQMAT);


-- 
-- Non Foreign Key Constraints for Table PR_GRUPCONT 
-- 
ALTER TABLE DINAMIC.PR_GRUPCONT ADD (
  CONSTRAINT PK_GRUPCONT
  PRIMARY KEY
  (GT_CODIGO)
  USING INDEX DINAMIC.PK_GRUPCONT);


-- 
-- Non Foreign Key Constraints for Table PR_INSTFIN 
-- 
ALTER TABLE DINAMIC.PR_INSTFIN ADD (
  CONSTRAINT PK_PR_INSTFIN
  PRIMARY KEY
  (IF_CODIGO)
  USING INDEX DINAMIC.PK_PR_INSTFIN);


-- 
-- Non Foreign Key Constraints for Table PR_MODSYS 
-- 
ALTER TABLE DINAMIC.PR_MODSYS ADD (
  CONSTRAINT PK_MODSYS
  PRIMARY KEY
  (MD_CODIGO)
  USING INDEX DINAMIC.PK_MODSYS);


-- 
-- Non Foreign Key Constraints for Table PR_NUMSUC 
-- 
ALTER TABLE DINAMIC.PR_NUMSUC ADD (
  CONSTRAINT PK_PR_NUMSUC
  PRIMARY KEY
  (SU_CODIGO, PR_NOMBRE)
  USING INDEX DINAMIC.PK_PR_NUMSUC);


-- 
-- Non Foreign Key Constraints for Table PR_PAIS 
-- 
ALTER TABLE DINAMIC.PR_PAIS ADD (
  CONSTRAINT PK_PR_PAIS
  PRIMARY KEY
  (PA_CODIGO)
  USING INDEX DINAMIC.PK_PR_PAIS);


-- 
-- Non Foreign Key Constraints for Table PR_PREMIOS 
-- 
ALTER TABLE DINAMIC.PR_PREMIOS ADD (
  CONSTRAINT PK_PREMIO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, PE_CODIGO)
  USING INDEX DINAMIC.PK_PREMIO);


-- 
-- Non Foreign Key Constraints for Table PR_PROV 
-- 
ALTER TABLE DINAMIC.PR_PROV ADD (
  CONSTRAINT PK_PROV
  PRIMARY KEY
  (PA_CODIGO, PO_CODIGO)
  USING INDEX DINAMIC.PK_PROV);


-- 
-- Non Foreign Key Constraints for Table RP_MAX_MIN 
-- 
ALTER TABLE DINAMIC.RP_MAX_MIN ADD (
  CONSTRAINT PK_MAX_MIN
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, BO_CODIGO, IT_CODIGO)
  USING INDEX DINAMIC.PK_MAX_MIN);


-- 
-- Non Foreign Key Constraints for Table SG_MENU 
-- 
ALTER TABLE DINAMIC.SG_MENU ADD (
  CONSTRAINT PK_SG_MENU
  PRIMARY KEY
  (MN_CODIGO)
  USING INDEX DINAMIC.PK_SG_MENU);


-- 
-- Non Foreign Key Constraints for Table SG_ROL 
-- 
ALTER TABLE DINAMIC.SG_ROL ADD (
  CONSTRAINT PK_SG_ROL
  PRIMARY KEY
  (RS_NOMBRE)
  USING INDEX DINAMIC.PK_SG_ROL);


-- 
-- Non Foreign Key Constraints for Table SG_ROLMENU 
-- 
ALTER TABLE DINAMIC.SG_ROLMENU ADD (
  CONSTRAINT PK_SG_ROLMENU
  PRIMARY KEY
  (MN_CODIGO, RS_NOMBRE)
  USING INDEX DINAMIC.PK_SG_ROLMENU);


-- 
-- Non Foreign Key Constraints for Table TMP_CLI 
-- 
ALTER TABLE DINAMIC.TMP_CLI ADD (
  CONSTRAINT PK_CLI
  PRIMARY KEY
  (CODIGO)
  USING INDEX DINAMIC.PK_CLI);


-- 
-- Non Foreign Key Constraints for Table TMP_CXC 
-- 
ALTER TABLE DINAMIC.TMP_CXC ADD (
  CONSTRAINT PK_CXC
  PRIMARY KEY
  (SEC)
  USING INDEX DINAMIC.PK_CXC);


-- 
-- Non Foreign Key Constraints for Table TMP_ITEMS 
-- 
ALTER TABLE DINAMIC.TMP_ITEMS ADD (
  CONSTRAINT PK_I
  PRIMARY KEY
  (I_CODIGO)
  USING INDEX DINAMIC.PK_I);


-- 
-- Non Foreign Key Constraints for Table TMP_KITS 
-- 
ALTER TABLE DINAMIC.TMP_KITS ADD (
  CONSTRAINT PK_K
  PRIMARY KEY
  (CODIGO)
  USING INDEX DINAMIC.PK_K);


-- 
-- Non Foreign Key Constraints for Table TMP_REL 
-- 
ALTER TABLE DINAMIC.TMP_REL ADD (
  CONSTRAINT PK_REL
  PRIMARY KEY
  (SEC)
  USING INDEX DINAMIC.PK_REL);


-- 
-- Non Foreign Key Constraints for Table IN_FORTINTE 
-- 
ALTER TABLE DINAMIC.IN_FORTINTE ADD (
  CONSTRAINT PK_IN_FORTINTE
  PRIMARY KEY
  (EM_CODIGO, FO_CODIGO, IT_CODIGO)
  USING INDEX DINAMIC.PK_IN_FORTINTE);


-- 
-- Non Foreign Key Constraints for Table IN_TINTE 
-- 
ALTER TABLE DINAMIC.IN_TINTE ADD (
  CONSTRAINT PK_TINTE
  PRIMARY KEY
  (FT_CODIGO)
  USING INDEX DINAMIC.PK_TINTE);


-- 
-- Non Foreign Key Constraints for Table CC_COMISIONES 
-- 
ALTER TABLE DINAMIC.CC_COMISIONES ADD (
  CONSTRAINT PK_COMISIONES
  PRIMARY KEY
  (SECUENCIAL)
  USING INDEX DINAMIC.PK_COMISIONES);


-- 
-- Non Foreign Key Constraints for Table CO_DETREP 
-- 
ALTER TABLE DINAMIC.CO_DETREP ADD (
  CONSTRAINT PK_DETREP
  PRIMARY KEY
  (EM_CODIGO, CR_CODIGO, DR_COLUMNA)
  USING INDEX DINAMIC.PK_DETREP);


-- 
-- Non Foreign Key Constraints for Table IN_EQUIVALENCIA 
-- 
ALTER TABLE DINAMIC.IN_EQUIVALENCIA ADD (
  CONSTRAINT PK_IN_EQUIVALENCIA
  PRIMARY KEY
  (UB_CODIGO, UB_CODEQU)
  USING INDEX DINAMIC.PK_IN_EQUIVALENCIA);


-- 
-- Non Foreign Key Constraints for Table CB_DETTAR 
-- 
ALTER TABLE DINAMIC.CB_DETTAR ADD (
  CONSTRAINT PK_CB_DETTAR
  PRIMARY KEY
  (CT_CODIGO, EM_CODIGO, DT_SECUE)
  USING INDEX DINAMIC.PK_CB_DETTAR);


-- 
-- Non Foreign Key Constraints for Table NO_CARFAM 
-- 
ALTER TABLE DINAMIC.NO_CARFAM ADD (
  CONSTRAINT PK_NO_CARFAM
  PRIMARY KEY
  (EP_CODIGO, CF_CODIGO)
  USING INDEX DINAMIC.PK_NO_CARFAM);


-- 
-- Non Foreign Key Constraints for Table NO_RUBCAL 
-- 
ALTER TABLE DINAMIC.NO_RUBCAL ADD (
  CONSTRAINT PK_NO_RUBCAL
  PRIMARY KEY
  (RU_CODIGO)
  USING INDEX DINAMIC.PK_NO_RUBCAL);


-- 
-- Non Foreign Key Constraints for Table PD_DETPED 
-- 
ALTER TABLE DINAMIC.PD_DETPED ADD (
  CONSTRAINT PK_PD_DETPED
  PRIMARY KEY
  (PE_CODIGO, DP_SECUE)
  USING INDEX DINAMIC.PK_PD_DETPED);


-- 
-- Non Foreign Key Constraints for Table PD_DETREQ 
-- 
ALTER TABLE DINAMIC.PD_DETREQ ADD (
  CONSTRAINT PK_PD_DETREQ
  PRIMARY KEY
  (RM_CODIGO, RE_SECUE)
  USING INDEX DINAMIC.PK_PD_DETREQ);


-- 
-- Non Foreign Key Constraints for Table PD_DETRTA 
-- 
ALTER TABLE DINAMIC.PD_DETRTA ADD (
  CONSTRAINT PK_PD_DETRTA
  PRIMARY KEY
  (RT_CODIGO, RQ_SECUE)
  USING INDEX DINAMIC.PK_PD_DETRTA);


-- 
-- Non Foreign Key Constraints for Table PD_ORDCIF 
-- 
ALTER TABLE DINAMIC.PD_ORDCIF ADD (
  CONSTRAINT PK_PD_ORDCIF
  PRIMARY KEY
  (OR_CODIGO, CF_SECUE)
  USING INDEX DINAMIC.PK_PD_ORDCIF);


-- 
-- Non Foreign Key Constraints for Table PD_ORDMPD 
-- 
ALTER TABLE DINAMIC.PD_ORDMPD ADD (
  CONSTRAINT PK_PD_ORDMPD
  PRIMARY KEY
  (OR_CODIGO, DR_SECUE)
  USING INDEX DINAMIC.PK_PD_ORDMPD);


-- 
-- Non Foreign Key Constraints for Table PR_CANTON 
-- 
ALTER TABLE DINAMIC.PR_CANTON ADD (
  CONSTRAINT PK_CANTON
  PRIMARY KEY
  (PA_CODIGO, PO_CODIGO, CT_CODIGO)
  USING INDEX DINAMIC.PK_CANTON);


-- 
-- Non Foreign Key Constraints for Table PR_CIUDAD 
-- 
ALTER TABLE DINAMIC.PR_CIUDAD ADD (
  CONSTRAINT PK_PR_CIUDAD
  PRIMARY KEY
  (PA_CODIGO, CU_CODIGO)
  USING INDEX DINAMIC.PK_PR_CIUDAD);


-- 
-- Non Foreign Key Constraints for Table PR_EMPRE 
-- 
ALTER TABLE DINAMIC.PR_EMPRE ADD (
  CONSTRAINT PK_PR_EMPRE
  PRIMARY KEY
  (EM_CODIGO)
  USING INDEX DINAMIC.PK_PR_EMPRE);


-- 
-- Non Foreign Key Constraints for Table PR_PARAM 
-- 
ALTER TABLE DINAMIC.PR_PARAM ADD (
  CONSTRAINT PK_PR_PARAM
  PRIMARY KEY
  (PR_NOMBRE, EM_CODIGO)
  USING INDEX DINAMIC.PK_PR_PARAM);


-- 
-- Non Foreign Key Constraints for Table PR_SUCUR 
-- 
ALTER TABLE DINAMIC.PR_SUCUR ADD (
  CONSTRAINT PK_PR_SUCUR
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO)
  USING INDEX DINAMIC.PK_PR_SUCUR);


-- 
-- Non Foreign Key Constraints for Table SG_ACCESO 
-- 
ALTER TABLE DINAMIC.SG_ACCESO ADD (
  CONSTRAINT PK_SG_ACCESO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, SA_LOGIN)
  USING INDEX DINAMIC.PK_SG_ACCESO);


-- 
-- Non Foreign Key Constraints for Table CO_ESTCTA 
-- 
ALTER TABLE DINAMIC.CO_ESTCTA ADD (
  CONSTRAINT PK_CO_ESTCTA
  PRIMARY KEY
  (EM_CODIGO, EC_LONTOT)
  USING INDEX DINAMIC.PK_CO_ESTCTA);


-- 
-- Non Foreign Key Constraints for Table CO_PLACTA 
-- 
ALTER TABLE DINAMIC.CO_PLACTA ADD (
  CONSTRAINT PK_CO_PLACTA
  PRIMARY KEY
  (EM_CODIGO, PL_CODIGO)
  USING INDEX DINAMIC.PK_CO_PLACTA);


-- 
-- Non Foreign Key Constraints for Table CO_PLANSUC 
-- 
ALTER TABLE DINAMIC.CO_PLANSUC ADD (
  CONSTRAINT PK_CO_PLANSUC
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, PL_CODIGO)
  USING INDEX DINAMIC.PK_CO_PLANSUC);


-- 
-- Non Foreign Key Constraints for Table CO_SALCTA 
-- 
ALTER TABLE DINAMIC.CO_SALCTA ADD (
  CONSTRAINT PK_CO_SALCTA
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, PL_CODIGO, SC_MES, SC_ANIO)
  USING INDEX DINAMIC.PK_CO_SALCTA);


-- 
-- Non Foreign Key Constraints for Table CO_TIPCOM 
-- 
ALTER TABLE DINAMIC.CO_TIPCOM ADD (
  CONSTRAINT PK_CO_TIPCOM
  PRIMARY KEY
  (TI_CODIGO)
  USING INDEX DINAMIC.PK_CO_TIPCOM);


-- 
-- Non Foreign Key Constraints for Table CP_TIPMOV 
-- 
ALTER TABLE DINAMIC.CP_TIPMOV ADD (
  CONSTRAINT PK_CP_TIPMOV
  PRIMARY KEY
  (TV_CODIGO, TV_TIPO)
  USING INDEX DINAMIC.PK_CP_TIPMOV);


-- 
-- Non Foreign Key Constraints for Table FA_CLIEN 
-- 
ALTER TABLE DINAMIC.FA_CLIEN ADD (
  CONSTRAINT PK_FA_CLIEN
  PRIMARY KEY
  (CE_CODIGO)
  USING INDEX DINAMIC.PK_FA_CLIEN);

ALTER TABLE DINAMIC.FA_CLIEN ADD (
  CONSTRAINT UK_RUCCI
  UNIQUE (CE_RUCIC)
  USING INDEX DINAMIC.UK_RUCCI);


-- 
-- Non Foreign Key Constraints for Table FA_CTACLI 
-- 
ALTER TABLE DINAMIC.FA_CTACLI ADD (
  CONSTRAINT PK_FA_CTACLI
  PRIMARY KEY
  (IF_CODIGO, CS_NUMERO)
  USING INDEX DINAMIC.PK_FA_CTACLI);


-- 
-- Non Foreign Key Constraints for Table FA_FORMPAG 
-- 
ALTER TABLE DINAMIC.FA_FORMPAG ADD (
  CONSTRAINT PK_FA_FORMPAG
  PRIMARY KEY
  (FP_CODIGO)
  USING INDEX DINAMIC.PK_FA_FORMPAG);


-- 
-- Non Foreign Key Constraints for Table FA_TIPMOVCA 
-- 
ALTER TABLE DINAMIC.FA_TIPMOVCA ADD (
  CONSTRAINT PK_FA_TIPMOVCA
  PRIMARY KEY
  (TJ_CODIGO)
  USING INDEX DINAMIC.PK_FA_TIPMOVCA);


-- 
-- Non Foreign Key Constraints for Table IN_BODE 
-- 
ALTER TABLE DINAMIC.IN_BODE ADD (
  CONSTRAINT PK_IN_BODE
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, BO_CODIGO)
  USING INDEX DINAMIC.PK_IN_BODE);


-- 
-- Non Foreign Key Constraints for Table IN_CABPREP 
-- 
ALTER TABLE DINAMIC.IN_CABPREP ADD (
  CONSTRAINT PK_IN_CABPREP
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, BO_CODIGO, PR_NUMERO)
  USING INDEX DINAMIC.PK_IN_CABPREP);


-- 
-- Non Foreign Key Constraints for Table IN_CLASE 
-- 
ALTER TABLE DINAMIC.IN_CLASE ADD (
  CONSTRAINT PK_IN_CLASE
  PRIMARY KEY
  (CL_CODIGO)
  USING INDEX DINAMIC.PK_IN_CLASE);


-- 
-- Non Foreign Key Constraints for Table IN_FABRICANTE 
-- 
ALTER TABLE DINAMIC.IN_FABRICANTE ADD (
  CONSTRAINT PK_IN_FABRICANTE
  PRIMARY KEY
  (FB_CODIGO)
  USING INDEX DINAMIC.PK_IN_FABRICANTE);


-- 
-- Non Foreign Key Constraints for Table IN_HTLABELS 
-- 
ALTER TABLE DINAMIC.IN_HTLABELS ADD (
  CONSTRAINT PK_IN_HTLABELS
  PRIMARY KEY
  (EM_CODIGO, LH_CODIGO)
  USING INDEX DINAMIC.PK_IN_HTLABELS);


-- 
-- Non Foreign Key Constraints for Table IN_MARCA 
-- 
ALTER TABLE DINAMIC.IN_MARCA ADD (
  CONSTRAINT PK_IN_MARCA
  PRIMARY KEY
  (MA_CODIGO)
  USING INDEX DINAMIC.PK_IN_MARCA);


-- 
-- Non Foreign Key Constraints for Table IN_PROVE 
-- 
ALTER TABLE DINAMIC.IN_PROVE ADD (
  CONSTRAINT PK_IN_PROVE
  PRIMARY KEY
  (PV_CODIGO)
  USING INDEX DINAMIC.PK_IN_PROVE);


-- 
-- Non Foreign Key Constraints for Table IN_TIMOV 
-- 
ALTER TABLE DINAMIC.IN_TIMOV ADD (
  CONSTRAINT PK_IN_TIMOV
  PRIMARY KEY
  (EM_CODIGO, TM_CODIGO, TM_IOE)
  USING INDEX DINAMIC.PK_IN_TIMOV);


-- 
-- Non Foreign Key Constraints for Table IN_TIPPRE 
-- 
ALTER TABLE DINAMIC.IN_TIPPRE ADD (
  CONSTRAINT PK_IN_TIPPRE
  PRIMARY KEY
  (TD_CODIGO)
  USING INDEX DINAMIC.PK_IN_TIPPRE);


-- 
-- Non Foreign Key Constraints for Table CB_CRUCE 
-- 
ALTER TABLE DINAMIC.CB_CRUCE ADD (
  CONSTRAINT PK_CB_CRUCE
  PRIMARY KEY
  (CT_CODIGO, EM_CODIGO, DT_SECUE, BT_CODIGO)
  USING INDEX DINAMIC.PK_CB_CRUCE);


-- 
-- Non Foreign Key Constraints for Table CB_CTAINS 
-- 
ALTER TABLE DINAMIC.CB_CTAINS ADD (
  CONSTRAINT PK_CB_CTAINS
  PRIMARY KEY
  (IF_CODIGO, CN_CODIGO)
  USING INDEX DINAMIC.PK_CB_CTAINS);


-- 
-- Non Foreign Key Constraints for Table CB_EGRESO 
-- 
ALTER TABLE DINAMIC.CB_EGRESO ADD (
  CONSTRAINT PK_CB_EGRESOS
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, EG_NUMERO, EG_ND)
  USING INDEX DINAMIC.PK_CB_EGRESOS);


-- 
-- Non Foreign Key Constraints for Table CB_INGRESO 
-- 
ALTER TABLE DINAMIC.CB_INGRESO ADD (
  CONSTRAINT PK_CB_INGRESO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, IG_NUMERO)
  USING INDEX DINAMIC.PK_CB_INGRESO);


-- 
-- Non Foreign Key Constraints for Table CC_TIPO 
-- 
ALTER TABLE DINAMIC.CC_TIPO ADD (
  CONSTRAINT PK_CC_TIPO
  PRIMARY KEY
  (TT_CODIGO, TT_IOE)
  USING INDEX DINAMIC.PK_CC_TIPO);


-- 
-- Non Foreign Key Constraints for Table CO_CABCOM 
-- 
ALTER TABLE DINAMIC.CO_CABCOM ADD (
  CONSTRAINT PK_CO_CABCOM
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, TI_CODIGO, CP_NUMERO)
  USING INDEX DINAMIC.PK_CO_CABCOM);


-- 
-- Non Foreign Key Constraints for Table CO_CENCOS 
-- 
ALTER TABLE DINAMIC.CO_CENCOS ADD (
  CONSTRAINT PK_CO_CENCOS
  PRIMARY KEY
  (EM_CODIGO, CS_CODIGO)
  USING INDEX DINAMIC.PK_CO_CENCOS);


-- 
-- Non Foreign Key Constraints for Table CO_COMAUT 
-- 
ALTER TABLE DINAMIC.CO_COMAUT ADD (
  CONSTRAINT PK_CO_COMAUT
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, CT_CODIGO, CT_COLUM, PL_CODIGO)
  USING INDEX DINAMIC.PK_CO_COMAUT);


-- 
-- Non Foreign Key Constraints for Table CO_DETCOM 
-- 
ALTER TABLE DINAMIC.CO_DETCOM ADD (
  CONSTRAINT PK_CO_DETCOM
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, TI_CODIGO, CP_NUMERO, PL_CODIGO, DT_SECUE)
  USING INDEX DINAMIC.PK_CO_DETCOM);


-- 
-- Non Foreign Key Constraints for Table CO_PLANIFF 
-- 
ALTER TABLE DINAMIC.CO_PLANIFF ADD (
  CONSTRAINT PK_PLANNIF
  PRIMARY KEY
  (EM_CODIGO, PI_CODIGO)
  USING INDEX DINAMIC.PK_PLANNIF);


-- 
-- Non Foreign Key Constraints for Table CO_CABNIFF 
-- 
ALTER TABLE DINAMIC.CO_CABNIFF ADD (
  CONSTRAINT PK_CABNIFF
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, TI_CODIGO, CI_NUMERO)
  USING INDEX DINAMIC.PK_CABNIFF);


-- 
-- Non Foreign Key Constraints for Table CO_DETNIFF 
-- 
ALTER TABLE DINAMIC.CO_DETNIFF ADD (
  CONSTRAINT PK_DETNIFF
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, TI_CODIGO, CI_NUMERO, PI_CODIGO, DI_SECUE)
  USING INDEX DINAMIC.PK_DETNIFF);


-- 
-- Non Foreign Key Constraints for Table IN_TOMFIS 
-- 
ALTER TABLE DINAMIC.IN_TOMFIS ADD (
  CONSTRAINT PK_IN_TOMFIS
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, BO_CODIGO, TS_NUMERO)
  USING INDEX DINAMIC.PK_IN_TOMFIS);


-- 
-- Non Foreign Key Constraints for Table IN_VENPRO 
-- 
ALTER TABLE DINAMIC.IN_VENPRO ADD (
  CONSTRAINT PK_IN_VENPRO
  PRIMARY KEY
  (PV_CODIGO, VP_CODIGO)
  USING INDEX DINAMIC.PK_IN_VENPRO);


-- 
-- Non Foreign Key Constraints for Table NO_DEPARTA 
-- 
ALTER TABLE DINAMIC.NO_DEPARTA ADD (
  CONSTRAINT PK_NO_DEPARTA
  PRIMARY KEY
  (EM_CODIGO, DT_CODIGO)
  USING INDEX DINAMIC.PK_NO_DEPARTA);


-- 
-- Non Foreign Key Constraints for Table NO_EMPLE 
-- 
ALTER TABLE DINAMIC.NO_EMPLE ADD (
  CONSTRAINT PK_NO_EMPLE
  PRIMARY KEY
  (EP_CODIGO)
  USING INDEX DINAMIC.PK_NO_EMPLE);


-- 
-- Non Foreign Key Constraints for Table NO_FALTA 
-- 
ALTER TABLE DINAMIC.NO_FALTA ADD (
  CONSTRAINT PK_NO_FALTA
  PRIMARY KEY
  (EP_CODIGO, PE_CODIGO, PE_TIPO)
  USING INDEX DINAMIC.PK_NO_FALTA);


-- 
-- Non Foreign Key Constraints for Table NO_PRESTAMO 
-- 
ALTER TABLE DINAMIC.NO_PRESTAMO ADD (
  CONSTRAINT PK_NO_PRESTAMO
  PRIMARY KEY
  (EP_CODIGO, PP_NUMERO)
  USING INDEX DINAMIC.PK_NO_PRESTAMO);


-- 
-- Non Foreign Key Constraints for Table NO_VACACION 
-- 
ALTER TABLE DINAMIC.NO_VACACION ADD (
  CONSTRAINT PK_NO_VACACION
  PRIMARY KEY
  (EP_CODIGO, VA_CODIGO)
  USING INDEX DINAMIC.PK_NO_VACACION);


-- 
-- Non Foreign Key Constraints for Table PR_COLOR 
-- 
ALTER TABLE DINAMIC.PR_COLOR ADD (
  CONSTRAINT PK_PR_COLOR
  PRIMARY KEY
  (CO_CODIGO)
  USING INDEX DINAMIC.PK_PR_COLOR);


-- 
-- Non Foreign Key Constraints for Table PR_NUMTRANS 
-- 
ALTER TABLE DINAMIC.PR_NUMTRANS ADD (
  CONSTRAINT PK_PR_NUMTRANS
  PRIMARY KEY
  (EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO)
  USING INDEX DINAMIC.PK_PR_NUMTRANS);


-- 
-- Non Foreign Key Constraints for Table TS_INGRESO 
-- 
ALTER TABLE DINAMIC.TS_INGRESO ADD (
  CONSTRAINT PK_TS_INGRESO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, TE_CODIGO)
  USING INDEX DINAMIC.PK_TS_INGRESO);


-- 
-- Non Foreign Key Constraints for Table CP_MOVIM 
-- 
ALTER TABLE DINAMIC.CP_MOVIM ADD (
  CONSTRAINT PK_CP_MOVIM
  PRIMARY KEY
  (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO)
  USING INDEX DINAMIC.PK_CP_MOVIM);


-- 
-- Non Foreign Key Constraints for Table CP_PAGO 
-- 
ALTER TABLE DINAMIC.CP_PAGO ADD (
  CONSTRAINT PK_CP_PAGO
  PRIMARY KEY
  (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO, PM_SECUENCIA)
  USING INDEX DINAMIC.PK_CP_PAGO);


-- 
-- Non Foreign Key Constraints for Table FA_CIERRE 
-- 
ALTER TABLE DINAMIC.FA_CIERRE ADD (
  CONSTRAINT PK_FA_CIERRE
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, CI_CODIGO, CJ_CAJA, EP_CODIGO, CI_FECHA)
  USING INDEX DINAMIC.PK_FA_CIERRE);


-- 
-- Non Foreign Key Constraints for Table FA_GUIA 
-- 
ALTER TABLE DINAMIC.FA_GUIA ADD (
  CONSTRAINT PK_FA_GUIA
  PRIMARY KEY
  (GU_NUMERO)
  USING INDEX DINAMIC.PK_FA_GUIA);


-- 
-- Non Foreign Key Constraints for Table FA_MOVCAJA 
-- 
ALTER TABLE DINAMIC.FA_MOVCAJA ADD (
  CONSTRAINT PK_FA_MOVCAJA
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, CJ_CAJA, MC_NUMERO)
  USING INDEX DINAMIC.PK_FA_MOVCAJA);


-- 
-- Non Foreign Key Constraints for Table FA_VENTA 
-- 
ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT PK_FA_VENTA
  PRIMARY KEY
  (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO)
  USING INDEX DINAMIC.PK_FA_VENTA);


-- 
-- Non Foreign Key Constraints for Table IN_CABAJUS 
-- 
ALTER TABLE DINAMIC.IN_CABAJUS ADD (
  CONSTRAINT PK_IN_CABAJUS
  PRIMARY KEY
  (SU_CODIGO, BO_CODIGO, AJ_NUMERO, TM_CODIGO, TM_IOE, EM_CODIGO)
  USING INDEX DINAMIC.PK_IN_CABAJUS);


-- 
-- Non Foreign Key Constraints for Table IN_COMPRA 
-- 
ALTER TABLE DINAMIC.IN_COMPRA ADD (
  CONSTRAINT PK_IN_COMPRA
  PRIMARY KEY
  (EC_CODIGO, EM_CODIGO, SU_CODIGO, CO_NUMERO)
  USING INDEX DINAMIC.PK_IN_COMPRA);


-- 
-- Non Foreign Key Constraints for Table IN_ITEM 
-- 
ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT PK_IN_ITEM
  PRIMARY KEY
  (EM_CODIGO, IT_CODIGO)
  USING INDEX DINAMIC.PK_IN_ITEM);

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT UK_CODANT
  UNIQUE (IT_CODANT)
  USING INDEX DINAMIC.UK_CODANT);


-- 
-- Non Foreign Key Constraints for Table IN_ITEPRO 
-- 
ALTER TABLE DINAMIC.IN_ITEPRO ADD (
  CONSTRAINT PK_IN_ITEPRO
  PRIMARY KEY
  (EM_CODIGO, IT_CODIGO, PV_CODIGO)
  USING INDEX DINAMIC.PK_IN_ITEPRO);


-- 
-- Non Foreign Key Constraints for Table IN_ITESUCUR 
-- 
ALTER TABLE DINAMIC.IN_ITESUCUR ADD (
  CONSTRAINT PK_IN_ITESUCUR
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, IT_CODIGO)
  USING INDEX DINAMIC.PK_IN_ITESUCUR);


-- 
-- Non Foreign Key Constraints for Table IN_ITETAR 
-- 
ALTER TABLE DINAMIC.IN_ITETAR ADD (
  CONSTRAINT PK_ITETAR
  PRIMARY KEY
  (IT_CODIGO, IF_CODIGO, EM_CODIGO)
  USING INDEX DINAMIC.PK_ITETAR);


-- 
-- Non Foreign Key Constraints for Table IN_PREPARADO 
-- 
ALTER TABLE DINAMIC.IN_PREPARADO ADD (
  CONSTRAINT PK_IN_PREPARADO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, BO_CODIGO, PR_NUMERO, PR_SECUENCIA, IT_CODIGO, IT_CODPREP)
  USING INDEX DINAMIC.PK_IN_PREPARADO);


-- 
-- Non Foreign Key Constraints for Table IN_RELITEM 
-- 
ALTER TABLE DINAMIC.IN_RELITEM ADD (
  CONSTRAINT PK_IN_RELITEM
  PRIMARY KEY
  (TR_CODIGO, IT_CODIGO1, EM_CODIGO, IT_CODIGO)
  USING INDEX DINAMIC.PK_IN_RELITEM);


-- 
-- Non Foreign Key Constraints for Table CB_DETING 
-- 
ALTER TABLE DINAMIC.CB_DETING ADD (
  CONSTRAINT PK_CB_DETING
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, IG_NUMERO, PL_CODIGO, DI_SECUE)
  USING INDEX DINAMIC.PK_CB_DETING);


-- 
-- Non Foreign Key Constraints for Table CC_MOVIM 
-- 
ALTER TABLE DINAMIC.CC_MOVIM ADD (
  CONSTRAINT PK_CC_MOVIM
  PRIMARY KEY
  (TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO)
  USING INDEX DINAMIC.PK_CC_MOVIM);


-- 
-- Non Foreign Key Constraints for Table IN_TRANSFER 
-- 
ALTER TABLE DINAMIC.IN_TRANSFER ADD (
  CONSTRAINT PK_IN_TRANSFER
  PRIMARY KEY
  (EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO, TF_TICKET)
  USING INDEX DINAMIC.PK_IN_TRANSFER);


-- 
-- Non Foreign Key Constraints for Table NO_ASISTENCIA 
-- 
ALTER TABLE DINAMIC.NO_ASISTENCIA ADD (
  CONSTRAINT PK_NO_ASISTENCIA
  PRIMARY KEY
  (EM_CODIGO, EP_CODIGO, AS_FECHA)
  USING INDEX DINAMIC.PK_NO_ASISTENCIA);


-- 
-- Non Foreign Key Constraints for Table NO_CABROL 
-- 
ALTER TABLE DINAMIC.NO_CABROL ADD (
  CONSTRAINT PK_NO_CABROL
  PRIMARY KEY
  (EP_CODIGO, RR_CODIGO)
  USING INDEX DINAMIC.PK_NO_CABROL);


-- 
-- Non Foreign Key Constraints for Table NO_CURSO 
-- 
ALTER TABLE DINAMIC.NO_CURSO ADD (
  CONSTRAINT PK_NO_CURSO
  PRIMARY KEY
  (EP_CODIGO, CM_CODIGO)
  USING INDEX DINAMIC.PK_NO_CURSO);


-- 
-- Non Foreign Key Constraints for Table NO_DETPAG 
-- 
ALTER TABLE DINAMIC.NO_DETPAG ADD (
  CONSTRAINT PK_NO_DETPAG
  PRIMARY KEY
  (EP_CODIGO, PP_NUMERO, DP_NUMERO)
  USING INDEX DINAMIC.PK_NO_DETPAG);


-- 
-- Non Foreign Key Constraints for Table NO_ROLPAGO 
-- 
ALTER TABLE DINAMIC.NO_ROLPAGO ADD (
  CONSTRAINT PK_NO_ROLPAGO
  PRIMARY KEY
  (EP_CODIGO, RU_CODIGO, RR_CODIGO)
  USING INDEX DINAMIC.PK_NO_ROLPAGO);


-- 
-- Non Foreign Key Constraints for Table TS_DETING 
-- 
ALTER TABLE DINAMIC.TS_DETING ADD (
  CONSTRAINT PK_TS_DETING
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, TE_CODIGO, DT_NUMDOC)
  USING INDEX DINAMIC.PK_TS_DETING);


-- 
-- Non Foreign Key Constraints for Table CP_CABDEB 
-- 
ALTER TABLE DINAMIC.CP_CABDEB ADD (
  CONSTRAINT PK_CP_CABDEB
  PRIMARY KEY
  (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO, DP_CODIGO)
  USING INDEX DINAMIC.PK_CP_CABDEB);


-- 
-- Non Foreign Key Constraints for Table CP_CRUCE 
-- 
ALTER TABLE DINAMIC.CP_CRUCE ADD (
  CONSTRAINT PK_CP_CRUCE
  PRIMARY KEY
  (TV_CODDEB, TV_TIPODEB, MP_CODDEB, TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO)
  USING INDEX DINAMIC.PK_CP_CRUCE);


-- 
-- Non Foreign Key Constraints for Table CP_DETDEB 
-- 
ALTER TABLE DINAMIC.CP_DETDEB ADD (
  CONSTRAINT PK_CP_DETDEB
  PRIMARY KEY
  (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO, DP_CODIGO, DD_SECUE)
  USING INDEX DINAMIC.PK_CP_DETDEB);


-- 
-- Non Foreign Key Constraints for Table FA_DETDEVOL 
-- 
ALTER TABLE DINAMIC.FA_DETDEVOL ADD (
  CONSTRAINT PK_FA_DETDEVOL
  PRIMARY KEY
  (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO, VE_NUMDEVOL)
  USING INDEX DINAMIC.PK_FA_DETDEVOL);


-- 
-- Non Foreign Key Constraints for Table FA_DETVE 
-- 
ALTER TABLE DINAMIC.FA_DETVE ADD (
  CONSTRAINT PK_FA_DETVE
  PRIMARY KEY
  (ES_CODIGO, BO_CODIGO, VE_NUMERO, IT_CODIGO, EM_CODIGO, SU_CODIGO, DV_SECUE)
  USING INDEX DINAMIC.PK_FA_DETVE);


-- 
-- Non Foreign Key Constraints for Table FA_RECPAG 
-- 
ALTER TABLE DINAMIC.FA_RECPAG ADD (
  CONSTRAINT PK_FA_RECPAG
  PRIMARY KEY
  (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO, RP_NUMERO)
  USING INDEX DINAMIC.PK_FA_RECPAG);


-- 
-- Non Foreign Key Constraints for Table IN_DESCITEM 
-- 
ALTER TABLE DINAMIC.IN_DESCITEM ADD (
  CONSTRAINT PK_IN_DESCITEM
  PRIMARY KEY
  (TD_CODIGO, EM_CODIGO, IT_CODIGO, ES_CODIGO)
  USING INDEX DINAMIC.PK_IN_DESCITEM);


-- 
-- Non Foreign Key Constraints for Table IN_DETTRANS 
-- 
ALTER TABLE DINAMIC.IN_DETTRANS ADD (
  CONSTRAINT PK_IN_DETTRANS
  PRIMARY KEY
  (EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO, TF_TICKET, DF_SECUEN, IT_CODIGO)
  USING INDEX DINAMIC.PK_IN_DETTRANS);


-- 
-- Non Foreign Key Constraints for Table IN_HOJTEC 
-- 
ALTER TABLE DINAMIC.IN_HOJTEC ADD (
  CONSTRAINT PK_IN_HOJTEC
  PRIMARY KEY
  (HT_CODHOJA)
  USING INDEX DINAMIC.PK_IN_HOJTEC);


-- 
-- Non Foreign Key Constraints for Table IN_HTITEM 
-- 
ALTER TABLE DINAMIC.IN_HTITEM ADD (
  CONSTRAINT PK_IN_HTITEM
  PRIMARY KEY
  (HT_CODHOJA, EM_CODIGO, LH_CODIGO)
  USING INDEX DINAMIC.PK_IN_HTITEM);


-- 
-- Non Foreign Key Constraints for Table IN_ITEBOD 
-- 
ALTER TABLE DINAMIC.IN_ITEBOD ADD (
  CONSTRAINT PK_IN_ITEBOD
  PRIMARY KEY
  (IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO)
  USING INDEX DINAMIC.PK_IN_ITEBOD);


-- 
-- Non Foreign Key Constraints for Table IN_ITEDET 
-- 
ALTER TABLE DINAMIC.IN_ITEDET ADD (
  CONSTRAINT PK_IN_ITEDET
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, DI_REF1)
  USING INDEX DINAMIC.PK_IN_ITEDET);


-- 
-- Non Foreign Key Constraints for Table IN_ITEEMP 
-- 
ALTER TABLE DINAMIC.IN_ITEEMP ADD (
  CONSTRAINT PK_IN_ITEEMP
  PRIMARY KEY
  (EM_CODIGO, IT_CODIGO, IT_FECHA)
  USING INDEX DINAMIC.PK_IN_ITEEMP);


-- 
-- Non Foreign Key Constraints for Table IN_MOVIM 
-- 
ALTER TABLE DINAMIC.IN_MOVIM ADD (
  CONSTRAINT PK_IN_MOVIM
  PRIMARY KEY
  (TM_CODIGO, TM_IOE, IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, MV_NUMERO)
  USING INDEX DINAMIC.PK_IN_MOVIM);


-- 
-- Non Foreign Key Constraints for Table CC_CHEQUE 
-- 
ALTER TABLE DINAMIC.CC_CHEQUE ADD (
  CONSTRAINT PK_CC_CHEQUE
  PRIMARY KEY
  (TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO, CH_SECUE)
  USING INDEX DINAMIC.PK_CC_CHEQUE);


-- 
-- Non Foreign Key Constraints for Table CC_CRUCE 
-- 
ALTER TABLE DINAMIC.CC_CRUCE ADD (
  CONSTRAINT PK_CC_CRUCE
  PRIMARY KEY
  (TT_CODDEB, TT_IOEDEB, MT_CODDEB, TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO)
  USING INDEX DINAMIC.PK_CC_CRUCE);


-- 
-- Non Foreign Key Constraints for Table IN_AJUSTE 
-- 
ALTER TABLE DINAMIC.IN_AJUSTE ADD (
  CONSTRAINT PK_IN_AJUSTE
  PRIMARY KEY
  (AJ_NUMERO, TM_CODIGO, TM_IOE, IT_CODIGO, DA_SECUEN, SU_CODIGO, EM_CODIGO, BO_CODIGO)
  USING INDEX DINAMIC.PK_IN_AJUSTE);


-- 
-- Non Foreign Key Constraints for Table IN_DETCO 
-- 
ALTER TABLE DINAMIC.IN_DETCO ADD (
  CONSTRAINT PK_IN_DETCO
  PRIMARY KEY
  (EM_CODIGO, SU_CODIGO, BO_CODIGO, IT_CODIGO, EC_CODIGO, CO_NUMERO, DC_SECUE)
  USING INDEX DINAMIC.PK_IN_DETCO);


-- 
-- Non Foreign Key Constraints for Table IN_DETTOMA 
-- 
ALTER TABLE DINAMIC.IN_DETTOMA ADD (
  CONSTRAINT PK_IN_DETTOMA
  PRIMARY KEY
  (TS_NUMERO, IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, DS_SECUE)
  USING INDEX DINAMIC.PK_IN_DETTOMA);


-- 
-- Foreign Key Constraints for Table CB_DETCOBT 
-- 
ALTER TABLE DINAMIC.CB_DETCOBT ADD (
  CONSTRAINT FK_DETALLE_COBRO 
  FOREIGN KEY (BT_CODIGO, EM_CODIGO) 
  REFERENCES DINAMIC.CB_CABCOBT (BT_CODIGO,EM_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_SUBRUB 
-- 
ALTER TABLE DINAMIC.NO_SUBRUB ADD (
  CONSTRAINT FK_SUBRUBRO 
  FOREIGN KEY (RU_CODPAD) 
  REFERENCES DINAMIC.NO_RUBRO (RU_CODIGO));

ALTER TABLE DINAMIC.NO_SUBRUB ADD (
  CONSTRAINT FK_RUBRO_PADRE 
  FOREIGN KEY (RU_CODIGO) 
  REFERENCES DINAMIC.NO_RUBRO (RU_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_PROV 
-- 
ALTER TABLE DINAMIC.PR_PROV ADD (
  CONSTRAINT FK_PAS_PROV 
  FOREIGN KEY (PA_CODIGO) 
  REFERENCES DINAMIC.PR_PAIS (PA_CODIGO));


-- 
-- Foreign Key Constraints for Table SG_MENU 
-- 
ALTER TABLE DINAMIC.SG_MENU ADD (
  CONSTRAINT FK_OPCION_MENU_PADRE 
  FOREIGN KEY (MN_PADRE) 
  REFERENCES DINAMIC.SG_MENU (MN_CODIGO));


-- 
-- Foreign Key Constraints for Table SG_ROLMENU 
-- 
ALTER TABLE DINAMIC.SG_ROLMENU ADD (
  CONSTRAINT FK_ROL_OPCIONES_MENU_2 
  FOREIGN KEY (MN_CODIGO) 
  REFERENCES DINAMIC.SG_MENU (MN_CODIGO));

ALTER TABLE DINAMIC.SG_ROLMENU ADD (
  CONSTRAINT FK_ROL_OPCIONES_MENU_1 
  FOREIGN KEY (RS_NOMBRE) 
  REFERENCES DINAMIC.SG_ROL (RS_NOMBRE));


-- 
-- Foreign Key Constraints for Table CO_DETREP 
-- 
ALTER TABLE DINAMIC.CO_DETREP ADD (
  CONSTRAINT FK_CABREP_DETREP 
  FOREIGN KEY (EM_CODIGO, CR_CODIGO) 
  REFERENCES DINAMIC.CO_CABREP (EM_CODIGO,CR_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_EQUIVALENCIA 
-- 
ALTER TABLE DINAMIC.IN_EQUIVALENCIA ADD (
  CONSTRAINT FK_UNIDAD_EQUIVALENCIA 
  FOREIGN KEY (UB_CODEQU) 
  REFERENCES DINAMIC.IN_UNIBAS (UB_CODIGO));

ALTER TABLE DINAMIC.IN_EQUIVALENCIA ADD (
  CONSTRAINT FK_EQUIVALENCIA_UNIDAD 
  FOREIGN KEY (UB_CODIGO) 
  REFERENCES DINAMIC.IN_UNIBAS (UB_CODIGO));


-- 
-- Foreign Key Constraints for Table CB_DETTAR 
-- 
ALTER TABLE DINAMIC.CB_DETTAR ADD (
  CONSTRAINT FK_VOUCHER_TARJETAS 
  FOREIGN KEY (CT_CODIGO, EM_CODIGO) 
  REFERENCES DINAMIC.CB_TARJETAS (CT_CODIGO,EM_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_CARFAM 
-- 
ALTER TABLE DINAMIC.NO_CARFAM ADD (
  CONSTRAINT FK_PARENTEZCO_CARGA 
  FOREIGN KEY (PF_CODIGO) 
  REFERENCES DINAMIC.NO_PARENT (PF_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_RUBCAL 
-- 
ALTER TABLE DINAMIC.NO_RUBCAL ADD (
  CONSTRAINT FK_RUBROS_CALCULADOS 
  FOREIGN KEY (RU_CODIGO) 
  REFERENCES DINAMIC.NO_RUBRO (RU_CODIGO));


-- 
-- Foreign Key Constraints for Table PD_DETPED 
-- 
ALTER TABLE DINAMIC.PD_DETPED ADD (
  CONSTRAINT FK_PD_DETPE_RELATIONS_PD_PEDID 
  FOREIGN KEY (PE_CODIGO) 
  REFERENCES DINAMIC.PD_PEDIDO (PE_CODIGO));


-- 
-- Foreign Key Constraints for Table PD_DETREQ 
-- 
ALTER TABLE DINAMIC.PD_DETREQ ADD (
  CONSTRAINT FK_PD_DETRE_RELATIONS_PD_REQMA 
  FOREIGN KEY (RM_CODIGO) 
  REFERENCES DINAMIC.PD_REQMAT (RM_CODIGO));


-- 
-- Foreign Key Constraints for Table PD_DETRTA 
-- 
ALTER TABLE DINAMIC.PD_DETRTA ADD (
  CONSTRAINT FK_PD_DETRT_RELATIONS_PD_RECET 
  FOREIGN KEY (RT_CODIGO) 
  REFERENCES DINAMIC.PD_RECETA (RT_CODIGO));


-- 
-- Foreign Key Constraints for Table PD_ORDCIF 
-- 
ALTER TABLE DINAMIC.PD_ORDCIF ADD (
  CONSTRAINT FK_PD_ORDCI_RELATIONS_PD_ORDPR 
  FOREIGN KEY (OR_CODIGO) 
  REFERENCES DINAMIC.PD_ORDPRD (OR_CODIGO));


-- 
-- Foreign Key Constraints for Table PD_ORDMOD 
-- 
ALTER TABLE DINAMIC.PD_ORDMOD ADD (
  CONSTRAINT FK_ORDMOD_CTRPRD 
  FOREIGN KEY (CR_CODIGO) 
  REFERENCES DINAMIC.PD_CTRPRD (CR_CODIGO));

ALTER TABLE DINAMIC.PD_ORDMOD ADD (
  CONSTRAINT FK_PD_ORDMO_RELATIONS_PD_ORDPR 
  FOREIGN KEY (OR_CODIGO) 
  REFERENCES DINAMIC.PD_ORDPRD (OR_CODIGO));


-- 
-- Foreign Key Constraints for Table PD_ORDMPD 
-- 
ALTER TABLE DINAMIC.PD_ORDMPD ADD (
  CONSTRAINT FK_PD_ORDMP_RELATIONS_PD_ORDPR 
  FOREIGN KEY (OR_CODIGO) 
  REFERENCES DINAMIC.PD_ORDPRD (OR_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_CANTON 
-- 
ALTER TABLE DINAMIC.PR_CANTON ADD (
  CONSTRAINT FK_PROV_CANTON 
  FOREIGN KEY (PA_CODIGO, PO_CODIGO) 
  REFERENCES DINAMIC.PR_PROV (PA_CODIGO,PO_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_CIUDAD 
-- 
ALTER TABLE DINAMIC.PR_CIUDAD ADD (
  CONSTRAINT FK_PAIS_CIUDAD 
  FOREIGN KEY (PA_CODIGO) 
  REFERENCES DINAMIC.PR_PAIS (PA_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_EMPRE 
-- 
ALTER TABLE DINAMIC.PR_EMPRE ADD (
  CONSTRAINT FK_CIUDAD_EMPRESA 
  FOREIGN KEY (PA_CODIGO, CU_CODIGO) 
  REFERENCES DINAMIC.PR_CIUDAD (PA_CODIGO,CU_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_PARAM 
-- 
ALTER TABLE DINAMIC.PR_PARAM ADD (
  CONSTRAINT FK_EMPRESA_PARAMETRO 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_SUCUR 
-- 
ALTER TABLE DINAMIC.PR_SUCUR ADD (
  CONSTRAINT FK_EMPRESA_SUCURSAL 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table SG_ACCESO 
-- 
ALTER TABLE DINAMIC.SG_ACCESO ADD (
  CONSTRAINT FK_SEGURIDAD_SUCURSAL 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.SG_ACCESO ADD (
  CONSTRAINT FK_ROL_USUARIO 
  FOREIGN KEY (RS_NOMBRE) 
  REFERENCES DINAMIC.SG_ROL (RS_NOMBRE));


-- 
-- Foreign Key Constraints for Table CO_ESTCTA 
-- 
ALTER TABLE DINAMIC.CO_ESTCTA ADD (
  CONSTRAINT FK_EMPRESA_ESTRUCTURA_PLAN 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_PLACTA 
-- 
ALTER TABLE DINAMIC.CO_PLACTA ADD (
  CONSTRAINT FK_PLAN_CUENTAS_HIJOS 
  FOREIGN KEY (EM_CODIGO, PL_PADRE) 
  REFERENCES DINAMIC.CO_PLACTA (EM_CODIGO,PL_CODIGO));

ALTER TABLE DINAMIC.CO_PLACTA ADD (
  CONSTRAINT FK_EMPRESA_PLAN_CTAS 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_PLANSUC 
-- 
ALTER TABLE DINAMIC.CO_PLANSUC ADD (
  CONSTRAINT FK_CUENTA_AUTORIZADA_SUCURSAL 
  FOREIGN KEY (EM_CODIGO, PL_CODIGO) 
  REFERENCES DINAMIC.CO_PLACTA (EM_CODIGO,PL_CODIGO));

ALTER TABLE DINAMIC.CO_PLANSUC ADD (
  CONSTRAINT FK_CUENTAS_POR_SUCURSAL 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_SALCTA 
-- 
ALTER TABLE DINAMIC.CO_SALCTA ADD (
  CONSTRAINT FK_PLAN_CTAS_SALDO_CTA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, PL_CODIGO) 
  REFERENCES DINAMIC.CO_PLANSUC (EM_CODIGO,SU_CODIGO,PL_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_TIPCOM 
-- 
ALTER TABLE DINAMIC.CO_TIPCOM ADD (
  CONSTRAINT FK_EMPRESA_TIPO_COMPROB 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));

ALTER TABLE DINAMIC.CO_TIPCOM ADD (
  CONSTRAINT FK_CABAUT_TIPCOM 
  FOREIGN KEY (TI_CODIGO) 
  REFERENCES DINAMIC.CO_TIPCOM (TI_CODIGO));


-- 
-- Foreign Key Constraints for Table CP_TIPMOV 
-- 
ALTER TABLE DINAMIC.CP_TIPMOV ADD (
  CONSTRAINT FK_EMPRESA_TIPO_MOV_CXP 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_CLIEN 
-- 
ALTER TABLE DINAMIC.FA_CLIEN ADD (
  CONSTRAINT FK_TIPO_CLIENTE 
  FOREIGN KEY (TC_CODIGO) 
  REFERENCES DINAMIC.FA_TIPCLI (TC_CODIGO));

ALTER TABLE DINAMIC.FA_CLIEN ADD (
  CONSTRAINT FK_CLASE_CLIENTE 
  FOREIGN KEY (CA_CODIGO) 
  REFERENCES DINAMIC.FA_CLACLI (CA_CODIGO));

ALTER TABLE DINAMIC.FA_CLIEN ADD (
  CONSTRAINT FK_CIUDAD_CLIENTE 
  FOREIGN KEY (PA_CODIGO, CU_CODIGO) 
  REFERENCES DINAMIC.PR_CIUDAD (PA_CODIGO,CU_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_CTACLI 
-- 
ALTER TABLE DINAMIC.FA_CTACLI ADD (
  CONSTRAINT FK_INSTITUCION_CTA 
  FOREIGN KEY (IF_CODIGO) 
  REFERENCES DINAMIC.PR_INSTFIN (IF_CODIGO));

ALTER TABLE DINAMIC.FA_CTACLI ADD (
  CONSTRAINT FK_CLIENTE_CTASCOR 
  FOREIGN KEY (CE_CODIGO) 
  REFERENCES DINAMIC.FA_CLIEN (CE_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_FORMPAG 
-- 
ALTER TABLE DINAMIC.FA_FORMPAG ADD (
  CONSTRAINT FK_FA_FORMPAG_CO_PLACTA 
  FOREIGN KEY (EM_CODIGO, PL_CODIGO) 
  REFERENCES DINAMIC.CO_PLACTA (EM_CODIGO,PL_CODIGO));

ALTER TABLE DINAMIC.FA_FORMPAG ADD (
  CONSTRAINT FK_EMPRESA_FORMAS_PAGO 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_TIPMOVCA 
-- 
ALTER TABLE DINAMIC.FA_TIPMOVCA ADD (
  CONSTRAINT FK_EMPRESA_TIPO_MOV_CAJA 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_BODE 
-- 
ALTER TABLE DINAMIC.IN_BODE ADD (
  CONSTRAINT FK_SUCURSAL_BODEGA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_CABPREP 
-- 
ALTER TABLE DINAMIC.IN_CABPREP ADD (
  CONSTRAINT FK_SUCURSAL_PREPARADOS 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.IN_CABPREP ADD (
  CONSTRAINT FK_FK_BODEGA_PREPARADO 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_CLASE 
-- 
ALTER TABLE DINAMIC.IN_CLASE ADD (
  CONSTRAINT FK_EMPRESA_CLASES 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));

ALTER TABLE DINAMIC.IN_CLASE ADD (
  CONSTRAINT FK_CLASE_CLASE 
  FOREIGN KEY (CL_CODPAD) 
  REFERENCES DINAMIC.IN_CLASE (CL_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_FABRICANTE 
-- 
ALTER TABLE DINAMIC.IN_FABRICANTE ADD (
  CONSTRAINT FK_EMPRESA_FABRICANTE 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_HTLABELS 
-- 
ALTER TABLE DINAMIC.IN_HTLABELS ADD (
  CONSTRAINT FK_EMPRESA_SUPERTIPO 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_MARCA 
-- 
ALTER TABLE DINAMIC.IN_MARCA ADD (
  CONSTRAINT FK_EMPRESA_MARCA 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_PROVE 
-- 
ALTER TABLE DINAMIC.IN_PROVE ADD (
  CONSTRAINT FK_EMPRESA_PROVEEDOR 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));

ALTER TABLE DINAMIC.IN_PROVE ADD (
  CONSTRAINT FK_CIUDAD_PROVEEDOR 
  FOREIGN KEY (PA_CODIGO, CU_CODIGO) 
  REFERENCES DINAMIC.PR_CIUDAD (PA_CODIGO,CU_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_TIMOV 
-- 
ALTER TABLE DINAMIC.IN_TIMOV ADD (
  CONSTRAINT FK_EMPRESA_TIPO_MOV_INV 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_TIPPRE 
-- 
ALTER TABLE DINAMIC.IN_TIPPRE ADD (
  CONSTRAINT FK_EMPRESA_TIPO_DESCUENTO 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CB_CRUCE 
-- 
ALTER TABLE DINAMIC.CB_CRUCE ADD (
  CONSTRAINT FK_CRUCE_VOUCHERS 
  FOREIGN KEY (CT_CODIGO, EM_CODIGO, DT_SECUE) 
  REFERENCES DINAMIC.CB_DETTAR (CT_CODIGO,EM_CODIGO,DT_SECUE));

ALTER TABLE DINAMIC.CB_CRUCE ADD (
  CONSTRAINT FK_CRUCE_COBROS 
  FOREIGN KEY (BT_CODIGO, EM_CODIGO) 
  REFERENCES DINAMIC.CB_CABCOBT (BT_CODIGO,EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CB_CTAINS 
-- 
ALTER TABLE DINAMIC.CB_CTAINS ADD (
  CONSTRAINT FK_SUCURSAL_CUENTA_INS 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.CB_CTAINS ADD (
  CONSTRAINT FK_INST_FINA_CUENTA_COR 
  FOREIGN KEY (IF_CODIGO) 
  REFERENCES DINAMIC.PR_INSTFIN (IF_CODIGO));


-- 
-- Foreign Key Constraints for Table CB_EGRESO 
-- 
ALTER TABLE DINAMIC.CB_EGRESO ADD (
  CONSTRAINT FK_RETENCION_EGRESO 
  FOREIGN KEY (RF_CODIGO) 
  REFERENCES DINAMIC.CC_RETEN (RF_CODIGO));

ALTER TABLE DINAMIC.CB_EGRESO ADD (
  CONSTRAINT FK_RELATION_4566 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.CB_EGRESO ADD (
  CONSTRAINT FK_CTA_INST_FINAN_EGRESO 
  FOREIGN KEY (IF_CODIGO, CN_CODIGO) 
  REFERENCES DINAMIC.CB_CTAINS (IF_CODIGO,CN_CODIGO));

ALTER TABLE DINAMIC.CB_EGRESO ADD (
  CONSTRAINT FK_CONCEPTO_EGRESO 
  FOREIGN KEY (TN_CODIGO) 
  REFERENCES DINAMIC.CB_TIPO (TN_CODIGO));


-- 
-- Foreign Key Constraints for Table CB_INGRESO 
-- 
ALTER TABLE DINAMIC.CB_INGRESO ADD (
  CONSTRAINT FK_SUCURSAL_INGRESO 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.CB_INGRESO ADD (
  CONSTRAINT FK_RELATION_41159 
  FOREIGN KEY (RF_CODIGO) 
  REFERENCES DINAMIC.CC_RETEN (RF_CODIGO));

ALTER TABLE DINAMIC.CB_INGRESO ADD (
  CONSTRAINT FK_CUENTA_INST_INGRESO 
  FOREIGN KEY (IF_CODIGO, CN_CODIGO) 
  REFERENCES DINAMIC.CB_CTAINS (IF_CODIGO,CN_CODIGO));

ALTER TABLE DINAMIC.CB_INGRESO ADD (
  CONSTRAINT FK_CONCEPTO_INGRESO 
  FOREIGN KEY (TN_CODIGO) 
  REFERENCES DINAMIC.CB_TIPO (TN_CODIGO));


-- 
-- Foreign Key Constraints for Table CC_TIPO 
-- 
ALTER TABLE DINAMIC.CC_TIPO ADD (
  CONSTRAINT FK_EMPRESA_TIPO_MOV_CXC 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_CABCOM 
-- 
ALTER TABLE DINAMIC.CO_CABCOM ADD (
  CONSTRAINT FK_TIPO_COMPROBANTE 
  FOREIGN KEY (TI_CODIGO) 
  REFERENCES DINAMIC.CO_TIPCOM (TI_CODIGO));

ALTER TABLE DINAMIC.CO_CABCOM ADD (
  CONSTRAINT FK_EMPRESA_CAB_COMPROB 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));

ALTER TABLE DINAMIC.CO_CABCOM ADD (
  CONSTRAINT FK_COMPROBANTE_SUCURSAL 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_CENCOS 
-- 
ALTER TABLE DINAMIC.CO_CENCOS ADD (
  CONSTRAINT FK_EMPRESA_CENTRO_COSTOS 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_COMAUT 
-- 
ALTER TABLE DINAMIC.CO_COMAUT ADD (
  CONSTRAINT FK_COMAUT_PLANSUC 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, PL_CODIGO) 
  REFERENCES DINAMIC.CO_PLANSUC (EM_CODIGO,SU_CODIGO,PL_CODIGO));

ALTER TABLE DINAMIC.CO_COMAUT ADD (
  CONSTRAINT FK_CABAUT_COMAUT 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, CT_CODIGO) 
  REFERENCES DINAMIC.CO_CABAUT (EM_CODIGO,SU_CODIGO,CT_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_DETCOM 
-- 
ALTER TABLE DINAMIC.CO_DETCOM ADD (
  CONSTRAINT FK_CUENTA_DETALLE_COMPROBANTE 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, PL_CODIGO) 
  REFERENCES DINAMIC.CO_PLANSUC (EM_CODIGO,SU_CODIGO,PL_CODIGO));

ALTER TABLE DINAMIC.CO_DETCOM ADD (
  CONSTRAINT FK_COMPROBANTE_DETALLE 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, TI_CODIGO, CP_NUMERO) 
  REFERENCES DINAMIC.CO_CABCOM (EM_CODIGO,SU_CODIGO,TI_CODIGO,CP_NUMERO));

ALTER TABLE DINAMIC.CO_DETCOM ADD (
  CONSTRAINT FK_CENTRO_COSTOS_DETALLE 
  FOREIGN KEY (EM_CODIGO, CS_CODIGO) 
  REFERENCES DINAMIC.CO_CENCOS (EM_CODIGO,CS_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_PLANIFF 
-- 
ALTER TABLE DINAMIC.CO_PLANIFF ADD (
  CONSTRAINT FK_PLANIFF_PR_EMPRE 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_CABNIFF 
-- 
ALTER TABLE DINAMIC.CO_CABNIFF ADD (
  CONSTRAINT FK_CABNIFF_CO_TIPCOM 
  FOREIGN KEY (TI_CODIGO) 
  REFERENCES DINAMIC.CO_TIPCOM (TI_CODIGO));


-- 
-- Foreign Key Constraints for Table CO_DETNIFF 
-- 
ALTER TABLE DINAMIC.CO_DETNIFF ADD (
  CONSTRAINT FK_CO_DETNIFF_CO_PLANIFF 
  FOREIGN KEY (EM_CODIGO, PI_CODIGO) 
  REFERENCES DINAMIC.CO_PLANIFF (EM_CODIGO,PI_CODIGO));

ALTER TABLE DINAMIC.CO_DETNIFF ADD (
  CONSTRAINT FK_DETNIFF_CABNIFF 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, TI_CODIGO, CI_NUMERO) 
  REFERENCES DINAMIC.CO_CABNIFF (EM_CODIGO,SU_CODIGO,TI_CODIGO,CI_NUMERO));


-- 
-- Foreign Key Constraints for Table IN_TOMFIS 
-- 
ALTER TABLE DINAMIC.IN_TOMFIS ADD (
  CONSTRAINT FK_BODEGA_TOMAFIS 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_VENPRO 
-- 
ALTER TABLE DINAMIC.IN_VENPRO ADD (
  CONSTRAINT FK_PROVEEDOR_VENDEDOR 
  FOREIGN KEY (PV_CODIGO) 
  REFERENCES DINAMIC.IN_PROVE (PV_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_DEPARTA 
-- 
ALTER TABLE DINAMIC.NO_DEPARTA ADD (
  CONSTRAINT FK_EMPRESA_DEPARTAMENTO 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_EMPLE 
-- 
ALTER TABLE DINAMIC.NO_EMPLE ADD (
  CONSTRAINT FK_EMPLEADO_JEFE 
  FOREIGN KEY (EP_CODJEF) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));

ALTER TABLE DINAMIC.NO_EMPLE ADD (
  CONSTRAINT FK_EMPLEADO_CANTON 
  FOREIGN KEY (PA_CODIGO, PO_CODIGO, CT_CODIGO) 
  REFERENCES DINAMIC.PR_CANTON (PA_CODIGO,PO_CODIGO,CT_CODIGO));

ALTER TABLE DINAMIC.NO_EMPLE ADD (
  CONSTRAINT FK_CARGO_EMPLEADO 
  FOREIGN KEY (CR_CODIGO) 
  REFERENCES DINAMIC.NO_CARGO (CR_CODIGO));

ALTER TABLE DINAMIC.NO_EMPLE ADD (
  CONSTRAINT FK_BODEGA_SECCION_EMPLEADO 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_FALTA 
-- 
ALTER TABLE DINAMIC.NO_FALTA ADD (
  CONSTRAINT FK_EMPLEADO_FALTA 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_PRESTAMO 
-- 
ALTER TABLE DINAMIC.NO_PRESTAMO ADD (
  CONSTRAINT FK_TIPO_PRESTAMO 
  FOREIGN KEY (TP_CODIGO) 
  REFERENCES DINAMIC.NO_TIPPRES (TP_CODIGO));

ALTER TABLE DINAMIC.NO_PRESTAMO ADD (
  CONSTRAINT FK_RUBRO_PRESTAMO 
  FOREIGN KEY (RU_CODIGO) 
  REFERENCES DINAMIC.NO_RUBRO (RU_CODIGO));

ALTER TABLE DINAMIC.NO_PRESTAMO ADD (
  CONSTRAINT FK_PRESTAMO_EMPLEADO 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_VACACION 
-- 
ALTER TABLE DINAMIC.NO_VACACION ADD (
  CONSTRAINT FK_EMPLEADO_VACACION 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_COLOR 
-- 
ALTER TABLE DINAMIC.PR_COLOR ADD (
  CONSTRAINT FK_EMPRESA_COLOR 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));


-- 
-- Foreign Key Constraints for Table PR_NUMTRANS 
-- 
ALTER TABLE DINAMIC.PR_NUMTRANS ADD (
  CONSTRAINT FK_NUMERO_TRANSFER_BODEGA_2 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));

ALTER TABLE DINAMIC.PR_NUMTRANS ADD (
  CONSTRAINT FK_NUMERO_TRANSFER_BODEGA_1 
  FOREIGN KEY (EM_CODIGO, SU_CODENV, BO_CODENV) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table TS_INGRESO 
-- 
ALTER TABLE DINAMIC.TS_INGRESO ADD (
  CONSTRAINT FK_TS_SUCURSAL_INGRESO 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.TS_INGRESO ADD (
  CONSTRAINT FK_TS_INGRESO_EMPLEADO 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table CP_MOVIM 
-- 
ALTER TABLE DINAMIC.CP_MOVIM ADD (
  CONSTRAINT FK_TIPOMOVIM_MOVIM_CXP 
  FOREIGN KEY (TV_CODIGO, TV_TIPO) 
  REFERENCES DINAMIC.CP_TIPMOV (TV_CODIGO,TV_TIPO));

ALTER TABLE DINAMIC.CP_MOVIM ADD (
  CONSTRAINT FK_SUCURSAL_MOV_CXP 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.CP_MOVIM ADD (
  CONSTRAINT FK_RETENCION_MOVIM_CXP 
  FOREIGN KEY (RF_CODIGO) 
  REFERENCES DINAMIC.CC_RETEN (RF_CODIGO));

ALTER TABLE DINAMIC.CP_MOVIM ADD (
  CONSTRAINT FK_PROVEEDOR_MOVIMIENTO_CXP 
  FOREIGN KEY (PV_CODIGO) 
  REFERENCES DINAMIC.IN_PROVE (PV_CODIGO));


-- 
-- Foreign Key Constraints for Table CP_PAGO 
-- 
ALTER TABLE DINAMIC.CP_PAGO ADD (
  CONSTRAINT FP_FORMAPAGO_PAGO 
  FOREIGN KEY (FP_CODIGO) 
  REFERENCES DINAMIC.FA_FORMPAG (FP_CODIGO));

ALTER TABLE DINAMIC.CP_PAGO ADD (
  CONSTRAINT FK_MOVIMIENTO_CXP_PAGO 
  FOREIGN KEY (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO) 
  REFERENCES DINAMIC.CP_MOVIM (TV_CODIGO,TV_TIPO,EM_CODIGO,SU_CODIGO,MP_CODIGO));

ALTER TABLE DINAMIC.CP_PAGO ADD (
  CONSTRAINT FK_CUENTA_INST_PAGO_CXP 
  FOREIGN KEY (IF_CODIGO, CN_CODIGO) 
  REFERENCES DINAMIC.CB_CTAINS (IF_CODIGO,CN_CODIGO));

ALTER TABLE DINAMIC.CP_PAGO ADD (
  CONSTRAINT FK_CPPAGO_COPLANSUC 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, PL_CODIGO) 
  REFERENCES DINAMIC.CO_PLANSUC (EM_CODIGO,SU_CODIGO,PL_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_CIERRE 
-- 
ALTER TABLE DINAMIC.FA_CIERRE ADD (
  CONSTRAINT FK_CIERRE_EMPLE 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));

ALTER TABLE DINAMIC.FA_CIERRE ADD (
  CONSTRAINT FK_CIERRE_CAJA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, CJ_CAJA) 
  REFERENCES DINAMIC.FA_CAJA (EM_CODIGO,SU_CODIGO,CJ_CAJA));


-- 
-- Foreign Key Constraints for Table FA_GUIA 
-- 
ALTER TABLE DINAMIC.FA_GUIA ADD (
  CONSTRAINT FK_REF_9352 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.FA_GUIA ADD (
  CONSTRAINT FK_EMPLEADO_GUIA 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_MOVCAJA 
-- 
ALTER TABLE DINAMIC.FA_MOVCAJA ADD (
  CONSTRAINT FK_TIPO_MOVIMIENTO_CAJA 
  FOREIGN KEY (TJ_CODIGO) 
  REFERENCES DINAMIC.FA_TIPMOVCA (TJ_CODIGO));

ALTER TABLE DINAMIC.FA_MOVCAJA ADD (
  CONSTRAINT FK_SUCURSAL_MOV_CAJA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.FA_MOVCAJA ADD (
  CONSTRAINT FK_CAJA_MOVIMIENTO_CAJA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, CJ_CAJA) 
  REFERENCES DINAMIC.FA_CAJA (EM_CODIGO,SU_CODIGO,CJ_CAJA)
  ON DELETE CASCADE);


-- 
-- Foreign Key Constraints for Table FA_VENTA 
-- 
ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT FK_GUIA_VENTA 
  FOREIGN KEY (GU_NUMERO) 
  REFERENCES DINAMIC.FA_GUIA (GU_NUMERO));

ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT FK_ESTADO_VENTA 
  FOREIGN KEY (ES_CODIGO) 
  REFERENCES DINAMIC.FA_ESTADO (ES_CODIGO));

ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT FK_EMPLEADO_VENTA 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));

ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT FK_CLIENTE_VENTA 
  FOREIGN KEY (CE_CODIGO) 
  REFERENCES DINAMIC.FA_CLIEN (CE_CODIGO));

ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT FK_CAJA_VENTA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, CJ_CAJA) 
  REFERENCES DINAMIC.FA_CAJA (EM_CODIGO,SU_CODIGO,CJ_CAJA)
  ON DELETE CASCADE);

ALTER TABLE DINAMIC.FA_VENTA ADD (
  CONSTRAINT FK_BODEGA_CABECERA_VTA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_CABAJUS 
-- 
ALTER TABLE DINAMIC.IN_CABAJUS ADD (
  CONSTRAINT FK_TIPO_MOV_INV_AJUSTE 
  FOREIGN KEY (EM_CODIGO, TM_CODIGO, TM_IOE) 
  REFERENCES DINAMIC.IN_TIMOV (EM_CODIGO,TM_CODIGO,TM_IOE));

ALTER TABLE DINAMIC.IN_CABAJUS ADD (
  CONSTRAINT FK_RESPONSABLE_AJUSTE 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));

ALTER TABLE DINAMIC.IN_CABAJUS ADD (
  CONSTRAINT FK_BODEGA_CABECERA_AJUSTE 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_COMPRA 
-- 
ALTER TABLE DINAMIC.IN_COMPRA ADD (
  CONSTRAINT FK_SUCURSAL_CAB_COMPRA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.IN_COMPRA ADD (
  CONSTRAINT FK_PROVEEDOR_COMPRA 
  FOREIGN KEY (PV_CODIGO, VP_CODIGO) 
  REFERENCES DINAMIC.IN_VENPRO (PV_CODIGO,VP_CODIGO));

ALTER TABLE DINAMIC.IN_COMPRA ADD (
  CONSTRAINT FK_FORMA_PAGO_COMPRA 
  FOREIGN KEY (FP_CODIGO) 
  REFERENCES DINAMIC.FA_FORMPAG (FP_CODIGO));

ALTER TABLE DINAMIC.IN_COMPRA ADD (
  CONSTRAINT FK_ESTADO_COMPRA 
  FOREIGN KEY (EC_CODIGO) 
  REFERENCES DINAMIC.IN_COESTADO (EC_CODIGO));

ALTER TABLE DINAMIC.IN_COMPRA ADD (
  CONSTRAINT FK_COMPRA_COMPRA 
  FOREIGN KEY (EC_CODPAD, EM_CODIGO, SU_CODIGO, CO_NUMPAD) 
  REFERENCES DINAMIC.IN_COMPRA (EC_CODIGO,EM_CODIGO,SU_CODIGO,CO_NUMERO));


-- 
-- Foreign Key Constraints for Table IN_ITEM 
-- 
ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_UNIDAD_BASE_ITEM 
  FOREIGN KEY (UB_CODIGO) 
  REFERENCES DINAMIC.IN_UNIBAS (UB_CODIGO));

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_PAIS_ITEM 
  FOREIGN KEY (PA_CODIGO) 
  REFERENCES DINAMIC.PR_PAIS (PA_CODIGO));

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_MARCA_ITEM 
  FOREIGN KEY (MA_CODIGO) 
  REFERENCES DINAMIC.IN_MARCA (MA_CODIGO));

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_FABRICANTE_ITEM 
  FOREIGN KEY (FB_CODIGO) 
  REFERENCES DINAMIC.IN_FABRICANTE (FB_CODIGO));

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_EMPRESA_ITEM 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_COLOR_ITEM 
  FOREIGN KEY (CO_CODIGO) 
  REFERENCES DINAMIC.PR_COLOR (CO_CODIGO));

ALTER TABLE DINAMIC.IN_ITEM ADD (
  CONSTRAINT FK_CLASE_ITEM 
  FOREIGN KEY (CL_CODIGO) 
  REFERENCES DINAMIC.IN_CLASE (CL_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_ITEPRO 
-- 
ALTER TABLE DINAMIC.IN_ITEPRO ADD (
  CONSTRAINT FK_PROVEEDOR_ITEM 
  FOREIGN KEY (PV_CODIGO) 
  REFERENCES DINAMIC.IN_PROVE (PV_CODIGO));

ALTER TABLE DINAMIC.IN_ITEPRO ADD (
  CONSTRAINT FK_ITEM_PROVEEDOR 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_ITESUCUR 
-- 
ALTER TABLE DINAMIC.IN_ITESUCUR ADD (
  CONSTRAINT FK_ITEM_SUCURSAL_1 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_ITESUCUR ADD (
  CONSTRAINT FK_ITEMS_SUCURSAL_2 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_ITETAR 
-- 
ALTER TABLE DINAMIC.IN_ITETAR ADD (
  CONSTRAINT FK_ITETAR_ITEM 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_ITETAR ADD (
  CONSTRAINT FK_ITETAR_INSTFIN 
  FOREIGN KEY (IF_CODIGO) 
  REFERENCES DINAMIC.PR_INSTFIN (IF_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_PREPARADO 
-- 
ALTER TABLE DINAMIC.IN_PREPARADO ADD (
  CONSTRAINT FK_PREPARADOS_DETALLE 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO, PR_NUMERO) 
  REFERENCES DINAMIC.IN_CABPREP (EM_CODIGO,SU_CODIGO,BO_CODIGO,PR_NUMERO));

ALTER TABLE DINAMIC.IN_PREPARADO ADD (
  CONSTRAINT FK_PREPARACION_ITEMS 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_PREPARADO ADD (
  CONSTRAINT FK_ITEM_PREPARADO 
  FOREIGN KEY (EM_CODIGO, IT_CODPREP) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_RELITEM 
-- 
ALTER TABLE DINAMIC.IN_RELITEM ADD (
  CONSTRAINT FK_TIPO_RELACION_ITEM 
  FOREIGN KEY (TR_CODIGO) 
  REFERENCES DINAMIC.IN_TIPRELITEM (TR_CODIGO));

ALTER TABLE DINAMIC.IN_RELITEM ADD (
  CONSTRAINT FK_ITEM_RELACION_ITEM_1 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_RELITEM ADD (
  CONSTRAINT FK_ITEM_RELACION_ITEM 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO1) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table CB_DETEGR 
-- 
ALTER TABLE DINAMIC.CB_DETEGR ADD (
  CONSTRAINT FK_EGRESO_DETALLE_EGRESO 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, EG_NUMERO, EG_ND) 
  REFERENCES DINAMIC.CB_EGRESO (EM_CODIGO,SU_CODIGO,EG_NUMERO,EG_ND));


-- 
-- Foreign Key Constraints for Table CB_DETING 
-- 
ALTER TABLE DINAMIC.CB_DETING ADD (
  CONSTRAINT FK_INGRESO_DETALLE_ING 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, IG_NUMERO) 
  REFERENCES DINAMIC.CB_INGRESO (EM_CODIGO,SU_CODIGO,IG_NUMERO));


-- 
-- Foreign Key Constraints for Table CC_MOVIM 
-- 
ALTER TABLE DINAMIC.CC_MOVIM ADD (
  CONSTRAINT FK_TIPO_MOVIM_MOVIMI_CXC 
  FOREIGN KEY (TT_CODIGO, TT_IOE) 
  REFERENCES DINAMIC.CC_TIPO (TT_CODIGO,TT_IOE));

ALTER TABLE DINAMIC.CC_MOVIM ADD (
  CONSTRAINT FK_SUCURSAL_MOV_CXC 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO) 
  REFERENCES DINAMIC.PR_SUCUR (EM_CODIGO,SU_CODIGO));

ALTER TABLE DINAMIC.CC_MOVIM ADD (
  CONSTRAINT FK_RETENCION_MOVIMIENTO 
  FOREIGN KEY (RF_CODIGO) 
  REFERENCES DINAMIC.CC_RETEN (RF_CODIGO));

ALTER TABLE DINAMIC.CC_MOVIM ADD (
  CONSTRAINT FK_CLIENTE_MOVIMIENTO 
  FOREIGN KEY (CE_CODIGO) 
  REFERENCES DINAMIC.FA_CLIEN (CE_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_TRANSFER 
-- 
ALTER TABLE DINAMIC.IN_TRANSFER ADD (
  CONSTRAINT FK_EMPLEADO_TRANSFERENCIA 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));

ALTER TABLE DINAMIC.IN_TRANSFER ADD (
  CONSTRAINT FK_BOTEGA_TRANS_SALIDA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));

ALTER TABLE DINAMIC.IN_TRANSFER ADD (
  CONSTRAINT FK_BODEGA_TRANS_ENTRADA 
  FOREIGN KEY (EM_CODIGO, SU_CODENV, BO_CODENV) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_ASISTENCIA 
-- 
ALTER TABLE DINAMIC.NO_ASISTENCIA ADD (
  CONSTRAINT FK_EMPRE_ASISTENCIA 
  FOREIGN KEY (EM_CODIGO) 
  REFERENCES DINAMIC.PR_EMPRE (EM_CODIGO));

ALTER TABLE DINAMIC.NO_ASISTENCIA ADD (
  CONSTRAINT FK_EMPLE_ASISTENCIA 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_CABROL 
-- 
ALTER TABLE DINAMIC.NO_CABROL ADD (
  CONSTRAINT FK_EMPLEADO_ROL 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_CURSO 
-- 
ALTER TABLE DINAMIC.NO_CURSO ADD (
  CONSTRAINT FK_EMPLEADO_CURSO 
  FOREIGN KEY (EP_CODIGO) 
  REFERENCES DINAMIC.NO_EMPLE (EP_CODIGO));


-- 
-- Foreign Key Constraints for Table NO_DETPAG 
-- 
ALTER TABLE DINAMIC.NO_DETPAG ADD (
  CONSTRAINT FK_PAGO_DETALLE_PAGO 
  FOREIGN KEY (EP_CODIGO, PP_NUMERO) 
  REFERENCES DINAMIC.NO_PRESTAMO (EP_CODIGO,PP_NUMERO));


-- 
-- Foreign Key Constraints for Table NO_ROLPAGO 
-- 
ALTER TABLE DINAMIC.NO_ROLPAGO ADD (
  CONSTRAINT FK_RUBRO_ROL 
  FOREIGN KEY (RU_CODIGO) 
  REFERENCES DINAMIC.NO_RUBRO (RU_CODIGO));

ALTER TABLE DINAMIC.NO_ROLPAGO ADD (
  CONSTRAINT FK_CABECERAROL_DETALLEROL 
  FOREIGN KEY (EP_CODIGO, RR_CODIGO) 
  REFERENCES DINAMIC.NO_CABROL (EP_CODIGO,RR_CODIGO));


-- 
-- Foreign Key Constraints for Table TS_DETING 
-- 
ALTER TABLE DINAMIC.TS_DETING ADD (
  CONSTRAINT FK_TS_DETALLE_INGRESO 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, TE_CODIGO) 
  REFERENCES DINAMIC.TS_INGRESO (EM_CODIGO,SU_CODIGO,TE_CODIGO));


-- 
-- Foreign Key Constraints for Table CP_CABDEB 
-- 
ALTER TABLE DINAMIC.CP_CABDEB ADD (
  CONSTRAINT FK_MOVPAGO_DEBITO 
  FOREIGN KEY (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO) 
  REFERENCES DINAMIC.CP_MOVIM (TV_CODIGO,TV_TIPO,EM_CODIGO,SU_CODIGO,MP_CODIGO));


-- 
-- Foreign Key Constraints for Table CP_CRUCE 
-- 
ALTER TABLE DINAMIC.CP_CRUCE ADD (
  CONSTRAINT FK_MOVIMIENTO_DEB_CRUCE_CXP 
  FOREIGN KEY (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO) 
  REFERENCES DINAMIC.CP_MOVIM (TV_CODIGO,TV_TIPO,EM_CODIGO,SU_CODIGO,MP_CODIGO));

ALTER TABLE DINAMIC.CP_CRUCE ADD (
  CONSTRAINT FK_MOVIMIENTO_CRE_CRUCE_CXP 
  FOREIGN KEY (TV_CODDEB, TV_TIPODEB, EM_CODIGO, SU_CODIGO, MP_CODDEB) 
  REFERENCES DINAMIC.CP_MOVIM (TV_CODIGO,TV_TIPO,EM_CODIGO,SU_CODIGO,MP_CODIGO));


-- 
-- Foreign Key Constraints for Table CP_DETDEB 
-- 
ALTER TABLE DINAMIC.CP_DETDEB ADD (
  CONSTRAINT FK_CABDEBITO_DETDEBITO 
  FOREIGN KEY (TV_CODIGO, TV_TIPO, EM_CODIGO, SU_CODIGO, MP_CODIGO) 
  REFERENCES DINAMIC.CP_MOVIM (TV_CODIGO,TV_TIPO,EM_CODIGO,SU_CODIGO,MP_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_DETDEVOL 
-- 
ALTER TABLE DINAMIC.FA_DETDEVOL ADD (
  CONSTRAINT FK_VENTA_DEVOLUCION 
  FOREIGN KEY (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO) 
  REFERENCES DINAMIC.FA_VENTA (ES_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO));


-- 
-- Foreign Key Constraints for Table FA_DETVE 
-- 
ALTER TABLE DINAMIC.FA_DETVE ADD (
  CONSTRAINT FK_VENTA_DETALLE_VENTA 
  FOREIGN KEY (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO) 
  REFERENCES DINAMIC.FA_VENTA (ES_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO));

ALTER TABLE DINAMIC.FA_DETVE ADD (
  CONSTRAINT FK_ITEM_SUCURSAL_DETALLE_VTA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITESUCUR (EM_CODIGO,SU_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table FA_RECPAG 
-- 
ALTER TABLE DINAMIC.FA_RECPAG ADD (
  CONSTRAINT FK_VENTA_PAGO 
  FOREIGN KEY (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO) 
  REFERENCES DINAMIC.FA_VENTA (ES_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,VE_NUMERO));

ALTER TABLE DINAMIC.FA_RECPAG ADD (
  CONSTRAINT FK_INSTITUCION_FINAC_PAGO 
  FOREIGN KEY (IF_CODIGO) 
  REFERENCES DINAMIC.PR_INSTFIN (IF_CODIGO));

ALTER TABLE DINAMIC.FA_RECPAG ADD (
  CONSTRAINT FK_FORMA_PAGO_RECEPCION_PAGO 
  FOREIGN KEY (FP_CODIGO) 
  REFERENCES DINAMIC.FA_FORMPAG (FP_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_DESCITEM 
-- 
ALTER TABLE DINAMIC.IN_DESCITEM ADD (
  CONSTRAINT FK_ESTADO_VTA_DESCUENTO 
  FOREIGN KEY (ES_CODIGO) 
  REFERENCES DINAMIC.FA_ESTADO (ES_CODIGO));

ALTER TABLE DINAMIC.IN_DESCITEM ADD (
  CONSTRAINT FK_DESCUENTO_POR_ITEM_2 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_DESCITEM ADD (
  CONSTRAINT FK_DESCUENTO_POR_ITEM_1 
  FOREIGN KEY (TD_CODIGO) 
  REFERENCES DINAMIC.IN_TIPPRE (TD_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_DETTRANS 
-- 
ALTER TABLE DINAMIC.IN_DETTRANS ADD (
  CONSTRAINT FK_ITEM_TRANSFERENCIA 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_DETTRANS ADD (
  CONSTRAINT FK_DETALLE_TRANSFERENCIA 
  FOREIGN KEY (EM_CODIGO, SU_CODENV, BO_CODENV, SU_CODIGO, BO_CODIGO, TF_TICKET) 
  REFERENCES DINAMIC.IN_TRANSFER (EM_CODIGO,SU_CODENV,BO_CODENV,SU_CODIGO,BO_CODIGO,TF_TICKET));


-- 
-- Foreign Key Constraints for Table IN_HOJTEC 
-- 
ALTER TABLE DINAMIC.IN_HOJTEC ADD (
  CONSTRAINT FK_RELATION_53610 
  FOREIGN KEY (MA_CODIGO) 
  REFERENCES DINAMIC.IN_MARCA (MA_CODIGO));

ALTER TABLE DINAMIC.IN_HOJTEC ADD (
  CONSTRAINT FK_ITEM_HOJA_TECNICA 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_HTITEM 
-- 
ALTER TABLE DINAMIC.IN_HTITEM ADD (
  CONSTRAINT FK_TIPO_HOJA_TECNICA 
  FOREIGN KEY (HT_CODHOJA) 
  REFERENCES DINAMIC.IN_HOJTEC (HT_CODHOJA));

ALTER TABLE DINAMIC.IN_HTITEM ADD (
  CONSTRAINT FK_SUPERTIPO_TIPO 
  FOREIGN KEY (EM_CODIGO, LH_CODIGO) 
  REFERENCES DINAMIC.IN_HTLABELS (EM_CODIGO,LH_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_ITEBOD 
-- 
ALTER TABLE DINAMIC.IN_ITEBOD ADD (
  CONSTRAINT FK_ITEM_SUCURSAL_BODEGA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITESUCUR (EM_CODIGO,SU_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_ITEBOD ADD (
  CONSTRAINT FK_BODEGA_ITEM 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_BODE (EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_ITEDET 
-- 
ALTER TABLE DINAMIC.IN_ITEDET ADD (
  CONSTRAINT FK_IN_ITEDET_IN_ITEM 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_ITEEMP 
-- 
ALTER TABLE DINAMIC.IN_ITEEMP ADD (
  CONSTRAINT FK_IN_ITEEMP_IN_ITEM 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_MOVIM 
-- 
ALTER TABLE DINAMIC.IN_MOVIM ADD (
  CONSTRAINT FP_IN_MOVIM_IN_ITEM 
  FOREIGN KEY (EM_CODIGO, IT_CODIGO) 
  REFERENCES DINAMIC.IN_ITEM (EM_CODIGO,IT_CODIGO));

ALTER TABLE DINAMIC.IN_MOVIM ADD (
  CONSTRAINT FK_TIPO_MOVIMIENTO 
  FOREIGN KEY (EM_CODIGO, TM_CODIGO, TM_IOE) 
  REFERENCES DINAMIC.IN_TIMOV (EM_CODIGO,TM_CODIGO,TM_IOE));

ALTER TABLE DINAMIC.IN_MOVIM ADD (
  CONSTRAINT FK_MOVIMIENTO_ITEM 
  FOREIGN KEY (IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_ITEBOD (IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table CC_CHEQUE 
-- 
ALTER TABLE DINAMIC.CC_CHEQUE ADD (
  CONSTRAINT FK_MOV_CXC_CHEQUE 
  FOREIGN KEY (TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO) 
  REFERENCES DINAMIC.CC_MOVIM (TT_CODIGO,TT_IOE,EM_CODIGO,SU_CODIGO,MT_CODIGO));

ALTER TABLE DINAMIC.CC_CHEQUE ADD (
  CONSTRAINT FK_INST_FINANCIERA_CHEQUE 
  FOREIGN KEY (IF_CODIGO) 
  REFERENCES DINAMIC.PR_INSTFIN (IF_CODIGO));

ALTER TABLE DINAMIC.CC_CHEQUE ADD (
  CONSTRAINT FK_CHEQUE_FORMA_PAGO 
  FOREIGN KEY (FP_CODIGO) 
  REFERENCES DINAMIC.FA_FORMPAG (FP_CODIGO));


-- 
-- Foreign Key Constraints for Table CC_CRUCE 
-- 
ALTER TABLE DINAMIC.CC_CRUCE ADD (
  CONSTRAINT FK_MOVIMIENTO_DEB_CRUCE 
  FOREIGN KEY (TT_CODIGO, TT_IOE, EM_CODIGO, SU_CODIGO, MT_CODIGO) 
  REFERENCES DINAMIC.CC_MOVIM (TT_CODIGO,TT_IOE,EM_CODIGO,SU_CODIGO,MT_CODIGO));

ALTER TABLE DINAMIC.CC_CRUCE ADD (
  CONSTRAINT FK_MOVIMIENTO_CRED_CRUCE 
  FOREIGN KEY (TT_CODDEB, TT_IOEDEB, EM_CODIGO, SU_CODIGO, MT_CODDEB) 
  REFERENCES DINAMIC.CC_MOVIM (TT_CODIGO,TT_IOE,EM_CODIGO,SU_CODIGO,MT_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_AJUSTE 
-- 
ALTER TABLE DINAMIC.IN_AJUSTE ADD (
  CONSTRAINT FK_CABECERA_DETALLE_AJUSTE 
  FOREIGN KEY (SU_CODIGO, BO_CODIGO, AJ_NUMERO, TM_CODIGO, TM_IOE, EM_CODIGO) 
  REFERENCES DINAMIC.IN_CABAJUS (SU_CODIGO,BO_CODIGO,AJ_NUMERO,TM_CODIGO,TM_IOE,EM_CODIGO));

ALTER TABLE DINAMIC.IN_AJUSTE ADD (
  CONSTRAINT FK_AJUSTE_ITEM_BODEGA 
  FOREIGN KEY (IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_ITEBOD (IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO));


-- 
-- Foreign Key Constraints for Table IN_DETCO 
-- 
ALTER TABLE DINAMIC.IN_DETCO ADD (
  CONSTRAINT FK_ITEMS_DETALLE_COMPRA 
  FOREIGN KEY (IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_ITEBOD (IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO));

ALTER TABLE DINAMIC.IN_DETCO ADD (
  CONSTRAINT FK_CABECERA_DETALLE_COMPRA 
  FOREIGN KEY (EC_CODIGO, EM_CODIGO, SU_CODIGO, CO_NUMERO) 
  REFERENCES DINAMIC.IN_COMPRA (EC_CODIGO,EM_CODIGO,SU_CODIGO,CO_NUMERO));


-- 
-- Foreign Key Constraints for Table IN_DETTOMA 
-- 
ALTER TABLE DINAMIC.IN_DETTOMA ADD (
  CONSTRAINT FK_TOMAFIS_DETOMA 
  FOREIGN KEY (EM_CODIGO, SU_CODIGO, BO_CODIGO, TS_NUMERO) 
  REFERENCES DINAMIC.IN_TOMFIS (EM_CODIGO,SU_CODIGO,BO_CODIGO,TS_NUMERO));

ALTER TABLE DINAMIC.IN_DETTOMA ADD (
  CONSTRAINT FK_ITEM_BOD_DETTOMA 
  FOREIGN KEY (IT_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO) 
  REFERENCES DINAMIC.IN_ITEBOD (IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO));


GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.AN_RETAIR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC."BIN$8kn66cNJQHOKPYs2ud/3Kw==$0" TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_CABCOBT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_CUENTIPO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_DETCOBT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_TARJETAS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_TIPO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CC_COMISIONES TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CC_RETEN TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_CABAUT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_CABREP TO GENERAL_USER;

GRANT SELECT ON DINAMIC.DOCPRO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_CAJA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_CIECAJA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_CLACLI TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_DCTOCLI TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_ENTREGA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_ESTADO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_REFERENCIA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_SRIVENTAS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_TIPCLI TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_COESTADO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_DOCPRO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_FORMULAS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_FORPARAM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITEMRES TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_RECPAG TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_TIPRELITEM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_UBICA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_UNIBAS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_CARGO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_PARENT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_RUBRO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_SUBRUB TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_TIPPRES TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_CTRPRD TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_ORDPRD TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_PEDIDO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_RECETA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_REQMAT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_GRUPCONT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_INSTFIN TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_MODSYS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_NUMEROS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_NUMSUC TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_PAIS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_PREMIOS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_PROV TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.RP_MAX_MIN TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.SG_AUDIT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.SG_MENU TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.SG_ROL TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.SG_ROLMENU TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_DETTAR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_DETREP TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_EQUIVALENCIA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_CARFAM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_RUBCAL TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_DETPED TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_DETREQ TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_DETRTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_ORDCIF TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_ORDMOD TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PD_ORDMPD TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_CANTON TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_CIUDAD TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_EMPRE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_PARAM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_SUCUR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.SG_ACCESO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_CRUCE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_CTAINS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_EGRESO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_INGRESO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CC_TIPO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_CABCOM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_CENCOS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_COMAUT TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_DETCOM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_ESTCTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_PLACTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_PLANSUC TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_SALCTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CO_TIPCOM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CP_TIPMOV TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_CLIEN TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_CTACLI TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_FORMPAG TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_TIPMOVCA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_BODE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_CABPREP TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_CLASE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_FABRICANTE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_HTLABELS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_MARCA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_PROVE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_TIMOV TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_TIPPRE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_TOMFIS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_VENPRO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_DEPARTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_EMPLE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_FALTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_PRESTAMO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_VACACION TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_COLOR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.PR_NUMTRANS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.TS_INGRESO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_DETEGR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CB_DETING TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CC_MOVIM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CP_MOVIM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CP_PAGO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_CIERRE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_GUIA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_MOVCAJA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_VENTA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_CABAJUS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_COMPRA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITEM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITEPRO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITESUCUR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITETAR TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_PREPARADO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_RELITEM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_TRANSFER TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_ASISTENCIA TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_CABROL TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_CURSO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_DETPAG TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.NO_ROLPAGO TO GENERAL_USER;

GRANT EXECUTE ON DINAMIC.SP_CAMBIADESUC_MOVBANCOS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.TS_DETING TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CC_CHEQUE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CC_CRUCE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CP_CABDEB TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CP_CRUCE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.CP_DETDEB TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_DETDEVOL TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_DETVE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.FA_RECPAG TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_DESCITEM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_DETTRANS TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_HOJTEC TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_HTITEM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITEBOD TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITEDET TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_ITEEMP TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_MOVIM TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_AJUSTE TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_DETCO TO GENERAL_USER;

GRANT DELETE, INSERT, SELECT, UPDATE ON DINAMIC.IN_DETTOMA TO GENERAL_USER;