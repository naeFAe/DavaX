INSERT INTO DIM_DEPARTMENT (source_department_id, department_name)
SELECT
    department_id,
    department_name
FROM DEPARTMENTS;

INSERT INTO DIM_EMPLOYEE (source_employee_id, first_name, last_name, email, job_title)
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    job_title
FROM EMPLOYEES;


INSERT INTO DIM_DATE (
    date_key,
    full_date,
    day_number,
    month_number,
    year_number,
    day_name,
    is_weekend
)
SELECT DISTINCT
    TO_NUMBER(TO_CHAR(dt, 'YYYYMMDD')) AS date_key,
    dt AS full_date,
    TO_NUMBER(TO_CHAR(dt, 'DD')) AS day_number,
    TO_NUMBER(TO_CHAR(dt, 'MM')) AS month_number,
    TO_NUMBER(TO_CHAR(dt, 'YYYY')) AS year_number,
    TRIM(TO_CHAR(dt, 'DAY', 'NLS_DATE_LANGUAGE=ENGLISH')) AS day_name,
    CASE
        WHEN TO_CHAR(dt, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') IN ('SAT', 'SUN') THEN 'Y'
        ELSE 'N'
    END AS is_weekend
FROM (
    SELECT work_date AS dt FROM TIMESHEET_ENTRIES
    UNION
    SELECT absence_date AS dt FROM ABSENCE_LOG
);