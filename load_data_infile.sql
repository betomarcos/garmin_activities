
-- First ensure the MySQL connection > Advanced > Others has in the text box: 'OPT_LOCAL_INFILE=1'
-- This script reloads the garmin_all_activities_raw data in MySQL
-- The source data from CSV is an export from Garmin Connect, then run a Macro to format and remove bad data.


TRUNCATE TABLE garmin.garmin_all_activities_raw;

LOAD DATA LOCAL INFILE '/Users/albertomarcos/Documents/Projects/DATA PROJECTS/1. data_analysis_folder/datasets/Garmin datasets/garmin_all_activities_2024_june_5 cleanup.csv'
INTO TABLE garmin.garmin_all_activities_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;



-- Ran this to remove a column from the schema, no need to run everytime reloading data
-- ALTER TABLE garmin.garmin_all_activities_raw DROP COLUMN Distance;


select * from garmin.garmin_all_activities_raw;
  
  
