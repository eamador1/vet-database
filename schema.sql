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

/* Create a link table named vets */
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY,
  name CHAR(25),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

/* Create a link table named specializations */
CREATE TABLE specializations (
  vet_id INT,
  species_id INT,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets(id),
  FOREIGN KEY (species_id) REFERENCES animals(id)
);

/* Create a link table named visits */
CREATE TABLE visits (
id INT GENERATED ALWAYS AS IDENTITY,
vet_id INT,
animal_id INT,
date_of_visit DATE,
PRIMARY KEY (id),
FOREIGN KEY (vet_id) REFERENCES vets(id),
FOREIGN KEY (animal_id) REFERENCES animals(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

/* Indexing to improve database inquiring */

CREATE INDEX animal_id_asc ON visits(animal_id ASC);

CREATE INDEX vet_id_asc ON visits(vet_id ASC);

CREATE INDEX email_asc ON owners(email ASC);


