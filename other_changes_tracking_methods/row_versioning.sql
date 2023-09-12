/*
    Row versioning using triggers.
    We have a user table that is used in a traditional way.
    We have a user_history table containing versioned contents of user.
    Applications write to user, triggers keep user_history in sync.

    Other variants:
      - We could use the same table and make the timestamp column invisible.
        But this would more likely have an impact on applications.
      - We could avoid storing the current version in user_history.
        But some analysis would become more difficult and the benefit would be minimal.
*/


CREATE OR REPLACE SCHEMA data_changes_row;
USE data_changes_row;


CREATE OR REPLACE TABLE user (
    uuid UUID DEFAULT UUID(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (uuid),
    UNIQUE unq_email (email)
)
    COMMENT 'Table used by application'
;

CREATE OR REPLACE TABLE user_history (
    uuid UUID DEFAULT UUID(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    valid_since TIMESTAMP DEFAULT NOW()
        COMMENT 'When this row version was created',
    valid_until TIMESTAMP DEFAULT '2038-01-01'
        COMMENT 'When this row version was deleted or replaced',
    PRIMARY KEY (uuid, valid_until)
        COMMENT 'Must include valid_until to allow duplicates and allow finding the current version',
    UNIQUE unq_email (email, valid_until)
        COMMENT 'UNIQUE keys should include valid_until too',
    INDEX idx_last_name_first_name (last_name, first_name, valid_until)
        COMMENT 'Even if duplicates are allowed, including valid_until allows us to find the current versions'
)
    COMMENT 'Tracks changes in table user'
;


DELIMITER ||

CREATE OR REPLACE TRIGGER user_ai
    AFTER INSERT ON user
    FOR EACH ROW
BEGIN
    INSERT INTO user_history
        (uuid, first_name, last_name, email, valid_since, valid_until)
        VALUES
        (NEW.uuid, NEW.first_name, NEW.last_name, NEW.email, NOW(), '2038-01-01')
    ;
END;

CREATE OR REPLACE TRIGGER user_ad
    AFTER DELETE ON user
    FOR EACH ROW
BEGIN
    UPDATE user_history
        SET valid_until = NOW()
        WHERE
            uuid = OLD.uuid
            AND valid_until = '2038-01-01'
    ;
END;

CREATE OR REPLACE TRIGGER user_au
    AFTER UPDATE ON user
    FOR EACH ROW
BEGIN
    UPDATE user_history
        SET valid_until = NOW()
        WHERE
            uuid = OLD.uuid
            AND valid_until = '2038-01-01'
    ;
    INSERT INTO user_history
        (uuid, first_name, last_name, email, valid_since, valid_until)
        VALUES
        (NEW.uuid, NEW.first_name, NEW.last_name, NEW.email, NOW(), '2038-01-01')
    ;
END;

||
DELIMITER ;


-- Testing the triggers

INSERT INTO user
    (first_name, last_name, email)
    VALUES
    ('Leonard', 'Nimoy', 'leo@spock.com')
;
SELECT * FROM user;
SELECT * FROM user_history;

UPDATE user
    SET email = 'llap@spock.com'
    WHERE email = 'leo@spock.com'
;
SELECT * FROM user;
SELECT * FROM user_history;

DELETE FROM user WHERE email = 'llap@spock.com';
SELECT * FROM user;
SELECT * FROM user_history;
