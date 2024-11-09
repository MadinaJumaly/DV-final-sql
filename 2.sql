SELECT EXTRACT(MONTH FROM ti.date_new)                       AS "Month",
       SUM(ti."Sum_payment") / COUNT(DISTINCT ti."Id_check") AS "Average_amount_per_check",
       COUNT(DISTINCT ti."Id_check") /
       COUNT(DISTINCT EXTRACT(MONTH FROM ti.date_new))       AS "Average_number_of_operations_per_month",
       COUNT(DISTINCT ti."ID_client") /
       COUNT(DISTINCT EXTRACT(MONTH FROM ti.date_new))       AS "Average_number_of_clients_per_month",
       CONCAT(CAST((CAST(COUNT(DISTINCT ti."Id_check") AS DECIMAL) /
                    (SELECT COUNT(DISTINCT ti."Id_check") FROM transaction_info ti)) * 100 AS NUMERIC(10, 2)),
              '%')                                           AS "Share_of_total_number_of_transactions",
       CONCAT(CAST((CAST(SUM(ti."Sum_payment") AS DECIMAL) /
                    (SELECT SUM(ti."Sum_payment") FROM transaction_info ti)) * 100 AS NUMERIC(10, 2)),
              '%')                                           AS "Share_of_total_amount_of_transactions"
FROM transaction_info ti
GROUP BY EXTRACT(MONTH FROM ti.date_new)
ORDER BY EXTRACT(MONTH FROM ti.date_new);