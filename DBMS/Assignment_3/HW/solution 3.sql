SHOWS TABLES; 

SELECT * FROM EMPLOYEE;

1##  Print the names of all the employees who earn more than the average salary.

SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

SOLUTION -> 
+----------+-------+---------+
| Fname    | Minit | Lname   |
+----------+-------+---------+
| Franklin | T     | Wong    |
| Ramesh   | K     | Narayan |
| James    | E     | Borg    |
| Jennifer | S     | Wallace |
+----------+-------+---------+
4 rows in set (0.01 sec)


2## List the names of employees who are supervisors but have no dependents.
"Select Fname, Minit, Lname From EMPLOYEE AS E JOIN DEPENDENT AS D WHERE E.Ssn = D.Essn AND E.Super_ssn IS NULL;"
"SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Ssn IN (SELECT Super_ssn FROM EMPLOYEE) AND Ssn NOT IN (SELECT Essn FROM DEPENDENT);"

SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Ssn NOT IN (SELECT DISTINCT Ssn FROM EMPLOYEE AS E JOIN DEPENDENT AS D ON E.Ssn = D.Essn) AND Ssn IN (select DISTINCT Super_Ssn from EMPLOYEE WHERE Super_ssn != 0);

SOLUTION -> 
+-------+-------+-------+
| Fname | Minit | Lname |
+-------+-------+-------+
| James | E     | Borg  |
+-------+-------+-------+
1 row in set, 1 warning (0.00 sec)



3## Print the names of all the employees in decreasing order of their throughput of making money (throughput is defined by the amount they earn per
hour of their work)

SELECT Fname, Minit, Lname, (SELECT Salary/SUM(Hours) FROM WORKS_ON WHERE Essn = Ssn) AS throughput FROM EMPLOYEE ORDER BY throughput DESC;

+----------+-------+---------+-------------+
| Fname    | Minit | Lname   | throughput  |
+----------+-------+---------+-------------+
| Jennifer | S     | Wallace | 1228.571429 |
| Franklin | T     | Wong    | 1000.000000 |
| Ramesh   | K     | Narayan |  950.000000 |
| John     | B     | Smith   |  750.000000 |
| Joyce    | A     | English |  625.000000 |
| Ahmad    | V     | Jabbar  |  625.000000 |
| Alicia   | J     | Zelaya  |  625.000000 |
| James    | E     | Borg    |        NULL |
+----------+-------+---------+-------------+
8 rows in set (0.00 sec)

4 ## Print the department name of the company in decreasing order of their average employee throughput.

SELECT Dname, (SELECT AVG(Salary/Sum(Hours)) FROM EMPLOYEE AS E JOIN WORKS_ON AS W ON E.Ssn = W.Essn WHERE E.Dno = D.Dnumber) AS throughput FROM DEPARTMENT AS D ORDER BY throughput DESC;

select d.Dname , sum(p.SP) from DEPARTMENT as d join (select Dno , (Salary/30)/(SUM(Hours)/5) as SP from EMPLOYEE , WORKS_ON where Essn=Ssn group by (Essn) order by (Salary/30)/(SUM(Hours)/5) desc) as p where p.Dno= d.Dnumber group by (p.Dno) order by sum(p.SP) desc ;

+-----+----------------+--------------------+
| Dno | Dname          | Avg_Emp_throughput |
+-----+----------------+--------------------+
|   5 | Research       |     831.2500000000 |
|   4 | Administration |     826.1904763333 |
|   1 | Headquarters   |               NULL |
+-----+----------------+--------------------+
3 rows in set (0.01 sec)

"SELECT Dname, AVG(Salary / Hours) AS Throughput FROM DEPARTMENT, EMPLOYEE, WORKS_ON WHERE Dnumber = Dno AND Ssn = Essn GROUP BY Dname ORDER BY Throughput DESC;"


5 ## List the names of projects and the number of employees that work on it in decreasing order of employee count.

Select Pname, COUNT(Essn) AS Employee_Count FROM PROJECT, WORKS_ON WHERE Pnumber = Pno GROUP BY Pname ORDER BY Employee_Count DESC;

+-----------------+----------------+
| Pname           | Employee_Count |
+-----------------+----------------+
| Computerization |              3 |
| Newbenefits     |              3 |
| ProductY        |              3 |
| Reorganization  |              3 |
| ProductX        |              2 |
| ProductZ        |              2 |
+-----------------+----------------+
6 rows in set (0.07 sec)


6 ## Department with more than 3 employees, retrieve the dept number and number of employees earning more than 37k. 

Select Dno, count(Ssn) from EMPLOYEE where Dno in (select Dno from EMPLOYEE group by Dno having count(Ssn) >3) and Salary>37000 group by Dno;

->solution 
+-----+------------+
| Dno | count(Ssn) |
+-----+------------+
|   5 |          2 |
+-----+------------+
1 row in set (0.05 sec)

7 ##Retrieve employee names of all the employees not working on either project 1 or 2. (make sure output has no duplicate SSN) (assume (Fname, Minit, Lname) is unique for an employee)

SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Ssn NOT IN (SELECT Essn FROM WORKS_ON WHERE Pno = 1 OR Pno = 2);

+----------+-------+---------+
| Fname    | Minit | Lname   |
+----------+-------+---------+
| Ramesh   | K     | Narayan |
| James    | E     | Borg    |
| Jennifer | S     | Wallace |
| Ahmad    | V     | Jabbar  |
| Alicia   | J     | Zelaya  |
+----------+-------+---------+
5 rows in set (0.02 sec)


8 ##  Retrieve the names of all employees who work in the department that has the employee with the highest salary among all employees.

SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Dno = (SELECT Dno FROM EMPLOYEE WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE));

solution -> 

+-------+-------+-------+
| Fname | Minit | Lname |
+-------+-------+-------+
| James | E     | Borg  |
+-------+-------+-------+
1 row in set (0.02 sec)

9 ## Retrieve the names of all employees whose supervisor’s supervisor has ‘888665555’ for Ssn.

SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Super_ssn IN (SELECT Ssn FROM EMPLOYEE WHERE Super_ssn = '888665555');

SELECT Fname, Lname from EMPLOYEE WHERE Super_ssn IN (Select Ssn from EMPLOYEE where Super_ssn IN ('888665555'));

Solution -> 
+--------+-------+---------+
| Fname  | Minit | Lname   |
+--------+-------+---------+
| John   | B     | Smith   |
| Joyce  | A     | English |
| Ramesh | K     | Narayan |
| Ahmad  | V     | Jabbar  |
| Alicia | J     | Zelaya  |
+--------+-------+---------+
5 rows in set (0.01 sec)

10 ## Retrieve the names of employees who make at least $ 10,000 more than the employee who is paid the least in the company

SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Salary > (SELECT Salary FROM EMPLOYEE ORDER BY Salary ASC LIMIT 1) + 10000;

Solution -> 
+----------+-------+---------+
| Fname    | Minit | Lname   |
+----------+-------+---------+
| Franklin | T     | Wong    |
| Ramesh   | K     | Narayan |
| James    | E     | Borg    |
| Jennifer | S     | Wallace |
+----------+-------+---------+
4 rows in set (0.01 sec)




