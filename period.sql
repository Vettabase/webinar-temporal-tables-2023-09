CREATE OR REPLACE SCHEMA period;
USE period;

-- create an application-period table

CREATE OR REPLACE TABLE reservation (
    uuid UUID DEFAULT UUID(),
    bungalow_name VARCHAR(100) NOT NULL,
    client_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (uuid, start_date),
    PERIOD FOR reservation (start_date, end_date)
);

ALTER TABLE reservation
    ADD UNIQUE unq_reservation (bungalow_name, reservation WITHOUT OVERLAPS)
;

-- make an existing table application-period

CREATE OR REPLACE TABLE reservation (
    uuid UUID DEFAULT UUID(),
    bungalow_name VARCHAR(100) NOT NULL,
    client_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (uuid)
);

ALTER TABLE reservation
    ADD PERIOD FOR reservation (start_date, end_date),
    ADD UNIQUE unq_reservation (bungalow_name, reservation WITHOUT OVERLAPS)
;

-- demo

INSERT INTO reservation (bungalow_name, client_name, start_date, end_date)
    VALUES
    ('Yellow House',  'John Coltrane',   '2023-08-01',  '2023-08-15'),
    ('Yellow House',  'Charles Mingus',  '2023-08-16',  '2023-08-30'),
    ('Green House',   'Ornette Coleman', '2023-08-01',  '2023-08-30')
;

-- this should fail
INSERT INTO reservation (bungalow_name, client_name, start_date, end_date)
    VALUES
    ('Green House',  'Thelonius Monk',   '2023-08-29',  '2023-09-30')
;

-- delete the first day of a reservation

DELETE FROM reservation
    FOR PORTION OF reservation
    FROM '2023-08-01' TO '2023-08-02'
    WHERE bungalow_name = 'Yellow House'
;

SELECT * FROM reservation;


-- delete the first 3 days of a resercation
-- by specifying an interval

DELETE FROM reservation
    FOR PORTION OF reservation
    FROM '2023-08-01' TO ('2023-08-01' + INTERVAL 3 DAY)
    WHERE bungalow_name = 'Yellow House'
;

SELECT * FROM reservation;

-- delete 1 dqy in the middle of a reservation

-- NOTE: this is where we get an error if we don't include
-- one of the dates in the primary key

DELETE FROM reservation
    FOR PORTION OF reservation
    FROM '2023-08-10' TO ('2023-08-10' + INTERVAL 2 DAY)
    WHERE bungalow_name = 'Yellow House'
;

SELECT * FROM reservation;

-- update a portion of a reservation

UPDATE reservation
    FOR PORTION OF reservation
    FROM '2023-08-10' TO ('2023-08-10' + INTERVAL 11 DAY)
    SET client_name = 'John Cage'
    WHERE bungalow_name = 'Green House'
;

SELECT * FROM reservation WHERE bungalow_name = 'Green House';
