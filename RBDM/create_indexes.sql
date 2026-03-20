-- ============================================
-- 4. CREATE INDEXES
-- ============================================

CREATE INDEX idx_timesheet_status ON timesheets(status);
CREATE INDEX idx_entry_work_date ON timesheet_entries(work_date);

SELECT 
    index_name,
    table_name,
    uniqueness
FROM user_indexes
WHERE table_name IN ('TIMESHEETS', 'TIMESHEET_ENTRIES')