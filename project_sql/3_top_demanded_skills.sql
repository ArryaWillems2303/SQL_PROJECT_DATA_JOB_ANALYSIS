/*
Question: What are the most in-demand skills for Data Analyst roles?

- This query identifies the 5 most frequently requested skills for Data Analyst roles 
  across remote, Netherlands, and Belgium-based job postings.

- It joins job listings with associated skill requirements and counts how often each skill appears.

Why? It helps surface which tools and technologies are currently most valued in this regional job market, 
offering useful direction for anyone trying to build a relevant and competitive data skill set.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    (
        job_location = 'Anywhere'
        OR job_location LIKE '%Netherlands%'
        OR job_location LIKE '%Belgium%'
    )
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5

-- Insight:
-- This query returns the top 5 most frequently requested skills for Data Analyst roles 
-- across remote, Dutch, and Belgian job listings. 
-- The results highlight which tools are consistently expected by employers, 
-- helping to guide focused skill development for those aiming to enter or grow within the field.