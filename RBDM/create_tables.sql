-- 2. CREATE TABLES

CREATE TABLE departments (
    department_id   NUMBER PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    employee_id    NUMBER PRIMARY KEY,
    department_id  NUMBER NOT NULL,
    first_name     VARCHAR2(50) NOT NULL,
    last_name      VARCHAR2(50) NOT NULL,
    email          VARCHAR2(100) NOT NULL UNIQUE,
    hire_date      DATE NOT NULL,
    job_title      VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_employees_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id     NUMBER PRIMARY KEY,
    project_code   VARCHAR2(20) NOT NULL UNIQUE,
    project_name   VARCHAR2(100) NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE,
    is_active      CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT chk_project_active
        CHECK (is_active IN ('Y', 'N'))
);

CREATE TABLE timesheets (
    timesheet_id       NUMBER PRIMARY KEY,
    employee_id        NUMBER NOT NULL,
    week_start_date    DATE NOT NULL,
    status             VARCHAR2(20) DEFAULT 'DRAFT' NOT NULL,
    approval_details   CLOB CHECK (approval_details IS JSON),
    created_at         DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_timesheets_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),
    CONSTRAINT chk_timesheet_status
        CHECK (status IN ('DRAFT', 'SUBMITTED', 'APPROVED', 'REJECTED'))
);

CREATE TABLE timesheet_entries (
    entry_id           NUMBER PRIMARY KEY,
    timesheet_id       NUMBER NOT NULL,
    project_id         NUMBER NOT NULL,
    work_date          DATE NOT NULL,
    hours_worked       NUMBER(4,2) NOT NULL,
    task_description   VARCHAR2(200) NOT NULL,
    CONSTRAINT fk_entries_timesheet
        FOREIGN KEY (timesheet_id)
        REFERENCES timesheets(timesheet_id),
    CONSTRAINT fk_entries_project
        FOREIGN KEY (project_id)
        REFERENCES projects(project_id),
    CONSTRAINT chk_hours_worked
        CHECK (hours_worked > 0 AND hours_worked <= 24)
);