/* Database schema to keep the structure of entire database. */

ALTER SEQUENCE id RESTART WITH 1;

DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg real,
    species_id int,
    owner_id int
);

DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(100),
    age int
);

DROP TABLE IF EXISTS species;
CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(100)
);

ALTER TABLE animals
  ADD FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals
  ADD FOREIGN KEY (owner_id) REFERENCES owners (id);

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

DROP TABLE IF EXISTS specialization;
CREATE TABLE specialization (
    vet_id INT,
    species_id INT
);

DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
    date DATE,
    vet_id INT,
    animal_id INT
);
