-- schema.sql
-- Table: taxi_trips
-- Database: zepto_sql_project
-- Does not modify any pre-existing tables

CREATE TABLE IF NOT EXISTS taxi_trips (
    pickup           TIMESTAMP,
    dropoff          TIMESTAMP,
    passengers       INTEGER,
    distance         NUMERIC(8, 2),
    fare             NUMERIC(8, 2),
    tip              NUMERIC(8, 2),
    tolls            NUMERIC(8, 2),
    total            NUMERIC(8, 2),
    color            TEXT,
    payment          TEXT,
    pickup_zone      TEXT,
    dropoff_zone     TEXT,
    pickup_borough   TEXT,
    dropoff_borough  TEXT,
    hour             INTEGER,
    day_name         TEXT,
    trip_date        DATE,
    trip_minutes     NUMERIC(8, 2),
    tipped           INTEGER,
    fare_per_mile    NUMERIC(8, 3)
);
