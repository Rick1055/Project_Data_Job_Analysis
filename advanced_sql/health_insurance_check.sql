SELECT
    company.name AS company_name,
    job_postings.job_health_insurance AS health_insurance,
    job_postings.job_posted_date AS date_time,
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS month
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS company
    ON job_postings.company_id = company.company_id
WHERE
    ( EXTRACT(MONTH FROM job_postings.job_posted_date) >= 3 AND  EXTRACT(MONTH FROM job_postings.job_posted_date) <=6) 
    AND job_health_insurance = true;
