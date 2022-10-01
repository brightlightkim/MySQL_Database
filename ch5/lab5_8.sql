/*
Explain the query SELECT * FROM film WHERE title = 'ALONE TRIP';.

In the EXPLAIN result, column key is null, indicating no index is available for the query. Column rows is 100, indicating all rows are read. The query executes a table scan and is slow.

Create an index idx_title on the title column.

Explain the query of step 1 again.

In the EXPLAIN result, column key has value idx_title, indicating the query uses the index on title. Column rows is 1, indicating only one table row is read. The query is fast.

Explain the query SELECT * FROM film WHERE title > 'ALONE TRIP';.

In the EXPLAIN result, column key is null, indicating the query does not use the idx_title index. Column rows is 100, indicating all rows are read. Since the query has > in the WHERE clause rather than =, the query executes a table scan and is slow.

Explain the query SELECT rating, count(*) FROM film GROUP BY rating;

In the EXPLAIN result, column key is null, indicating no index is available for the query. Column rows is 100, indicating all rows are read. The query executes a table scan and is slow.

Create an index idx_rating on the rating column.

Explain the query of step 5 again.

In the EXPLAIN result, column key has value idx_rating, indicating the query reads rating values from the index. The query uses an index scan, which is faster than a table scan (step 5).
*/

EXPLAIN SELECT * FROM sakila.film WHERE title = 'ALONE TRIP';

CREATE INDEX idx_title ON sakila.film(title);

EXPLAIN SELECT * FROM sakila.film WHERE title = 'ALONE TRIP';

EXPLAIN SELECT * FROM film WHERE title > 'ALONE TRIP';

EXPLAIN SELECT rating, count(*) FROM film GROUP BY rating;

CREATE INDEX idx_rating ON sakila.film(rating);

EXPLAIN SELECT rating, count(*) FROM film GROUP BY rating;