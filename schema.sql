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

