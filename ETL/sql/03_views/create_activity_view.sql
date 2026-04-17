-- This view combines the fact table with all dimension tables
CREATE OR REPLACE VIEW VW_ACTIVITY AS
SELECT
    d.full_date,
    e.name,
    f.activity_type,
    l.location_name,
    f.hours
FROM FACT_ACTIVITY f
JOIN DIM_DATE d ON f.date_key = d.date_key
JOIN DIM_EMPLOYEE e ON f.employee_key = e.employee_key
JOIN DIM_LOCATION l ON f.location_key = l.location_key;