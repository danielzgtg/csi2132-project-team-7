# E-hotels

## Group 7

| Name | Student Number |
| --- | --- |
| Daniel Tang | 0300068985 |
| Haris Vohra | 0300174288 |
| Mahenth Sivaruban | 0300194748 |

The ER diagram and the Relational Database Schema are mostly identical to the ones in Deliverable 1.
Please see the previous submission if it is necessary to consult them.
Some less important constraints were relaxed to improve performance and storage.
The columns were changed to support user authentication, and the area feature.

## A: The DBMS and the programming languages that you have used in your implementation of the application.

We used the recommended DBMS and programming languages in our implementation of the application.
We used PostgreSQL for the implementation of the database.
Apache Tomcat was used for client-server communication, and Java was used for the server side of the application, in the specific format of JSP.
We used HTML inside the JSP for he client side of the application, with Bootstrap CSS and Javascript to improve the visual aspects.
We chose to stick with the recommended technologies so that we can learn new technologies.

## B: Specific steps to guide someone to install your applications

1. Ensure that Docker is installed
2. Run `./gradlew war` in `./server`
3. Run `docker compose up`

The will also run the application after installing it in Docker.

## C: A list with the DDLs that create your database

1. `docker-entrypoint-initdb.d/1-ddl.sql`

All the necessary DDL is in that file.

## 2. Your SQL code that supports all the functionalities in your application

The SQL code in in the `.jsp` files in the application.

## 3. All the code that is necessary for running your application

All the necessary code is included in this zip.

## You are requested to do the following:

See `Report.txt`
