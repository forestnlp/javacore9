/*测试：数据库：WEB：xx.xx orcl:NJPT/NJPT
  武汉邮政车辆年检平台
  2020.11.5
  命名规则t_nj_开始（表_）
  表名一般用简拼，少量用英文
  字段一般用简拼，少量用英文
*/
select sysdate from dual
/*机构信息,自邮一族机构信息填写机构代码*/
create table t_nj_jgxx
(
  id integer not null,/*id*/
  pid integer not null,/*上级机构id*/
  jgdm varchar2(10),/*机构代码*/
  jgmc varchar2(50),/*机构名称*/
  zjm varchar2(50),/*助记码*/
  state varchar2(1) default 1,    /*1，正常 0，停用*/

  constraint pk_t_nj_jgxx primary key(id)
);
create sequence sq_t_nj_jgxx  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*后台操作员,年检服务员,网点推广工作人员*/
create table t_nj_czy
(
  id integer not null,/*id*/
  dlmc varchar2(20),/*登录名称*/
  name varchar2(200),/*姓名*/
  zjm varchar2(20),/*助记码*/
  role_id integer,/*角色id,菜单、角色表自建*/
  jgxx_id integer,/*所属机构t_nj_jgxx.id*/
  zdxx_id integer,/*(工作检测)站点id:t_nj_zdxx.id*/
  pwd varchar2(50),/*密码*/
  wxid varchar2(50),/*微信id，绑定方法1关注自邮行天下2通过dlmc登录，系统自行关联，关联后不需再关联*/
  dh varchar2(20),/*电话号码*/
  khjlh varchar2(20),/*客户经理号,邮政业务推广人员填写*/
  state varchar2(1) default 1,    /*1，正常 0，停用*/

  constraint pk_t_nj_czy primary key(id)
);

create sequence sq_t_nj_czy  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*系统参数表*/
create table t_nj_sysparm
(
  code varchar2(3) not null,/*参数代码*/
  name varchar2(50),/*参数名称*/
  vtype varchar2(50),/*参数类型C字符N数值D日期*/
  val varchar2(50),/*参数值*/
  memo varchar2(100),/*备注*/
  constraint pk_t_nj_sysparm primary key(code)
);
insert into t_nj_sysparm(code,name,vtype,val) values('001','照片服务器IP','C','27.0.0.1');
COMMIT;

/*业务类型表*/
create table t_nj_ywlx
(
  code varchar2(4),/*业务代码：01XX会员业务，02XX违章处理，03XX年检业务*/
  name varchar2(50),/*业务说明*/
  gzxx varchar2(2000),/*告知信息*/
  state varchar2(1) default 1,    /*1，正常 0，停用*/

  add_rq date default sysdate,/*创建日期*/
  memo varchar2(100),/*备注*/
  constraint pk_t_nj_ywlx primary key(id)
);

insert into t_nj_ywlx(code,name,state,gzxx) values('0101','会员包购买','1','告知：购买服务');
insert into t_nj_ywlx(code,name,state,gzxx) values('0201','代客年检','1','告知：定点交车');
insert into t_nj_ywlx(code,name,state,gzxx) values('0301','违章处理','1','告知：线上违章处理');
COMMIT;

/*订单信息表*/
drop table t_nj_ddxx;
create table t_nj_ddxx
(
  /*基本信息*/
  id integer not null,/*订单id*/
  ywlx_code varchar2(4),/*业务类型：t_nj_ywlx.code*/
  ddbz varchar2(1) default 0,/*订单标志0创建1完结*/

  /*费用信息*/
  sumfee number(12,2) default 0,/*实收合计*/
  cxfee number(12,2) default 0,/*撤销合计,当日撤销*/
  fkbz varchar2(1),/*付款标志0未付款1已付2全退3部分退*/
  fkpz varchar2(100),/*付款凭证*/

  /*客户信息*/
  kh_khxx_id varchar2(50),/*客户id t_nj_khxx*/
  kh_khxx_wxid varchar2(50),/*客户-微信id*/
  kh_xm varchar2(20),/*客户-姓名*/
  kh_xb varchar2(1),/*客户-性别1男0女*/
  kh_dh varchar2(50),/*客户-电话*/
  kh_hplx varchar2(2),/*客户-号牌类型t_nj_hplx.code*/
  kh_hphm varchar2(20),/*客户-号牌号码*/
  kh_khjlh varchar2(20),/*客户经理号(保留)*/
  kh_sfwxtz varchar2(1) default 1,/*是否微信通知0不需要1需要*/
  kh_sfdxtz varchar2(1) default 0,/*是否短信通知0不需要1需要*/

  /*当前处理状态*/
  dq_clxx_id integer,/*当前处理信息id,t_nj_ddxx_clxx.id,填写最新处理的id号码*/
  dq_clcode varchar2(2),/*处理代码t_nj_ddxx_clxx.clcode*/
  dq_clname varchar2(50),/*处理说明t_nj_ddxx_clxx.clname*/

  /*业务包购买信息,购买业务包业务填写*/
  ywb_id integer not null,/*id主键*/
  ywb_name varchar2(50),/*业务包名称*/
  ywb_ywblx varchar2(1),/*业务包类型0普通1会员关联2车辆关联*/

  /*年检业务信息，年检业务填写*/
  nj_wtbz varchar2(1) default 1,/*委托标志0到点年检1代客年检*/
  nj_zdbz varchar2(1) default 0,/*站点标志0客户不指定1客户指定站点*/
  nj_zdxx_zdid integer,/*指定(站点)id,t_nj_zdxx.id*/
  nj_zdxx_sjid integer,/*实际(站点)id,t_nj_zdxx.id*/
  nj_qcsj date,/*取车时间*/
  nj_qcdd varchar2(200),/*取车地点*/
  nj_qcddx varchar2(200),/*取车地点，导航定位*/
  nj_njbz varchar2(1) default 1,/*年检标志0正常完成1年检异常*/

  /*业务员信息，年检后台分配业务员接车送车检验*/
  ywy_id integer,/*业务员id,t_nj_czy.id*/
  ywy_wxid integer,/*业务员wxid*/
  ywy_name varchar2(20),/*业务员姓名*/
  ywy_jgid integer,/*业务员机构id,t_nj_jgxx.id*/
  ywy_czrq date default sysdate,/*业务员操作日期*/
  ywy_memo varchar2(500),/*业务员备注*/

  add_rq date default sysdate,/*订单创建日期*/
  constraint pk_t_nj_ddxx primary key(id)
);
create sequence sq_t_nj_ddxx  minvalue 1 nomaxvalue start with 10000 increment by 1 nocache nocycle;

/*订单信息子表-处理信息表*/
drop table t_nj_ddxx_clxx;
create table t_nj_ddxx_clxx
(
  /*基本信息*/
  id integer not null,/*订单处理id*/
  ddxx_id integer,/*订单id*/
  cldmb_code varchar2(2),/*处理代码t_nj_cldmb.code*/
  cldmb_name varchar2(50),/*处理名称t_nj_cldmb.name*/
  clzp varchar2(200),/*处理照片(存放地址)*/
  clddx varchar2(200),/*处理地点，导航定位*/
  ismsg varchar2(1),/*是否发送消息0不发送1发送*/

  /*操作员信息*/
  czy_id integer,/*操作员id,t_nj_czy.id*/
  czy_name varchar2(20),/*操作员姓名*/
  czy_jgid integer,/*操作员机构id,t_nj_jgxx.id*/
  czy_czrq date default sysdate,/*操作员操作日期*/

  memo varchar2(500),/*备注*/
  constraint pk_t_nj_ddxx_clxx primary key(id)
);
create sequence sq_t_nj_ddxx_clxx  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*处理代码表*/
drop table t_nj_cldmb;
create table t_nj_cldmb
(
  /*基本信息*/
  code varchar2(2) not null,/*处理代码*/
  type varchar2(1),/*类型0客户处理，1后台工作人员处理，2年检服务人员处理,9系统处理*/
  name varchar2(50),/*处理名称*/
  zysx varchar2(2000),/*注意事项，填写处理时应注意的事项*/
  ismsg varchar2(1) default 1,/*是否发送消息0不发送1发送*/

  memo varchar2(200),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_cldmb primary key(code)
);
insert into t_nj_cldmb(code,type,name) values('00','0','订单生成，预约成功');
insert into t_nj_cldmb(code,type,name) values('01','0','客户拍照');
insert into t_nj_cldmb(code,type,name) values('07','0','客户取消订单');
insert into t_nj_cldmb(code,type,name) values('09','0','客户查询');
insert into t_nj_cldmb(code,type,name) values('10','1','确认订单');
insert into t_nj_cldmb(code,type,name) values('18','1','订单完成');
insert into t_nj_cldmb(code,type,name) values('19','1','取消订单');
insert into t_nj_cldmb(code,type,name) values('21','2','接车');
insert into t_nj_cldmb(code,type,name) values('22','2','协议拍照');
insert into t_nj_cldmb(code,type,name) values('23','2','到达站点');
insert into t_nj_cldmb(code,type,name) values('24','2','年检成功');
insert into t_nj_cldmb(code,type,name) values('25','2','年检异常');
insert into t_nj_cldmb(code,type,name) values('26','2','还车');
insert into t_nj_cldmb(code,type,name) values('29','2','订单退回');
insert into t_nj_cldmb(code,type,name) values('90','9','违章检查无违章');
insert into t_nj_cldmb(code,type,name) values('91','9','违章检查有违章');
COMMIT;

/*业务处理表*/
create table t_nj_ywlx_cldmb
(
  id integer not null,/*id主键*/
  ywlx_code integer,/*业务类型code,t_nj_ywlx.code*/
  cldbm_code integer,/*处理代码code,t_nj_cldmb.code*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_ywlx_cldmb primary key(id)
);
create sequence sq_t_nj_ywlx_cldmb  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*号牌类型表*/
create table t_nj_hplx
(
  code varchar2(2),/*代码*/
  name varchar2(50),/*说明*/
  memo varchar2(100),/*备注*/
  constraint pk_t_nj_hplx primary key(code)
);

insert into t_nj_hplx(code,name) values('01','小型');
insert into t_nj_hplx(code,name) values('99','其他');
COMMIT;

/*系统日志表*/
create table t_nj_syslog
(
  id integer not null,/*id主键*/
  name varchar2(2000),/*操作说明*/
  state varchar2(1) default 0,/*操作标志0正常1异常*/
  /*操作员信息*/
  czy_id integer,/*操作员id*/
  czy_name varchar2(20),/*操作员姓名*/
  czy_jgdm varchar2(8),/*操作员机构*/
  czy_czrq date default sysdate,/*操作员操作日期*/
  memo varchar2(100),/*备注*/
  constraint pk_t_nj_syslog primary key(id)
);
create sequence sq_t_nj_syslog  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

insert into t_nj_syslog(id,name) values(sq_t_syslog.nextval,'系统日志创建');
COMMIT;

select * from t_nj_syslog;

/*年检收费表*/
create table t_nj_fee
(
  code varchar2(2),/*代码*/
  hplx varchar2(10),/*号牌类型*/
  isyy varchar2(1) default '0',/*是否营运0非营运1营运*/
  hplxsm varchar2(50),/*号牌类型说明*/
  fee decimal(12,2),/*收费标准*/
  memo varchar2(100),/*备注*/
  constraint pk_t_dx_sysparm primary key(code)
);
insert into t_nj_fee(code,hplx,isyy,hplxsm,fee,memo) values('01','01','0','小型',270,'');
insert into t_nj_fee(code,hplx,isyy,hplxsm,fee,memo) values('02','01','1','小型',370,'');
COMMIT;

/*证件类型表*/
drop table t_nj_zjlx;
create table t_nj_zjlx
(
  code varchar2(2) not null,/*代码*/
  name varchar2(50),/*名称*/
  zjm varchar2(50),/*助记码*/
  constraint pk_t_nj_zjlx primary key(code)
);

insert into t_nj_zjlx(code,name,zjm) values('10','居民身份证','SFZ');
insert into t_nj_zjlx(code,name,zjm) values('11','户口本','HKB');
COMMIT;

/*客户信息表*/
create table t_nj_khxx
(
  id integer not null,/*id主键*/
  wxid varchar2(50),/*客户微信id*/
  xm varchar2(20),/*客户姓名*/
  xb varchar2(1),/*客户性别1男0女*/
  dh varchar2(50),/*客户电话*/
  dh2 varchar2(50),/*客户电话2*/
  yzbm varchar2(10),/*客户邮政编码*/
  addr varchar2(200),/*客户通讯地址*/
  zjlx varchar2(2) default 10,/*客户证件类型 t_nj_zjlx.code*/
  zjhm varchar2(20),/*客户证件号码*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_khxx primary key(id)
);
create sequence sq_t_nj_khxx  minvalue 1 nomaxvalue start with 1000000 increment by 1 nocache nocycle;

/*客户车辆信息表*/
create table t_nj_kh_clxx
(
  id integer not null,/*id主键*/
  khxx_id integer,/*客户id,t_nj_khxx.id*/
  hplx_code varchar2(2),/*号牌类型t_nj_hplx.code*/
  hphm varchar2(20),/*号牌号码*/
  clsbdh varchar2(20),/*车辆识别代号(后6位)*/
  syr varchar2(200),/*所有人*/
  syrdh varchar2(20),/*所有人电话*/
  yybz varchar2(1),/*营运标志0非营运车辆1营运车辆*/
  ssbz varchar2(1),/*所属标志0个人1公司*/
  zcrq date,/*注册日期，行驶证车辆注册日期*/
  hdzks integer,/*核定载客数*/

  memo varchar2(200),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_kh_clxx primary key(id)
);
create sequence sq_t_nj_kh_clxx  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*业务包表*/
create table t_nj_ywb
(
  id integer not null,/*id主键*/
  name varchar2(50),/*业务包名称*/
  gzxx varchar2(2000),/*业务包告知信息*/
  state varchar2(1) default 0,/*业务包状态0开放，1关闭*/
  ywblx varchar2(1),/*业务包类型0普通1会员关联2车辆关联*/
  qsrq date,/*业务包起始日期*/
  jzrq date,/*业务包截止日期*/

  /*费用信息*/
  fee decimal(12,2),/*费用(年)*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_yeb primary key(id)
);
create sequence sq_t_nj_ywb  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

insert into t_nj_yeb(id,name,fee) values(sq_t_nj_ywb.nextval,'关注包',0);
insert into t_nj_yeb(id,name,fee) values(sq_t_nj_ywb.nextval,'会员包',888);
insert into t_nj_yeb(id,name,fee) values(sq_t_nj_ywb.nextval,'年检包',258);
COMMIT;

/*业务类型业务包表*/
create table t_nj_ywlx_ywb
(
  id integer not null,/*id主键*/
  ywlx_code varchar2(4),/*业务类型code,t_nj_ywlx.code*/
  ywb_id integer,/*业务包id,t_nj_ywb.id*/
  fwqsrq date,/*业务包-服务起始日期*/
  fwjzrq date,/*业务包-服务截止日期*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_ywlx_ywb primary key(id)
);
create sequence sq_t_nj_ywlx_ywb  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*车辆业务包表*/
create table t_nj_cl_ywb
(
  id integer not null,/*id主键*/
  clxx_id integer,/*车辆id,t_nj_clxx.id*/
  ywb_id integer,/*业务包id,t_nj_ywb.id*/
  ddxx_id integer,/*订单信息id,t_nj_ddxx.id*/
  fwqsrq date,/*业务包-服务起始日期*/
  fwjzrq date,/*业务包-服务截止日期*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_cl_ywb primary key(id)
);
create sequence sq_t_nj_cl_ywb  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*客户业务包表*/
create table t_nj_kh_ywb
(
  id integer not null,/*id主键*/
  khxx_id integer,/*客户信息id,t_nj_khxx.id*/
  ywb_id integer,/*业务包id,t_nj_ywb.id*/
  ddxx_id integer,/*订单信息id,t_nj_ddxx.id*/
  fwqsrq date,/*业务包-服务起始日期*/
  fwjzrq date,/*业务包-服务截止日期*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_kh_ywb primary key(id)
);
create sequence sq_t_nj_kh_ywb  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

/*年检站点信息表*/
create table t_nj_zdxx
(
  id integer not null,/*id主键*/
  name varchar2(100),/*站点名称*/
  fwsj varchar2(200),/*服务时间：周一到周五，上午8：30到12：00，下午2:00到5:30；周六周日，上午8：30到12：00*/
  addr varchar2(100),/*站点地址*/
  addrx varchar2(100),/*站点地址,导航位置信息*/
  state varchar2(1) default 0,/*站点状态0开放1关闭*/

  fzr_id integer,/*负责人id，t_nj_czy.id*/

  memo varchar2(100),/*备注*/
  add_rq date default sysdate,/*创建日期*/
  constraint pk_t_nj_zdxx primary key(id)
);
create sequence sq_t_nj_zdxx  minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;

insert into t_nj_zdxx(id,name,addr) values(sq_t_nj_zdxx.nextval,'欣中南汽车检测站','武汉市江汉区江兴路特1号');
COMMIT;

--消息发送接口凭证
create table t_nj_msg
(
    id   INTEGER not null, /*消息id号码*/
    fsfs varchar2(1) default 0,/*发送方式0-微信，1-短信，2-微信+短信*/
    nr varchar2(2000),/*内容*/
    userid varchar2(100),/*接收人微信id*/
    userdh varchar2(20),/*接收人电话*/
    czy_id integer,/*操作员id*/
    czy_name varchar2(20),/*操作员姓名*/
    czrq date default sysdate,/*操作日期*/
    constraint pk_t_nj_gzh_msg primary key(id)
);
create sequence sq_t_nj_msg minvalue 1 nomaxvalue start with 1 increment by 1 nocache nocycle;
--凭证备份
create table t_nj_msg_log
(
    id   INTEGER not null,/*消息id号码*/
    fsfs varchar2(1) default 0,/*发送方式0-微信，1-短信，2-微信+短信*/
    nr varchar2(2000),/*内容*/
    userid varchar2(100),/*接收人微信id*/
    userdh varchar2(20),/*接收人电话*/
    czy_id integer,/*操作员id*/
    czy_name varchar2(20),/*操作员姓名*/
    czrq date,/*操作日期*/
    /*回执*/
    cz_rtn varchar(1000), -- 返回结果
    state varchar2(1) default 1 -- 1 成功  2 失败
    constraint pk_t_nj_msg_log primary key(id)
);

