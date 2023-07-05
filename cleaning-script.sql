----------------------------------------------
-- Google Data Analysis capstone project 1  --
--                                          --
----------------------------------------------


-- Store ride length each trip
-- ALTER TABLE trips DROP COLUMN IF EXISTS ride_length;
-- ALTER TABLE trips ADD ride_length INTERVAL;
-- UPDATE trips SET ride_length = ended_at - started_at;
-- ALTER TABLE trips ALTER COLUMN ride_length SET NOT NULL;

-- Checking if code above works
-- SELECT * FROM trips LIMIT 10

-- Store days of week (Sunday = 1 and so on)
-- ALTER TABLE trips DROP COLUMN IF EXISTS day_of_week;
-- ALTER TABLE trips ADD day_of_week INT;
-- https://www.postgresql.org/docs/current/functions-datetime.html
-- UPDATE trips set day_of_week = EXTRACT(DOW FROM started_at) + 1;
-- ALTER TABLE trips ALTER COLUMN day_of_week SET NOT NULL;

-- Checking if code above works
-- SELECT * FROM trips LIMIT 10;

-- Delete records that have ride length <= 60 secconds because it can be test data or relocate bike at dock station
-- DELETE FROM trips WHERE ride_length <= '00:00:60'::time;

-- Check results after cleaning
-- SELECT COUNT(*) FROM trips;
-- SELECT * FROM trips WHERE ride_length ISNULL OR ride_length <= '00:00:60'::time;
-- SELECT * FROM trips WHERE day_of_week ISNULL OR day_of_week <= 0;