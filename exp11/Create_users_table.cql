CREATE KEYSPACE mykeyspace WITH replication = {
  'class':'SimpleStrategy', 
  'replication_factor':1
};

CREATE TABLE mykeyspace.users (
  id UUID PRIMARY KEY,
  name text,
  age int,
  email text
);

INSERT INTO mykeyspace.users (id, name, age, email)
VALUES (uuid(), 'John Doe', 30, 'john@example.com');
