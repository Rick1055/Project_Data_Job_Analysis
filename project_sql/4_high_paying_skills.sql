/*
Question: What are the top skills based on salary?
- Identifies the top skills based on the salary provided for the Data Analyst position
- Focuses on roles w.r.t salary rather than location
- Why? It reveals how different skills affect the salary levels for different positions and helps identify the most financially rewarding skills to acquire
    or improve.
*/

WITH high_paying_skills AS
(
    SELECT
        job_skills.skill_id,
        ROUND(AVG(job_postings.salary_year_avg),0) AS skill_salary
    FROM 
        job_postings_fact AS job_postings
    LEFT JOIN skills_job_dim AS job_skills ON job_skills.job_id = job_postings.job_id
    WHERE 
        job_postings.salary_year_avg IS NOT NULL
        AND job_postings.job_title_short = 'Data Analyst' -- Change as per your job requirements 
    GROUP BY
        job_skills.skill_id
    HAVING
        COUNT(job_postings.job_id) > 10
        AND job_skills.skill_id IS NOT NULL
)

SELECT
    high_paying_skills.skill_id,
    skills.skills AS skill_name,
    high_paying_skills.skill_salary
FROM
    high_paying_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = high_paying_skills.skill_id
ORDER BY
    high_paying_skills.skill_salary DESC
LIMIT 10;

/* 
It feels wrong because SQL is everywhere, but you are witnessing the classic difference between "Most In-Demand" and "Highest Paying." Here is exactly why your results look like that:
1. SQL is "Table Stakes" (High Supply)
  - SQL is the absolute foundation of working with data. Almost every single data professional knows it. Because the supply of people who know SQL is so incredibly high, companies don't have to pay a massive premium to hire someone with that skill. 
  - It is expected that you know it just to get in the door.
2. Kafka is a Premium Specialization (Low Supply, High Complexity)
  -Kafka is an advanced, distributed event streaming platform used to handle massive pipelines of real-time data (think Uber matching riders in real-time or Netflix tracking millions of clicks).
  -As you dive deeper into Data Science, you'll see that transitioning from analyzing static CSVs to engineering real-time data streams requires a much steeper learning curve. The companies that need Kafka are usually massive tech enterprises dealing with Big Data, and there are far fewer analysts and engineers who know how to use it. Therefore, those companies have to pay top dollar to attract that talent.
   The Golden Rule of Tech Salaries

High Demand + High Supply (SQL, Excel): Lots of jobs, but average pay.
Moderate Demand + Low Supply (Kafka, PySpark, Snowflake): Fewer jobs, but massive salaries.

Despite of all this SQL remains crucial for job oppurtunities when it comes to the sheer volume of jobs.

[
  {
    "skill_id": 98,
    "skill_name": "kafka",
    "skill_salary": "129999"
  },
  {
    "skill_id": 101,
    "skill_name": "pytorch",
    "skill_salary": "125226"
  },
  {
    "skill_id": 31,
    "skill_name": "perl",
    "skill_salary": "124686"
  },
  {
    "skill_id": 99,
    "skill_name": "tensorflow",
    "skill_salary": "120647"
  },
  {
    "skill_id": 63,
    "skill_name": "cassandra",
    "skill_salary": "118407"
  },
  {
    "skill_id": 219,
    "skill_name": "atlassian",
    "skill_salary": "117966"
  },
  {
    "skill_id": 96,
    "skill_name": "airflow",
    "skill_salary": "116387"
  },
  {
    "skill_id": 3,
    "skill_name": "scala",
    "skill_salary": "115480"
  },
  {
    "skill_id": 169,
    "skill_name": "linux",
    "skill_salary": "114883"
  },
  {
    "skill_id": 234,
    "skill_name": "confluence",
    "skill_salary": "114153"
  }
]
*/