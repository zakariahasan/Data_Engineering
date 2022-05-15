-- Query 1: Create Group Using Window Frame (GUWF)
SELECT ID, v, s=MAX(v) OVER (PARTITION BY c)
FROM
(
    SELECT ID, v
        ,c=COUNT(v) OVER (ORDER BY ID)
    FROM #X
) a
ORDER BY ID;
