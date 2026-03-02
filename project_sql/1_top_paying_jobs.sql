/*
Question: What are the top-paying data analyst jobs?
- Identify the top highest-paying Data analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- BONUS: Displays the company names so you can prioritise in accordance to your preferences
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into enployer's demands and mindset
*/

SELECT
    job_postings.job_id,
    job_postings.job_title,
    company.name AS company_name,
    job_postings.job_location AS location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg AS avg_yearly_salary,
    job_postings.job_posted_date AS date_of_posting
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS company ON job_postings.company_id = company.company_id
WHERE
    job_title LIKE '%Data_Analyst%' -- If you want to check for other roles, make changes here
    AND job_location = 'Anywhere' -- If you want to have a specific job location, specify here
    AND salary_year_avg IS NOT NULL -- specify salary ranges and requirements here
ORDER BY
    salary_year_avg DESC
LIMIT 10;
