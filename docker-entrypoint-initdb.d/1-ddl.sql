CREATE TABLE employee
(
    ssn_or_sin INTEGER      NOT NULL PRIMARY KEY,
    full_name  VARCHAR(255) NOT NULL,
    address    VARCHAR(255) NOT NULL
);

CREATE TABLE chain
(
    address_central_office VARCHAR(255) PRIMARY KEY,
    contact_email_address  VARCHAR(255) NOT NULL,
    contact_phone_num      VARCHAR(255) NOT NULL,
    owner_ssn_or_sin       INTEGER      NOT NULL REFERENCES employee (ssn_or_sin) ON DELETE CASCADE
);

CREATE TABLE area
(
    area VARCHAR(255) PRIMARY KEY
);

CREATE TABLE hotel
(
    address_of_hotel       VARCHAR(255) NOT NULL,
    area_of_hotel          VARCHAR(255) NOT NULL REFERENCES area (area),
    address_central_office VARCHAR(255) NOT NULL REFERENCES chain (address_central_office) ON DELETE CASCADE,
    ranking                SMALLINT     NOT NULL,
    contact_email_address  VARCHAR(255) NOT NULL,
    contact_phone_num      VARCHAR(255) NOT NULL,
    manager_ssn_or_sin     INTEGER      NOT NULL REFERENCES employee (ssn_or_sin) ON DELETE CASCADE,
    PRIMARY KEY (address_of_hotel, area_of_hotel),
    CHECK (ranking BETWEEN 1 AND 5)
);

CREATE TABLE room
(
    address_of_hotel    VARCHAR(255) NOT NULL,
    area_of_hotel       VARCHAR(255) NOT NULL,
    room_id             INTEGER      NOT NULL,
    room_price_cents    INTEGER      NOT NULL,
    capacity            SMALLINT     NOT NULL,
    extended_capacity   SMALLINT     NOT NULL,
    problems_or_damages VARCHAR(255) NOT NULL,
    PRIMARY KEY (address_of_hotel, area_of_hotel, room_id),
    FOREIGN KEY (address_of_hotel, area_of_hotel) REFERENCES hotel (address_of_hotel, area_of_hotel) ON DELETE CASCADE,
    CHECK (room_price_cents > 0),
    CHECK (capacity BETWEEN 1 AND 5),
    CHECK (extended_capacity BETWEEN 1 AND 5),
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
    area_of_hotel    VARCHAR(255) NOT NULL,
    room_id          INTEGER      NOT NULL,
    amenity_name     VARCHAR(255) NOT NULL REFERENCES amenity (name),
    PRIMARY KEY (address_of_hotel, area_of_hotel, room_id, amenity_name),
    FOREIGN KEY (address_of_hotel, area_of_hotel, room_id) REFERENCES room (address_of_hotel, area_of_hotel, room_id) ON DELETE CASCADE
);

CREATE TABLE customer
(
    ssn_or_sin        INTEGER PRIMARY KEY,
    full_name         VARCHAR(255) NOT NULL,
    address           VARCHAR(255) NOT NULL,
    registration_date DATE         NOT NULL DEFAULT now(),
    CHECK (registration_date > '2023-03-27')
);

CREATE TABLE booking_or_renting
(
    address_of_hotel    VARCHAR(255) NOT NULL,
    area_of_hotel       VARCHAR(255) NOT NULL,
    room_id             INTEGER      NOT NULL,
    start_date          DATE         NOT NULL,
    end_date            DATE         NOT NULL,
    customer_ssn_or_sin INTEGER REFERENCES customer (ssn_or_sin),
    was_booked          BOOL         NOT NULL,
    is_renting          BOOL         NOT NULL,
    PRIMARY KEY (address_of_hotel, area_of_hotel, room_id, start_date),
    -- FOREIGN KEY (address_of_hotel, area_of_hotel, room_id) REFERENCES room (address_of_hotel, area_of_hotel room_id), -- Need to make room deletable
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
    address_of_hotel    VARCHAR(255) NOT NULL,
    area_of_hotel       VARCHAR(255) NOT NULL,
    employee_ssn_or_sin INTEGER      NOT NULL REFERENCES employee (ssn_or_sin),
    role_name           VARCHAR(255) NOT NULL REFERENCES role (name),
    PRIMARY KEY (address_of_hotel, employee_ssn_or_sin),
    FOREIGN KEY (address_of_hotel, area_of_hotel) REFERENCES hotel (address_of_hotel, area_of_hotel)
);

CREATE INDEX hotel_hotel_chain_id_idx ON hotel (address_central_office);
CREATE INDEX room_hotel_id_idx ON room (address_of_hotel);
CREATE INDEX customer_registration_date_idx ON customer (registration_date);

CREATE VIEW available_rooms_per_area AS
SELECT h.address_of_hotel, h.area_of_hotel, COUNT(r.room_id) AS available_rooms
FROM Hotel h
INNER JOIN room r ON h.address_of_hotel = r.address_of_hotel
LEFT JOIN booking_or_renting rt ON r.room_id = rt.room_id
AND rt.start_date <= NOW() AND rt.end_date >= NOW()
WHERE rt.address_of_hotel IS NULL
GROUP BY h.address_of_hotel, h.area_of_hotel;

CREATE VIEW room_capacity_per_hotel AS
SELECT r.address_of_hotel, r.capacity, COUNT(r.room_id) AS room_count
FROM Room r
GROUP BY r.address_of_hotel, r.capacity;
