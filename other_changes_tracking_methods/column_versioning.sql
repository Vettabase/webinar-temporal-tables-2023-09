/*
    Column versioning using triggers.
    We have a user table that is used in a traditional way.
    We have a user_change table containing versions of each value in user.
    Applications write to user, triggers keep user_change in sync.

    Other variants:
      - We could keep the new value rather than the old.
        Instead of the first_version column we'd have a last_version
        (set to TRUE when a deleted row is deleted).
      - The first_version column helps finding out if the row was inserted
        of the old value was NULL. If old entries are periodically deleted
        and not all columns are NOT NULL, this is the only way to know that.
      - We could keep both the old and new value in each user_change row.
        But this would simplify a small number of queries, and it would take
        remarkably more storage.
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
);

CREATE OR REPLACE TABLE user_change (
    uuid UUID DEFAULT UUID(),
    row_change_uuid UUID
        COMMENT 'Helpful to identify changes made by the same statement',
    changed_column VARCHAR(64) NOT NULL,
    old_value VARCHAR(100) DEFAULT NULL,
    first_version BOOL NOT NULL DEFAULT FALSE
        COMMENT 'Only true for newly inserted rows',
    valid_until TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (uuid, changed_column, valid_until)
);


DELIMITER ||

CREATE OR REPLACE TRIGGER user_ai
    AFTER INSERT ON user
    FOR EACH ROW
BEGIN
    SET @user_ai_uuid := UUID();
    INSERT INTO user_change
        (changed_column, first_version, row_change_uuid)
        VALUES
        ('first_name', TRUE, @user_ai_uuid),
        ('last_name', TRUE, @user_ai_uuid),
        ('email', TRUE, @user_ai_uuid)
    ;
    SET @user_ai_uuid := NULL;
END;

CREATE OR REPLACE TRIGGER user_ad
    AFTER DELETE ON user
    FOR EACH ROW
BEGIN
    SET @user_ad_uuid := UUID();
    INSERT INTO user_change
        (changed_column, old_value, row_change_uuid)
        VALUES
        ('first_name', OLD.first_name, @user_ad_uuid),
        ('last_name', OLD.last_name, @user_ad_uuid),
        ('email', OLD.email, @user_ad_uuid)
    ;
    SET @user_ad_uuid := NULL;
END;

CREATE OR REPLACE TRIGGER user_au
    AFTER UPDATE ON user
    FOR EACH ROW
BEGIN
    SET @user_au_uuid := UUID();
    IF OLD.first_name <> NEW.first_name THEN
        INSERT INTO user_change
            (changed_column, old_value, row_change_uuid)
            VALUES
            ('first_name', OLD.first_name, @user_au_uuid)
        ;
    END IF;

    IF OLD.last_name <> NEW.last_name THEN
        INSERT INTO user_change
            (changed_column, old_value, row_change_uuid)
            VALUES
            ('last_name', OLD.last_name, @user_au_uuid)
        ;
    END IF;

    IF OLD.email <> NEW.email THEN
        INSERT INTO user_change
            (changed_column, old_value, row_change_uuid)
            VALUES
            ('email', OLD.email, @user_au_uuid)
        ;
    END IF;
    SET @user_au_uuid := NULL;
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
SELECT * FROM user_change;

UPDATE user
    SET email = 'llap@spock.com'
    WHERE email = 'leo@spock.com'
;
SELECT * FROM user;
SELECT * FROM user_change;

DELETE FROM user WHERE email = 'llap@spock.com';
SELECT * FROM user;
SELECT * FROM user_change;

-- Reading UUIDs can be difficult
SELECT row_change_uuid, MIN(first_version), COUNT(*) FROM user_change GROUP BY row_change_uuid;
