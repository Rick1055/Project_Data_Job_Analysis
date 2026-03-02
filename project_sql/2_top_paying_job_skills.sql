/*
Question: What skills are required for the top-paying data analyst jobs?
- We can use the top 10 highest-paying Data Analyst jobs from the first query
- We add the skills required for each of the 10 postings and the skill type so we can have clear idea of skills demanded in the top roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,helping job-seekers understand if they have the required skills 
  or do they need to learn and/or develop skills  that align with their targeted job posting
*/
WITH top_paying_jobs AS
(
    SELECT
    job_postings.job_id,
    job_postings.job_title,
    company.name AS company_name,
    job_postings.salary_year_avg AS avg_yearly_salary
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS company ON job_postings.company_id = company.company_id
WHERE
    job_title LIKE '%Data_Analyst%' -- If you want to check for other roles, make changes here
    AND job_location = 'Anywhere' -- If you want to have a specific job location, specify here
    AND salary_year_avg IS NOT NULL -- specify salary ranges and requirements here
ORDER BY
    salary_year_avg DESC
LIMIT 10
),
skills_req AS(
    SELECT 
        top_paying_jobs.job_id,
        top_paying_jobs.job_title,
        top_paying_jobs.company_name,
        top_paying_jobs.avg_yearly_salary,
        job_skills.skill_id
    FROM 
        top_paying_jobs
/* 
   - INNER JOIN used as we do not care about the jobs that do not require any 
   - If you do, use LEFT JOIN instead
*/
    INNER JOIN skills_job_dim AS job_skills ON top_paying_jobs.job_id = job_skills.job_id
)
SELECT
    skills_req.job_id,
    skills_req.job_title,
    skills_req.company_name,
    skills.skills AS skill_name,
    skills.type AS skill_type,
    skills_req.avg_yearly_salary
FROM 
    skills_dim AS skills
RIGHT JOIN skills_req ON skills.skill_id = skills_req.skill_id;

/*
1.Insights :

- The "Big Three": SQL (9 postings), Python (8 postings), and Tableau (6 postings) are the undisputed rulers of top-paying data analyst roles.

- The "Why": SQL is the universal language for extracting data, Python is the heavy lifter for analysis and automation, and Tableau is the bridge to communicate those findings to non-technical leaders.

- The Reality Check: If you are missing any of these three skills, you are automatically locked out of the vast majority of jobs paying over $180,000.

2.Skill Investment Stratergies: Volume vs. Niche Premiums

- The "Safe & Lucrative" Route : Look at Tableau. It is in very high demand and sits above the $200,000 average salary mark. It is the perfect blend of being widely needed and highly valued.

- The "Premium Niche" Route : Look at the very top left dots—Hadoop, Crystal, and Flow. These skills have incredibly low demand (only 1 posting each in this dataset). However, because these technologies are so difficult or niche, the companies that do need them are forced to pay astronomical premiums (up to $232,000) to find someone who knows them.

[
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "232423.0"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "232423.0"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skill_name": "r",
    "skill_type": "programming",
    "avg_yearly_salary": "232423.0"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skill_name": "hadoop",
    "skill_type": "libraries",
    "avg_yearly_salary": "232423.0"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skill_name": "tableau",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "232423.0"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "217000.0"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skill_name": "crystal",
    "skill_type": "programming",
    "avg_yearly_salary": "217000.0"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skill_name": "oracle",
    "skill_type": "cloud",
    "avg_yearly_salary": "217000.0"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skill_name": "tableau",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "217000.0"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skill_name": "flow",
    "skill_type": "other",
    "avg_yearly_salary": "217000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "go",
    "skill_type": "programming",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "snowflake",
    "skill_type": "cloud",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "pandas",
    "skill_type": "libraries",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "numpy",
    "skill_type": "libraries",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "excel",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "tableau",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skill_name": "gitlab",
    "skill_type": "other",
    "avg_yearly_salary": "205000.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "azure",
    "skill_type": "cloud",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "aws",
    "skill_type": "cloud",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "oracle",
    "skill_type": "cloud",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "snowflake",
    "skill_type": "cloud",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "tableau",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "power bi",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "sap",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "jenkins",
    "skill_type": "other",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "bitbucket",
    "skill_type": "other",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "atlassian",
    "skill_type": "other",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "jira",
    "skill_type": "async",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skill_name": "confluence",
    "skill_type": "async",
    "avg_yearly_salary": "189309.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "r",
    "skill_type": "programming",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "git",
    "skill_type": "other",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "bitbucket",
    "skill_type": "other",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "atlassian",
    "skill_type": "other",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "jira",
    "skill_type": "async",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skill_name": "confluence",
    "skill_type": "async",
    "avg_yearly_salary": "189000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "go",
    "skill_type": "programming",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "snowflake",
    "skill_type": "cloud",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "pandas",
    "skill_type": "libraries",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "numpy",
    "skill_type": "libraries",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "excel",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "tableau",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skill_name": "gitlab",
    "skill_type": "other",
    "avg_yearly_salary": "186000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "html",
    "skill_type": "programming",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "css",
    "skill_type": "programming",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "aws",
    "skill_type": "cloud",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "keras",
    "skill_type": "libraries",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "angular",
    "skill_type": "webframeworks",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "flask",
    "skill_type": "webframeworks",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "fastapi",
    "skill_type": "webframeworks",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 1638595,
    "job_title": "Senior Data Analyst",
    "company_name": "Patterned Learning AI",
    "skill_name": "windows",
    "skill_type": "os",
    "avg_yearly_salary": "185000.0"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "184000.0"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "184000.0"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "skill_name": "r",
    "skill_type": "programming",
    "avg_yearly_salary": "184000.0"
  },
  {
    "job_id": 813346,
    "job_title": "Senior Data Analyst, GTM (South Bay, CA or Remote)",
    "company_name": "Zoom Video Communications",
    "skill_name": "sql",
    "skill_type": "programming",
    "avg_yearly_salary": "181000.0"
  },
  {
    "job_id": 813346,
    "job_title": "Senior Data Analyst, GTM (South Bay, CA or Remote)",
    "company_name": "Zoom Video Communications",
    "skill_name": "python",
    "skill_type": "programming",
    "avg_yearly_salary": "181000.0"
  },
  {
    "job_id": 813346,
    "job_title": "Senior Data Analyst, GTM (South Bay, CA or Remote)",
    "company_name": "Zoom Video Communications",
    "skill_name": "r",
    "skill_type": "programming",
    "avg_yearly_salary": "181000.0"
  },
  {
    "job_id": 813346,
    "job_title": "Senior Data Analyst, GTM (South Bay, CA or Remote)",
    "company_name": "Zoom Video Communications",
    "skill_name": "tableau",
    "skill_type": "analyst_tools",
    "avg_yearly_salary": "181000.0"
  },
  {
    "job_id": 813346,
    "job_title": "Senior Data Analyst, GTM (South Bay, CA or Remote)",
    "company_name": "Zoom Video Communications",
    "skill_name": "jira",
    "skill_type": "async",
    "avg_yearly_salary": "181000.0"
  },
  {
    "job_id": 813346,
    "job_title": "Senior Data Analyst, GTM (South Bay, CA or Remote)",
    "company_name": "Zoom Video Communications",
    "skill_name": "zoom",
    "skill_type": "sync",
    "avg_yearly_salary": "181000.0"
  }
]
*/