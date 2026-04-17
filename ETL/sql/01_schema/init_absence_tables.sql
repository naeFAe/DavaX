CREATE TABLE STG_ABSENCE_LOG_RAW (
    employee_id_text      VARCHAR2(20),
    absence_date_text     VARCHAR2(30),
    absence_duration_text VARCHAR2(30),
    absence_type          VARCHAR2(50)
);

CREATE TABLE Absence_Log (
    absence_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id    NUMBER,
    absence_date   DATE,
    absence_hours  NUMBER(5,2),
    absence_type   VARCHAR2(50)
);


