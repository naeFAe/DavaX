-- Afiseaza totalul orelor lucrate de fiecare angajat
SELECT 
    e.first_name,
    e.last_name,
    SUM(te.hours_worked) AS total_hours
FROM employees e
JOIN timesheets t ON e.employee_id = t.employee_id
JOIN timesheet_entries te ON t.timesheet_id = te.timesheet_id
GROUP BY e.first_name, e.last_name;