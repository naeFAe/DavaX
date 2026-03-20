-- ============================================
-- 5. CREATE VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_employee_timesheets AS
SELECT 
    e.first_name,
    e.last_name,
    t.week_start_date,
    t.status,
    te.work_date,
    te.hours_worked,
    p.project_name
FROM employees e
JOIN timesheets t ON e.employee_id = t.employee_id
JOIN timesheet_entries te ON t.timesheet_id = te.timesheet_id
JOIN projects p ON te.project_id = p.project_id;