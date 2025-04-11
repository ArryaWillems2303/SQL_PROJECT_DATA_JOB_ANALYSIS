/*
Answer: What are the top skills based on salary?

- This query calculates the average salary associated with each skill 
  across Data Analyst roles that disclose compensation.

- It includes remote, Netherlands, and Belgium-based job postings to reflect 
  the most relevant markets for this analysis.

Why? Understanding how different skills correlate with higher average salaries 
can help guide where to focus learning efforts and which tools offer the greatest 
strategic advantage when entering or advancing in the data field.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
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
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;


-- Insight:
-- This query shows which skills are most frequently associated with higher average salaries 
-- in Data Analyst roles across remote, Dutch, and Belgian listings.
-- It helps identify tools that may offer strong positioning in the job market based on compensation trends.