INSERT INTO ABSENCE_LOG (
    employee_id,
    absence_date,
    absence_hours,
    absence_type
)
SELECT
    TO_NUMBER(employee_id_text),
    CASE
        WHEN REGEXP_LIKE(absence_date_text, '^\d{4}-\d{2}-\d{2}$')
            THEN TO_DATE(absence_date_text, 'YYYY-MM-DD')
        WHEN REGEXP_LIKE(absence_date_text, '^\d{4}/\d{2}/\d{2}$')
            THEN TO_DATE(absence_date_text, 'YYYY/MM/DD')
        WHEN REGEXP_LIKE(absence_date_text, '^\d{2}-\d{2}-\d{4}$')
            THEN TO_DATE(absence_date_text, 'DD-MM-YYYY')
    END,
    NVL(TO_NUMBER(REGEXP_SUBSTR(absence_duration_text, '([0-9]+)h', 1, 1, NULL, 1)), 0)
    +
    NVL(TO_NUMBER(REGEXP_SUBSTR(absence_duration_text, '([0-9]+)m', 1, 1, NULL, 1)), 0) / 60,
    absence_type
FROM STG_ABSENCE_LOG_RAW
WHERE
    REGEXP_LIKE(employee_id_text, '^[0-9]+$')
    AND EXISTS (
        SELECT 1
        FROM EMPLOYEES e
        WHERE e.employee_id = TO_NUMBER(employee_id_text)
    )
    AND (
        REGEXP_LIKE(absence_date_text, '^\d{4}-\d{2}-\d{2}$')
        OR REGEXP_LIKE(absence_date_text, '^\d{4}/\d{2}/\d{2}$')
        OR REGEXP_LIKE(absence_date_text, '^\d{2}-\d{2}-\d{4}$')
    )
    AND REGEXP_LIKE(absence_duration_text, '^([0-9]+h)? ?([0-9]+m)?$')
    AND (
        NVL(TO_NUMBER(REGEXP_SUBSTR(absence_duration_text, '([0-9]+)h', 1, 1, NULL, 1)), 0)
        +
        NVL(TO_NUMBER(REGEXP_SUBSTR(absence_duration_text, '([0-9]+)m', 1, 1, NULL, 1)), 0) / 60
    ) <= 24;