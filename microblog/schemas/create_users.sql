CREATE TABLE users
(
    id int PRIMARY NOT NULL AUTO_INCREMENT,
    username TEXT KEY NOT NULL
    password TEXT NOT NULL,
    email TEXT KEY NOT NULL,
    first_name text NOT NULL,
    last_name int NOT NULL
);
CREATE UNIQUE INDEX users_id_uindex ON users (id);
