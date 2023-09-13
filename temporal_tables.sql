CREATE OR REPLACE SCHEMA temporal_tables;
USE temporal_tables;


-- Create a regular table, and later make it system-versioned

CREATE OR REPLACE TABLE product_category (
    uuid UUID DEFAULT UUID(),
    category_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (uuid)
);
INSERT INTO product_category (category_name) VALUES
    ('Books'),
    ('Audiobooks'),
    ('Comics'),
    ('Magazines')
;

ALTER TABLE product_category
    ADD COLUMN valid_since TIMESTAMP(6) GENERATED ALWAYS AS ROW START INVISIBLE,
    ADD COLUMN valid_until TIMESTAMP(6) GENERATED ALWAYS AS ROW END INVISIBLE,
    ADD PERIOD FOR SYSTEM_TIME(valid_since, valid_until),
    ADD SYSTEM VERSIONING
;

ALTER TABLE product_category
    PARTITION BY SYSTEM_TIME (
        PARTITION p_history HISTORY,
        PARTITION p_current CURRENT
    )
;

SELECT * FROM product_category;

INSERT INTO product_category (category_name) VALUES
    ('Stationery')
;
DELETE FROM product_category WHERE category_name = 'Comics';

SELECT * FROM product_category;
SELECT *, valid_since, valid_until FROM product_category;
SELECT *, valid_since, valid_until FROM product_category FOR SYSTEM_TIME ALL;

-- see the deleted rows
SELECT *, valid_since, valid_until
    FROM product_category FOR SYSTEM_TIME ALL
    WHERE valid_until < NOW()
;

-- we could achieve the same by reading the history partition
-- without SYSTEM_TIME specification
SELECT *, valid_since, valid_until
    FROM product_category PARTITION (p_history)
;

-- see rows deleted more than 1 year ago
SELECT *, valid_since, valid_until
    FROM product_category FOR SYSTEM_TIME ALL
    WHERE valid_until < (NOW() - INTERVAL 1 YEAR)
;

-- see rows deleted a certain day
SELECT *, valid_since, valid_until
    FROM product_category FOR SYSTEM_TIME ALL
    WHERE valid_until BETWEEN '2023-06-06 00:00:00' AND '2023-06-07 00:00:00'
;


-- we can also create a sysver table from the beginning

CREATE TABLE user (
    uuid UUID DEFAULT UUID(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
        WITHOUT SYSTEM VERSIONING,
    valid_since TIMESTAMP(6) GENERATED ALWAYS AS ROW START INVISIBLE,
    valid_until TIMESTAMP(6) GENERATED ALWAYS AS ROW END INVISIBLE,
    PRIMARY KEY (uuid),
    UNIQUE unq_email (email),
    PERIOD FOR SYSTEM_TIME(valid_since, valid_until)
)
    WITH SYSTEM VERSIONING
;


-- number of current customers that started a Diamond subscription in or after May 2023

SELECT now.*
    FROM (
        SELECT *
            FROM user
    ) AS now
    INNER JOIN (
        SELECT *
            FROM user FOR SYSTEM_TIME ALL
            WHERE '2023-05-01' BETWEEN valid_since AND valid_until
    ) AS past
        ON now.uuid = past.uuid
    WHERE past.uuid IS NOT NULL
        AND now.subscription_type = 'DIAMOND'
        AND past.subscription_type <> 'DIAMOND'
;

-- history of a customer

SELECT
        *,
        valid_since, valid_until,
        DATEDIFF(valid_until, valid_since) AS duration_days
    FROM user FOR SYSTEM_TIME ALL
    WHERE uuid = '19eb5a9a-51b1-11ee-923e-560004819076'
    ORDER BY valid_since
\G

-- history of a single column

SELECT
    subscription_type, previous_subscription_type,
    valid_since, valid_until,
    DATEDIFF(valid_until, valid_since) AS duration_days
FROM (
    SELECT
            subscription_type,
            LAG(subscription_type) OVER (ORDER BY valid_since)
                AS previous_subscription_type,
            valid_since, valid_until
        FROM user FOR SYSTEM_TIME ALL
        WHERE uuid = '19eb5a9a-51b1-11ee-923e-560004819076'
) v
WHERE previous_subscription_type IS NULL OR subscription_type <> previous_subscription_type
ORDER BY valid_since
\G

-- find rows inserted in the last month

SELECT *
    FROM (
        SELECT
            *,
            valid_since, valid_until,
            LAG(uuid) OVER (ORDER BY valid_since) AS lag
        FROM user
        WHERE valid_since > (NOW() - INTERVAL 1 MONTH)
    ) v
    WHERE lag IS NULL
\G

-- find rows deleted in the last month

SELECT *
    FROM (
        SELECT
            *,
            valid_since, valid_until,
            LEAD(uuid) OVER (ORDER BY valid_since) AS lead
        FROM user
        WHERE valid_since > (NOW() - INTERVAL 1 MONTH)
    ) v
    WHERE lead IS NULL AND valid_until < NOW()
\G

-- see how often rows change

SELECT AVG(c), STDDEV(c), MIN(c), MAX(c)
    FROM (
        SELECT email, COUNT(*) AS c
        FROM user FOR SYSTEM_TIME ALL
        WHERE  valid_since > (NOW() - INTERVAL 6 MONTH)
        GROUP BY email
    ) v
;

-- with this information in mind,
-- see how many times a row has changed in the last 6 months

SELECT email, COUNT(*)
    FROM user FOR SYSTEM_TIME ALL
    WHERE email = 'jocelynporter@example.org'
        AND valid_since > (NOW() - INTERVAL 6 MONTH)
;

-- see the rows that change most often

SELECT email, COUNT(*)
    FROM user FOR SYSTEM_TIME ALL
    WHERE  valid_since > (NOW() - INTERVAL 6 MONTH)
    GROUP BY email
    HAVING COUNT(*) > 1
    ORDER BY COUNT(*)
;

-- fraud detection:
-- see persons who shared the same ip

SELECT ip, COUNT(DISTINCT uuid)
    FROM user FOR SYSTEM_TIME ALL
    WHERE valid_since > (NOW() - INTERVAL 1 YEAR)
    GROUP BY ip
    HAVING COUNT(DISTINCT uuid) > 1
;

-- get a numerical sequence
SELECT seq AS month
    FROM seq_1_to_12
;

-- number of subscription by month and type

SELECT
        s.month,
        CASE u.subscription_type
            WHEN '' THEN '0'
            WHEN 'BRONZE' THEN '1 - BRONZE'
            WHEN 'SILVER' THEN '2 - SILVER'
            WHEN 'GOLD' THEN '3 - GOLD'
            WHEN 'DIAMOND' THEN '4 - DIAMOND'
        END AS subscription_type,
        COUNT(*)
    FROM (
        SELECT CAST(CONCAT('2023-', seq, '-01 00:00:00') AS datetime) AS month
            FROM seq_1_to_12
    ) s
    LEFT JOIN user FOR SYSTEM_TIME ALL u
        ON s.month BETWEEN u.valid_since AND u.valid_until
    GROUP BY s.month, subscription_type WITH ROLLUP
;

