/*
Question: What are the top-paying Data Analyst jobs?

- This query identifies the 100 highest-paying Data Analyst roles 
  across remote, Netherlands, and Belgium-based listings.
  
- Only job postings that disclose salary information are included to ensure 
  that results reflect actual compensation levels.

Why? To understand which roles offer the strongest leverage in terms of compensation,
and to set a data-backed foundation for deeper analysis of required skills.
*/
 
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND

(
    job_location = 'Anywhere'
    OR job_location LIKE '%Netherlands%'
    OR job_location LIKE '%Belgium%'
)
    AND
    salary_year_avg IS NOT NULL
    
ORDER BY
    CASE
        WHEN job_location LIKE '%Netherlands%' THEN 1
        WHEN job_location LIKE '%Belgium%' THEN 2
        WHEN job_location = 'Anywhere' THEN 3
        ELSE 4
    END,
    salary_year_avg DESC
LIMIT 100;

--Insight:
--This query returns the top-paying Data Analyst roles in the dataset, limited to those with 
--disclosed salaries and based in either the Netherlands, Belgium, or listed as remote.
--Results are ordered to prioritize local market roles first, followed by remote options.
--This creates a grounded starting point for further analysis on skill requirements and trends.
