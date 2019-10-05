CREATE TABLE Departments (
	id SERIAL PRIMARY KEY,
	Department_Number VARCHAR(255),
	Department_Name VARCHAR(255)
);

CREATE TABLE Department_EMP (
	id SERIAL PRIMARY KEY,
	Employee_Number INT,
	Department_Number VARCHAR(255),
	Start_Date DATE,
	End_Date DATE
);

CREATE TABLE Department_Manager (
	id SERIAL PRIMARY KEY,
	Department_Number VARCHAR(255),
	Employee_Number INT,
	Start_Date DATE,
	End_Date DATE
);

CREATE TABLE Employees (
	id SERIAL PRIMARY KEY,
	Employee_Number INT,
	Birth_Date DATE,
	First_Name VARCHAR(255),
	Last_Name VARCHAR(255),
	Gender VARCHAR(255),
	Start_Date DATE
);

CREATE TABLE Salaries (
	id SERIAL PRIMARY KEY,
	Employee_Number INT,
	Salary INT,
	Start_Date DATE,
	End_Date DATE
);

CREATE TABLE Titles (
	id SERIAL PRIMARY KEY,
	Employee_Number INT,
	Title VARCHAR(255),
	Start_Date DATE,
	End_Date DATE
);

--Employee details
SELECT employees.First_Name, employees.Last_Name, employees.Gender, salaries.Salary
FROM employees
INNER JOIN salaries
ON employees.Employee_Number = salaries.Employee_Number;

--Employee's hired in 1986
SELECT * FROM employees
WHERE start_date >= '19860101' AND start_date <= '19861231'

--Managers of each department
SELECT department_manager.Employee_Number, employees.First_Name, employees.Last_Name, department_manager.Start_Date,
	   department_manager.End_Date, department_manager.Department_Number, departments.Department_Name
FROM department_manager
INNER JOIN employees
	ON department_manager.Employee_Number = employees.Employee_Number
INNER JOIN departments
	ON department_manager.Department_Number = departments.Department_Number
	
--Department of each employee
SELECT department_emp.Employee_Number, employees.Last_Name, employees.First_Name, departments.Department_Name
FROM department_emp
INNER JOIN employees
	ON department_emp.Employee_Number = employees.Employee_Number
INNER JOIN departments
	ON department_emp.Department_Number = departments.Department_Number
	
--Employees w/first name of Hercules and last name starting w/B 
SELECT * FROM employees
WHERE First_Name = 'Hercules' AND Last_Name LIKE 'B%';


--All employees in the sales department
SELECT * FROM departments  --used select statement to figure out the sales department number
SELECT department_emp.Employee_Number, department_emp.Department_Number, employees.Last_Name, employees.First_Name
FROM department_emp
INNER JOIN employees
	ON department_emp.Employee_Number = employees.Employee_Number
	WHERE department_emp.Department_Number = 'd007'

--All employees within the sales and development departments 
SELECT department_emp.Employee_Number, employees.Last_Name, employees.First_Name, departments.Department_Name 
FROM department_emp
INNER JOIN employees
	ON department_emp.Employee_Number = employees.Employee_Number
INNER JOIN departments
	ON department_emp.Department_Number = departments.Department_Number
	WHERE departments.Department_Name IN ('Development', 'Sales');

--Frequency of employee last names in decensing order
SELECT Last_Name, count(Last_Name) FROM employees
GROUP BY Last_Name
ORDER BY count(Last_Name) DESC