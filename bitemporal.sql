CREATE OR REPLACE SCHEMA bitemporal;
USE bitemporal;

-- create an application-period table

CREATE OR REPLACE TABLE reservation (
    uuid UUID DEFAULT UUID(),
    bungalow_name VARCHAR(100) NOT NULL,
    client_name VARCHAR(100) NOT NULL,
    
    -- when this reservation starts and ends
    start_date DATE,
    end_date DATE,
    
    -- when this row version was inserted / deleted / updated
    valid_since TIMESTAMP(6) GENERATED ALWAYS AS ROW START INVISIBLE,
    valid_until TIMESTAMP(6) GENERATED ALWAYS AS ROW END INVISIBLE,

    PRIMARY KEY (uuid, start_date),
    UNIQUE unq_reservation (bungalow_name, reservation WITHOUT OVERLAPS),
    PERIOD FOR reservation (start_date, end_date),
    PERIOD FOR SYSTEM_TIME(valid_since, valid_until)
)
    WITH SYSTEM VERSIONING
;

ALTER TABLE t
    PARTITION BY SYSTEM_TIME
    INTERVAL 1 MONTH
    PARTITIONS 12
;
