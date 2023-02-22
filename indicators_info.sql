-- INDICATORS AND CODES - EXPENDITURES
-- UIS.XGDP.1.FSGOV -- Government expenditure on primary education as % of GDP (%)

-- Get list of indicator topics
SELECT 
  topic,
  COUNT(topic)
FROM bigquery-public-data.world_bank_intl_education.series_summary
GROUP BY topic;

-- Get list of indicators for topic: Expenditures, Primary
SELECT
  *
FROM bigquery-public-data.world_bank_intl_education.series_summary
WHERE
  (topic IN ('Expenditures')
    AND indicator_name LIKE '%primary%')
  OR topic IN ('Primary');

SELECT 
  series_code,
  topic,
  indicator_name,
  long_definition
FROM 
  `bigquery-public-data.world_bank_intl_education.series_summary`
WHERE 
  series_code IN ('UIS.XGDP.1.FSGOV')
ORDER BY 
  series_code;