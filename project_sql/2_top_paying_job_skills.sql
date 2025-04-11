/*
Question: What skills are required for the top-paying Data Analyst jobs?

- This query analyzes the top 10 highest-paying Data Analyst roles across 
  remote, Netherlands, and Belgium-based job postings with disclosed salaries.
  
- It joins each job with its listed required skills to identify which 
  tools and technologies are consistently associated with these top-tier roles.

Why this matters:
By identifying the most commonly required skills in top-paying roles,
job seekers can better prioritize where to focus their time and learning.
Skills like SQL, Python, and Tableau consistently appear, offering 
high-leverage opportunities for breaking into competitive positions.
*/

WITH top_paying_jobs AS (
  SELECT
      job_id,
      job_title,
      salary_year_avg,
      name AS company_name
  FROM
      job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE
      job_title_short = 'Data Analyst' AND
      (
          job_location = 'Anywhere' OR
          job_location LIKE '%Netherlands%' OR
          job_location LIKE '%Belgium%'
      ) AND
      salary_year_avg IS NOT NULL
  ORDER BY
      salary_year_avg DESC
  LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;

-- Insight:
-- his query reveals the skill sets most frequently associated with the top-paying 
--Data Analyst roles in remote, Dutch, and Belgian markets.

--Tools like SQL, Python, and Tableau appear consistently, with R, Excel, Snowflake, 
--and Pandas also showing up across multiple roles.

--These results help highlight where technical focus may offer the strongest leverage 
--for breaking into competitive data roles and aligning with industry expectations.
