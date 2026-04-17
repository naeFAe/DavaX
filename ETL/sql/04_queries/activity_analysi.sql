SELECT *
FROM VW_EMPLOYEE_ACTIVITY_LOGS
ORDER BY full_date, employee_name, activity_type;

SELECT *
FROM VW_EMPLOYEE_ACTIVITY_LOGS
WHERE source_employee_id = 7
ORDER BY full_date;

SELECT *
FROM VW_EMPLOYEE_ACTIVITY_LOGS
WHERE full_date = DATE '2026-05-05'
ORDER BY employee_name;


SELECT *
FROM VW_EMPLOYEE_ACTIVITY_LOGS
WHERE activity_type = 'ABSENCE'
ORDER BY full_date, employee_name;


SELECT *
FROM VW_EMPLOYEE_ACTIVITY_LOGS
WHERE activity_type = 'WORK'
ORDER BY full_date, employee_name;


SELECT
    employee_name,
    SUM(hours_quantity) AS total_hours
FROM VW_EMPLOYEE_ACTIVITY_LOGS
GROUP BY employee_name
ORDER BY employee_name;


SELECT
    full_date,
    SUM(hours_quantity) AS total_hours
FROM VW_EMPLOYEE_ACTIVITY_LOGS
GROUP BY full_date
ORDER BY full_date;