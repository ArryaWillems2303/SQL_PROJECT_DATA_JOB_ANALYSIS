/*
Bonus Query: Local job market transparency in the Netherlands and Belgium

- This query counts the total number of Data Analyst roles in the Netherlands and Belgium,
  and how many of those roles include salary information.

Why? It highlights the low rate of salary transparency in local job markets, providing a 
clear justification for including remote roles in the main salary-based analysis.
*/

SELECT
    CASE
        WHEN job_location LIKE '%Netherlands%' THEN 'Netherlands'
        WHEN job_location LIKE '%Belgium%' THEN 'Belgium'
    END AS country,
    COUNT(*) AS total_jobs,
    COUNT(CASE WHEN salary_year_avg IS NOT NULL THEN 1 END) AS jobs_with_salary
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
  AND (
      job_location LIKE '%Netherlands%' OR
      job_location LIKE '%Belgium%'
  )
GROUP BY country;

-- Insight:
-- The Netherlands and Belgium each had over 3,700 Data Analyst job postings in the dataset,
-- but only around 20 in each country included a defined salary.
-- This lack of salary transparency made it necessary to incorporate remote roles,
-- where salary data was more consistently available, in order to build a meaningful analysis.