-- INSERT TRIGGER: updates total price of a leasing when bike is added to it

CREATE OR REPLACE TRIGGER TRG_LEASING_BIKE_INSERT_PRE
BEFORE INSERT ON leasing_bike
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    leasing_rec leasing%rowtype;
    bikePrice bike.pricePerDay%type;
    bikeLeasingPrice bike.pricePerDay%type;
    newTotal leasing.total%type;
BEGIN
    SELECT * INTO leasing_rec FROM leasing
    WHERE lid = :NEW.leasing;
    
    SELECT pricePerDay INTO bikePrice FROM bike
    WHERE bid = :NEW.bike;
    
    bikeLeasingPrice := (leasing_rec.endDate - leasing_rec.startDate) * bikePrice;
    
    IF(leasing_rec.total IS NULL) THEN
        newTotal := bikeLeasingPrice;
    ELSE
        newTotal := leasing_rec.total + bikeLeasingPrice;
    END IF;
    
    UPDATE leasing
    SET total = newTotal
    WHERE lid = leasing_rec.lid;
END;
/

CREATE OR REPLACE TRIGGER TRG_PART_INSERT_UPDATE_PRE
BEFORE INSERT OR UPDATE ON part
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    leasing_rec leasing%rowtype;
    partPrice part.pricePerDay%type;
    partLeasingPrice part.pricePerDay%type;
    newTotal leasing.total%type;
BEGIN
    SELECT * INTO leasing_rec FROM leasing
    WHERE lid = :NEW.leasing;
    
    SELECT pricePerDay INTO bikePrice FROM part
    WHERE pid = :NEW.part;
    
    partLeasingPrice := (leasing_rec.endDate - leasing_rec.startDate) * partPrice;
    
    IF(leasing_rec.total IS NULL) THEN
        newTotal := partLeasingPrice;
    ELSE
        newTotal := leasing_rec.total + partLeasingPrice;
    END IF;
    
    UPDATE leasing
    SET total = newTotal
    WHERE lid = part_rec.lid;
END;
/

-- UPDATE TRIGGER: recalculates total price of a leasing when its endDate is updated

CREATE OR REPLACE TRIGGER TRG_LEASING_PRE_UPDATE_ENDDATE
BEFORE UPDATE OF endDate ON leasing
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    totalBikePricePerDay bike.pricePerDay%type;
    totalPartPricePerDay part.pricePerDay%type;
BEGIN
    SELECT SUM(pricePerDay) INTO totalBikePricePerDay FROM leasing_bike
    INNER JOIN bike ON bike.bid = leasing_bike.bike
    WHERE leasing = :NEW.lid;
    
    SELECT SUM(pricePerDay) INTO totalPartPricePerDay FROM part
    WHERE leasing = :NEW.lid;
    
    :NEW.total := (:NEW.endDate - :OLD.startDate) * (totalBikePricePerDay + totalPartPricePerDay);
END;
/
