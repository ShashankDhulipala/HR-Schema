create database HR;
use HR;

CREATE TABLE regions
   ( region_id int NOT NULL primary key, 
    region_name VARCHAR(25)
    );

CREATE TABLE countries 
   ( country_id CHAR(2) NOT NULL primary key
   , country_name VARCHAR(40) 
   , region_id int 
	, foreign key (region_id) references regions(region_id)
   );
 

CREATE TABLE locations
   ( location_id int not null primary key
   , street_address VARCHAR(40)
   , postal_code VARCHAR(12)
   , city VARCHAR(30) not null
   , state_province VARCHAR(25)
   , country_id CHAR(2)
   , foreign key (country_id) references countries (country_id)
   ) ;
 

CREATE TABLE departments
   ( department_id int not null primary key
   , department_name VARCHAR(30) not null
   , manager_id int
   , location_id int
   , foreign key (location_id) references locations (location_id)
   ) ;

CREATE TABLE jobs
   ( job_id VARCHAR(10) not null primary key
   , job_title VARCHAR(35) not null
   
   , min_salary int
   , max_salary int
   ) ;

CREATE TABLE employees
   ( employee_id int not null primary key
   , first_name VARCHAR(20)
   , last_name VARCHAR(25) not null
   , email VARCHAR(25) NOT NULL
   , phone_number VARCHAR(20)
   , hire_date DATE NOT NULL
   , job_id VARCHAR(10) not null
   , salary double
   , commission_pct double
   , manager_id int
   , department_id int
   , CONSTRAINT emp_salary_min
   CHECK (salary > 0) 
   , CONSTRAINT emp_email_uk
   UNIQUE (email),
   foreign key (department_id) references departments(department_id),
   foreign key (job_id) references jobs(job_id),
   foreign key (manager_id) references employees (employee_id)
   ) ; 

CREATE TABLE job_history
   ( employee_id int not null
   , start_date DATE not null
   , end_date DATE not null
   , job_id VARCHAR(10) not null
   , department_id int 
   , CONSTRAINT jhist_date_interval
   CHECK (end_date > start_date),
   constraint primary key (employee_id, start_date),
   foreign key (job_id) references jobs(job_id),
   foreign key (employee_id) references employees (employee_id),
   foreign key (department_id) references departments (department_id)
   ) ;
   
   