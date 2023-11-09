/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name IN ('Agumon',  'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg<10.5;
SELECT * FROM animals WHERE neutered=TRUE;
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Then roll back  */
BEGIN;
UPDATE animals
SET species = 'Unspecified';
-- Select statement to verify the update
SELECT * FROM animals WHERE species = 'Unspecified';
ROLLBACK;

/* Name Species */
BEGIN;
UPDATE animals
SET species='digimon' 
WHERE
name LIKE '%mon';
SELECT species from animals; -- verify that change was made

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL; 
SELECT species from animals; -- verify that change was made
COMMIT;
SELECT species from animals; -- verify that change persists after commit

/* Delete all animals born after Jan 1st, 2022 */
BEGIN;
DELETE FROM animals
WHERE  date_of_birth > '2022-01-01';
SELECT * FROM animals;

/* Create a savepoint */
SAVEPOINT my_savepoint;

/* Update all animals' weight to be their weight multiplied by -1 */
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

/* Rollback to the savepoint */
ROLLBACK TO my_savepoint;
SELECT * FROM animals;

/* Update all animals' weights that are negative to be their weight multiplied by -1 */
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * FROM animals;

/* Commit transaction */
COMMIT;
SELECT * FROM animals;

/* Total Animals */
SELECT COUNT(*) FROM animals;

/* How many animals have not tried to escape */
SELECT
COUNT(*)
FROM animals
WHERE escape_attempts = 0;

/* What is the average weight of animals? */

SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT
    Neutered,
    AVG(escape_attempts)
FROM
    animals
GROUP BY
    neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT
    species,
    MIN(weight_kg),
    MAX(weight_kg)
FROM
    Animals
GROUP BY
    species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT
    species,
    SUM(escape_attempts)/COUNT(*) AS average
FROM
    animals
WHERE
    date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY
    species;
