CREATE TABLE employees (
     employee_id INT,	
first_name TEXT,
last_name TEXT,	
date_of_birth DATE,	
gender CHAR	,
hire_date DATE,	
department_id INT,	
position_id INT,	
salary	NUMERIC,
manager BOOLEAN,
PRIMARY KEY (employee_id));

CREATE TABLE departments (
     department_id INT,	
    name TEXT,
PRIMARY KEY (department_id));

CREATE TABLE positions (
     position_id INT,	
name TEXT,
PRIMARY KEY (position_id));

ALTER TABLE employees
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE employees
ADD FOREIGN KEY (position_id) REFERENCES positions(position_id);

ALTER TABLE public.employees OWNER to postgres;
ALTER TABLE public.departments OWNER to postgres;
ALTER TABLE public.positions OWNER to postgres

-- create indexes for better performances:
CREATE INDEX idx_employee_id on public.employees (employee_id);
CREATE INDEX idx_department_id on public.departments (department_id);
CREATE INDEX idx_position_id on public.positions (position_id)

-- load data in our tables
COPY employees
FROM 'C:\Users\katar\Documents\SQL\employee\csv\employees.csv'
DELIMITER ',' CSV HEADER;
COPY departments
FROM 'C:\Users\katar\Documents\SQL\employee\csv\departments.csv'
DELIMITER ',' CSV HEADER;
COPY positions
FROM 'C:\Users\katar\Documents\SQL\employee\csv\positions.csv'
DELIMITER ',' CSV HEADER;

--above gives permission error, in Postgres go on database, right click 'PSQL TOOL'
\COPY employees
FROM 'C:\Users\katar\Documents\SQL\employee\csv\employees.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\COPY departments
FROM 'C:\Users\katar\Documents\SQL\employee\csv\departments.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\COPY positions
FROM 'C:\Users\katar\Documents\SQL\employee\csv\positions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');