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

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Vet William Tatcher', 45, '03-23-2000'),
       ('Vet Maisy Smith', 26, '01-17-2019'),
       ('Vet Stephanie Mendez', 64, '05-04-1981'),
       ('Vet Jack Harkness', 38, '01-07-2008');

INSERT INTO specialization (vet_id, species_id)
VALUES (1, 1),
       (3, 1),
       (3, 2),
       (4, 2);

INSERT INTO visits (date, vet_id, animal_id)
VALUES ('05-24-2020', 1, 1),
       ('07-22-2020', 3, 1),
       ('02-02-2021', 4, 2),
       ('01-05-2020', 2, 3),
       ('03-08-2020', 2, 3),
       ('05-14-2020', 2, 3),
       ('05-04-2021', 3, 4),
       ('02-24-2021', 4, 5),
       ('12-21-2019', 2, 6),
       ('08-10-2019', 1, 6),
       ('04-07-2021', 2, 6),
       ('09-29-2019', 3, 7),
       ('10-03-2020', 4, 8),
       ('11-04-2020', 4, 8),
       ('01-24-2019', 2, 9),
       ('05-15-2019', 2, 9),
       ('02-27-2020', 2, 9),
       ('08-03-2020', 2, 9),
       ('05-24-2020', 3, 10),
       ('01-11-2021', 1, 10);