-- DROP CONSTRAINTS
ALTER TABLE bike DROP CONSTRAINT bike_fk1;
ALTER TABLE leasing_bike DROP CONSTRAINT leasing_bike_fk1;
ALTER TABLE leasing_bike DROP CONSTRAINT leasing_bike_fk2;
ALTER TABLE address DROP CONSTRAINT address_fk1;
ALTER TABLE customer DROP CONSTRAINT customer_fk1;
ALTER TABLE paymentinfo DROP CONSTRAINT paymentinfo_fk1;
ALTER TABLE leasing DROP CONSTRAINT leasing_fk1;
ALTER TABLE part DROP CONSTRAINT part_fk1;
ALTER TABLE part DROP CONSTRAINT part_fk2;
ALTER TABLE leasing_bike DROP CONSTRAINT leasing_bike_u1;
ALTER TABLE leasing DROP CONSTRAINT leasing_valid_total;
ALTER TABLE bike DROP CONSTRAINT bike_valid_price;
ALTER TABLE leasing DROP CONSTRAINT leasing_valid_dates;

-- DROP TABLES
DROP TABLE country;
DROP TABLE parttype;
DROP TABLE biketype;
DROP TABLE bike;
DROP TABLE address;
DROP TABLE customer;
DROP TABLE paymentinfo;
DROP TABLE leasing;
DROP TABLE part;
DROP TABLE leasing_bike;

-- CREATE ALL TABLES

CREATE TABLE bike(
    bID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pricePerDay NUMBER(4,2) NOT NULL,
    biketype INTEGER NOT NULL
);

CREATE TABLE biketype(
    btID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(40) NOT NULL
);

CREATE TABLE leasing_bike(
    lbID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    leasing INTEGER NOT NULL,
    bike INTEGER NOT NULL
);

CREATE TABLE country (
    couID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

CREATE TABLE address (
    aID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    street VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    streetNr INTEGER NOT NULL,
    plz INTEGER NOT NULL,
    country INTEGER NOT NULL
);

CREATE TABLE customer (
    cID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tel INTEGER NOT NULL,
    email VARCHAR(40) NOT NULL,
    firstname VARCHAR(40) NOT NULL,
    name VARCHAR(40) NOT NULL,
    address INTEGER NOT NULL
);

CREATE TABLE paymentinfo (
    piID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cardNr INTEGER NOT NULL,
    owner VARCHAR(40) NOT NULL,
    valid_till DATE NOT NULL,
    customer INTEGER NOT NULL
);

CREATE TABLE leasing (
  lID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total NUMBER(4,2),
  startDate DATE DEFAULT SYSDATE NOT NULL, -- Default value today
  endDate DATE DEFAULT SYSDATE + 1 NOT NULL, -- Default leasing duration one day
  customer INTEGER NOT NULL
);

CREATE TABLE part (
  pID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  leasing INTEGER,
  parttype INTEGER NOT NULL
);

CREATE TABLE parttype (
  ptID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type varchar(40) NOT NULL
);

-- Adding Constrains
ALTER TABLE bike ADD CONSTRAINT bike_fk1 FOREIGN KEY (biketype) REFERENCES biketype(btID);
ALTER TABLE leasing_bike ADD CONSTRAINT leasing_bike_fk1 FOREIGN KEY (leasing) REFERENCES leasing(lID);
ALTER TABLE leasing_bike ADD CONSTRAINT leasing_bike_fk2 FOREIGN KEY (bike) REFERENCES bike(bID);
ALTER TABLE address ADD CONSTRAINT address_fk1 FOREIGN KEY (country) REFERENCES country(couID);
ALTER TABLE customer ADD CONSTRAINT customer_fk1 FOREIGN KEY (address) REFERENCES address(aID);
ALTER TABLE paymentinfo ADD CONSTRAINT paymentinfo_fk1 FOREIGN KEY (customer) REFERENCES customer(cID);
ALTER TABLE leasing ADD CONSTRAINT leasing_fk1 FOREIGN KEY (customer) REFERENCES customer(cID);
ALTER TABLE part ADD CONSTRAINT part_fk1 FOREIGN KEY (leasing) REFERENCES leasing(lID);
ALTER TABLE part ADD CONSTRAINT part_fk2 FOREIGN KEY (parttype) REFERENCES parttype(ptID);

-- Unique constraints
ALTER TABLE leasing_bike ADD CONSTRAINT leasing_bike_u1 UNIQUE (leasing, bike);

-- Check Constrains
ALTER TABLE leasing ADD CONSTRAINT leasing_valid_total CHECK (total>=0);
ALTER TABLE bike ADD CONSTRAINT bike_valid_price CHECK (pricePerDay>=0);
ALTER TABLE leasing ADD CONSTRAINT leasing_valid_dates CHECK (startDate<endDate);
