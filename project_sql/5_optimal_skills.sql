/*
Answer: What are the most optimal skills to learn?

- This query identifies skills that are both in high demand and associated with higher average salaries 
  in Data Analyst job postings across remote, Netherlands, and Belgium roles.

- It uses two subqueries: one to calculate how often each skill appears (demand), and one to calculate 
  the average salary associated with each skill.

Why? It provides a high-leverage perspective for prioritizing skill development by aligning with 
real-world hiring patterns — especially for those entering the field or aiming to improve job alignment.
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        (
            job_location = 'Anywhere' OR
            job_location LIKE '%Netherlands%' OR
            job_location LIKE '%Belgium%'
        )
    GROUP BY skills_dim.skill_id
), 

average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        (
            job_location = 'Anywhere' OR
            job_location LIKE '%Netherlands%' OR
            job_location LIKE '%Belgium%'
        )
    GROUP BY skills_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 6;

-- Insight:
-- This query highlights skills that strike a strong balance between demand and compensation.
-- By focusing on roles with defined salaries in both local (NL/BE) and remote listings,
-- it reveals which tools are most likely to offer leverage in today’s job market.
-- The result helps prioritize where to invest learning time for those aiming to grow or break into the field.