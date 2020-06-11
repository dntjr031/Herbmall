--9강_PL_SQL.sql
--[2020-04-28 화]
--PL/SQL
/*
    - Procedural language extension to Structured Query Language
    - SQL과 일반 프로그래밍 언어의 특성을 결합한 언어
    - 변수, 상수 선언 가능
    - 조건문, 반복문 사용 가능
*/

/*
    선언부
        - declare 키워드 사용
        - 변수나 상수를 선언하는 부분
        
    실행부
        - begin ~ end 키워드 사용
        - 변수에 값 할당, 조건문, 반복문, sql문장등을 처리
        - 실행해야 할 로직을 넣는 부분
        
    예외처리부
        - exception 키워드 사용
        - 실행부에서 예외가 발생했을 때 처리하는 부분
*/
--선언부, 실행부, 예외처리부가 하나의 PL/SQL 블록을 구성하고,
--오라클은 이 블록 단위로 처리함

declare  --선언부 : 변수를 선언하는 부분    
    counter number;
begin   --실행부 : 처리할 로직을 넣는 부분
    --변수에 값 할당
    counter := 1;
    
    --로직 처리
    counter:= counter/0;
    
    if counter is not null then
        dbms_output.put_line('counter=>' || counter);
    end if;
    
    exception when others then  --예외 처리부
    --exception when ZERO_DIVIDE then  
        dbms_output.put_line('0으로 나누면 안됩니다.');
end;    

--1~10까지 for문 이용하여 반복처리
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

--while문 이용
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

--[2020-04-29 수]
--변수, 상수 선언
/*
    변수명 데이터타입;          --변수 선언
    변수명 constant 데이터타입; --상수 선언
    변수명 테이블명.컬럼명%type;  --변수 선언
        => 해당 테이블의 해당 컬럼과 동일한 타입의 변수 선언
    
    예)  name varchar2(30);
        curYear constant number := 2020;
        empno   employees.employee_id%type;    
*/

select * from employees;

--조건문
/*
1) if문
    if 조건1 then
        문장1;
    elsif 조건2 then
        문장2;
    else
        문장3;
    end if;

2) case문
    case
    when 조건 then
        문장1;
    else
        문장2;
    end case;                
*/
--if문 이용
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

--case문
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
        
        dbms_output.put_line('case문 :' || grade 
                || '=>' || result);
        
        exception when others then
            dbms_output.put_line('error!');                
end;

--반복문
/*
    1) 
       loop
            exit when 조건;
       end loop; 
       
    2) 
        for 변수 in [reverse] 초기값..종료값 loop
            처리할 문장;
        end loop;
    
    3) 
        while 조건 loop
            처리할 문장;
        end loop;     
*/
--loop 문 이용
declare
    i   number;
    result  number;
begin
    i := 1;
    
    loop
        result := i*2; --2,4,6....20,22
        
        exit when result>20;  --조건을 만족하면 반복문 탈출
        dbms_output.put_line(result); --2,4,...20
        
        i:=i+1; --2,3...10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--for문

declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result := i*5;
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;
    
    dbms_output.put_line('---------for문 reverse 이용----------');
    
    result := 0;
    for i in reverse 1..10 loop
        result := i*4;
        dbms_output.put_line('i :' || i || ', result:' || result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--while문
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

--PL/SQL 서브 프로그램
/*
    - 데이터베이스 객체로 저장해서 필요할 때마다 호출하여 사용할 수 있는
    PL/SQL 블록
    
    1) 함수 (function) - 결과값을 반환함
        - 사용자 정의 함수를 말함
        - 특정 기능을 수행한 뒤, 결과값을 반환하는 서브 프로그램
        
    2) 내장 프로시저(저장 프로시저, stored procedure) - 결과값을 반환하지 않음
*/

--함수
/*
    create or replace function 함수명
    (파라미터1  데이터타입,
     파라미터2  데이터타입, ...)
        return 데이터타입
    is 또는 as
        변수 선언
    begin
        처리할 로직
        
        exception when others then
            예외처리할 문장
    end;        
*/
--주민번호를 넣으면 성별을 리턴하는 함수 만들기
create or replace function get_gender
(
    --파라미터
    p_ssn   varchar2
)
return varchar2     --반환타입
is
    --변수 선언
    v_gender    varchar2(10);
begin
    --처리할 로직
    select case when substr(p_ssn,7,1) in ('1','3') then '남자'
                else '여자' end
           into v_gender
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_line('error');            
end;

--함수 실행시키기
select get_gender('0110093122222') from dual; --사용자 정의 함수
select length('java') from dual; --오라클 함수

select gno, gname, jumin, get_gender(jumin) 성별 
from gogak;
select gno, gname, jumin, length(gname) 이름길이 
from gogak;
