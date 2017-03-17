-- Create table
create table DINAMIC.CC_COMISIONES
(
  tt_coddeb  VARCHAR2(20) not null,
  tt_ioedeb  CHAR(1) not null,
  mt_coddeb  VARCHAR2(20) not null,
  tt_codigo  VARCHAR2(20) not null,
  tt_ioe     CHAR(1) not null,
  em_codigo  VARCHAR2(20) not null,
  su_codigo  VARCHAR2(20) not null,
  mt_codigo  VARCHAR2(20) not null,
  cr_fecha   DATE not null,
  cr_valdeb  NUMBER(14,2),
  cr_valcre  NUMBER(14,2),
  estado     VARCHAR2(1),
  ch_numero  VARCHAR2(20),
  ch_fecefec DATE,
  fp_codigo  VARCHAR2(20),
  secuencial NUMBER(5) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table DINAMIC.CC_COMISIONES
  add constraint PK_COMISIONES primary key (SECUENCIAL)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
