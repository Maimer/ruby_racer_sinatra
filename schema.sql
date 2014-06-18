CREATE TABLE scores (
  id serial PRIMARY KEY,
  name varchar(255) NOT NULL,
  score integer NOT NULL,
  floor integer NOT NULL,
  bombs integer NOT NULL,
  coins integer NOT NULL,
  created_at timestamp NOT NULL
);
