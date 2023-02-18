(todo put the code for the title page)

(todo line break)

# ER Diagram

```plantuml
hide circle
hide methods
allowmixing

class Chain {
int id
String name
String central_address
String[] email
String[] phone
}
hexagon owns
Chain <-- owns

class Hotel {
String address
int star_rating
String email
String[] phone
}
owns == Hotel
hexagon contains
Hotel <-- contains

class Room {
int room_number
int price_cents
int capacity
int max_capacity
String problems
}
contains == Room
hexagon offers
Room <-- offers

class Amenity {
String name
}
offers == Amenity

class Person {
String full_name
String address
int ssn
}

class Customer {
Date registration_date
}
Person <|-- Customer

class Employee {
}
Person <|-- Employee
Hotel == managed_by
managed_by --> Employee

class Role {
String role_name
}
hexagon employment
Role <-- employment
employment -- Employee
employment -- Hotel

class BookingOrRenting {
Date start
Date end
}
hexagon requests_room
BookingOrRenting -- requests_room
requests_room --> Room

class Booking {
}
BookingOrRenting <|-- Booking

class Renting {
}
BookingOrRenting <|-- Renting

```

(todo sync the justification from google docs)

# Relational Database Schema

```plantumll
hide circle
hide methods

class chain {
int id
String name
String central_address
}

class chain_email {
int id
String email
}

class chain_phone {
int id
String phone
}

class hotel {
int chain_id
int id
String address
int star_rating
String email
int manager_ssn
}

class hotel_phone {
int hotel_id
String phone
}

class room {
int hotel_id
int room_number
int price_cents
int capacity
int max_capacity
String problems
}

class amenity {
String name
}

class room_amenity {
int hotel_id
int room_number
String amenity_name
}

class customer {
String full_name
String address
int ssn
Date registration_date
}

class employee {
String full_name
String address
int ssn
boolean is_employee
}

class role {
String name
}

class employment {
int hotel_id
int employee_ssn
String role_name
}

class booking_or_renting {
int id
Date start
Date end
int hotel_id
int room_number
boolean had_booking
boolean is_renting
}
```

(todo sync from google docs)

# Constraints

(todo sync from google docs)
