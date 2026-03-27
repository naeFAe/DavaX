CREATE OR REPLACE PROCEDURE adjust_salaries_by_commission
IS
   v_new_salary employees.salary%TYPE;
BEGIN
   debug_util.log_msg('adjust_salaries_by_commission', 1, 'Start procedure');

   FOR rec IN (
      SELECT employee_id, salary, commission_pct
      FROM employees
   )
   LOOP
      debug_util.log_msg(
         'adjust_salaries_by_commission',
         10,
         'Processing employee with ID = ' || rec.employee_id
      );

      debug_util.log_variable(
         'adjust_salaries_by_commission',
         11,
         'salary',
         TO_CHAR(rec.salary)
      );

      debug_util.log_variable(
         'adjust_salaries_by_commission',
         12,
         'commission_pct',
         TO_CHAR(rec.commission_pct)
      );

      IF rec.commission_pct IS NOT NULL THEN
         v_new_salary := rec.salary + (rec.salary * rec.commission_pct);

         debug_util.log_msg(
            'adjust_salaries_by_commission',
            20,
            'commission_pct has a value. Salary is increased proportionally.'
         );
      ELSE
         v_new_salary := rec.salary + (rec.salary * 0.02);

         debug_util.log_msg(
            'adjust_salaries_by_commission',
            21,
            'commission_pct is NULL. Salary is increased by 2%.'
         );
      END IF;

      debug_util.log_variable(
         'adjust_salaries_by_commission',
         25,
         'v_new_salary',
         TO_CHAR(v_new_salary)
      );

      UPDATE employees
      SET salary = v_new_salary
      WHERE employee_id = rec.employee_id;

      debug_util.log_msg(
         'adjust_salaries_by_commission',
         30,
         'Salary has been updated for employee_id = ' || rec.employee_id
      );
   END LOOP;

   COMMIT;
   debug_util.log_msg('adjust_salaries_by_commission', 40, 'End procedure');
   DBMS_OUTPUT.PUT_LINE('Salaries have been updated.');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      debug_util.log_error('adjust_salaries_by_commission', SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Warning!!! Salaries have not been updated!');
END;