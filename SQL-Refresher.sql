CREATE DATABASE PetAdoptionDB;
USE PetAdoptionDB;

--  Create, Modify, Rename Table

CREATE TABLE Animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    species VARCHAR(30),
    age INT,
    arrival_date DATE
);

CREATE TABLE Adoptions (
    adoption_id INT AUTO_INCREMENT PRIMARY KEY,
    adopter_name VARCHAR(50),
    animal_id INT,
    adoption_date DATE,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Modify
ALTER TABLE Animals ADD COLUMN gender VARCHAR(10);

-- Table rename
RENAME TABLE Animals TO Animal_List;

-- Insert Data

INSERT INTO Animal_List (name, species, age, arrival_date, gender) VALUES
('Max', 'Dog', 3, '2023-01-15', 'Male'),
('Luna', 'Cat', 2, '2023-02-10', 'Female'),
('Buddy', 'Dog', 1, '2023-03-05', 'Male'),
('Milo', 'Rabbit', 4, '2023-01-22', 'Male'),
('Bella', 'Cat', 2, '2023-04-12', 'Female');

INSERT INTO Adoptions (adopter_name, animal_id, adoption_date) VALUES
('Alice', 1, '2023-05-01'),
('Bob', 2, '2023-06-10'),
('Charlie', 3, '2023-06-15'),
('David', 4, '2023-07-01'),
('Emma', 5, '2023-07-20');

-- Data Manipulation Queries

-- update

SET SQL_SAFE_UPDATES = 0;

UPDATE Animal_List
SET age = 5
WHERE name = 'Milo';

SET SQL_SAFE_UPDATES = 1;

-- Delete

DELETE FROM Animal_List
WHERE name = 'Bella';

-- Select Queries with Filtering
-- Specific Attributes & Rows

SELECT name, species FROM Animal_List WHERE species = 'Dog';

-- WHERE Clause with Operators

-- AND
SELECT * FROM Animal_List
WHERE age > 2 AND species = 'Dog';

-- IN & NOT IN
SELECT * FROM Animal_List
WHERE species IN ('Cat', 'Rabbit');

-- BETWEEN
SELECT * FROM Animal_List
WHERE age BETWEEN 2 AND 4;

-- LIKE
SELECT * FROM Animal_List
WHERE name LIKE 'B%';

-- ALIASES
SELECT name AS AnimalName, species AS Type FROM Animal_List;

-- String Functions
SELECT UPPER(name), LENGTH(name) FROM Animal_List;

-- Date functions
SELECT name, MONTH(arrival_date) AS ArrivalMonth FROM Animal_List;

-- Aggregate and Grouping

SELECT species, COUNT(*) AS total_animals, AVG(age) AS avg_age
FROM Animal_List
GROUP BY species
HAVING COUNT(*) > 1;


-- Joins

-- Inner join
SELECT a.name, a.species, d.adopter_name
FROM Animal_List a
JOIN Adoptions d ON a.animal_id = d.animal_id;

-- Left join
SELECT a.name, d.adopter_name
FROM Animal_List a
LEFT JOIN Adoptions d ON a.animal_id = d.animal_id;

-- Right join
SELECT a.name, d.adopter_name
FROM Animal_List a
RIGHT JOIN Adoptions d ON a.animal_id = d.animal_id;

-- Full Outer Join

SELECT a.name, d.adopter_name
FROM Animal_List a
LEFT JOIN Adoptions d ON a.animal_id = d.animal_id
UNION
SELECT a.name, d.adopter_name
FROM Animal_List a
RIGHT JOIN Adoptions d ON a.animal_id = d.animal_id;

-- Cross join
SELECT a.name, d.adopter_name
FROM Animal_List a
CROSS JOIN Adoptions d;

-- Self join

SELECT a1.name AS Animal1, a2.name AS Animal2
FROM Animal_List a1, Animal_List a2
WHERE a1.age = a2.age AND a1.animal_id != a2.animal_id;

-- Join with aggregate

SELECT a.species, COUNT(d.adoption_id) AS total_adoptions
FROM Animal_List a
JOIN Adoptions d ON a.animal_id = d.animal_id
GROUP BY a.species;

-- Subqueries

-- Basic sq

SELECT * FROM Animal_List
WHERE animal_id IN (
    SELECT animal_id FROM Adoptions WHERE adopter_name = 'Alice'
);

-- Correlated sq
SELECT name FROM Animal_List a
WHERE EXISTS (
    SELECT 1 FROM Adoptions d WHERE d.animal_id = a.animal_id
);

-- Set Operations

-- Union
SELECT name FROM Animal_List
UNION
SELECT adopter_name FROM Adoptions;

-- Intersect

SELECT a.name FROM Animal_List a
INNER JOIN Adoptions d ON a.animal_id = d.animal_id;








