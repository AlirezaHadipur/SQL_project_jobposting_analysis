**SQL Job Posting Analysis Project**

# Introduction 📢
Dive into the data job market! Focusing on several roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in roles.

You can see the queries here: [Click](Queries)🔍.
# Background 🔦
I attended a [SQL Toturial](https://www.youtube.com/watch?v=7mz73uXD9DA&t=12914s)
on YouTube from Luke Barousse as a part of my journey as a data analyst. My goal was to improve my knowledge about SQL and whatever I learned In university about SQL as a computer engineer.

## The questions I wanted to answer through my SQL queries were:
- What are the top-paying data analyst jobs?
- What skills are required for these top-paying jobs?
- What skills are most in demand for data analysts?
- Which skills are associated with higher salaries?
- What are the most optimal skills to learn?
# Tools I Used 🛠⚒
Throughout this project, I used different tools to work easier and more efficiently:

**SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.

**PostgreSQL :** The chosen database management system(DBMS), it's free and powerful.

**Visual Studio Code:** My code editor, I connected VSCode to PostgreSQL by extensions.

**Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

**ChatGPT:** Getting useful insights from the result of queries and visualizing.

**Microsoft Copilot:** Getting useful insights from the result of queries and visualizing.

# The Analysis
Each query for this project aimed to investigate specific aspects of the different roles job market(especially data analysis). Here’s how I approached each question:

## 1. Top Paying Data Analyst Jobs
To identify the top 10 highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high-paying opportunities in the field.

```SQL
SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    job_work_from_home,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id 
    
WHERE
    salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
**Key insights:**

    1. Salary Ranges:
    The average annual salaries for these data analyst roles vary significantly:
    Data Analyst: Around $650,0001.
    Director of Analytics: Approximately $336,5002.
    Associate Director-Data Insights: An average of $255,829.53.

    2. Work Flexibility:
    All the listed positions offer full-time employment.
    Notably, they also allow remote work (with the “job_work_from_home” attribute set to true).
    This trend reflects the growing acceptance of remote work arrangements, providing data analysts with flexibility and work-life balance.

    3. Job Postings Timeline:
    The posting dates for these roles span across different months in 2023:
    Data Analyst: Posted on February 20, 20231.
    Director of Analytics: Posted on August 23, 20232.
    Associate Director-Data Insights: Posted on June 18, 20233.
    Analyzing the timing of job postings can reveal seasonal trends or industry-specific hiring cycles.

    by: Microsoft Copilot



## 2. Skills for Top Paying Jobs
To understand what skills are required for top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```SQL
WITH top_paying_jobs AS(
    SELECT job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg,
        job_posted_date
    FROM job_postings_fact
        LEFT JOIN company_dim ON 
        job_postings_fact.company_id = company_dim.company_id
    WHERE salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    ORDER BY salary_year_avg DESC
    LIMIT 10
),
job_to_skill AS(
    SELECT job_id,
        skills_dim.skill_id,
        skills,
        type AS job_type
    FROM skills_job_dim
        INNER JOIN skills_dim ON 
        skills_dim.skill_id = skills_job_dim.skill_id
)
SELECT top_paying_jobs.*, skills
FROM top_paying_jobs
    INNER JOIN job_to_skill ON 
    top_paying_jobs.job_id = job_to_skill.job_id
```
**Key insights:**

- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```SQL
WITH JOB_TO_SKILL AS
	(SELECT SKILLS_JOB_DIM.SKILL_ID,
			SKILLS,
			JOB_ID
		FROM SKILLS_JOB_DIM
		INNER JOIN SKILLS_DIM ON SKILLS_JOB_DIM.SKILL_ID = SKILLS_DIM.SKILL_ID
  )
  
SELECT SKILL_ID,
	SKILLS,
	JOB_TITLE_SHORT AS JOB_TITLE,
	COUNT(JOB_POSTINGS_FACT.job_id) AS NUMBER_OF_JOBS
FROM JOB_TO_SKILL
INNER JOIN JOB_POSTINGS_FACT ON JOB_TO_SKILL.JOB_ID = JOB_POSTINGS_FACT.JOB_ID
WHERE JOB_TITLE_SHORT='Data Analyst'
GROUP BY
	SKILL_ID, SKILLS, JOB_TITLE_SHORT
ORDER BY
	NUMBER_OF_JOBS DESC
```
**key insights:**

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```SQL
WITH JOB_TO_SKILL AS
	(SELECT SKILLS_JOB_DIM.SKILL_ID,
			SKILLS,
			JOB_ID
		FROM SKILLS_JOB_DIM
		INNER JOIN SKILLS_DIM ON SKILLS_JOB_DIM.SKILL_ID = SKILLS_DIM.SKILL_ID
  )
  
SELECT
	SKILLS,
	ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM JOB_TO_SKILL
INNER JOIN JOB_POSTINGS_FACT ON JOB_TO_SKILL.JOB_ID = JOB_POSTINGS_FACT.JOB_ID
WHERE salary_year_avg IS NOT NULL
AND JOB_TITLE_SHORT = 'Data Analyst' AND job_work_from_home = TRUE 
GROUP BY
	SKILL_ID, SKILLS
ORDER BY
	average_salary DESC
LIMIT 25
```
**Key insights:**

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```SQL
WITH JOB_TO_SKILL AS
	(SELECT SKILLS_JOB_DIM.SKILL_ID,
			SKILLS,
			JOB_ID
		FROM SKILLS_JOB_DIM
		INNER JOIN SKILLS_DIM ON SKILLS_JOB_DIM.SKILL_ID = SKILLS_DIM.SKILL_ID
  )
  
SELECT
	SKILLS,
	ROUND(AVG(salary_year_avg), 0) AS average_salary,
    COUNT(JOB_POSTINGS_FACT.job_id) AS demand
FROM JOB_TO_SKILL
INNER JOIN JOB_POSTINGS_FACT ON JOB_TO_SKILL.JOB_ID = JOB_POSTINGS_FACT.JOB_ID
WHERE salary_year_avg IS NOT NULL
AND JOB_TITLE_SHORT = 'Data Analyst' AND job_work_from_home = TRUE 
GROUP BY
	SKILL_ID, SKILLS
ORDER BY
	demand DESC, average_salary 
LIMIT 25
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analysts sorted by salary*

**Key insights:**

- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned 💡
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables, and getting familiar with temp tables.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions 📕
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics. 

On the other hand, it was a great chance for me to learn SQL in practice and also how to document my work to be more clear for others.


Thanks to Luke Barousse for his amazing [SQL Tutorial](https://www.youtube.com/watch?v=7mz73uXD9DA&t=12914s). I took help from Luke for this documentation.
