-- INDICATORS AND CODES - EXPENDITURES
-- UIS.XGDP.1.FSGOV -- Government expenditure on primary education as % of GDP (%)

-- Create CTE to join country_summary with international_education
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

-- Identify number of records per country, see timeline of records
-- See if there's a large enough sample size to look at more recent records (after 2010)
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

-- Identify number of records per income group, see timeline of records
-- See if there's a large enough sample size to look at more recent records
-- CTE
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
  COUNT(year) AS count_records,
  MIN(year) AS min_year,
  MAX(year) AS max_year
FROM ie
WHERE indicator_code IN ('UIS.XGDP.1.FSGOV') -- Government expenditure on primary education as % of GDP (%)
  AND year > 2010
GROUP BY income_rank
ORDER BY count_records;

-- Identify number of records per region, see timeline of records
-- See if there's a large enough sample size to look at more recent records
-- CTE
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

-- Summary statistics - Government expenditure on primary education as % of GDP, by income level, after 2010
-- average and standard deviation
--  CTE
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

-- Summary statistics - Government expenditure on primary education as % of GDP, by income level, after 2010
-- min, median, max, quartiles
-- CTE
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

-- Investigate expenditure for lower middle income group to identify outliers
-- CTE
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