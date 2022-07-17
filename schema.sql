/* Database schema to keep the structure of entire database. */

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