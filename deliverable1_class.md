Title page

<div style="page-break-before:always"></div>

# ER Diagram

```plantuml
hide circle
hide methods
allowmixing

class Chain {
<u>address-central-office</u>
contact-email-address
contact-phone-num
}
hexagon owns
Chain <-- owns

class Hotel {
<u>address-of-hotel</u>
ranking
contact-email-address
contact-phone-num
}
owns == Hotel
hexagon has
Hotel <-- has

class Room {
<u>room-id</u>
room-price-cents
capacity
extended-capacity
problems-or-damages
}
has == Room
hexagon offers
Room <-- offers

class Amenity {
<u>name</u>
}
offers == Amenity

class Person {
<u>ssn-or-sin</u>
full-name
address
}

class Customer {
registration-date
}
Person <|-- Customer

class Employee {
}
Person <|-- Employee
hexagon manages
Hotel == manages
manages --> Employee

hexagon manager
manager -- Employee : 0..1 employees being managed
manager -- Employee : 0..* manager

class Role {
<u>role-name</u>
}
hexagon "works-for" as works_for
Role <-- works_for
works_for -- Employee
works_for -- Hotel

class BookingOrRenting {
<w>start</w>
end
}
hexagon requests_room
BookingOrRenting == requests_room
Customer -- requests_room
requests_room -- Room

class Booking {
}
BookingOrRenting <|-- Booking

class Renting {
}
BookingOrRenting <|-- Renting
```

- There is a `Amenity` entity to ensure that the spellings that employees input are standardized
- Views (sea view, mountain view, etc.) and amenities (TV, AC, fridge, etc.) are conceptually the same. Customers will enjoy them in the same way, and search for them in the same way. It is decided that `View` be merged with `Amenity`
- The common attributes between `Employee` and `Customer` have been extracted to `Person` so that the diagram is easier to reason about logically
- There is a `Role` entity to ensure that "roles/positions" are standardized
- The `Role` entity should not track managers; the `manages` relation should do that
- Checking in a customer is done by adding the additional specialization `Renting` to their `Booking`
- Customers that directly show up at a hotel receive a `Renting` that will never be a `Booking`
- It is assumed that there is no desire of posterity to denormalize a snapshot of `Room` into `BookingOrRenting`
- There was no requirement for a booking cancellation feature. Some businesses have no-return policies, and let this application serve them
- There is no `name` attribute added to `chain`s and `hotel`s as that was not in the requirements. It may be a little bit awkward for the user, but it is possible to refer uniquely to them by their `address`es.
- It is fine for the `chain` and `hotel` contacts to be the same, as some business might have it that way legitimately
- `address_*` is not broken up in case there are special delivery instructions
- `full_name` is not broken up into components, in order to respect human rights

<div style="page-break-before:always"></div>

# Relational Database Schema

```plantuml
hide circle
hide methods

class chain {
<u>address_central_office</u>
contact_email_address
contact_phone_num
}

class hotel {
<u>address_of_hotel</u>
address_central_office
ranking
contact_email_address
contact_phone_num
manager_ssn_or_sin
}
chain::address_central_office <-- hotel::address_central_office

class room {
<u>address_of_hotel</u>
<u>room_id</u>
room_price_cents
capacity
extended_capacity
problems_or_damages
}
hotel::address_of_hotel <-- room::address_of_hotel

class amenity {
<u>name</u>
}

class offers {
<u>address_of_hotel</u>
<u>room_id</u>
<u>amenity_name</u>
}
room::address_of_hotel <-- offers::address_of_hotel
room::room_id <-- offers::room_id
amenity::name <- offers::amenity_name

class customer {
<u>ssn_or_sin</u>
full_name
address
registration_date
}

class employee {
<u>ssn_or_sin</u>
full_name
address
}
hotel::manager_ssn_or_sin --> employee::ssn_or_sin

class manager {
<u>manager_ssn_or_sin</u>
<u>managed_ssn_or_sin</u>
}
manager::manager_ssn_or_sin --> employee::ssn_or_sin
manager::managed_ssn_or_sin --> employee::ssn_or_sin

class role {
<u>name</u>
}

class employment {
<u>address_of_hotel</u>
<u>employee_ssn_or_sin</u>
<u>role_name</u>
}
employment::address_of_hotel --> hotel::address_of_hotel
employment::employee_ssn_or_sin --> employee::ssn_or_sin
employment::role_name --> role::name

class booking_or_renting {
<u>address_of_hotel</u>
<u>room_id</u>
<u>start</u>
customer_ssn_or_sin
end
was_booked
is_renting
}
booking_or_renting::customer_ssn_or_sin --> customer::ssn_or_sin
```

- `employee` and `customer` are split apart, because they are likely to be disjoint and the data operations performed on each tend to be radically different
- The constraints `booking_or_renting.address_of_hotel --> hotel::address_of_hotel` and `booking_or_renting.room_id --> room::room_id` are not included so that the `room`s can be deleted while keeping the `booking_or_renting` archived
- It would have been desired to use a surrogate key for `chain` and `hotel` so the asymptotic complexity of references to them are improved. However, the existing keys are sufficient to identify them, and it is not currently necessary to introduce this additional complexity before profiling
- `Booking`s and `Renting`s are merged back into a single table, just with booleans, to avoid the overhead of another table
- Underlines are supposed to be solid, but may appear dotted if zoomed in for some reason. Copy and paste to distinguish them from underscores

<div style="page-break-before:always"></div>

# Constraints

## Primary Key Constraints

Every table in the database needs a primary key to identify each entry in it specifically.
The primary key constraint needs to ensure that the primary key is distinct, non-null, and unchangeable.
In the `hotel`s table, we defined the `address_of_hotel` column as the primary key.
This would guarantee that every hotel in the database has a unique identifier that can be used to refer to it from its rooms in the database.
For example, the `rooms` table has foreign key column called `address_of_hotel` that refers to the `address_of_hotel` column in the `hotel`s table.
This would guarantee that each room in the database is associated with a specific hotel.
By defining `address_of_hotel` as the primary key in the `hotel`s table, we guarantee that each hotel has a unique identifier that can be used to link it to other tables in the database.
See the underlines in the previous sections for the rest of the constraints.


## Referential Integrity Constraints

The referential integrity constraint ensures that the data in the foreign key column of a table corresponds to the data in the primary key column of another table.
In the `room`s table, we define a foreign key constraint on the `address_of_hotel` column that refers to the `address_of_hotel` column in the `hotel`s table.
This would ensure that each room in the database is associated with a specific hotel that exists in the `hotel`s table.
If a customer attempts to book a room and specifies a hotel that doesn't exist, the constraint would prevent the booking from being created.
By creating a referential integrity constraint between the `room`s and `hotel`s tables, we can ensure that the data in the database will be consistent and accurate.
See the arrows in the previous sections for the rest of the constraints.

## Domain Constraints

The domain constraint ensures that the data in a column of a table is valid and within an acceptable range.

- `contact_email_address VARCHAR(255)` as they are usually
- `contact_phone_num VARCHAR(255)`, since some phone numbers have leading zeroes or have extensions
- `address* VARCHAR(255)`, as addresses are usually
- `*_or_sin INTEGER`, as SINs are fixed
- `ranking SMALLINT`, as it {1,2,3,4,5}
- `room_price_cents INTEGER`, as money must not be stored as floating-point numbers
- `*capacity INTEGER`, as head count is a cardinality
- `*name VARCHAR{255}`, to be flexible about how people want to name things
- `was_booked BOOLEAN`, `is_renting BOOLEAN`, as these are flags
- `start DATE`, `end DATE`, as these are dates without times, going by the convention that the date is the night of check-in

<div style="page-break-before:always"></div>

## Attribute Constraints

This section is can be considered part of the user-defined constraints section, but was split from it because the lecture slides does this.

- On, `room.capacity` and `room.extended_capacity`, value must be 1, 2, and 4. This is to ensure that only valid room types are stored in the database. We only allow values such as "single”, "double”, and "suite" respectively. This constraint prevents any invalid values from being inputted into the table.
- All integers must `>= 0` as this system does not have uses for negative numbers
- `room.room_price_cents > 0`. Price can't be negative, and free is likely a mistake
- `1 <= hotel.ranking <= 5`, because "1-star up to 5-star" is in the description
- Both `contact_phone_num` shall be numeric, possibly including "#" and "P". They shall be at least 4 digits
- No strings except `problems_or_damages` shall be blank because they need to identify things
- All columns are `NOT NULL`, for similar reasons
- `*_or_sin` shall pass the SIN checksum

By defining attribute constraints, we can help ensure that the data stored in the system is correct and consistent .
This prevents any issues that might happen if invalid data is entered.

## User-Defined Constraints

User-defined constraints are added to ensure that the data entered into the database meets a specific business rule or requirements, such as a maximum number of rooms in a hotel or a minimum price of a room.

- `booking_or_renting.end - booking_or_renting.start < 1 month`. There is likely a business rule that specifies that a customer cannot book a room for a duration that exceeds the maximum number of nights, so this user-defined constraint is created which checks the duration of a room booking and compares it to the maximum number of nights allowed. If the booking duration exceeds the maximum allowed, the constraint will prevent the booking from being added to the database.
- `booking_or_renting.start <= booking_or_renting.end`. Prevents interference with the uniqueness constraints and makes sure the period is a valid date range
- `customer.registration_date <= now()`. Can't register in the future. Also, all timezones should be UTC for simplicity
- `application_install_time() < booking_or_renting.start < customer.registration_date.`. Can't book into the past
- `manager.manager_ssn_or_sin != manager.managed_ssn_or_sin`. Someone can't manage themselves, and if they are the owner, this fact should be cannonicalized to them not belonging to this relation
- `UNIQUE (booking_or_renting.start, booking_or_renting.address_of_hotel, booking_or_renting.room_id)`. Can't have two guests booking the same room
- `room.capacity <= room.extended_capacity`. Naturally extending the capacity will increase it
