DROP TABLE IF EXISTS doctorsExaminations;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS examinations;
DROP TABLE IF EXISTS wards;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS sponsors;

CREATE TABLE IF NOT EXISTS departments (
    id SERIAL NOT NULL PRIMARY KEY,
    building INT NOT NULL, 
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS doctors (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    premium_money INT NOT NULL,
    department_id INT NOT NULL,
    salary INT NOT NULL,
    surname VARCHAR(255) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctorsExaminations (
    id SERIAL NOT NULL PRIMARY KEY,
    endTime TIME NOT NULL,
    startTime TIME NOT NULL,
    doctor_id INT NOT NULL,
    examination_id INT NOT NULL,
    ward_id INT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

CREATE TABLE IF NOT EXISTS examinations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS wards (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    places INT NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS donations (
    id SERIAL NOT NULL PRIMARY KEY,
    amount INT NOT NULL,
    date DATE NOT NULL,
    department_id INT NOT NULL,
    sponsor_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS sponsors (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


INSERT INTO departments (building, name) VALUES
    (1, 'Cardiology'),
    (2, 'Gastroenterology'),
    (3, 'General Surgery'),
    (4, 'Microbiology');

INSERT INTO doctors (name, premium_money, department_id, salary, surname) VALUES
    ('Thomas', 5000.00, 1, 80000.00, 'Gerada'),
    ('Emily', 4500.00, 2, 75000.00, 'Brown'),
    ('Joshua', 1000.00, 3, 200.00, 'Bell'),
    ('Anthony', 10000.00, 4, 10000.00, 'Davis');

INSERT INTO examinations (name) VALUES
    ('MRI'),
    ('CT Scan'),
    ('Echocardiogram');

INSERT INTO wards (name, places, department_id) VALUES
    ('Ward A', 20, 1),
    ('Ward B', 15, 2),
    ('Ward C', 25, 3),
    ('Ward 4', 20, 4),
    ('Ward 4', 20, 4);

INSERT INTO donations (amount, date, department_id, sponsor_id) VALUES
(1000, '2024-04-23', 1, 1),
(1500, '2024-04-23', 2, 2),
(10500, '2024-04-24', 1, 3);

INSERT INTO sponsors (name) VALUES
    ('ABC Healthcare'),
    ('XYZ Foundation'),
    ('HealthFirst Charity');

INSERT INTO doctorsExaminations (endTime, startTime, doctor_id, examination_id, ward_id) VALUES
('15:00:00', '12:00:00', 1, 1, 1),
('19:00:00', '17:00:00', 2, 2, 2),
('20:00:00', '18:00:00', 3, 3, 3);


/*Task 1 
select w.name
from wards AS w
JOIN departments AS d
ON w.department_id=d.id
WHERE d.name LIKE 'Cardiology';
*/

/*Task 2  
select w.name
from wards AS w
JOIN departments AS d
ON w.department_id=d.id
WHERE d.name IN ('Gastroenterology', 'General Surgery');
*/

/*Task 3 
select name, COUNT(*)
from donations 
JOIN departments
ON department_id=departments.id
GROUP BY departments.name
ORDER BY COUNT(*)
LIMIT 1;
*/

/*Task 4 
SELECT d.name,d.surname
FROM doctors AS d
WHERE d.salary > (SELECT salary FROM doctors WHERE name = 'Thomas' AND surname = 'Gerada');
*/

/*Task 5
SELECT d.name,w.places
FROM wards AS w
Join departments AS d
ON w.department_id=d.id
WHERE w.places>(SELECT avg(war.places) 
FROM wards AS war      
JOIN departments AS dep 
ON war.department_id=dep.id        
WHERE dep.name = 'Microbiology');
*/

/*Task 6 
SELECT d.name, d.surname
FROM doctors AS d
WHERE (d.salary + d.premium_money) > (
    SELECT sum(salary + 100)
    FROM doctors
    WHERE name = 'Anthony' AND surname = 'Davis')
	AND name <> 'Anthony' AND surname <> 'Davis';
*/

/* Task 7 
SELECT dp.name
FROM doctors as d
join doctorsExaminations as de
on de.doctor_id=d.id
join wards as w
on de.ward_id=w.id
join departments as dp
on w.department_id=dp.id
where d.name='Joshua' and d.surname ='Bell';
*/

/* Task 8 
SELECT sp.name
FROM sponsors as sp
join donations as don
on sp.id = don.sponsor_id 
join departments as dp
on don.department_id = dp.id
where dp.name != 'Gastroenterology' and dp.name != 'Microbiology';
*/

/*Task 9
SELECT doc.surname
FROM doctors as doc
join doctorsExaminations as docEx
on doc.id = docEx.doctor_id
where docEx.startTime = '12:00' and docEx.endTime = '15:00';
*/

