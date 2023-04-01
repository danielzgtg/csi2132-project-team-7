INSERT INTO amenity (name)
VALUES ('TV'),
       ('AC'),
       ('Fridge'),
       ('Sea View'),
       ('Mountain View');

INSERT INTO employee (ssn_or_sin, full_name, address)
VALUES (123456789, 'Verena Kantere', '75 Laurier Ave E, Ottawa, ON K1N 6N5');

INSERT INTO customer (ssn_or_sin, full_name, address)
VALUES (123123123, 'Test', '1 Main Street');

INSERT INTO chain (address_central_office, contact_email_address, contact_phone_num, owner_ssn_or_sin)
VALUES ('392 Lectus. St.', 'vivamus@aol.couk', '(379) 950-3166', 123456789),
       ('392 Feugiat Rd.', 'nulla.magna@google.com', '(866) 622-8583', 123456789),
       ('P.O. Box 809, 5059 Ornare. Rd.', 'faucibus@hotmail.edu', '1-164-167-7113', 123456789),
       ('267 Ornare Rd.', 'nunc@icloud.com', '(449) 203-3068', 123456789),
       ('P.O. Box 366, 6251 Non, Road', 'mi.pede@aol.com', '(252) 764-6172', 123456789);

INSERT INTO area (area)
VALUES ('Ottawa'),
       ('Kanata');

INSERT INTO role (name)
VALUES ('Office'),
       ('Kitchen'),
       ('Housekeeping'),
       ('Concierge'),
       ('Security'),
       ('Porter'),
       ('Recreation'),
       ('Host'),
       ('Technician'),
       ('Parking')
;

INSERT INTO hotel (address_of_hotel, area_of_hotel, address_central_office, ranking, contact_email_address,
                   contact_phone_num, manager_ssn_or_sin)
VALUES ('886 Fusce St.', 'Kanata', '392 Lectus. St.', 2, 'ac@outlook.net', '(615) 414-9412', 123456789),
       ('4282 Etiam Rd.', 'Kanata', '392 Lectus. St.', 1, 'libero.mauris@icloud.couk', '1-353-275-7431', 123456789),
       ('235 Malesuada St.', 'Ottawa', '392 Lectus. St.', 4, 'eget.varius@aol.org', '(483) 630-0412', 123456789),
       ('885 Pede, Av.', 'Kanata', '392 Lectus. St.', 3, 'fringilla.euismod@outlook.org', '1-247-845-1761', 123456789),
       ('619 Vitae Street', 'Ottawa', '392 Lectus. St.', 3, 'ligula.aliquam@google.couk', '1-561-339-7185', 123456789),
       ('5424 Conubia Street', 'Ottawa', '392 Lectus. St.', 1, 'pede.malesuada@aol.ca', '1-710-216-2284', 123456789),
       ('385 Non Av.', 'Ottawa', '392 Lectus. St.', 3, 'lorem@protonmail.net', '1-253-312-9472', 123456789),
       ('446 Pharetra Street', 'Ottawa', '392 Lectus. St.', 5, 'quis.accumsan@outlook.edu', '(655) 813-3989',
        123456789),

       ('997 Et St.', 'Kanata', '392 Feugiat Rd.', 3, 'donec.egestas.aliquam@google.edu', '(854) 742-8734', 123456789),
       ('310 Vitae Rd.', 'Kanata', '392 Feugiat Rd.', 5, 'suscipit@outlook.couk', '(499) 275-1738', 123456789),
       ('393 Elit, Av.', 'Ottawa', '392 Feugiat Rd.', 4, 'duis@aol.org', '1-666-581-5756', 123456789),
       ('6972 Sit Rd.', 'Kanata', '392 Feugiat Rd.', 1, 'natoque.penatibus@aol.org', '1-890-748-3144', 123456789),
       ('764 Sapien Ave', 'Ottawa', '392 Feugiat Rd.', 3, 'quisque@protonmail.edu', '(222) 604-7214', 123456789),
       ('824 Lorem, Road', 'Ottawa', '392 Feugiat Rd.', 2, 'fermentum.arcu@google.ca', '1-537-364-3411', 123456789),
       ('6537 Suscipit Rd.', 'Kanata', '392 Feugiat Rd.', 2, 'arcu@icloud.net', '1-986-704-4050', 123456789),
       ('870 Eu, Rd.', 'Ottawa', '392 Feugiat Rd.', 3, 'lectus.justo@google.net', '(546) 224-7417', 123456789),

       ('5802 Pede Ave', 'Ottawa', 'P.O. Box 809, 5059 Ornare. Rd.', 1, 'placerat.orci@protonmail.ca', '(206) 168-5864',
        123456789),
       ('1986 Nulla. Rd.', 'Kanata', 'P.O. Box 809, 5059 Ornare. Rd.', 4, 'sem.egestas.blandit@aol.edu',
        '1-754-794-6217', 123456789),
       ('851 Vel, St.', 'Kanata', 'P.O. Box 809, 5059 Ornare. Rd.', 4, 'suscipit@yahoo.com', '1-375-794-5851',
        123456789),
       ('710 Augue St.', 'Ottawa', 'P.O. Box 809, 5059 Ornare. Rd.', 4, 'lectus.pede.ultrices@hotmail.net',
        '1-668-565-5992', 123456789),
       ('2050 Quis St.', 'Kanata', 'P.O. Box 809, 5059 Ornare. Rd.', 1, 'sed.et@google.org', '(239) 224-4346',
        123456789),
       ('885 Felis. Avenue', 'Kanata', 'P.O. Box 809, 5059 Ornare. Rd.', 3, 'rutrum.non.hendrerit@hotmail.com',
        '1-231-674-5212', 123456789),
       ('6933 Volutpat. Av.', 'Kanata', 'P.O. Box 809, 5059 Ornare. Rd.', 3, 'imperdiet.ornare.in@aol.com',
        '(884) 355-7622', 123456789),
       ('6600 Vulputate Street', 'Kanata', 'P.O. Box 809, 5059 Ornare. Rd.', 4, 'in@google.org', '(677) 312-3810',
        123456789),

       ('275 Quisque Rd.', 'Ottawa', '267 Ornare Rd.', 3, 'elit.curabitur@icloud.ca', '(959) 847-2461', 123456789),
       ('944 Magna. Rd.', 'Kanata', '267 Ornare Rd.', 3, 'non@yahoo.couk', '1-850-884-3631', 123456789),
       ('699 Quisque St.', 'Ottawa', '267 Ornare Rd.', 3, 'magna.a.tortor@icloud.org', '1-347-523-1328', 123456789),
       ('288 Lacinia Ave', 'Kanata', '267 Ornare Rd.', 3, 'tincidunt@hotmail.org', '1-736-757-6738', 123456789),
       ('358 Magna. Av.', 'Kanata', '267 Ornare Rd.', 3, 'velit.cras.lorem@hotmail.com', '1-702-794-3093', 123456789),
       ('1111 Convallis, Street', 'Ottawa', '267 Ornare Rd.', 4, 'pharetra.nibh@yahoo.com', '1-350-587-9416',
        123456789),
       ('1201 Proin Avenue', 'Ottawa', '267 Ornare Rd.', 5, 'tellus.imperdiet.non@outlook.couk', '(416) 734-3927',
        123456789),
       ('599 Sem, Rd.', 'Kanata', '267 Ornare Rd.', 2, 'faucibus.leo@outlook.com', '1-734-483-6231', 123456789),

       ('1648 Nisl. Street', 'Ottawa', 'P.O. Box 366, 6251 Non, Road', 4, 'faucibus.ut@outlook.edu', '1-228-441-7669',
        123456789),
       ('5740 Semper Ave', 'Kanata', 'P.O. Box 366, 6251 Non, Road', 1, 'quam.curabitur@outlook.net', '1-620-711-5058',
        123456789),
       ('3678 Massa. St.', 'Kanata', 'P.O. Box 366, 6251 Non, Road', 2, 'sem@icloud.org', '1-673-358-5821', 123456789),
       ('618 Commodo St.', 'Ottawa', 'P.O. Box 366, 6251 Non, Road', 2, 'ornare.lectus@outlook.com', '(732) 475-0285',
        123456789),
       ('168 Phasellus Ave', 'Ottawa', 'P.O. Box 366, 6251 Non, Road', 2, 'ante.vivamus@hotmail.edu', '1-572-934-5899',
        123456789),
       ('212 Integer St.', 'Kanata', 'P.O. Box 366, 6251 Non, Road', 5, 'sit.amet.ornare@icloud.couk', '(875) 657-5634',
        123456789),
       ('667 At, Avenue', 'Ottawa', 'P.O. Box 366, 6251 Non, Road', 3, 'lorem@outlook.couk', '1-576-596-1341',
        123456789),
       ('808 Ut, Road', 'Kanata', 'P.O. Box 366, 6251 Non, Road', 2, 'nostra.per@protonmail.ca', '1-876-889-4068',
        123456789)
;
