--sys�� system �������� �α����ؼ� ����� ����, ���̺����̽� �����ϱ�
--sqlplus "/as sysdba  ==>�ý���dba����
--connect /as sysdba ==> dba ����

--���̺� �����̽� ����
create tablespace herbmall
datafile 'C:\myoracle\data\herbmall.dbf' size 48m
extent management local
uniform size 64k
segment space management auto;

--����� ���� ����
create user herb
identified by herb123
default tablespace herbmall;

--����� ���Ѻο�
grant connect,resource to herb;
--grant connect, dba to herb with admin option;

--�� ���� ���� �ο��ϱ�
grant create view to herb;
