CREATE TABLE customer
(
    ssn_or_sin        integer PRIMARY KEY,
    full_name         character varying,
    address           character varying,
    registration_date date
);

CREATE TABLE amenity
(
    name character varying NOT NULL
);

CREATE TABLE booking_or_renting
(
    address_of_hotel    character varying NOT NULL,
    room_id             character varying NOT NULL,
    start_date          date              NOT NULL,
    customer_ssn_or_sin integer REFERENCES customer (ssn_or_sin),
    end_date            date,
    was_booked          boolean,
    is_renting          boolean,
    PRIMARY KEY (address_of_hotel, room_id, start_date)
);

CREATE TABLE chain
(
    address_central_office character varying PRIMARY KEY,
    contact_email_address  character varying,
    contact_phone_num      integer
);

CREATE TABLE employee
(
    ssn_or_sin integer NOT NULL PRIMARY KEY,
    full_name  character varying,
    address    character varying
);

CREATE TABLE employment
(
    address_of_hotel    character varying,
    employee_ssn_or_sin integer           NOT NULL REFERENCES customer (ssn_or_sin),
    role_name           character varying NOT NULL,
    PRIMARY KEY (address_of_hotel, employee_ssn_or_sin)
);

CREATE TABLE hotel
(
    address_of_hotel       character varying PRIMARY KEY,
    address_central_office character varying,
    ranking                integer,
    contact_email_address  character varying,
    contact_phone_num      integer,
    manager_ssn_or_sin     integer
);

CREATE TABLE manager
(
    manager_ssn_or_sin integer PRIMARY KEY REFERENCES employee (ssn_or_sin),
    managed_ssn_or_sin integer REFERENCES employee (ssn_or_sin)
);

CREATE TABLE offers
(
    address_of_hotel character varying NOT NULL,
    room_id          character varying NOT NULL,
    amenity_name     character varying NOT NULL,
    PRIMARY KEY (address_of_hotel, room_id, amenity_name)
);

CREATE TABLE role
(
    name character varying PRIMARY KEY
);

CREATE TABLE room
(
    address_of_hotel    character varying,
    room_id             integer PRIMARY KEY,
    room_price_cents    integer,
    capacity            integer,
    extended_capacity   integer,
    problems_or_damages character varying
);
