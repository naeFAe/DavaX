CREATE OR REPLACE PACKAGE debug_util
IS
   g_debug_mode NUMBER := 0;

   PROCEDURE enable_debug;
   PROCEDURE disable_debug;

   PROCEDURE log_msg(
      p_module_name VARCHAR2,
      p_line        NUMBER,
      p_message     VARCHAR2
   );

   PROCEDURE log_variable(
      p_module_name VARCHAR2,
      p_line        NUMBER,
      p_name        VARCHAR2,
      p_value       VARCHAR2
   );

   PROCEDURE log_error(
      p_proc VARCHAR2,
      p_err  VARCHAR2
   );
END debug_util;