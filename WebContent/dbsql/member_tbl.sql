--drop table zipcode cascade constraint;
create table zipcode
(
 zipcode varchar2(5),
 sido varchar2(100),
 gugun varchar2(100),
 dong varchar2(200),
 startbunji varchar2(100),
 endbunji varchar2(100),
 seq number primary key
);

select * from zipcode;

--drop table member cascade constraint;
create table member
(
    no           number        primary key,
    userid     varchar2(20)   unique not null,
    name      varchar2(20)    not null,
    pwd        varchar2(15)    not null,
    email       varchar2(50)    null,
    hp            varchar2(20)    null,
    --tel             varchar2(20)    null,
    zipcode    varchar2(5)        null,
    address    varchar2(200)   null,
    addressDetail    varchar2(100)   null,
    regdate     date        default sysdate,
    mileage        number   default 0,
    outdate		date        null  
);

--drop sequence member_seq;
create sequence member_seq
increment by 1
start with 1
nocache;

select * from member;

