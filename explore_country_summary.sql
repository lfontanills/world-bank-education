-- Explore country_summary table
SELECT 
  income_group,
  COUNT(income_group)
FROM bigquery-public-data.world_bank_intl_education.country_summary
GROUP BY income_group;

-- Generate a list of countries by income_group, region
-- short_name, country_code for income group aggregates:
  -- 'High income' -- 'HIC' 
  -- 'Low income' -- 'LIC'
  -- 'Lower middle income' -- 'LMC'
  -- 'Middle income' -- 'MIC'
  -- 'Upper middle income' -- UMC
  -- 'Low & middle income' -- 'LMY'

SELECT
  income_group,
  country_code,
  short_name,
  region
FROM bigquery-public-data.world_bank_intl_education.country_summary
WHERE region IS NOT NULL
ORDER BY income_group, country_code;

-- Count number of countries in each income group
SELECT
  income_group,
  COUNT(country_code) AS country_count
FROM bigquery-public-data.world_bank_intl_education.country_summary
WHERE income_group IS NOT NULL
GROUP BY income_group;

-- Count the number of countries in each income group per region
SELECT
  income_group,
  region,
  COUNT(country_code) AS country_count
FROM bigquery-public-data.world_bank_intl_education.country_summary
WHERE income_group IS NOT NULL
GROUP BY income_group, region
ORDER BY income_group, country_count DESC;

-- Count the number of countries in each income group per region
-- Improve ordering by creating new income_group ranks
SELECT
  CASE 
    WHEN income_group IN ('High income: OECD')
    THEN '1 High income: OECD'
    WHEN income_group IN ('High income: nonOECD')
    THEN '2 High income: nonOECD'
    WHEN income_group IN ('Upper middle income')
    THEN '3 Upper middle income'
    WHEN income_group IN ('Lower middle income')
    THEN '4 Lower middle income'
    WHEN income_group IN ('Low income')
    THEN '5 Low income'
    ELSE 'undefined' END AS income_rank,
  region,
  COUNT(country_code) AS country_count
FROM bigquery-public-data.world_bank_intl_education.country_summary
WHERE income_group IS NOT NULL
GROUP BY income_rank, region
ORDER BY income_rank, country_count DESC;