create or replace procedure  --프로시저 이름 
(
--매개변수

)
is
--변수선언부

begin
--처리할 내용
    
    commit;

EXCEPTION
    WHEN OTHERS THEN
	raise_application_error(-20001, ' 실패!');
        ROLLBACK;
end;
