CREATE TABLE guestbook ( 
no		    number		primary key,   --글 번호	
name		varchar2(20)    not null,    		--작성자 이름
pwd			varchar2(20)    not null, 		--비밀번호
content		varchar2(4000)	null, 		--글의 내용
regdate		date		default  sysdate 	--작성일자
);

create sequence guestbook_seq
increment by 1
start with 1
nocache;

select * from guestbook;
