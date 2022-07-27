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

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals
   SET species_id = 2 WHERE name LIKE '%mon';

UPDATE animals
   SET species_id = 1
 WHERE species_id IS NULL;

-- What animals belong to Melody Pond?
SELECT a.name
  FROM owners o
 INNER JOIN animals a
    ON o.id = a.owner_id
 WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
  FROM animals a
 INNER JOIN species s ON a.species_id = s.id
 WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name
  FROM animals a
  FULL OUTER JOIN owners o ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(a.species_id)
  FROM species s
 INNER JOIN animals a on s.id = a.species_id
 GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
  FROM animals a
 INNER JOIN species s ON s.id = a.species_id
 INNER JOIN owners o ON a.owner_id = o.id
 WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
  FROM animals a
 INNER JOIN species s ON s.id = a.species_id
 INNER JOIN owners o ON a.owner_id = o.id
 WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.name)
  FROM animals a
 INNER JOIN species s ON s.id = a.species_id
 INNER JOIN owners o ON a.owner_id = o.id
 GROUP BY o.full_name
 ORDER BY COUNT(a.name) DESC
 LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name, vi.date
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 WHERE v.name LIKE '%William Tatcher'
 ORDER BY date DESC
 LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT (a.name))
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 WHERE v.name LIKE '%Mendez%';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name
  FROM specialization s
 RIGHT OUTER JOIN vets v ON v.id = s.vet_id
  LEFT OUTER JOIN species sp ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 WHERE v.name LIKE '%Mendez%' AND vi.date BETWEEN '08-01-2020' AND '08-30-2020';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(DISTINCT(vi.date)) AS visits
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 GROUP BY a.name
 ORDER BY visits DESC
 LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name, vi.date
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 WHERE v.name LIKE '%Maisy%'
 ORDER BY date ASC
 LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, v.name, v.date_of_graduation, v.age, vi.date
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 WHERE v.name LIKE '%Maisy%'
 ORDER BY date DESC
 LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
  FROM vets v
  JOIN visits vi on v.id = vi.vet_id
  JOIN animals a ON vi.animal_id = a.id
  JOIN specialization s on v.id = s.vet_id
 WHERE NOT s.species_id = a.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT a.name, COUNT(vi.date) AS visits
  FROM animals a
 INNER JOIN visits vi ON a.id = vi.animal_id
 INNER JOIN vets v ON vi.vet_id = v.id
 WHERE v.name LIKE '%Maisy%'
 GROUP BY a.name
 ORDER BY visits DESC
 LIMIT 1;

-- Check running of populate script
EXPLAIN ANALYSE SELECT COUNT(*)
  FROM visits
 WHERE animal_id = 4;

EXPLAIN ANALYSE SELECT COUNT(*) FROM visits where animal_id = 4;

EXPLAIN ANALYSE SELECT * FROM visits where vet_id = 2;

EXPLAIN ANALYSE SELECT * FROM owners where email = 'owner_18327@mail.com';
