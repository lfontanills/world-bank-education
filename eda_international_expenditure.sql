-- INDICATORS AND CODES - EXPENDITURES
-- UIS.XGDP.1.FSGOV -- Government expenditure on primary education as % of GDP (%)

-- Create CTE to join country_summary with international_education
-- Identify number of records per country, year range of records per country
WITH ie AS (
  SELECT 
    CASE 
    WHEN cs.income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN cs.income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN cs.income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN cs.income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN cs.income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
    cs.region,
    ie.country_code,
    ie.country_name,
    ie.indicator_name,
    ie.indicator_code,
    ie.value,
    ie.year
  FROM bigquery-public-data.world_bank_intl_education.international_education AS ie
    LEFT JOIN bigquery-public-data.world_bank_intl_education.country_summary AS cs
    ON ie.country_code = cs.country_code
  WHERE cs.region IS NOT NULL)

SELECT 
  country_code,
  COUNT(year) AS count_records,
  MIN(year) AS min_year,
  MAX(year) AS max_year
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
GROUP BY country_code
ORDER BY count_records;

-- Repeat CTE to join country_summary with international_education
-- Identify number of countries, number of records, year range BY income group
WITH ie AS ( -- CTE
  SELECT 
    CASE 
    WHEN cs.income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN cs.income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN cs.income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN cs.income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN cs.income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
    cs.region,
    ie.country_code,
    ie.country_name,
    ie.indicator_name,
    ie.indicator_code,
    ie.value,
    ie.year
  FROM bigquery-public-data.world_bank_intl_education.international_education AS ie
    LEFT JOIN bigquery-public-data.world_bank_intl_education.country_summary AS cs
    ON ie.country_code = cs.country_code
  WHERE cs.region IS NOT NULL)

SELECT 
  income_rank,
  COUNT(DISTINCT country_code) AS count_countries,
  COUNT(year) AS count_records,
  MIN(year) AS min_year,
  MAX(year) AS max_year
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
GROUP BY income_rank
ORDER BY income_rank;

-- Repeat CTE to join country_summary with international_education
-- Identify number of records per region, see timeline of records 
WITH ie AS (
  SELECT 
    CASE 
    WHEN cs.income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN cs.income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN cs.income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN cs.income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN cs.income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
    cs.region,
    ie.country_code,
    ie.country_name,
    ie.indicator_name,
    ie.indicator_code,
    ie.value,
    ie.year
  FROM bigquery-public-data.world_bank_intl_education.international_education AS ie
    LEFT JOIN bigquery-public-data.world_bank_intl_education.country_summary AS cs
    ON ie.country_code = cs.country_code
  WHERE cs.region IS NOT NULL)

SELECT 
  region,
  COUNT(year) AS count_records,
  MIN(year) AS min_year,
  MAX(year) AS max_year
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
GROUP BY region
ORDER BY count_records;

-- Repeat CTE to join country_summary with international_education
-- Summary statistics - average, stdev, min, max, range
WITH ie AS (
  SELECT 
    CASE 
    WHEN cs.income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN cs.income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN cs.income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN cs.income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN cs.income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
    cs.region,
    ie.country_code,
    ie.country_name,
    ie.indicator_name,
    ie.indicator_code,
    ie.value,
    ie.year
  FROM bigquery-public-data.world_bank_intl_education.international_education AS ie
    LEFT JOIN bigquery-public-data.world_bank_intl_education.country_summary AS cs
    ON ie.country_code = cs.country_code
  WHERE cs.region IS NOT NULL)

SELECT 
  income_rank,
  MIN(value) AS min_expenditure,
  MAX(value) AS max_expenditure,
  MAX(value) - MIN(value) AS range_expenditure,
  AVG(value) AS avg_expenditure,
  STDDEV(value) AS sd_expenditure
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
GROUP BY income_rank
ORDER BY income_rank;

-- Repeat CTE to join country_summary with international_education
-- Summary statistics - quintiles
WITH ie AS (
  SELECT 
    CASE 
    WHEN cs.income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN cs.income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN cs.income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN cs.income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN cs.income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
    cs.region,
    ie.country_code,
    ie.country_name,
    ie.indicator_name,
    ie.indicator_code,
    ie.value,
    ie.year
  FROM bigquery-public-data.world_bank_intl_education.international_education AS ie
    LEFT JOIN bigquery-public-data.world_bank_intl_education.country_summary AS cs
    ON ie.country_code = cs.country_code
  WHERE cs.region IS NOT NULL)

SELECT 
  income_rank,
  APPROX_QUANTILES(value, 4) AS quantiles_expenditure
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
GROUP BY income_rank
ORDER BY income_rank;

-- Repeat CTE to join country_summary with international_education
-- Look at lower middle income group to identify countries with high averages
WITH ie AS (
  SELECT 
    CASE 
    WHEN cs.income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN cs.income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN cs.income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN cs.income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN cs.income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
    cs.region,
    ie.country_code,
    ie.country_name,
    ie.indicator_name,
    ie.indicator_code,
    ie.value,
    ie.year
  FROM bigquery-public-data.world_bank_intl_education.international_education AS ie
    LEFT JOIN bigquery-public-data.world_bank_intl_education.country_summary AS cs
    ON ie.country_code = cs.country_code
  WHERE cs.region IS NOT NULL)

SELECT
  region,
  country_name,
  AVG(value) as avg_expenditure,
  MAX(value) as max_expenditure
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
  AND income_rank IN ('4 Lower middle income')
GROUP BY region, country_name
ORDER BY avg_expenditure DESC;