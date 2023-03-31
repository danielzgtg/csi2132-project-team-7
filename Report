a. 

b.

c. 

CREATE TABLE chain (
  address_central_office varchar(255) PRIMARY KEY,
  contact_email_address varchar(255),
  contact_phone_num varchar(20)
);

CREATE TABLE hotel (
  address_of_hotel varchar(255) PRIMARY KEY,
  address_central_office varchar(255),
  ranking int,
  contact_email_address varchar(255),
  contact_phone_num varchar(20),
  manager_ssn_or_sin varchar(20),
  FOREIGN KEY (address_central_office) REFERENCES chain(address_central_office),
  FOREIGN KEY (manager_ssn_or_sin) REFERENCES employee(ssn_or_sin)
);

CREATE TABLE room (
  address_of_hotel varchar(255),
  room_id varchar(20),
  room_price_cents int,
  capacity int,
  extended_capacity int,
  problems_or_damages varchar(255),
  PRIMARY KEY (address_of_hotel, room_id),
  FOREIGN KEY (address_of_hotel) REFERENCES hotel(address_of_hotel)
);

CREATE TABLE amenity (
  name varchar(255) PRIMARY KEY
);

CREATE TABLE offers (
  address_of_hotel varchar(255),
  room_id varchar(20),
  amenity_name varchar(255),
  PRIMARY KEY (address_of_hotel, room_id, amenity_name),
  FOREIGN KEY (address_of_hotel, room_id) REFERENCES room(address_of_hotel, room_id),
  FOREIGN KEY (amenity_name) REFERENCES amenity(name)
);

CREATE TABLE customer (
  ssn_or_sin varchar(20) PRIMARY KEY,
  full_name varchar(255),
  address varchar(255),
  registration_date date
);

CREATE TABLE employee (
  ssn_or_sin varchar(20) PRIMARY KEY,
  full_name varchar(255),
  address varchar(255)
);

CREATE TABLE manager (
  manager_ssn_or_sin varchar(20),
  managed_ssn_or_sin varchar(20),
  PRIMARY KEY (manager_ssn_or_sin, managed_ssn_or_sin),
  FOREIGN KEY (manager_ssn_or_sin) REFERENCES employee(ssn_or_sin),
  FOREIGN KEY (managed_ssn_or_sin) REFERENCES employee(ssn_or_sin)
);

CREATE TABLE role (
  name varchar(255) PRIMARY KEY
);

CREATE TABLE employment (
  address_of_hotel varchar(255),
  employee_ssn_or_sin varchar(20),
  role_name varchar(255),
  PRIMARY KEY (address_of_hotel, employee_ssn_or_sin, role_name),
  FOREIGN KEY (address_of_hotel) REFERENCES hotel(address_of_hotel),
  FOREIGN KEY (employee_ssn_or_sin) REFERENCES employee(ssn_or_sin),
  FOREIGN KEY (role_name) REFERENCES role(name)
);

CREATE TABLE booking_or_renting (
  address_of_hotel varchar(255),
  room_id varchar(20),
  start date,
  customer_ssn_or_sin varchar(20),
  end date,
  was_booked boolean,
  is_renting boolean,
  PRIMARY KEY (address_of_hotel, room_id, start),
  FOREIGN KEY (address_of_hotel, room_id) REFERENCES room(address_of_hotel, room_id),
  FOREIGN KEY (customer_ssn_or_sin) REFERENCES customer(ssn_or_sin)
);
