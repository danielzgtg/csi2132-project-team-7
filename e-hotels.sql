CREATE TABLE employee
(
    ssn_or_sin INTEGER      NOT NULL PRIMARY KEY,
    full_name  VARCHAR(255) NOT NULL,
    address    VARCHAR(255) NOT NULL
);

CREATE TABLE manager
(
    manager_ssn_or_sin integer REFERENCES employee (ssn_or_sin),
    managed_ssn_or_sin integer PRIMARY KEY REFERENCES employee (ssn_or_sin)
);

CREATE TABLE chain
(
    address_central_office VARCHAR(255) PRIMARY KEY,
    contact_email_address  VARCHAR(255) NOT NULL,
    contact_phone_num      VARCHAR(255) NOT NULL
);

CREATE TABLE hotel
(
    address_of_hotel       VARCHAR(255) PRIMARY KEY,
    address_central_office VARCHAR(255) NOT NULL REFERENCES chain (address_central_office),
    ranking                INTEGER      NOT NULL,
    contact_email_address  VARCHAR(255) NOT NULL,
    contact_phone_num      VARCHAR(255) NOT NULL,
    manager_ssn_or_sin     INTEGER      NOT NULL REFERENCES employee (ssn_or_sin),
    CHECK (ranking BETWEEN 1 AND 5)
);

CREATE TABLE room
(
    address_of_hotel    VARCHAR(255) NOT NULL REFERENCES hotel (address_of_hotel),
    room_id             INTEGER      NOT NULL,
    room_price_cents    INTEGER      NOT NULL,
    capacity            INTEGER      NOT NULL,
    extended_capacity   integer      NOT NULL,
    problems_or_damages VARCHAR(255) NOT NULL,
    PRIMARY KEY (address_of_hotel, room_id),
    CHECK (room_price_cents > 0),
    CHECK (capacity > 0),
    CHECK (extended_capacity >= capacity)
);

CREATE TABLE amenity
(
    name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE offers
(
    address_of_hotel VARCHAR(255) NOT NULL,
    room_id          INTEGER      NOT NULL,
    amenity_name     VARCHAR(255) NOT NULL REFERENCES amenity (name),
    PRIMARY KEY (address_of_hotel, room_id, amenity_name),
    FOREIGN KEY (address_of_hotel, room_id) REFERENCES room (address_of_hotel, room_id)
);

CREATE TABLE customer
(
    ssn_or_sin        INTEGER PRIMARY KEY,
    full_name         VARCHAR(255) NOT NULL,
    address           VARCHAR(255) NOT NULL,
    registration_date DATE         NOT NULL,
    CHECK (registration_date > '2023-03-27')
);

CREATE TABLE booking_or_renting
(
    address_of_hotel    VARCHAR(255) NOT NULL,
    room_id             INTEGER      NOT NULL,
    start_date          DATE         NOT NULL,
    customer_ssn_or_sin INTEGER REFERENCES customer (ssn_or_sin),
    end_date            DATE         NOT NULL,
    was_booked          BOOL         NOT NULL,
    is_renting          BOOL         NOT NULL,
    PRIMARY KEY (address_of_hotel, room_id, start_date),
    FOREIGN KEY (address_of_hotel, room_id) REFERENCES room (address_of_hotel, room_id),
    CHECK (start_date > '2023-03-27'),
    CHECK (end_date >= start_date),
    CHECK (was_booked OR is_renting)
);

CREATE TABLE role
(
    name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE employment
(
    address_of_hotel    VARCHAR(255) NOT NULL REFERENCES hotel (address_of_hotel),
    employee_ssn_or_sin INTEGER      NOT NULL REFERENCES employee (ssn_or_sin),
    role_name           VARCHAR(255) NOT NULL REFERENCES role (name),
    PRIMARY KEY (address_of_hotel, employee_ssn_or_sin)
);
