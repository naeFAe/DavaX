-- Afiseaza toti angajatii si orele lor, inclusiv cei fara pontaj
SELECT 
    e.first_name,
    e.last_name,
    te.hours_worked
FROM employees e
LEFT JOIN timesheets t ON e.employee_id = t.employee_id
LEFT JOIN timesheet_entries te ON t.timesheet_id = te.timesheet_id;