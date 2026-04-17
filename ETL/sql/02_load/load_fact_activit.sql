INSERT INTO FACT_ACTIVITY (
    date_key,
    employee_key,
    department_key,
    activity_type,
    hours_quantity,
    source
)
SELECT
    d.date_key,
    de.employee_key,
    dd.department_key,
    'WORK' AS activity_type,
    te.hours_worked,
    'TIMESHEET' AS source
FROM TIMESHEET_ENTRIES te
JOIN TIMESHEETS t
    ON te.timesheet_id = t.timesheet_id
JOIN EMPLOYEES e
    ON t.employee_id = e.employee_id
JOIN DIM_EMPLOYEE de
    ON de.source_employee_id = e.employee_id
JOIN DIM_DEPARTMENT dd
    ON dd.source_department_id = e.department_id
JOIN DIM_DATE d
    ON d.full_date = te.work_date;

INSERT INTO FACT_ACTIVITY (
    date_key,
    employee_key,
    department_key,
    activity_type,
    hours_quantity,
    source
)
SELECT
    d.date_key,
    de.employee_key,
    dd.department_key,
    'ABSENCE' AS activity_type,
    a.absence_hours,
    'ABSENCE_LOG' AS source
FROM ABSENCE_LOG a
JOIN EMPLOYEES e
    ON a.employee_id = e.employee_id
JOIN DIM_EMPLOYEE de
    ON de.source_employee_id = e.employee_id
JOIN DIM_DEPARTMENT dd
    ON dd.source_department_id = e.department_id
JOIN DIM_DATE d
    ON d.full_date = a.absence_date;
    
    
