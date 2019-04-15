USE ayakkala;

DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS receipts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS goods;

CREATE TABLE customers(
Id INTEGER PRIMARY KEY,
LastName CHAR(20),
FirstName CHAR(20)
);

CREATE TABLE goods(
Id CHAR(15) PRIMARY KEY,
Flavor CHAR(20),
Food CHAR(20),
Price DECIMAL
);

CREATE TABLE receipts(
RecieptNumber INTEGER PRIMARY KEY,
`Date` DATE,
CustomerId INTEGER,
FOREIGN KEY (CustomerId) REFERENCES customers (ID)
);

CREATE TABLE items(
Reciept INTEGER,
Ordinal INTEGER,
Item CHAR(15),
FOREIGN KEY (Reciept) references receipts (RecieptNumber),
FOREIGN KEY (Item) references goods (Id)
);
