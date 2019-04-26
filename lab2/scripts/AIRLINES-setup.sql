USE ayakkala;

DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS airports100;
DROP TABLE IF EXISTS airlines;

CREATE TABLE airlines (

Id INTEGER PRIMARY KEY,
Airline VARCHAR(100) NOT NULL,
Abbreviation VARCHAR(50) NOT NULL,
Country VARCHAR(100) NOT NULL

);

CREATE TABLE airports100 (

City VARCHAR(100) NOT NULL,
AirportCode CHAR(3) PRIMARY KEY,
AirportName VARCHAR(100) NOT NULL,
Country VARCHAR(100) NOT NULL,
CountryAbbrev CHAR(3) NOT NULL

);

CREATE TABLE flights(

Airline INTEGER,
FlightNo INTEGER,
SourceAirport CHAR(3),
DestAirport CHAR(3),
CONSTRAINT PK_CompositePKTable PRIMARY KEY(Airline,FlightNo),
FOREIGN KEY (SourceAirport) REFERENCES airports100(AirportCode),
FOREIGN KEY (DestAirport) REFERENCES airports100(AirportCode),
FOREIGN KEY (Airline) REFERENCES airlines(Id)
);