-- ============================================
-- 3. INSERT DATA
-- ============================================

-- Departments
INSERT INTO departments VALUES (1, 'IT');
INSERT INTO departments VALUES (2, 'HR');
INSERT INTO departments VALUES (3, 'Finance');

-- Employees
INSERT INTO employees VALUES (1, 1, 'John', 'Doe', 'john.doe@email.com', DATE '2022-01-10', 'Developer');
INSERT INTO employees VALUES (2, 1, 'Anna', 'Popescu', 'anna.popescu@email.com', DATE '2023-03-15', 'QA');
INSERT INTO employees VALUES (3, 2, 'Maria', 'Ionescu', 'maria.ionescu@email.com', DATE '2021-07-01', 'HR Specialist');

-- Projects
INSERT INTO projects VALUES (1, 'PRJ001', 'Website', DATE '2024-01-01', NULL, 'Y');
INSERT INTO projects VALUES (2, 'PRJ002', 'Mobile App', DATE '2024-02-01', NULL, 'Y');

-- Timesheets
INSERT INTO timesheets VALUES (
    1, 1, DATE '2025-03-10', 'SUBMITTED',
    '{"approver":"manager1","notes":"OK"}',
    SYSDATE
);

INSERT INTO timesheets VALUES (
    2, 2, DATE '2025-03-10', 'DRAFT',
    NULL,
    SYSDATE
);

-- Timesheet Entries
INSERT INTO timesheet_entries VALUES (1, 1, 1, DATE '2025-03-10', 8, 'Development work');
INSERT INTO timesheet_entries VALUES (2, 1, 2, DATE '2025-03-11', 6, 'Mobile features');
INSERT INTO timesheet_entries VALUES (3, 1, 1, DATE '2025-03-12', 8, 'Bug fixing');