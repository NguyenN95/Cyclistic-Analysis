-----------------------------------------------------------------
-- Project: Google Data Analysis capstone project case study 1 --
-- Author: Nguyen Nguyen                                       --
-- Description: Cleaning and Manipulation data (analysis)      --
-----------------------------------------------------------------

-- CLEANING --

-- Count rows before clean
SELECT COUNT(ride_id) total_rows FROM trips;

-- Store ride length each trip
ALTER TABLE trips DROP COLUMN IF EXISTS ride_length;
ALTER TABLE trips ADD ride_length INTERVAL;
UPDATE trips SET ride_length = ended_at - started_at;
ALTER TABLE trips ALTER COLUMN ride_length SET NOT NULL;

-- Checking if code above works
SELECT * FROM trips LIMIT 10;

-- Store days of week (Sunday = 1 and so on)
-- https://www.postgresql.org/docs/current/functions-datetime.html
ALTER TABLE trips DROP COLUMN IF EXISTS day_of_week;
ALTER TABLE trips ADD day_of_week INT;
UPDATE trips SET day_of_week = EXTRACT(DOW FROM started_at) + 1;
ALTER TABLE trips ALTER COLUMN day_of_week SET NOT NULL;

-- Checking if code above works
SELECT * FROM trips LIMIT 10;

-- Delete records that have ride length <= 60 secconds because it can be test data or relocate bike at dock station
DELETE FROM trips WHERE ride_length <= '00:00:60'::TIME;

-- Check results after cleaning
SELECT COUNT(*) FROM trips;
SELECT * FROM trips WHERE ride_length ISNULL OR ride_length <= '00:00:60'::TIME;
SELECT * FROM trips WHERE day_of_week ISNULL OR day_of_week <= 0;

-- Count rows after cleaning
SELECT COUNT(ride_id) total_rows FROM trips;

-- Count distinct rows
SELECT COUNT(DISTINCT ride_id) total_distinct_rows FROM trips;

-- ANALYSIS --

-- Summary ride time (in seconds)
-- https://stackoverflow.com/questions/45417079/convert-interval-to-number-in-postgresql
-- https://stackoverflow.com/questions/12067656/how-do-i-get-min-median-and-max-from-my-query-in-postgresql
SELECT 
    member_casual user_type, 
    EXTRACT(EPOCH FROM AVG(ride_length)) mean, 
    EXTRACT(EPOCH FROM PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY ride_length)) median, 
    EXTRACT(EPOCH FROM MAX(ride_length)) max, 
    EXTRACT(EPOCH FROM MIN(ride_length)) min
FROM trips 
GROUP BY member_casual;

-- Average ride time by bike type
SELECT member_casual user_type, rideable_type bike_type, EXTRACT(EPOCH FROM AVG(ride_length)) avg_trip_duration FROM trips GROUP BY member_casual, rideable_type;

-- Total trips by days
SELECT member_casual user_type, day_of_week, COUNT(ride_id) total_trips FROM trips GROUP BY member_casual, day_of_week;
-- Query to get name of day 
-- https://www.commandprompt.com/education/how-to-get-day-names-in-postgresql/
-- SELECT member_casual user_type, TO_CHAR(started_at, 'day') day_of_week_name, COUNT(ride_id) total_trips FROM trips GROUP BY member_casual, day_of_week, day_of_week_name ORDER BY member_casual, day_of_week;

-- Total trips by bike type
SELECT member_casual user_type, rideable_type bike_type, COUNT(ride_id) total_trip FROM trips GROUP BY member_casual, rideable_type;
SELECT  member_casual user_type, day_of_week, rideable_type bike_type, COUNT(ride_id) total_trips FROM trips GROUP BY member_casual, day_of_week, rideable_type;

-- Total trips by bike type and days
-- Old
-- SELECT  member_casual user_type, day_of_week, rideable_type bike_type, COUNT(ride_id) total_trip FROM trips GROUP BY member_casual, day_of_week, rideable_type;
-- New (for visualizing)
SELECT TO_CHAR(started_at, 'day') day_of_week_name, rideable_type bike_type, COUNT(ride_id) total_trips FROM trips WHERE member_casual = 'casual' GROUP BY day_of_week, day_of_week_name, rideable_type ORDER BY day_of_week;	

SELECT  TO_CHAR(started_at, 'day') day_of_week_name, rideable_type bike_type, COUNT(ride_id) total_trips FROM trips WHERE member_casual = 'member' GROUP BY day_of_week, day_of_week_name, rideable_type ORDER BY day_of_week;	

-- Distribution (for visualizing)
SELECT EXTRACT(EPOCH FROM ride_length) ride_length_secs FROM trips WHERE member_casual = 'casual' ORDER BY ride_length DESC;
SELECT EXTRACT(EPOCH FROM ride_length) ride_length_secs FROM trips WHERE member_casual = 'member' ORDER BY ride_length DESC;