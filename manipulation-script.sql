----------------------------------------------
-- Google Data Analysis capstone project 1  --
--                                          --
----------------------------------------------

-- Total rows
-- SELECT COUNT(ride_id) total_rows FROM trips;

-- Descriptive analysis on ride_length
-- SELECT 
--     member_casual, 
--     CAST(EXTRACT(EPOCH FROM DATE_TRUNC('second', AVG(ride_length))) AS INT) mean_secs, 
--     CAST(EXTRACT(EPOCH FROM DATE_TRUNC('second', PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY ride_length))) AS INT) median_secs, 
--     CAST(EXTRACT(EPOCH FROM DATE_TRUNC('second', MAX(ride_length))) AS INT) max_secs, 
--     CAST(EXTRACT(EPOCH FROM DATE_TRUNC('second', MIN(ride_length))) AS INT) min_secs 
-- FROM trips 
-- GROUP BY member_casual;

-- Total trips by days
-- SELECT member_casual, day_of_week, COUNT(ride_id) total_trip FROM trips GROUP BY member_casual, day_of_week;

-- Total trips by bike type
-- SELECT member_casual, rideable_type bike_type, COUNT(ride_id) total_trip FROM trips GROUP BY member_casual, rideable_type;