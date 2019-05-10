USE STUDENTS;

-- STUDENTS-1
SELECT FirstName,LastName FROM list
WHERE classroom = 111
ORDER BY LastName ASC;


-- STUDENTS-2
SELECT DISTINCT classroom ,grade FROM list
ORDER BY classroom DESC;

-- STUDENTS-3
SELECT DISTINCT t.First,t.Last,list.classroom
FROM list
	INNER JOIN teachers as t on (list.classroom = t.classroom)
WHERE list.grade = 5
ORDER BY classroom ASC;

-- STUDENTS-4
SELECT DISTINCT l.FirstName,l.LastName FROM teachers as t
	INNER JOIN list as l on (t.classroom = l.classroom)
WHERE t.First = "OTHA" and t.Last = "MOYER"
ORDER BY l.LastName ASC;

-- STUDENTS-5
SELECT DISTINCT t.First,t.Last,l.grade FROM list as l
	INNER JOIN teachers as t on (t.classroom = l.classroom)
WHERE l.grade BETWEEN 0 and 3
ORDER BY l.grade ASC, t.last ASC;

USE BAKERY;

-- BAKERY-1
SELECT DISTINCT Flavor, Food, PRICE  FROM goods
WHERE PRICE < 5.00 and Flavor = "Chocolate"
ORDER BY PRICE DESC;

-- BAKERY-2
SELECT DISTINCT Flavor,Food,PRICE FROM goods
WHERE (PRICE > 1.10 and Food = "Cookie") 
		OR (Flavor = "Lemon")
        OR (Flavor = "Apple" and Food <> "Pie")
ORDER BY Flavor ASC, Food ASC;

-- BAKERY-3
SELECT DISTINCT LastName,FirstName FROM receipts as r
	INNER JOIN customers as c on (r.Customer = c.CId)
WHERE r.SaleDate = '2007-10-03'
ORDER BY LastName ASC;

-- BAKERY-4
SELECT DISTINCT g.Flavor,g.Food FROM receipts as r
	INNER JOIN items as i on (r.RNumber = i.Receipt)
    INNER JOIN goods as g on (i.Item = g.GId)
WHERE r.SaleDate = '2007-10-04' and g.Food = "Cake"
ORDER BY g.Flavor ASC;

-- BAKERY-5
SELECT g.Flavor,g.Food,g.PRICE FROM customers as c 
	INNER JOIN receipts as r on (c.CId = r.Customer)
    INNER JOIN items as i on (r.RNumber = i.Receipt)
    INNER JOIN goods as g on (i.Item = g.GId)
WHERE c.FirstName  = "ARIANE" and c.LastName = "CRUZEN" 
		and r.Saledate = '2007-10-25'
ORDER BY Ordinal ASC;

-- BAKERY-6
SELECT DISTINCT g.Flavor,g.Food FROM customers as c
	INNER JOIN receipts as r on (r.Customer = c.Cid)
    INNER JOIN items as i on (i.Receipt = r.RNumber)
    INNER JOIN goods as g on (i.Item = g.GId)
WHERE c.FirstName = "KIP" and c.LastName = "ARNN" and r.SaleDate LIKE "2007-10-%" and Food = "Cookie"
ORDER BY Flavor ASC;

USE CSU;

-- CSU-1
SELECT DISTINCT Campus FROM campuses
WHERE County = "Los Angeles"
ORDER BY Campus ASC;

-- CSU-2
SELECT d.Year, d.degrees FROM degrees as d
	INNER JOIN campuses as c on (c.Id = d.CampusId)
WHERE Campus = "California Maritime Academy" and d.Year between 1994 and 2000
ORDER BY d.Year ASC;

-- CSU-3
SELECT DISTINCT c.Campus, d.Name, e.Gr, e.Ug FROM campuses as c
	INNER JOIN discEnr as e on (c.Id = e.CampusId)
    INNER JOIN disciplines as d on (e.Discipline = d.Id)
WHERE (d.Name = "Mathematics" or d.Name = "Engineering" or d.Name LIKE "Computer and Info.%") and 
				(c.Campus LIKE "%Polytechnic%") and
                (e.Year = 2004)
ORDER BY c.Campus ASC, d.Name ASC;

-- CSU-4
SELECT DISTINCT Campus,e.Gr,f.Gr FROM campuses as c
	INNER JOIN discEnr as e on (c.Id = e.CampusId)
    INNER JOIN discEnr as f on (c.Id = f.CampusId)
    INNER JOIN disciplines as d on (d.Id = e.Discipline)
    INNER JOIN disciplines as d1 on (d1.Id = f.Discipline)
where e.Ug > 0 and e.Gr > 0 and f.Ug > 0 and f.Gr > 0  and (d.Name = "Agriculture" and d1.Name = "Biological Sciences") and (e.Ug <> f. Ug)
ORDER BY e.Gr DESC;
    
-- CSU-5
SELECT DISTINCT c.Campus,d.Name,e.Ug,e.Gr from discEnr as e
	INNER JOIN campuses as c on (c.Id = e.CampusId)
    INNER JOIN disciplines as d on (d.Id = e.Discipline)
WHERE (3*e.Ug < e.Gr) and (e.Year = "2004")
ORDER BY c.Campus ASC,d.Name ASC;

-- CSU-6
SELECT f.Year,(f.fee * e.FTE) as Collected,ROUND(((f.fee * e.FTE)/fac.FTE),2)as Per_Faculty FROM fees as f
    INNER JOIN campuses as c on (c.Id = f.CampusId and c.Campus = "Fresno State University" and f.Year BETWEEN 2002 and 2004)
    INNER JOIN enrollments as e on (c.Id = e.CampusId and e.Year = f.Year)
    INNER JOIN faculty as fac on (fac.CampusId = c.Id and fac.Year = f.Year)
ORDER BY f.Year ASC;

-- CSU-7
SELECT c1.Campus,e1.FTE as Student_FTE,f.FTE as Faculty_FTE,round(e1.FTE/f.FTE,1) as Student_Faculty_Ratio FROM campuses as c1
	INNER JOIN campuses as c2 on (c2.Campus = "San Jose State University")
    INNER JOIN enrollments as e1 on (e1.CampusId = c1.Id)
    INNER JOIN enrollments as e2 on (e2.CampusId = c2.Id)
    INNER JOIN faculty as f on (f.CampusId = c1.Id and f.Year = 2003)
WHERE (e1.FTE > e2.FTE) and (e1.Year = 2003) and (e2.Year = 2003)
ORDER BY Student_Faculty_Ratio ASC;

USE INN;

-- INN-1
SELECT DISTINCT RoomCode,RoomName FROM rooms as r
WHERE decor = "modern" and basePrice < 160 and Beds = 2
ORDER BY RoomCode ASC;

-- INN-2
SELECT DISTINCT v.LastName,v.CheckIn,v.Checkout,(Adults+Kids) as Guests, Rate from reservations as v
	INNER JOIN rooms as r on (v.Room = r.RoomCode)
WHERE v.CheckIn LIKE "2010-07-%" and v.Checkout LIKE "2010-07-%"
		and RoomName = "Convoke and sanguine"
ORDER BY CheckIn ASC;

-- INN-3
SELECT r.RoomName,v.CheckIn,v.Checkout FROM rooms as r
	INNER JOIN reservations as v on (v.Room = r.RoomCode)
WHERE v.CheckIn <= "2010-02-06" and v.Checkout > "2010-02-06"
ORDER BY r.RoomName ASC;

-- INN-4
SELECT DISTINCT v.`CODE`,r.RoomName,v.CheckIn,v.Checkout,DATEDIFF(Checkout, CheckIn) * Rate as Paid FROM reservations as v
	INNER JOIN rooms as r on (v.Room = r.RoomCode)
WHERE v.FirstName = "GRANT" and v.LastName = "KNERIEN"
ORDER BY (CheckIn) ASC;

-- INN-5
SELECT DISTINCT r.RoomName,v.Rate,DATEDIFF( Checkout, CheckIn) as days_spent, DATEDIFF(Checkout, CheckIn)  * Rate as Total_Paid FROM reservations as v
	INNER JOIN rooms as r on (v.Room = r.RoomCode)
WHERE v.CheckIn = "2010-12-31"
ORDER BY DATEDIFF(Checkout, CheckIn)  DESC;

-- INN-6
SELECT DISTINCT v.CODE,r.RoomCode,r.RoomName,v.CheckIn,v.Checkout FROM reservations as v
	INNER JOIN rooms as r on (v.Room = r.RoomCode and 
	                          v.Adults = 4 and
	                          r.bedType = "Double")
ORDER BY CheckIn ASC,r.RoomCode ASC;

USE MARATHON;

-- MARATHON-1
SELECT Place,RunTime,Pace FROM marathon
WHERE FirstName = "TEDDY" and LastName = "BRASEL";

-- MARATHON-2
SELECT FirstName,LastName,Place,RunTime,GroupPlace FROM marathon
WHERE Sex = "F" and Town = "QUNICY" and State = "MA"
ORDER BY RunTime asc;

-- MARATHON-3
SELECT FirstName,LastName,Town,RunTime FROM marathon
WHERE Age = 34 and Sex = "F" and State = "CT"
ORDER BY RunTime ASC;

-- MARATHON-4
SELECT DISTINCT m1.BibNumber FROM marathon as m1
	INNER JOIN marathon as m2 on (m1.BibNumber = m2.BibNumber and (m1.FirstName <> m2.FirstName or m2.FirstName <> m1.FirstName))
ORDER BY m1.BibNumber ASC;
 
-- MARATHON-5
SELECT m.Sex,m.AgeGroup,m.FirstName,m.LastName,m.Age,m1.FirstName,m1.LastName,m1.Age FROM marathon as m

	INNER JOIN marathon as m1 on (m.AgeGroup = m1.AgeGroup and 
														   m.GroupPlace < m1.GroupPlace and 
                                                           m.GroupPlace < 3 and 
                                                           m1.GroupPlace < 3 and 
                                                           m.Sex = m1.Sex)
ORDER BY m.Sex ASC,m.AgeGroup ASC
;

USE AIRLINES;

-- AIRLINES-1
SELECT DISTINCT a.Name,a.Abbr FROM flights as f
	INNER JOIN airlines as a on (a.Id = f.Airline)
WHERE SOURCE = "AXX"
ORDER BY a.Name ASC;

-- AIRLINES-2
SELECT f.FlightNo, p.Code, p.Name FROM flights as f
	INNER JOIN airlines as a on (a.Id = f.Airline)
    INNER JOIN airports as p on (f.Destination = p.Code)
WHERE a.Abbr = "Northwest" and SOURCE = "AXX"
ORDER BY f.FlightNo ASC;

-- AIRLINES-3
SELECT f.FlightNo,f1.FlightNo,f1.Destination ,p.Name FROM flights as f
	INNER JOIN airlines as a on (a.Id = f.Airline and f.Source = "AXX" and a.Abbr = "Northwest")
    INNER JOIN flights as f1 on (f1.Source = f.Destination and f.Airline = f1.Airline and f1.Destination <> "AXX") 
    INNER JOIN airports as p on (f1.Destination = p.Code)
;

-- AIRLINES-4
SELECT DISTINCT f.Destination,f.Source FROM flights as f
	INNER JOIN flights as f1 on (f1.Source = f.Source and f1.Destination = f.Destination and f1.Airline <> f.Airline)
    INNER JOIN airlines as a on (f.Airline = a.Id)
    INNER JOIN airlines as a1 on (f1.Airline = a1.Id)
WHERE ((a.Abbr = "Frontier" and a1.Abbr  = "JetBlue") or (a1.Abbr = "Frontier" and a.Abbr  = "JetBlue")) and (f.Source > f.Destination);

-- AIRLINES-5
SELECT DISTINCT f.Source FROM flights as f
	INNER JOIN flights as f1 on (f1.Source = f.Source and f.Airline <> f1.Airline)
    INNER JOIN flights as f2 on (f2.Source = f.Source and f.Airline <> f2.Airline and f1.Airline <> f2.Airline)
    INNER JOIN flights as f3 on (f3.Source = f.Source and f.Airline <> f3.Airline and f1.Airline <> f3.Airline and f2.Airline <> f3.airline)
    INNER JOIN flights as f4 on (f4.Source = f.Source and f.Airline <> f4.Airline and f1.Airline <> f4.Airline and f2.Airline <> f4.airline and f3.Airline <> f4.Airline)
    INNER JOIN airlines as a on (a.Id = f.Airline and a.Abbr = "Southwest")
    INNER JOIN airlines as a1 on (a1.Id = f1.Airline and a1.Abbr = "UAL")
    INNER JOIN airlines as a2 on (a2.Id = f2.Airline and a2.Abbr = "USAir")
    INNER JOIN airlines as a3 on (a3.Id = f3.Airline and a3.Abbr = "Frontier")
    INNER JOIN airlines as a4 on (a4.Id = f4.Airline and a4.Abbr = "Delta")
ORDER BY f.Source ASC;
;

-- AIRLINES-6
SELECT DISTINCT p.Code from flights as f
	INNER JOIN flights as f1 on ((f1.FlightNo <> f.FlightNo) and (f1.Airline = f.Airline)
													AND ((f1.Source = f.Source) or (f1.Destination = f.Destination)))
	INNER JOIN flights as f2 on ((f2.FlightNo <> f.FlightNo) and (f2.Airline = f.Airline)
													AND ((f2.Source = f.Source) or (f2.Destination = f.Destination)) 
													AND((f1.FlightNo <> f2.FlightNo) AND (f1.Airline = f2.Airline) AND 
															(f.FlightNo < f1.FlightNo AND 
                                                             f1.FlightNo < f2.FlightNo) AND
															((f1.Source = f2.Source) or 
                                                             (f1.Destination = f2.Destination))))
	INNER JOIN airports as p on ((f.Source = p.Code and f1.Source = p.Code and f2.Source = p.Code) OR
													 (f.Destination = p.Code and f1.Destination = p.Code and f2.Destination = p.Code))
	INNER JOIN airlines as a on (f.Airline = a.Id)
WHERE a.Abbr = "Southwest"
ORDER BY p.Code ASC;

USE KATZENJAMMER;

-- KATZENJAMMER-1

SELECT s.Title FROM Albums as a
	INNER JOIN Tracklists as t on (t.Album = a.AId)
    INNER JOIN Songs as s on (t.Song = s.SongId)
WHERE a.Title = "Le Pop"
ORDER BY Position;


-- KATZENJAMMER-2
SELECT b.Firsname,i.Instrument FROM Songs as s
	INNER JOIN Instruments as i on (s.SongId = i.Song)
    INNER JOIN Band as b on (b.Id = i.Bandmate)
WHERE s.Title = "Mother Superior"
ORDER BY b.Firsname;

-- KATZENJAMMER-3
SELECT DISTINCT i.Instrument FROM Instruments as i
	INNER JOIN Band as b on (i.Bandmate = b.Id and b.Firsname = "Anne-Marit")
    INNER JOIN Performance as p on (p.Song = i.Song and i.Bandmate = p.Bandmate)
ORDER BY i.Instrument;

-- KATZENJAMMER-4
SELECT DISTINCT s.Title FROM Instruments as i
	INNER JOIN Songs as s on (i.Song = s.SongId)
WHERE i.Instrument = "ukalele"
ORDER BY s.Title;

-- KATZENJAMMER-5
SELECT DISTINCT i.Instrument FROM Vocals as v
	INNER JOIN Band as b on (b.Id = v.Bandmate and b.Firsname = "Turid")
    INNER JOIN Songs as s on (v.Song = s.SongId)
    INNER JOIn Instruments as i on (v.Song = i.Song and v.Bandmate = i.Bandmate)
WHERE v.VocalType = "lead"
ORDER BY i.Instrument;

-- KATZENJAMMER - 6
SELECT DISTINCT s.Title,b.Firsname,p.StagePosition FROM Vocals as v
	INNER JOIN Performance as p on (p.Song = v.Song and p.Bandmate = v.Bandmate and v.VocalType = "lead" and p.StagePosition <> "center")
    INNER JOIN Songs as s on (s.SongId = v.Song)
    INNER JOIN Band as b on (b.Id = v.Bandmate)
ORDER BY s.Title ASC;

-- KATZENJAMMER-7
SELECT DISTINCT s.Title FROM Instruments as i 
	INNER JOIN Instruments as i1 on (i1.Song = i.song and i1.Bandmate = i.Bandmate and i.Instrument < i1.Instrument)
	INNER JOIN Instruments as i2 on (i2.Song = i.song and i2.Bandmate = i.Bandmate and i2.Instrument <> i.Instrument and i2.Instrument <> i1.Instrument)
	INNER JOIN Band as b on (b.Id = i.Bandmate)
    INNER JOIN Songs as s on (s.SongId = i.Song)
WHERE b.Firsname = "Anne-Marit";

-- KATZENJAMMER-8
SELECT b3.Firsname `Right`, b1.Firsname Center,b.Firsname Back, b2.Firsname `Left` FROM Songs as s
	INNER JOIN Performance as p on (p.Song = s.SongId and s.Title = "A Bar in Amsterdam")
    INNER JOIN Performance as p1 on (p1.Song = s.SongId and s.TItle = "A bar in Amsterdam" and p1.StagePosition > p.StagePosition)
    INNER JOIN Performance as p2 on (p2.Song = s.SongId and s.TItle = "A bar in Amsterdam" and p2.StagePosition > p1.StagePosition)
    INNER JOIN Performance as p3 on (p3.Song = s.SongId and s.TItle = "A bar in Amsterdam" and p3.StagePosition > p2.StagePosition) 
    INNER JOIN Band as b on (b.Id = p.Bandmate)
    INNER JOIN Band as b1 on (b1.Id = p1.Bandmate)
    INNER JOIN Band as b2 on (b2.Id = p2.Bandmate)
    INNER JOIN Band as b3 on (b3.Id = p3.Bandmate);


