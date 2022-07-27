/* Populate database with sample data. */
DELETE FROM animals;
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, owner_id)
VALUES ('Agumon', '02/03/2020', 0, true, 10.23, 1),
       ('Gabumon', '11/15/2018', 2, true, 8, 2),
       ('Pickachu', '07/01/2021', 1, false, 15.05, 2),
       ('Devimon', '05/12/2017', 5, true, 11, 3),
       ('Charmander', '02/08/2020', 0, false, 11, 4),
       ('Plantmon', '11/15/2021', 2, true, 5.7, 3),
       ('Squirtle', '03/02/1993', 3, false, 12.13, 4),
       ('Angemon', '06/12/2005', 1, true, 45, 5),
       ('Boarmon', '06/07/2005', 7, true, 20.4, 5),
       ('Blossom', '10/13/1998', 3, true, 17, 4);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');
