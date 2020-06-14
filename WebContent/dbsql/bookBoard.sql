--�亯�� �Խ��� ���̺�
--drop table reboard  cascade constraint;

create table reboard
(
    no              number		primary key,      --��ȣ
    title         varchar2(100)      not null,            --�̸�    
    price           number	not null,             --��й�ȣ
    PUBLISHER       varchar2(100)	not  null,            --����
    regdate      date			default  sysdate,      --�ۼ���
    readcount  number		default 0     null,      --��ȸ��
    content      clob			null,			--����
	groupNo  	number      	default 0,       	--�׷��ȣ
	step	   	number       	default 0,	  	--���� �ܰ� 
	sortNo 	number       	default 0,   	--���� ���ļ���
	delFlag    	char			default 'N',	 --���� Flag  
    filename varchar2(100),
    filesize number,
    originalfilename varchar2(100)
);

create sequence reboard_seq
increment by 1
start with 1
nocache;

select * from reboard;
