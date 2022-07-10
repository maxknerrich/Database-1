-- COUNTRY DATA

INSERT INTO country(name) VALUES('Deutschland');
INSERT INTO country(name) VALUES('Schweiz');
INSERT INTO country(name) VALUES('Frankreich');


-- CUSTOMER DATA( includes address and paymentinfo )

INSERT INTO address(street, streetnr, plz, city, country) VALUES('Nobelstraße', 10, 70569, 'Stuttgart', 1);
INSERT INTO customer(firstname, name, address, email, tel) VALUES('Frank', 'Schmidt', 1, 'frank-schmidt@gmail.com', 0711654321);
INSERT INTO paymentinfo(customer, cardnr, owner, valid_till) VALUES(1, 7894456112307894, 'Franziska Schmidt', TO_DATE('23.10.2024'));

INSERT INTO address(street, streetnr, plz, city, country) VALUES('Ackerstrasse', 23, 4057, 'Basel', 2);
INSERT INTO customer(firstname, name, address, email, tel) VALUES('Marie', 'Schneider', 2, 'marie-schneider@gmail.com', 0611603316);
INSERT INTO paymentinfo(customer, cardnr, owner, valid_till) VALUES(2, 6112307894789445, 'Marie Schneider', TO_DATE('12.03.2023'));

INSERT INTO address(street, streetnr, plz, city, country) VALUES('Rue des Pierres', 10, 68120, 'Mulhouse', 3);
INSERT INTO customer(firstname, name, address, email, tel) VALUES('Franc', 'Henry', 3, 'franc-henry@gmail.fr', 0368975623);
INSERT INTO paymentinfo(customer, cardnr, owner, valid_till) VALUES(3, 4789445611230789, 'Franc Henry', TO_DATE('22.06.2025'));


-- PART DATA

INSERT INTO parttype(type) VALUES('Fahrradlicht');
INSERT INTO parttype(type) VALUES('Satteltasche');
INSERT INTO parttype(type) VALUES('Klingel');

INSERT INTO part(name, parttype) VALUES('Klemmlicht_A', 1);
INSERT INTO part(name, parttype) VALUES('Klemmlicht_B', 1);
INSERT INTO part(name, parttype) VALUES('Rücklicht_A', 1);
INSERT INTO part(name, parttype) VALUES('Sattetasche_Schwarz_A', 2);
INSERT INTO part(name, parttype) VALUES('Sattetasche_Schwarz_B', 2);
INSERT INTO part(name, parttype) VALUES('Klingel_Metall', 3);


-- BIKE  DATA

INSERT INTO biketype(type) VALUES('Citybike');
INSERT INTO biketype(type) VALUES('Gravelbike');
INSERT INTO biketype(type) VALUES('Trekkingbike');

INSERT INTO bike(pricePerDay, biketype) VALUES(9.99, 1);
INSERT INTO bike(pricePerDay, biketype) VALUES(9.99, 1);
INSERT INTO bike(pricePerDay, biketype) VALUES(7.99, 1);
INSERT INTO bike(pricePerDay, biketype) VALUES(11.50, 2);
INSERT INTO bike(pricePerDay, biketype) VALUES(11.50, 2);
INSERT INTO bike(pricePerDay, biketype) VALUES(10, 3);
INSERT INTO bike(pricePerDay, biketype) VALUES(10, 3);


-- LEASING DATA

INSERT INTO leasing(customer, startDate, endDate) VALUES(1, TO_DATE('10.07.2022'), TO_DATE('15.07.2022'));
INSERT INTO leasing_bike(bike, leasing) VALUES(1, 1);
INSERT INTO leasing_bike(bike, leasing) VALUES(6, 1);
UPDATE part 
SET leasing = 1
WHERE pid = 1;

INSERT INTO leasing(customer, startDate, endDate) VALUES(2, TO_DATE('12.07.2022'), TO_DATE('20.07.2022'));
INSERT INTO leasing_bike(bike, leasing) VALUES(4, 2);
UPDATE part 
SET leasing = 2
WHERE pid = 4;

INSERT INTO leasing(customer, startDate, endDate) VALUES(3, TO_DATE('20.09.2022'), TO_DATE('29.09.2022'));
INSERT INTO leasing_bike(bike, leasing) VALUES(7, 3);
UPDATE part 
SET leasing = 3
WHERE pid = 6;

