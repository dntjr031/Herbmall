
-- exec deleteReboard(no, step, groupNo);
create or replace procedure deleteReboard --프로시저 이름 
(
--매개변수
    p_no number,
    p_step number,
    p_groupNo number
)
is
--변수선언부
    cnt number;
begin
--처리할 내용
    if p_step = 0 then
        select count(*) into cnt from reboard
        where groupno = p_groupno;
        --답변이 존재하면 update
        if cnt > 1 then
            update reboard
            set delFlag='Y'
            where no = p_no;
        else
        --존재하지 않으면 delete
            delete from reboard
            where no = p_no;
        end if;
    else
    -- 답변인 경우 delete
        delete from reboard
        where no = p_no;
    end if;
    
    commit;

EXCEPTION
    WHEN OTHERS THEN
	raise_application_error(-20001, '글 삭제 실패!');
        ROLLBACK;
end;
