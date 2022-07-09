-- INSERT TRIGGER: updates total price of a leasing when bike is added to it

CREATE OR REPLACE TRIGGER TRG_LEASING_BIKE_INSERT_PRE
BEFORE INSERT ON leasing_bike
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    leasing_rec leasing%rowtype;
    bikePrice bike.price%type;
    bikeLeasingPrice bike.price%type;
    newTotal leasing.total%type;
BEGIN
    SELECT * INTO leasing_rec FROM leasing
    WHERE lid = :NEW.leasing;
    
    SELECT price INTO bikePrice FROM bike
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


-- UPDATE TRIGGER: recalculates total price of a leasing it's enddate is updated

CREATE OR REPLACE TRIGGER TRG_LEASING_PRE_UPDATE_ENDDATE
BEFORE UPDATE OF endDate ON leasing
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    totalPricePerDay bike.price%type;
BEGIN
    SELECT SUM(price) INTO totalPricePerDay FROM leasing_bike
    INNER JOIN bike ON bike.bid = leasing_bike.bike
    WHERE leasing = :NEW.lid;
    
    :NEW.total := (:NEW.endDate - :OLD.startDate) * totalPricePerDay;
END;