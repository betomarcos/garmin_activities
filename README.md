**OVERVIEW**

- Analysis on Garmin activities data. 
- Mostly focused on running and triathlon related activities.
- Most would use data exports from Garmin. Loaded to a local MySQL instance.

**TABLEAU**
- Garmin Workouts Analysis: https://public.tableau.com/app/profile/alberto.marcos/viz/garminactivities/Dashboard2?publish=yes
<img width="1309" alt="image" src="https://github.com/betomarcos/garmin_activities/assets/130506688/2004ece6-f4e6-43b5-bb9c-52a192aec4e6">


**QUERY TO CREATE DATASET**
drop table garmin_activities_stage;
CREATE TABLE garmin_activities_stage AS
SELECT
    CASE 
        WHEN activity_type LIKE '%Cycling%' OR activity_type LIKE '%Biking%' THEN 'Cycling' 
        WHEN activity_type LIKE '%Running%' THEN 'Running' 
        WHEN activity_type LIKE '%Walking%' THEN 'Walking' 
        WHEN activity_type LIKE '%Yoga%' THEN 'Yoga' 
        WHEN activity_type LIKE '%Strength Training%' THEN 'Strength Training' 
        ELSE 'Other'  -- will be able to filter out the "other" fields in Tableau.
    END AS activity_type,
    DATE(activity_date) AS activity_date,
    Title AS title,
    CAST(avg_hr AS DECIMAL(10, 2)) AS avg_hr,
    CAST(max_hr AS DECIMAL(10, 2)) AS max_hr,
    CAST(aerobic_te AS DECIMAL(5, 1)) AS aerobic_te,
    CAST(distance_km AS DECIMAL(10, 2)) AS distance_km,
    Calories AS calories,
    activity_time,
    ROUND(TIME_TO_SEC(activity_time) / 60) AS duration_minutes
FROM garmin_all_activities_raw
WHERE 
    avg_hr IS NOT NULL AND TRIM(avg_hr) != '' AND CAST(avg_hr AS DECIMAL(10, 2)) > 0
    AND distance_km IS NOT NULL AND TRIM(distance_km) != ''
    AND max_hr IS NOT NULL AND TRIM(max_hr) != '' AND CAST(max_hr AS DECIMAL(10, 2)) > 0
    AND aerobic_te IS NOT NULL AND TRIM(aerobic_te) != '' AND CAST(aerobic_te AS DECIMAL(5, 1)) >= 0
    AND activity_date IS NOT NULL
    AND activity_time IS NOT NULL
HAVING 
    max_hr < 201 -- this may change later on
;
