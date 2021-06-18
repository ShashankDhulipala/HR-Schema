# 1: Generate a report showing employees first name, last name, their department, city and state province
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees as e LEFT JOIN departments as d
ON e.department_id = d.department_id
LEFT JOIN locations as l
ON l.location_id = d.location_id;

# 2: Generate a report showing first name, last name, department number, department name for all the employees in departments 80 or 40
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees as e LEFT JOIN departments as d
ON e.department_id = d.department_id
WHERE e.department_id in (80,40);
#WHERE e.department_id = 80 or e.department_id = 40;

#3: Generate a report showing all employees whose first name contains a letter ‘Z’ Also add their last name, department, city and province
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN locations l
ON d.location_id = l.location_id
WHERE e.first_name LIKE '%Z%';

#4: Generate a report showing all departments including those without any employees 
SELECT * FROM departments d
LEFT JOIN employees e 
ON d.department_id = e.department_id;
#SELECT * FROM employees e RIGHT JOIN departments d
#ON  e.department_id = d.department_id;

#5 :Generate a report showing thos employees who earn more then the employee William Smith from department id 80
SELECT first_name, last_name, salary, department_id
FROM employees 
WHERE salary > (SELECT salary FROM employees
				WHERE first_name='William' AND last_name='Smith' 
				AND department_id=80);
                
#6 :Employees firstname, and first names of their respective managers.
SELECT e.first_name as 'Employee First Name', m.first_name as'Manager First Name'
FROM employees e LEFT JOIN employees m
ON e.manager_id = m.employee_id;

#7 :Generate a report showing all department names, city and the state province
SELECT d.department_name, l.city, l.state_province
FROM departments d LEFT JOIN locations l
ON d.location_id = l.location_id;

#8 :Generate a report showing first_name and last_name of all the employees including their department_id, and dept name ,
# include those employees who are not yet allocated to any departments yet.
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id;

#9 :Generate a report showing first name, last name and department id of all employees working in the same department as another employee whose last name is Russell
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = (SELECT department_id FROM employees
						WHERE last_name = 'Russell');
                        
#10 :Generate a report displaying job title, department name, employee full name, start date for all jobs which started on or after January 1st 1993
# and ending on or before 31 august 1997
SELECT j.job_title , d.department_name ,concat(e.first_name,' ',e.last_name) as fullname , jh.start_date , jh.end_date 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN jobs j ON e.job_id = j.job_id
JOIN job_history jh ON e.employee_id = jh.employee_id
WHERE jh.start_date >= '1993-01-01' AND jh.end_date <='1997-08-31';

#11 :Produce a report to display job title, full name, difference between maximum salary for the job and the salary of this employee
SELECT j.job_title, concat(e.first_name,' ',last_name) as fullname , j.max_salary,e.salary, (j.max_salary - e.salary) as 'difference between max salary and salary'
FROM employees e
JOIN jobs j ON e.job_id = j.job_id; 

#12 :Generate a report to display the name of the department, average salary and number of employees working in that department who got commission
SELECT d.department_name , d.department_id, AVG(e.salary) , count(employee_id) , e.commission_pct
FROM employees e JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING e.commission_pct > 0;

#13 :Generate a report to display the name of the country, city and the departments which are running there. 
SELECT c.country_name , l.city ,d.department_name
FROM countries c JOIN locations l
ON c.country_id = l.country_id
JOIN departments d
ON l.location_id = d.location_id ORDER BY c.country_name;

#14 :Generate a report to display DEPARTMENT NAME  and the full name of the manager
SELECT d.department_name , concat(e.first_name,' ',last_name) as 'manager full name'
FROM employees e JOIN departments d 
ON e.department_id = d.department_id
WHERE e.manager_id IS NOT NULL;

#15 :Generate a report to diplay the job title and average salary of the employees
SELECT job_title , AVG(salary)
FROM employees e JOIN jobs j 
ON e.job_id = j.job_id
GROUP BY job_title;

#16 :Generate a report to diplay the details of jobs which was done by any of the employees who is presently earning a salary above 12000
SELECT  e.first_name ,e.last_name ,e.salary ,e.job_id ,j.job_title ,jh.start_date , jh.end_date 
FROM employees e  JOIN job_history jh 
ON e.employee_id = jh.employee_id
JOIN jobs j ON jh.job_id = j.job_id
WHERE e.salary>12000;

# 17:Generate a report to display the employee id, job name, number of days worked in for all those jobs in department 80. 
SELECT e.employee_id ,j.job_title, datediff(jh.end_date ,jh.start_date) as 'no of days worked'
FROM  employees e JOIN job_history jh 
ON e.job_id = jh.job_id
JOIN jobs j ON e.job_id = j.job_id
WHERE e.department_id =80;

