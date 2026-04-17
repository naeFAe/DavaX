CREATE TABLE DIM_EMPLOYEE (
    employee_key         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_employee_id   NUMBER NOT NULL UNIQUE,
    first_name           VARCHAR2(50) NOT NULL,
    last_name            VARCHAR2(50) NOT NULL,
    email                VARCHAR2(100),
    job_title            VARCHAR2(100)
);

CREATE TABLE DIM_DEPARTMENT (
    department_key         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_department_id   NUMBER NOT NULL UNIQUE,
    department_name        VARCHAR2(100) NOT NULL
);

CREATE TABLE DIM_DATE (
    date_key        NUMBER PRIMARY KEY,
    full_date       DATE NOT NULL,
    day_number      NUMBER NOT NULL,
    month_number    NUMBER NOT NULL,
    year_number     NUMBER NOT NULL,
    day_name        VARCHAR2(20) NOT NULL,
    is_weekend      CHAR(1) CHECK (is_weekend IN ('Y','N'))
);


CREATE TABLE FACT_ACTIVITY (
    fact_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_key          NUMBER NOT NULL,
    employee_key      NUMBER NOT NULL,
    department_key    NUMBER NOT NULL,
    activity_type     VARCHAR2(20) NOT NULL CHECK (activity_type IN ('WORK', 'ABSENCE')),
    hours_quantity    NUMBER(4,2) NOT NULL CHECK (hours_quantity >= 0 AND hours_quantity <= 24),
    source            VARCHAR2(30) NOT NULL,

    CONSTRAINT fk_fact_date FOREIGN KEY (date_key)
        REFERENCES DIM_DATE(date_key),
    CONSTRAINT fk_fact_employee FOREIGN KEY (employee_key)
        REFERENCES DIM_EMPLOYEE(employee_key),
    CONSTRAINT fk_fact_department FOREIGN KEY (department_key)
        REFERENCES DIM_DEPARTMENT(department_key)
);