CREATE TABLESPACE MapTableSpace1
ADD
    DATAFILE 'E:/mysql/geography' CREATE TABLESPACE MapTableSpace2
ADD
    DATAFILE 'E:/mysql/geography2' CREATE TABLE Country (
        Code SMALLINT,
        Name VARCHAR(15),
        Captial VARCHAR(15)
    ) TABLESPACE MapTableSpace1 CREATE TABLE Continent (Code CHAR(2), Name VARCHAR(15)) TABLESPACE MapTableSpace1;

CREATE TABLE Country (
    Code INT,
    Name VARCHAR(15),
    IndependenceDate DATE,
    Capital VARCHAR(15)
) PARTITION BY RANGE (YEAR(IndependenceDate)) (
    PARTITION p1
    VALUES
        LESS THAN (1800),
        PARTITION p2
    VALUES
        LESS THAN (1850),
        PARTITION p3
    VALUES
        LESS THAN (1880),
        PARTITION p4
    VALUES
        LESS THAN (MAXVALUE),
)