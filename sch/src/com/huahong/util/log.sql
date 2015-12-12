-- Create table
create table IP_LOG_INFO
(
  ID        NUMBER(10) not null,
  USER_NAME VARCHAR2(50),
  LOG_LEVEL VARCHAR2(16),
  IP        VARCHAR2(16),
  TIME      DATE,
  URL       VARCHAR2(256),
  CONTENT   VARCHAR2(512)
)
tablespace SAFEDATA
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table IP_LOG_INFO
  is '��־��Ϣ��';
-- Add comments to the columns 
comment on column IP_LOG_INFO.ID
  is '��־ID';
comment on column IP_LOG_INFO.USER_NAME
  is '�û�';
comment on column IP_LOG_INFO.LOG_LEVEL
  is '��־���𣬹��У�DEBUG��INFO��ERROR��FATAL���ּ���';
comment on column IP_LOG_INFO.IP
  is '��¼IP';
comment on column IP_LOG_INFO.TIME
  is '��־ʱ��';
comment on column IP_LOG_INFO.URL
  is '���ʵ�URL';
comment on column IP_LOG_INFO.CONTENT
  is '��־����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table IP_LOG_INFO
  add constraint PK_IP_LOG_INFO primary key (ID)
  using index 
  tablespace SAFEDATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
