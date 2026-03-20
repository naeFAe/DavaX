-- ============================================
-- 6. MATERIALIZED VIEW
-- ============================================

CREATE MATERIALIZED VIEW mv_employee_monthly_hours
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    TO_CHAR(te.work_date, 'YYYY-MM') AS month
FROM employees e
JOIN timesheets t ON e.employee_id = t.employee_id
JOIN timesheet_entries te ON t.timesheet_id = te.timesheet_id
GROUP BY e.employee_id, e.first_name, e.last_name, TO_CHAR(te.work_date, 'YYYY-MM');