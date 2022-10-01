CREATE INDEX FirstIndex ON Flight (FlightNumber, AirlineName);

/* Show the indexes from flight */
SHOW INDEX FROM Flight;

EXPLAIN SELECT Street, CityName, PostalCode
        FROM Address, City
        WHERE Address.CityID = City.CityID AND Address.PostalCode > 40000;
/* EXPLAIN generates a results table with one row for each table in the SELECT statement. */

EXPLAIN 
  SELECT FlightNumber 
  FROM Flight 
  WHERE AirportCode IN
      (SELECT AirportCode
      FROM Airport
      WHERE Country = "Cuba");

