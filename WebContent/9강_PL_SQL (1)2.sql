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
select get_gender('0110093122222') from dual; --����� ���� �Լ�
select length('java') from dual; --����Ŭ �Լ�

select gno, gname, jumin, get_gender(jumin) ���� 
from gogak;
select gno, gname, jumin, length(gname) �̸����� 
from gogak;
