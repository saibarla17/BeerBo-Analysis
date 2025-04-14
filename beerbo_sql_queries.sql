
-- 1. View sample data
SELECT TOP 10 * FROM ProductionMetric;
SELECT TOP 10 * FROM Quality;
SELECT TOP 10 * FROM DeviceProperty;

-- 2. Count records
SELECT COUNT(*) FROM ProductionMetric;
SELECT COUNT(*) FROM Quality;
SELECT COUNT(*) FROM DeviceProperty;

-- 3. Unique keys
SELECT DISTINCT deviceKey FROM ProductionMetric;
SELECT DISTINCT shift_display_name FROM ProductionMetric;
SELECT DISTINCT team_display_name FROM ProductionMetric;

-- 4. Total downtime
SELECT 
    SUM(unplanned_stop_time) AS total_unplanned,
    SUM(planned_stop_time) AS total_planned
FROM ProductionMetric;

-- 5. Downtime by device
SELECT 
    deviceKey,
    AVG(unplanned_stop_time) AS avg_unplanned,
    MAX(unplanned_stop_time) AS max_unplanned,
    MIN(unplanned_stop_time) AS min_unplanned
FROM ProductionMetric
GROUP BY deviceKey;

-- 6. Top unplanned stop reasons
SELECT 
    process_state_reason_display_name,
    COUNT(*) AS frequency
FROM ProductionMetric
WHERE unplanned_stop_time > 0
GROUP BY process_state_reason_display_name
ORDER BY frequency DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- 7. Overall reject rate
SELECT 
    SUM(q.count) AS total_rejects,
    SUM(pm.good_count) AS total_good,
    ROUND(SUM(q.count) * 100.0 / (SUM(q.count) + SUM(pm.good_count)), 2) AS reject_rate_percent
FROM Quality q
JOIN ProductionMetric pm 
    ON q.prodmetric_stream_key = pm.prodmetric_stream_key;

-- 8. Reject rate by shift
SELECT 
    pm.shift_display_name,
    SUM(q.count) AS total_rejects,
    SUM(pm.good_count) AS total_good,
    ROUND(SUM(q.count) * 100.0 / (SUM(q.count) + SUM(pm.good_count)), 2) AS reject_rate_percent
FROM Quality q
JOIN ProductionMetric pm 
    ON q.prodmetric_stream_key = pm.prodmetric_stream_key
GROUP BY pm.shift_display_name;

-- 9. Reject rate by device type
SELECT 
    dp.Type,
    SUM(q.count) AS total_rejects,
    SUM(pm.good_count) AS total_good,
    ROUND(SUM(q.count) * 100.0 / (SUM(q.count) + SUM(pm.good_count)), 2) AS reject_rate_percent
FROM Quality q
JOIN ProductionMetric pm 
    ON q.prodmetric_stream_key = pm.prodmetric_stream_key
JOIN DeviceProperty dp 
    ON pm.deviceKey = dp.deviceKey
GROUP BY dp.Type;

-- 10. Efficiency vs cycle time
SELECT 
    dp.deviceKey,
    dp.DefaultCycleTime,
    SUM(pm.good_count) AS total_good,
    SUM(pm.run_time) AS total_run_time,
    ROUND(SUM(pm.good_count) * 3600.0 / NULLIF(SUM(pm.run_time), 0), 2) AS actual_good_per_hour
FROM ProductionMetric pm
JOIN DeviceProperty dp 
    ON pm.deviceKey = dp.deviceKey
GROUP BY dp.deviceKey, dp.DefaultCycleTime;
