SET SERVEROUTPUT ON

BEGIN
   debug_util.enable_debug;
   adjust_salaries_by_commission;
   debug_util.disable_debug;
END;