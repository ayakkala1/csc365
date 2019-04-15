USE ayakkala;

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS similar;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS ratings;

CREATE TABLE ratings(
`Name` VARCHAR(20) PRIMARY KEY,
Agg_Review DECIMAL,
`One` INTEGER,
Two INTEGER,
Three INTEGER,
Four INTEGER,
Five INTEGER,
Agg_Rating DECIMAL
);

CREATE TABLE similar(
`Name` VARCHAR(20),
Similar VARCHAR(20),
CONSTRAINT PK_CompositePKTable PRIMARY KEY(`Name`,Similar),
FOREIGN KEY (`Name`) REFERENCES ratings(`Name`)
);

CREATE TABLE tags(
`Name` VARCHAR(20),
Tags VARCHAR(20),
CONSTRAINT PK_CompositePKTable PRIMARY KEY(`Name`,Tags),
FOREIGN KEY (`Name`) REFERENCES ratings(`Name`)
);

CREATE TABLE reviews(
`Name` VARCHAR(20),
`Datetime` DATE,
Rating INTEGER,
Review VARCHAR(500),
Summary VARCHAR(100),
CONSTRAINT PK_CompositePKTable PRIMARY KEY(`Name`,`Datetime`,Summary),
FOREIGN KEY (`Name`) REFERENCES ratings(`Name`)
);