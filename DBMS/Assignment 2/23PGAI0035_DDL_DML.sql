create database COMPANY;
use COMPANY;

drop table if exists employee;
CREATE TABLE employee (
  fname    varchar(15) not null, 
  minit    varchar(1),
  lname    varchar(15) not null,
  ssn      char(9),
  bdate    date,
  address  varchar(30),
  sex      char,
  salary   int,
  superssn char(9),
  dno      int,
  primary key (ssn),
  foreign key (superssn) references employee(ssn)
);

drop table if exists department;
CREATE TABLE department (
  dname        varchar(15) not null,
  dnumber      int,
  mgrssn       char(9) not null, 
  mgrstartdate date,
  primary key (dnumber),
  unique (dname),
  foreign key (mgrssn) references employee(ssn)
);


alter table employee add (
  foreign key (dno) references department(dnumber)
);

drop table if exists dept_locations;
CREATE TABLE dept_locations (
  dnumber   int,
  dlocation varchar(15), 
  primary key (dnumber,dlocation),
  foreign key (dnumber) references department(dnumber)
);

drop table if exists project;
CREATE TABLE project (
  pname      varchar(15) not null,
  pnumber    int,
  plocation  varchar(15),
  dnum       int not null,
  primary key (pnumber),
  unique (pname),
  foreign key (dnum) references department(dnumber)
);

drop table if exists works_on;
CREATE TABLE works_on (
  essn   char(9),
  pno    int,
  hours  DECIMAL(4,1),
  primary key (essn,pno),
  foreign key (essn) references employee(ssn),
  foreign key (pno) references project(pnumber)
);

drop table if exists dependent;
CREATE TABLE dependent (
  essn           char(9),
  dependent_name varchar(15),
  sex            char,
  bdate          date,
  relationship   varchar(8),
  primary key (essn,dependent_name),
  foreign key (essn) references employee(ssn)
);
 
describe employee;
describe department;
describe dept_locations;
describe project;
describe works_on;
describe dependent;

DELETE FROM employee;
INSERT INTO employee VALUES ('James', 'E', 'Borg','888665555', '1937-11-10', '450 Stone, Houston,TX', 'M', 55000, null, null);
INSERT INTO employee VALUES ('Franklin', 'T', 'Wong','333445555', '1955-12-08', '638 Voss, Houston,TX', 'M', 40000, '888665555', null);
INSERT INTO employee VALUES ('Jennifer', 'S', 'Wallace','987654321', '1941-06-20', '291 Berry,Bellaire,TX', 'F', 43000, '888665555', null);

DELETE FROM department;
INSERT INTO department VALUES ('Research', 5, '333445555', '1988-05-22');
INSERT INTO department VALUES ('Administration', 4, '987654321', '1995-01-01');
INSERT INTO department VALUES ('Headquarters', 1, '888665555', '1981-06-19');

UPDATE employee SET DNO = 5 WHERE ssn = '333445555';
UPDATE employee SET DNO = 4 WHERE ssn = '987654321';
UPDATE employee SET DNO = 1 WHERE ssn = '888665555';

INSERT INTO employee VALUES ('John', 'B', 'Smith','123456789', '1965-01-09', '731 Fondren, Houston,TX', 'M', 30000, '333445555', 5);
INSERT INTO employee VALUES ('Alicia', 'J', 'Zelaya','999887777', '1968-01-19', '3321 Castle, Spring,TX', 'F', 25000, '987654321', 4);
INSERT INTO employee VALUES ('Ramesh', 'K', 'Narayan','666884444', '1962-09-15', '975 Fire Oak, Humble,TX', 'M', 38000, '333445555', 5);
INSERT INTO employee VALUES ('Joyce', 'A', 'English','453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO employee VALUES ('Ahmad', 'V', 'Jabbar','987987987', '1969-11-10', '980 Dallas, Houston,TX', 'M', 25000, '987654321', 4);

DELETE FROM project;
INSERT INTO project VALUES ('ProductX', 1, 'Bellaire',  5);
INSERT INTO project VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO project VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO project VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO project VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO project VALUES ('Newbenefits', 30,  'Stafford', 4);

DELETE FROM dept_locations;
INSERT INTO dept_locations VALUES (1, 'Houston');
INSERT INTO dept_locations VALUES (4, 'Stafford');
INSERT INTO dept_locations VALUES (5, 'Bellaire');
INSERT INTO dept_locations VALUES (5, 'Sugarland');
INSERT INTO dept_locations VALUES (5, 'Houston');

DELETE from dependent;
INSERT INTO dependent VALUES ('333445555','Alice','F','1986-04-05','Daughter');
INSERT INTO dependent VALUES ('333445555','Theodore','M','1983-10-25','Son');
INSERT INTO dependent VALUES ('333445555','Joy','F','1958-05-03','Spouse');
INSERT INTO dependent VALUES ('987654321','Abner','M','1942-02-28','Spouse');
INSERT INTO dependent VALUES ('123456789','Michael','M','1988-01-04','Son');
INSERT INTO dependent VALUES ('123456789','Alice','F', '1988-12-30','Daughter');
INSERT INTO dependent VALUES ('123456789','Elizabeth','F','1967-05-05','Spouse');

DELETE FROM works_on;
INSERT INTO works_on VALUES ('123456789', 1,  32.5);
INSERT INTO works_on VALUES ('123456789', 2,  7.5);
INSERT INTO works_on VALUES ('666884444', 3,  40.0);
INSERT INTO works_on VALUES ('453453453', 1,  20.0);
INSERT INTO works_on VALUES ('453453453', 2,  20.0);
INSERT INTO works_on VALUES ('333445555', 2,  10.0);
INSERT INTO works_on VALUES ('333445555', 3,  10.0);
INSERT INTO works_on VALUES ('333445555', 10, 10.0);
INSERT INTO works_on VALUES ('333445555', 20, 10.0);
INSERT INTO works_on VALUES ('999887777', 30, 30.0);
INSERT INTO works_on VALUES ('999887777', 10, 10.0);
INSERT INTO works_on VALUES ('987987987', 10, 35.0);
INSERT INTO works_on VALUES ('987987987', 30, 5.0);
INSERT INTO works_on VALUES ('987654321', 30, 20.0);
INSERT INTO works_on VALUES ('987654321', 20, 15.0);
INSERT INTO works_on VALUES ('888665555', 20, null);

show tables;

Select * from employee;
Select * from department;
Select * from dept_locations;
Select * from project;
Select * from works_on;
Select * from dependent;

alter table employee drop column minit;

Select * from employee;

alter table department add column ManagerName varchar(15) after dname; 

Select * from department;

UPDATE department SET ManagerName = 'Franklin' WHERE dname = 'Research';

Select * from department;

truncate table dept_locations;

drop table dept_locations;

show tables;

update works_on set hours = 30 where hours is null;

Select * from works_on;

Select pname, plocation from project;

Select fname, salary from employee where year(bdate) < '1960';

Select fname, lname from employee where fname like 'f%' or lname like 'f%';

select essn from works_on where (hours/5) > 5.5; 

select department.dname, employee.fname, employee.lname from department, employee where department.MgrSSN = employee.ssn;

Select salary from employee where salary IN (select min(salary) from employee) and dno = 5;

SELECT works_on.Pno, project.Pname FROM works_on, project  where project.Pnumber = works_on.Pno GROUP BY works_on.Pno HAVING AVG(Hours)>20 ;

Select M.dependent_name, D.dependent_name from dependent M , dependent D where M.essn = D.essn and (M.relationship = 'Spouse' and M.sex ='F') and (D.relationship = 'Daughter' and D.sex = 'F');
