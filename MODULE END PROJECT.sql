CREATE DATABASE LIBRARY;
USE LIBRARY;

CREATE TABLE BRANCH(
BRANCH_NUMBER INT PRIMARY KEY,
MANAGER_ID INT,
BRANCH_ADDRESS VARCHAR(70),
CONTACT_NUMBER INT 
);

CREATE TABLE EMPLOYEE(
EMPLOYEE_ID INT PRIMARY KEY,
EMPLOYEE_NAME VARCHAR(30),
POSITION VARCHAR(30),
SALARY INT,
BRANCH_NUMBER INT ,
FOREIGN KEY (BRANCH_NUMBER) REFERENCES BRANCH (BRANCH_NUMBER)
);

CREATE TABLE CUSTOMER(
CUSTOMER_ID INT PRIMARY KEY,
CUSTOMER_NAME VARCHAR(30),
CUSTOMER_ADDRESS VARCHAR(70),
REG_DATE DATE 
);

CREATE TABLE BOOKS(
ISBN INT PRIMARY KEY,
BOOK_TITLE VARCHAR(30),
CATEGORY VARCHAR(20),
RENTAL_PRICE INT,
STATUS VARCHAR(5),
AUTHOR VARCHAR(30),
PUBLISHER VARCHAR(30)
);

CREATE TABLE ISSUE_STATUS(
ISSUE_ID INT PRIMARY KEY,
ISSUED_CUST INT ,
FOREIGN KEY (ISSUED_CUST) REFERENCES CUSTOMER(CUSTOMER_ID),
ISSUED_BOOK_NAME VARCHAR(30),
ISSUE_DATE DATE ,
ISBN INT ,
FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN)
);

CREATE TABLE RETURN_STATUS(
RETURN_ID INT PRIMARY KEY,
RESTURN_CUST VARCHAR(30),
RETURNED_BOOK VARCHAR(30),
RETURN_DATE DATE,
ISBN_BOOK2 INT,
FOREIGN KEY(ISBN_BOOK2) REFERENCES BOOKS(ISBN)
);

INSERT INTO BRANCH VALUES
(1,101,'BR1',2765921),
(2,102,'BR2',6669824),
(3,103,'BR3',4289666),
(4,104,'BR4',1295672),
(5,105,'BR5',2414405),
(6,106,'BR6',5044142);

SELECT * FROM BRANCH;

INSERT INTO EMPLOYEE VALUES
(661,'SHYAM','HRM',30000,1),
(662,'RAM','FM',50000,2),
(663,'TEENA','AFM',40000,3),
(664,'SAM','FM',50000,4),
(665,'ARJITH','AFM',40000,5),
(666,'ALI','SYSTEM OPERATOR',25000,6);



INSERT INTO EMPLOYEE VALUES
(667,'SHYAMA','HRM',30000,2),
(668,'RAMYA','FM',50000,1),
(669,'TINU','AFM',40000,2),
(670,'SAMEER','FM',50000,3),
(671,'ARJITHA','AFM',40000,1),
(672,'ALIAS','SYSTEM OPERATOR',25000,1);

INSERT INTO EMPLOYEE VALUES
(673,'ROY','MANAGER',70000,1),
(674,'ALOK','AM',55000,2),
(675,'RAGHAV','SENIOR SUPERINTEDENT',100000,3);

SELECT * FROM EMPLOYEE;

INSERT INTO CUSTOMER VALUES
(201,'SIVA','CALICUT','2021-04-14'),
(202,'SANKAR','CALICUT','2021-04-20'),
(203,'ANOOP','CALICUT','2021-05-02'),
(204,'ARJUN','CALICUT','2022-06-01'),
(205,'VENKITESH','MALAPPURAM','2022-09-25'),
(206,'ARAVIND','MALAPPURAM','2023-12-05'),
(207,'ANAND','MALAPPURAM','2020-12-12');

SELECT * FROM CUSTOMER;

INSERT INTO BOOKS VALUES 
(3987,'THE GIRL IN ROOM 105','MYSTERY',99,'YES','CHETAN BAGATH','WESTLAND'),
(9784,'RANDAAMOOZHAM','DRAMA',170,'NO','MT VASUDEVAN','CURRENT BOOKS'),
(9789,'PONNIYAN SELVAN1','HISTORY',599,'YES','KALKI','DC BOOKS'),
(9788,'FRANCIS ITTYKORA','MYSTERY',199,'NO','T D RAMAKRISHNAN','DC BOOKS'),
(9787,'SUGHANDHIENNAANDAALDEVANAYAKI','POST MODERN NOVEL',199,'NO','T D RAMAKRISHNAN','DC BOOKS'),
(9765,'ORACHANTE ORMA KURIPPUKAL','MEMOIRS',105,'YES','T V EACHARA WARRIER','CURRENT BOOKS'),
(9764,'AND THE MOUNTAINS ECHOED','DRAMA',249,'YES','KHALED HOSSEINI','BLOOMSBURY');

SELECT * FROM BOOKS;

INSERT INTO ISSUE_STATUS VALUES
(10,201,'FRANCIS ITTYKORA','2022-12-31',9788),
(11,202,'AND THE MOUNTAINS ECHOED','2023-01-02',9764),
(12,203,'RANDAAMOOZHAM','2023-01-05',9784),
(13,204,'THE GIRL IN ROOM 105','2024-01-06',3987);
INSERT INTO ISSUE_STATUS VALUES
(14,206,'PONNIYAN SELVAN1','2023-06-02',9789);

SELECT * FROM ISSUE_STATUS;

INSERT INTO RETURN_STATUS VALUES
(20,'SIVA','FRANCIS ITTYKORA','2023-03-12',9788),
(21,'ANOOP','RANDAMOOZHAM','2024-05-15',9784),
(22,'SANKAR','AND THE MOUNTAINS ECHOED','2024-04-15',9764);

SELECT * FROM RETURN_STATUS;

#1. Retrieve the book title, category, and rental price of all available books. 
SELECT BOOK_TITLE,CATEGORY,RENTAL_PRICE FROM BOOKS;

#2. List the employee names and their respective salaries in descending order of salary.
SELECT EMPLOYEE_NAME,SALARY FROM EMPLOYEE ORDER BY SALARY DESC;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT ISSUED_BOOK_NAME,ISSUED_CUST FROM ISSUE_STATUS;

#4. Display the total count of books in each category.
SELECT CATEGORY,COUNT(*)AS BOOKS_COUNT FROM BOOKS GROUP BY CATEGORY;

#5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT EMPLOYEE_NAME,POSITION FROM EMPLOYEE WHERE SALARY > 50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT CUSTOMER.CUSTOMER_NAME FROM CUSTOMER
LEFT JOIN ISSUE_STATUS ON CUSTOMER.CUSTOMER_ID=ISSUE_STATUS.ISSUED_CUST
WHERE CUSTOMER.REG_DATE<'2022-01-01'AND ISSUE_STATUS.ISSUED_BOOK_NAME IS NULL;


#7. Display the branch numbers and the total count of employees in each branch.
SELECT BRANCH_NUMBER,COUNT(*)AS EMPLOYEE_COUNT FROM EMPLOYEE GROUP BY BRANCH_NUMBER;

#8. Display the names of customers who have issued books in the month of June 2023.
SELECT ISSUED_CUST,ISSUED_BOOK_NAME FROM ISSUE_STATUS WHERE ISSUE_DATE='2023-06-02';

SELECT DISTINCT CUSTOMER.CUSTOMER_NAME FROM ISSUE_STATUS JOIN
CUSTOMER ON ISSUE_STATUS.ISSUED_CUST=CUSTOMER.CUSTOMER_ID WHERE MONTH(ISSUE_STATUS.ISSUE_DATE)=6 AND YEAR(ISSUE_STATUS.ISSUE_DATE)=2023;

#9. Retrieve book_title from book table containing history.
SELECT BOOK_TITLE FROM BOOKS  WHERE CATEGORY='HISTORY';

#10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees. 
SELECT BRANCH_NUMBER, COUNT(*)AS COUNT_OF_EMPLOYEE FROM EMPLOYEE GROUP BY BRANCH_NUMBER HAVING COUNT(*)>5;

