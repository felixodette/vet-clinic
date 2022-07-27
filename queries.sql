/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

-- Find all animals whose name ends in "mon".
SELECT * FROM animals
 WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name
  FROM animals
 WHERE date_of_birth BETWEEN '01-01-2016' AND '12-31-2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
  FROM animals
 WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
  FROM animals
 WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
  FROM animals
 WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT *
  FROM animals
 WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT *
  FROM animals
 WHERE name NOT LIKE 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
  FROM animals
 WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;

UPDATE animals
   SET species = 'Unspecified';

SELECT *
  FROM animals;

COMMIT;

ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals
   SET species = 'Digimon'
 WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
   SET species = 'Pokemon'
 WHERE species IS NULL;

-- Commit the transaction.
COMMIT;

-- Verify that change was made and persists after commit.
SELECT * FROM animals;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

DELETE FROM animals;

ROLLBACK;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals
 WHERE date_of_birth > '01-01-2022';

-- Create a savepoint for the transaction.
SAVEPOINT january_2022;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
   SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO january_2022;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
   SET weight_kg = weight_kg * -1
 WHERE weight_kg < 0;

COMMIT;

-- How many animals are there?
SELECT COUNT(name)
  FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(name)
  FROM animals
 WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg)
  FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts)
  FROM animals
 WHERE escape_attempts > 0
 GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg)
  FROM animals
 GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
  FROM animals
 WHERE date_of_birth BETWEEN '01-01-1990' AND '12-31-2000'
 GROUP BY species;