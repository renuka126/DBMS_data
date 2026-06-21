

-- 1. Check if the event scheduler is ON
SHOW VARIABLES LIKE 'event_scheduler';

-- 2. Turn it ON (needed before any event will actually run)
SET GLOBAL event_scheduler = ON;

-- 3. Basic event: runs once, 1 minute from now
CREATE EVENT one_time_test
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
  INSERT INTO logs (message, created_at) VALUES ('test event ran', NOW());

-- 4. Recurring event: runs every day at a fixed time
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
STARTS '2026-06-22 02:00:00'
DO
  DELETE FROM logs WHERE created_at < NOW() - INTERVAL 30 DAY;

-- 5. Recurring event with an end date
CREATE EVENT weekly_report
ON SCHEDULE EVERY 1 WEEK
STARTS '2026-06-23 08:00:00'
ENDS '2026-12-31 23:59:59'
DO
  INSERT INTO report_log (generated_at) VALUES (NOW());

-- 6. View all events
SHOW EVENTS;

-- or with more detail:
SELECT EVENT_NAME, STATUS, EVENT_TYPE, EXECUTE_AT, INTERVAL_VALUE, INTERVAL_FIELD
FROM information_schema.EVENTS
WHERE EVENT_SCHEMA = DATABASE();

-- 7. Disable / enable an event without dropping it
ALTER EVENT daily_cleanup DISABLE;
ALTER EVENT daily_cleanup ENABLE;

-- 8. Drop an event entirely
DROP EVENT IF EXISTS daily_cleanup;