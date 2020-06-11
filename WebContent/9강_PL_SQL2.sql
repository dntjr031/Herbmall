--9��_PL_SQL.sql
--[2020-04-28 ȭ]
--PL/SQL
/*
    - Procedural language extension to Structured Query Language
    - SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���
    - ����, ��� ���� ����
    - ���ǹ�, �ݺ��� ��� ����
*/

/*
    �����
        - declare Ű���� ���
        - ������ ����� �����ϴ� �κ�
        
    �����
        - begin ~ end Ű���� ���
        - ������ �� �Ҵ�, ���ǹ�, �ݺ���, sql������� ó��
        - �����ؾ� �� ������ �ִ� �κ�
        
    ����ó����
        - exception Ű���� ���
        - ����ο��� ���ܰ� �߻����� �� ó���ϴ� �κ�
*/
--�����, �����, ����ó���ΰ� �ϳ��� PL/SQL ����� �����ϰ�,
--����Ŭ�� �� ��� ������ ó����

declare  --����� : ������ �����ϴ� �κ�    
    counter number;
begin   --����� : ó���� ������ �ִ� �κ�
    --������ �� �Ҵ�
    counter := 1;
    
    --���� ó��
    counter:= counter/0;
    
    if counter is not null then
        dbms_output.put_line('counter=>' || counter);
    end if;
    
    exception when others then  --���� ó����
    --exception when ZERO_DIVIDE then  
        dbms_output.put_line('0���� ������ �ȵ˴ϴ�.');
end;    

--1~10���� for�� �̿��Ͽ� �ݺ�ó��
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result := i*2;
        dbms_output.put_line(result);
    end loop;

    exception when others then
        dbms_output.put_line('error!');    
end;

--while�� �̿�
declare
    i   number;
    result number;
begin
    i := 1;
    
    while i<=10 loop
        result := i*3;
        dbms_output.put_line(i || '*3 => ' || result);
        
        i:=i+1;
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--[2020-04-29 ��]
--����, ��� ����
/*
    ������ ������Ÿ��;          --���� ����
    ������ constant ������Ÿ��; --��� ����
    ������ ���̺��.�÷���%type;  --���� ����
        => �ش� ���̺��� �ش� �÷��� ������ Ÿ���� ���� ����
    
    ��)  name varchar2(30);
        curYear constant number := 2020;
        empno   employees.employee_id%type;    
*/

select * from employees;

--���ǹ�
/*
1) if��
    if ����1 then
        ����1;
    elsif ����2 then
        ����2;
    else
        ����3;
    end if;

2) case��
    case
    when ���� then
        ����1;
    else
        ����2;
    end case;                
*/
--if�� �̿�
declare
    grade char;
    result  varchar2(50);
begin
    grade := 'B';
    
    if grade='A' then
        result := 'Excellent';
    elsif grade='B' then
        result := 'Good';
    elsif grade='C' then
        result := 'Fair';
    elsif grade='D' then
        result := 'Poor';
    else
        result := 'Not found!';
    end if;
    
    dbms_output.put_line(grade || ' => ' || result);
    
    exception when others then
        dbms_output.put_line('error!');            
end;

--case��
declare
    grade   char;
    result  varchar2(50);
begin
    grade:='C';
    
    case grade
        when 'A' then
            result := 'excellent';
        when 'B' then
            result := 'good';
        when 'C' then
            result := 'fair';
        when 'D' then
            result := 'poor';
        else
            result := 'not found';
        end case;
        
        dbms_output.put_line('case�� :' || grade 
                || '=>' || result);
        
        exception when others then
            dbms_output.put_line('error!');                
end;

--�ݺ���
/*
    1) 
       loop
            exit when ����;
       end loop; 
       
    2) 
        for ���� in [reverse] �ʱⰪ..���ᰪ loop
            ó���� ����;
        end loop;
    
    3) 
        while ���� loop
            ó���� ����;
        end loop;     
*/
--loop �� �̿�
declare
    i   number;
    result  number;
begin
    i := 1;
    
    loop
        result := i*2; --2,4,6....20,22
        
        exit when result>20;  --������ �����ϸ� �ݺ��� Ż��
        dbms_output.put_line(result); --2,4,...20
        
        i:=i+1; --2,3...10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--for��

declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result := i*5;
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;
    
    dbms_output.put_line('---------for�� reverse �̿�----------');
    
    result := 0;
    for i in reverse 1..10 loop
        result := i*4;
        dbms_output.put_line('i :' || i || ', result:' || result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--while��
declare
    i   number;
    result  number;
begin
    i:=1;
    result:=0;
    
    while result < 20 loop
        result := i*2; --2,4,..18,20
        dbms_output.put_line(result); --2,4..,18,20
        
        i:=i+1; --2,3,...9,10
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--PL/SQL ���� ���α׷�
/*
    - �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ�
    PL/SQL ���
    
    1) �Լ� (function) - ������� ��ȯ��
        - ����� ���� �Լ��� ����
        - Ư�� ����� ������ ��, ������� ��ȯ�ϴ� ���� ���α׷�
        
    2) ���� ���ν���(���� ���ν���, stored procedure) - ������� ��ȯ���� ����
*/

--�Լ�
/*
    create or replace function �Լ���
    (�Ķ����1  ������Ÿ��,
     �Ķ����2  ������Ÿ��, ...)
        return ������Ÿ��
    is �Ǵ� as
        ���� ����
    begin
        ó���� ����
        
        exception when others then
            ����ó���� ����
    end;        
*/
--�ֹι�ȣ�� ������ ������ �����ϴ� �Լ� �����
create or replace function get_gender
(
    --�Ķ����
    p_ssn   varchar2
)
return varchar2     --��ȯŸ��
is
    --���� ����
    v_gender    varchar2(10);
begin
    --ó���� ����
    select case when substr(p_ssn,7,1) in ('1','3') then '����'
                else '����' end
           into v_gender
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_line('error');            
end;

--�Լ� �����Ű��
select get_gender('0110094122222') from dual; --����� ���� �Լ�
select length('java') from dual; --����Ŭ �Լ�

select gno, gname, jumin, get_gender(jumin) ���� 
from gogak;
select gno, gname, jumin, length(gname) �̸����� 
from gogak;

--�ֹι�ȣ�� �̿��ؼ� ���̸� ���ϴ� �Լ� �����
--�Լ��� : get_age
create or replace function get_age
(
    p_ssn   varchar2
)
return number
is
    v_age   number;
begin 
    select extract(year from sysdate) - 
        (substr(p_ssn,1,2) 
            + case when substr(p_ssn,7,1) in ('1','2') then 1900
                    else 2000 end) 
            + 1 into v_age
    from dual;        
    
    return v_age;
    
    exception when others then
        dbms_output.put_line('error!');
end;

select get_age('9901081112222') ���� from dual;
select gno, gname, jumin, get_age(jumin) ���� from gogak;

--stored procedure (���� ���ν���, ���� ���ν���)
--Ư�� ����� ���������� ���� ��ȯ������ �ʴ� ���� ���α׷�
/*
create or replace procedure ���ν�����
(
    �Ķ����1   ������ Ÿ��,
    �Ķ����2   ������ Ÿ��,
    ...
)
is[as]
    ���� �����
begin
    ó���� ����
    
    exception when others then
        ����ó��
end;
*/
select * from pd2;
select * from user_sequences;

--pd2 ���̺� �Է��ϴ� ���ν���
create or replace procedure pd2_insert
(
    --�Ķ����
    --pd2 ���̺� insert�� �� �ʿ��� �Ķ���͵�
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is
--���� �����
begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode, p_pdname, p_price, p_company);
    
    commit; --�����ϸ� Ŀ��
    
    exception when others then
        dbms_output.put_line('pd2 insert error!');
        rollback;  --�����ϸ� �ѹ�
end;

--���� ���ν��� �����Ű��
/*
    execute ���ν����̸�(�Ķ����);
    �Ǵ�
    exec ���ν����̸�(�Ķ����);    
*/
execute pd2_insert('C01','���콺',34000,'�Ｚ');

select * from pd2 order by no desc;

exec pd2_insert('C02','�����',470000,'LG');

--pd2 ���̺� �÷��� �����ϴ� ���ν��� �����
create or replace procedure pd2_update
(
    --�Ķ����
    p_no    pd2.no%type,  --���̺��.�÷���%type => �ش� ���̺��� �ش� �÷���
                          --                    ������ ������ Ÿ��
                          --pd2 ���̺��� no �÷��� ������ Ÿ��
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type                        
)
is
    --���� �����
    v_cnt   number(3);
begin
    select count(*) into v_cnt 
    from pd2
    where no=p_no;
    
    --�ش� �����Ͱ� �����ϸ� update
    if v_cnt >0 then
        update pd2
        set pdcode=p_pdcode, pdname=p_pdname, price=p_price,
            company=p_company
        where no=p_no;
    end if;
    
    commit;
    
    exception when others then
        dbms_output.put_line('pd2 update error!');
        rollback;
end;

exec pd2_update(4, 'B03', '��ǻ��', 1800000, 'HP');

select * from pd2 order by no desc;

--�������ν���, �Լ� Ȯ��
select * from user_source
where name='PD2_UPDATE';

--exists �̿��� update
create or replace procedure pd2_update2
(
    --�Ķ����
    p_no    pd2.no%type,  --���̺��.�÷���%type => �ش� ���̺��� �ش� �÷���
                          --                    ������ ������ Ÿ��
                          --pd2 ���̺��� no �÷��� ������ Ÿ��
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type                        
)
is
    --���� �����
begin
    update pd2 a 
    set pdcode=p_pdcode, pdname=p_pdname,
        price=p_price, company=p_company
    where exists (select 1 from pd2 b where b.no=a.no and b.no=p_no);
    
    commit;
    
    exception when others then
        raise_application_error(-20001, 'pd2 update error!!');
        --����� ���� ���ܹ�ȣ�� -20001 ~ -20999����
        rollback;
end;

exec pd2_update2(4, 'B04', 'Ű����', -500, 'qnix'); 
--=> error
exec pd2_update2(4, 'B06', 'Ű����', 19000, 'qnix'); 

select * from pd2 order by no desc;

--%rowtype
/*
    %type�� �����ϳ�, �� �� �̻��� ���� ���� ����
    - �ο�Ÿ�� ������ ������ ���̺� �ִ� row(���ڵ�) ���� ����
*/
create or replace procedure prof_info
(
    p_profno    PROFESSOR.PROFNO%type
)
is
    v_prof_row  professor%rowtype; --professor���̺��� �� ���� ���ڵ� ����
                        --�� ���� �� �ִ� Ÿ��
    v_result    varchar2(2000);                    
begin
    select * into v_prof_row 
    from professor
    where profno=p_profno;
    
    v_result := v_prof_row.profno || ' ' || v_prof_row.name || ' '
        || v_prof_row.position || ' ' ||
        v_prof_row.pay + nvl(v_prof_row.bonus);
    
    dbms_output.put_line(v_result);
    
    exception when others then
        raise_application_error(-20002, '');
end;



