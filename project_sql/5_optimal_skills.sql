WITH optimal_skills AS
(
    -- This CTE gives the average salary along with the no. of job postings for each skill listed in the skills_dim table ignoring jobs which do not have any kind of skill requirement for each skill listed in the skills_dim table while ignoring the outliers using the HAVING clause of the CTE
    SELECT
        job_skills.skill_id,
        ROUND(AVG(job_postings.salary_year_avg),0) AS avg_skill_salary,
        COUNT(job_skills.job_id) AS job_count
    FROM 
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS job_skills ON job_postings.job_id = job_skills.job_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        job_skills.skill_id
    HAVING
        COUNT(job_postings.job_id) > 10
)
SELECT
    optimal_skills.skill_id,
    skills.skills AS skill_name,
    optimal_skills.job_count,
    optimal_skills.avg_skill_salary
FROM
    optimal_skills
LEFT JOIN skills_dim AS skills ON optimal_skills.skill_id = skills.skill_id
ORDER BY
/*
sort while keeping your current priorities in sight. I have arranged this table in accordance to a fresher searching for his first job/internship.
It would be more beneficial for a fresher (according to me) to priortise skills which have a larger volume of job openings rather than niche,high paying ones which have a deficit of postings.
But having said that, feel free to change the sorting according to your preferences at any point of time
*/
    optimal_skills.job_count DESC 

