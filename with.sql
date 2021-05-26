CREATE TABLE office (
  officeid NUMBER(2) CONSTRAINT PK_officeid PRIMARY KEY,
  name VARCHAR2(14),
  city VARCHAR2(13)
) ;

CREATE TABLE employee (
  empid NUMBER(4) CONSTRAINT PK_employee PRIMARY KEY,
  name VARCHAR2(10),
  position VARCHAR2(9),
  managerid NUMBER(4),
  hiredate DATE,
  salary NUMBER(7,2),
  bonus NUMBER(7,2),
  officeid NUMBER(2) CONSTRAINT FK_officeid REFERENCES office
);

INSERT INTO office VALUES (10,'Mobile','Plano');
INSERT INTO office VALUES (20,'Home Appliances','Dallas');
INSERT INTO office VALUES (30,'Semicounductor','Austin');
INSERT INTO office VALUES (40,'SSD','Houston');

INSERT INTO employee VALUES (3105,'Andrew','Supply Chain Analyst',3108,to_date('21-11-2001','dd-mm-yyyy'),1200,NULL,20);
INSERT INTO employee VALUES (3106,'Helen','Product Developer',3110,to_date('31-3-2006','dd-mm-yyyy'),1600,300,30);
INSERT INTO employee VALUES (3107,'Kelsi','Product Developer',3108,to_date('18-4-2006','dd-mm-yyyy'),1250,500,30);
INSERT INTO employee VALUES (3108,'Amanda','Program Manager',3113,to_date('19-5-2010','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO employee VALUES (3109,'Bona','Product Developer',3111,to_date('6-10-2007','dd-mm-yyyy'),1250,1400,30);
INSERT INTO employee VALUES (3110,'Sam','Program Manager',3113,to_date('5-8-2004','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO employee VALUES (3111,'Jade','Program Manager',3113,to_date('6-8-2013','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO employee VALUES (3112,'Eric','Logistic Coordinator',3108,to_date('23-AUG-99','dd-mm-rr')-85,1000,NULL,20);
INSERT INTO employee VALUES (3113,'Lee','Director',NULL,to_date('13-12-2000','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO employee VALUES (3114,'Jack','Product Developer',3110,to_date('9-8-1999','dd-mm-yyyy'),1500,0,30);
INSERT INTO employee VALUES (3115,'Charlene','Supply Chain Analyst',3108,to_date('23-JUN-97', 'dd-mm-rr')-51,1100,NULL,20);
INSERT INTO employee VALUES (3116,'Katrina','Logistics Coordinator',3108,to_date('2-11-2015','dd-mm-yyyy'),950,NULL,30);
INSERT INTO employee VALUES (3117,'Paul','Logistics Coordinator',3108,to_date('5-10-2018','dd-mm-yyyy'),900,NULL,20);
INSERT INTO employee VALUES (3118,'Edward','Logistics Coordinator',3108,to_date('10-10-2018','dd-mm-yyyy'),900,NULL,10);


--1. For each employee, find out total number of people who work in the same office
///////////////////////////////////*verson 1 *///////////////////////////////////////////

SELECT e.name,
       oc.office_count AS emp_office_count
FROM   employee e 
       JOIN (SELECT officeid, COUNT(*) AS office_count
             FROM   employee
             GROUP BY officeid) oc
        ON e.officeid = oc.officeid;
        
///////////////////////////////////*verson 2 *///////////////////////////////////////////

WITH office_count AS
(SELECT officeid, count(*)
  FROM employee
  GROUP BY officeid)
SELECT e.name, oc.count(*)
FROM employee e 
     JOIN office_count oc
     ON e.officeid=dc.officeid;
  
  
--2. For each employee, find out total number of people who work in the same office as his/her manager
///////////////////////////////////*verson 1 *///////////////////////////////////////////

SELECT e.name, e.empid, eoc.count(*) manager_office_count
FROM employee e
JOIN employee m 
ON e.managerid=m.empid
JOIN (SELECT officeid, count(*)
      FROM employee
      GROUP BY officeid) oc
ON m.officeid=oc.officeid;

///////////////////////////////////*verson 2 *///////////////////////////////////////////

WITH office_count AS
(SELECT officeid, count(*) 
  FROM employee  
  GROUP BY officeid)
SELECT e.empid, e.name, oc.count(*) manager_office_count
FROM employee e
JOIN employee m
ON e.managerid=m.empid
JOIN office_count oc
ON oc.officeid=m.officeid;

