SELECT log_id,
       log_time,
       module_name,
       line_no,
       log_message,
       session_id
FROM debug_log
ORDER BY log_id;