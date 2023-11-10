/* GENERATE AN ID AUTOMATICALLY */

ALTER TABLE animals 
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
( 'Agumon', '2020-02-03', 0, TRUE, 10.23 ),
('Gabumon', '2018-11-15', 2, TRUE , 8 ),
('Pikachu', '2021-01-07', 1, FALSE, 15.04 ),
('Devimon', '2017-05-12', 5, true, 11);


INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Charmander', '2020-02-08', 0, FALSE, -11),
('Plantmon', '2021-11-15', 2, TRUE, -5.7),
('Squirtle', '1993-04-02', 3, FALSE, -12.13 ),
('Angemon', '2005-06-12', 1, TRUE, -45 ),
('Boarmon', '2005-06-07', 7, TRUE, 20.4),
('Blossom', '1998-10-13', 3, TRUE, 17),
('Ditto', '2022-05-14', 4, TRUE, 22); 

INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);
SELECT * FROM owners;

INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');
SELECT * FROM species;

BEGIN;
UPDATE animals
SET species=1 
WHERE
name LIKE '%mon';
SELECT * FROM species;

UPDATE animals
SET species_id = 
  CASE 
    WHEN animals.name LIKE '%mon' AND (
         SELECT name FROM species WHERE id = animals.species_id
       ) = 'Pokemon' THEN 1
    ELSE 2
  END;



UPDATE animals
SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon') END);

SELECT * FROM animals;

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';
SELECT * FROM animals;

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');
SELECT * FROM animals;

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');
SELECT * FROM animals;

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
SELECT * FROM animals;

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Dean Winchester'  
)
WHERE name IN ('Angemon', 'Boarmon');
