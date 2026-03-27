CREATE OR REPLACE PACKAGE BODY debug_util
IS

   PROCEDURE enable_debug
   IS
   BEGIN
      g_debug_mode := 1;
      DBMS_OUTPUT.PUT_LINE('Debug mode on.');
   END;

   PROCEDURE disable_debug
   IS
   BEGIN
      g_debug_mode := 0;
      DBMS_OUTPUT.PUT_LINE('Debug mode off.');
   END;

   PROCEDURE log_msg(
      p_module_name VARCHAR2,
      p_line        NUMBER,
      p_message     VARCHAR2
   )
   IS
   BEGIN
      IF g_debug_mode = 1 THEN
         INSERT INTO debug_log(module_name, line_no, log_message)
         VALUES (p_module_name, p_line, p_message);

         COMMIT;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('The debug message was not saved');
   END;

   PROCEDURE log_variable(
      p_module_name VARCHAR2,
      p_line        NUMBER,
      p_name        VARCHAR2,
      p_value       VARCHAR2
   )
   IS
   BEGIN
      IF g_debug_mode = 1 THEN
         INSERT INTO debug_log(module_name, line_no, log_message)
         VALUES (p_module_name,
                 p_line,
                 p_name || ' = ' || p_value);

         COMMIT;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('The variable was not logged');
   END;

   PROCEDURE log_error(
      p_proc VARCHAR2,
      p_err  VARCHAR2
   )
   IS
   BEGIN
      IF g_debug_mode = 1 THEN
         INSERT INTO debug_log(module_name, line_no, log_message)
         VALUES (p_proc,
                 0,
                 'Erorr: ' || p_err);

         COMMIT;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('The error was not logged');
   END;

END debug_util;
