USE ayakkala;
SET SQL_SAFE_UPDATES = 0;

-- AIRLINES-1
#Remove from the flights database all flights except those to or from the airport with code AKI.

DELETE FROM flights
WHERE not(SourceAirport = "AKI") and not(DestAirport = "AKI");

-- AIRLINES-2
#For all flights NOT operatedby Continental, AirTran or Virgin, increase the flight number by 2000. 
# You may use numeric airline IDs in your SQL statement.

UPDATE flights
SET FlightNo = FlightNo + 2000
WHERE flights.Airline in (SELECT Id FROM airlines
										WHERE not(Airline in ("Continental Airlines","AirTran Airways","Virgin America")));

-- AIRLINES-3
ALTER TABLE airports100 
ADD COLUMN latitude DECIMAL(2,2) NOT NULL DEFAULT 0,
ADD COLUMN longitude DECIMAL(2,2)  NOT NULL DEFAULT 0,
ADD COLUMN altitude INTEGER NOT NULL DEFAULT 0 ;

UPDATE airports100
SET latitude = 39.85000000, longitude = -98.60000000, altitude = 42
WHERE AirportCode RLIKE '^[a-m]';

UPDATE airports100
SET latitude = -36.85000000, longitude = 174.76666667, altitude = 70
WHERE AirportCode RLIKE '^[n-z]';

-- BAKERY-1
#Reduce the prices of Lemon Cake and Napoleon Cake by $2.

UPDATE goods
SET Price = Price - 2
WHERE (Food = "Cake") AND ((Flavor = "Napoleon") OR (Flavor = "Lemon"));

-- BAKERY-2
#Increase by 15% the price of all Apricot or Chocolate flavored items with a current price below $5.95.

UPDATE goods
SET Price = Price * 1.15
WHERE ((Flavor = "Apricot") OR (Flavor = "Chocolate")) AND (Price < 5.95);

-- BAKERY-3
# Create Barcode
ALTER TABLE customers
ADD COLUMN  Barcodes VARCHAR(50) UNIQUE;

UPDATE customers
SET Barcodes = CONCAT(LPAD(Id, 8,0) , "-" ,LENGTH(LastName), "-" , REVERSE(FirstName));

-- INN-1
DROP TABLE IF EXISTS room_service;

CREATE TABLE room_service(
RoomId INTEGER,
OrderDate DATE,
DeliveryDate DATE,
BillAmount DECIMAL(10,2),
Gratuity DECIMAL(10,2),
FirstName VARCHAR(50),
CONSTRAINT PK_CompositePKTable PRIMARY KEY(RoomId,OrderDate),
FOREIGN KEY (RoomId) REFERENCES Reservations (`Code`)
);

 INSERT INTO room_service (RoomId,OrderDate,DeliveryDate,BillAmount,Gratuity,FirstName)
 VALUES
 (47496,'2019-01-01','2019-01-02',1.23,1.23,"Bob"),
 (41112,'2019-05-01','2019-05-02',1.23,1.23,"Luke"),
 (76809,'2018-05-01','2019-05-02',1.23,1.23,"Armaan");

-- INN-2

DELETE FROM room_service
WHERE DATE_ADD(OrderDate, INTERVAL 6 MONTH) < CURDATE();

-- INN-3

DROP TRIGGER IF EXISTS no_overlap;
delimiter $$
CREATE TRIGGER no_overlap BEFORE INSERT ON Reservations
 FOR EACH ROW
 BEGIN
	IF EXISTS (SELECT 1 FROM (SELECT CheckIn From Reservations
			WHERE 
            (Room = New.Room) 
            AND (New.CheckIn < CheckIn) 
            AND (New.Checkout > Checkin) 
                                                     ) AS CHECKER
					 ) 
            THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservation Overlap';
	END IF;
 	IF EXISTS (SELECT 1 FROM (SELECT CheckIn From Reservations
			WHERE 
            (Room = New.Room) 
            AND (New.CheckIn < CheckOut) 
            AND (New.CheckOut > Checkout) 
                                                     ) AS CHECKER
					 ) 
            THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservation Overlap';
	END IF;
	IF EXISTS (SELECT 1 FROM (SELECT CheckIn From Reservations
			WHERE 
            (Room = New.Room) 
            AND (New.CheckIn > CheckIn) 
            AND (New.CheckOut < CheckOut) 
                                                     ) AS CHECKER
					 ) 
            THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservation Overlap';
	END IF;
	IF EXISTS (SELECT 1 FROM (SELECT CheckIn From Reservations
			WHERE 
            (Room = New.Room) 
            AND (New.CheckIn = CheckIn) 
            AND (New.CheckOut = CheckOut) 
                                                     ) AS CHECKER
					 ) 
            THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservation Overlap';
	END IF;
    END$$
 delimiter ;


