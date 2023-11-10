/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
Id INT PRIMARY KEY NOT NULL,
name TEXT,
date_of_birth  DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg REAL
) ;

/* Add column species */

ALTER TABLE animals
ADD COLUMN species CHAR(20);

/* Create a table named owners */

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name CHAR(25),
    age INT,
    PRIMARY KEY(id)
);

/* Create a table named species */

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name CHAR(20),
    PRIMARY KEY(id)
);

/* Modify animals table */

SELECT * FROM animals;
BEGIN;
ALTER TABLE animals DROP COLUMN species;
SELECT * FROM animals;
ALTER TABLE animals 
ADD COLUMN species_id INT;
SELECT * FROM animals;
ALTER TABLE animals 
ADD COLUMN owner_id INT;
SELECT * FROM animals;
COMMIT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);