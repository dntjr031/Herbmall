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
select get_gender('0110094122222') from dual; --사용자 정의 함수
select length('java') from dual; --오라클 함수

select gno, gname, jumin, get_gender(jumin) 성별 
from gogak;
select gno, gname, jumin, length(gname) 이름길이 
from gogak;

--주민번호를 이용해서 나이를 구하는 함수 만들기
--함수명 : get_age
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

select get_age('9901081112222') 나이 from dual;
select gno, gname, jumin, get_age(jumin) 나이 from gogak;

--stored procedure (저장 프로시저, 내장 프로시저)
--특정 기능을 수행하지만 값을 반환하지는 않는 서브 프로그램
/*
create or replace procedure 프로시저명
(
    파라미터1   데이터 타입,
    파라미터2   데이터 타입,
    ...
)
is[as]
    변수 선언부
begin
    처리할 로직
    
    exception when others then
        예외처리
end;
*/
select * from pd2;
select * from user_sequences;

--pd2 테이블에 입력하는 프로시저
create or replace procedure pd2_insert
(
    --파라미터
    --pd2 테이블에 insert할 때 필요한 파라미터들
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is
--변수 선언부
begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode, p_pdname, p_price, p_company);
    
    commit; --성공하면 커밋
    
    exception when others then
        dbms_output.put_line('pd2 insert error!');
        rollback;  --실패하면 롤백
end;

--저장 프로시저 실행시키기
/*
    execute 프로시저이름(파라미터);
    또는
    exec 프로시저이름(파라미터);    
*/
execute pd2_insert('C01','마우스',34000,'삼성');

select * from pd2 order by no desc;

exec pd2_insert('C02','모니터',470000,'LG');

--pd2 테이블 컬럼을 수정하는 프로시저 만들기
create or replace procedure pd2_update
(
    --파라미터
    p_no    pd2.no%type,  --테이블명.컬럼명%type => 해당 테이블의 해당 컬럼과
                          --                    동일한 데이터 타입
                          --pd2 테이블의 no 컬럼과 동일한 타입
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type                        
)
is
    --변수 선언부
    v_cnt   number(3);
begin
    select count(*) into v_cnt 
    from pd2
    where no=p_no;
    
    --해당 데이터가 존재하면 update
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

exec pd2_update(4, 'B03', '컴퓨터', 1800000, 'HP');

select * from pd2 order by no desc;

--저장프로시저, 함수 확인
select * from user_source
where name='PD2_UPDATE';

--exists 이용한 update
create or replace procedure pd2_update2
(
    --파라미터
    p_no    pd2.no%type,  --테이블명.컬럼명%type => 해당 테이블의 해당 컬럼과
                          --                    동일한 데이터 타입
                          --pd2 테이블의 no 컬럼과 동일한 타입
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type                        
)
is
    --변수 선언부
begin
    update pd2 a 
    set pdcode=p_pdcode, pdname=p_pdname,
        price=p_price, company=p_company
    where exists (select 1 from pd2 b where b.no=a.no and b.no=p_no);
    
    commit;
    
    exception when others then
        raise_application_error(-20001, 'pd2 update error!!');
        --사용자 정의 예외번호는 -20001 ~ -20999까지
        rollback;
end;

exec pd2_update2(4, 'B04', '키보드', -500, 'qnix'); 
--=> error
exec pd2_update2(4, 'B06', '키보드', 19000, 'qnix'); 

select * from pd2 order by no desc;

--%rowtype
/*
    %type과 유사하나, 한 개 이상의 값에 대해 적용
    - 로우타입 변수를 선언해 테이블에 있는 row(레코드) 대입 가능
*/
create or replace procedure prof_info
(
    p_profno    PROFESSOR.PROFNO%type
)
is
    v_prof_row  professor%rowtype; --professor테이블의 한 개의 레코드 정보
                        --를 담을 수 있는 타입
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



