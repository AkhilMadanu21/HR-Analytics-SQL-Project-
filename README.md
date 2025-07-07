# HR-Analytics-SQL-Project-

![analytics-1030x618](https://github.com/user-attachments/assets/f868ac39-5b31-4a62-b224-def03c3b61c2)

This project explores a synthetic HR dataset using **advanced SQL techniques** to answer 20 real-world HR business questions. The goal is to uncover insights on employee attrition, performance, salary, tenure, and promotion trends.


## 📌 Problem Statement

Companies often face challenges in understanding workforce patterns and retention risks. The goal of this project is to perform SQL-based analysis on an HR dataset to extract valuable insights that can inform HR policies and decision-making.

---

## 🛠️ Tools & Techniques Used

- **SQL (MySQL)**
- **Window Functions**
- **Common Table Expressions (CTEs)**
- **Aggregate & Conditional Functions**
- **Date Functions**

---

## 📂 Dataset Overview

The dataset contains 300+ synthetic employee records with attributes such as:

- `employee_id`, `name`, `department`, `job_role`
- `salary`, `performance_rating`, `attrition`
- `hire_date`, `last_promotion_date`, `age`, `location`, `education_level`

---

## 🔍 Key Business Questions Solved

## 1. What is the attrition rate per department?
```sql
select department,
count(*) as total_emp,
count(case when attrition = 'Yes' then 1 end) as attrition_count,
(count(case when attrition = 'Yes' then 1 end)*100.0)/count(*) as attrition_percentage 
from hr_data
group by department;

```

## Output:
<img width="362" alt="image" src="https://github.com/user-attachments/assets/216eed75-9fa1-44a6-b290-c2270642fa3c" />


## 2. Which employees earn more than their department’s average salary?
```sql
with deptsal as 
(select department,avg(salary) as AvgSalary
from hr_data
group by department)
select e.name,e.department,e.salary
from hr_data as e
join deptsal as d on e.department = d.department
where e.salary > d.AvgSalary;
```

## Output:
<img width="235" alt="image" src="https://github.com/user-attachments/assets/ccc830a1-5bd0-422d-8c0b-af66ca70905d" />
<img width="235" alt="image" src="https://github.com/user-attachments/assets/147dc16b-994d-4477-b798-a2e270cee544" />
<img width="235" alt="image" src="https://github.com/user-attachments/assets/89e3c6b3-2320-48c4-a962-dba96cbc2c0a" />
<img width="235" alt="image" src="https://github.com/user-attachments/assets/9cdbbbba-d012-4267-a0dd-c0eb4d8c8a04" />
<img width="235" alt="image" src="https://github.com/user-attachments/assets/211ac87a-ff16-40ca-9a7d-faafe130791f" />


## 3. What is the current active headcount by location and department?
```sql
select location,department,count(attrition) as Active_emp
from hr_data
where attrition = 'No'
group by location,department;
```

## Output:
<img width="212" alt="image" src="https://github.com/user-attachments/assets/e015a3d7-21d4-4f49-b4bc-55e591822385" />


## 4. Which departments have the highest average salary?
```sql
select department,round(avg(salary),0)  AvgSalary
from hr_data
group by department
order by AvgSalary desc
limit 3;

```

## Output:
<img width="131" alt="image" src="https://github.com/user-attachments/assets/3a577ab8-2e68-4685-b0a3-725ffb4e971c" />


## 5. Which job roles have the highest attrition count?
```sql
select job_role,count(attrition) as Attrition_count
from hr_data
where attrition = 'No'
group by job_role
order by Attrition_count;
```

## Output:
<img width="192" alt="image" src="https://github.com/user-attachments/assets/5bfc4edf-b909-4b58-abdb-21045791061f" />


## 6. List employees who haven’t been promoted in the last 3 years.
```sql
select name,year(last_promotion_date) Yearofpromotion
from hr_data
where year(last_promotion_date) not in (2023,2024,2025)
order by Yearofpromotion;
```

## Output:
<img width="222" alt="image" src="https://github.com/user-attachments/assets/8ab4d05e-939d-40d2-86e7-666795ff5268" />
<img width="222" alt="image" src="https://github.com/user-attachments/assets/45406404-2bd7-4a6d-aeb2-4c3529fb1f4e" />
<img width="222" alt="image" src="https://github.com/user-attachments/assets/c6d1ec3d-f37f-4d2b-9888-39baba30f337" />
<img width="222" alt="image" src="https://github.com/user-attachments/assets/d0537ecf-b995-4b30-ae0a-a29d97c5362e" />




## 7. Who are the top 3 earners in each department?
```sql
WITH ranked_salaries AS (
    SELECT 
        department,
        name AS top_earners,
        salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank
    FROM hr_data
)
SELECT *
FROM ranked_salaries
WHERE dept_salary_rank <= 3;
```

## Output:
<img width="327" alt="image" src="https://github.com/user-attachments/assets/3bf3a915-3b54-4787-b4bf-4b63b538fb83" />
<img width="327" alt="image" src="https://github.com/user-attachments/assets/87414e9d-ecd4-4b7e-b390-2f94576a2c85" />



## 8. Which employees had low performance ratings and also left?
```sql
select name as Low_Performers,performance_rating,attrition
from hr_data
where performance_rating < 3 and attrition = 'Yes';
```

## Output:
<img width="308" alt="image" src="https://github.com/user-attachments/assets/e78c9471-05e5-4d58-ba59-31705f41e5b9" />


## 9. What is the average performance rating per department?
```sql
select department,round(avg(performance_rating),1) as AvgRating
from hr_data
group by department;

```

## Output:
<img width="134" alt="image" src="https://github.com/user-attachments/assets/3907be47-975c-4683-871f-eede7730a9d2" />


## 10. Which departments have the highest proportion of high performers?
```sql
select department,performance_rating,count(*) as performers,
count(*)*1.0/sum(count(*)) over(order by performance_rating desc) as Proportion
from hr_data
where performance_rating > 3
group by department,performance_rating;
```

## Output:
<img width="330" alt="image" src="https://github.com/user-attachments/assets/8b279dcb-041a-4b08-b52a-7fe76008e10c" />


## 11. How many years has each employee worked in the company?
```sql
select name,round(datediff(curdate(),hire_date)/365,0) as years_emp_worked 
from hr_data 
order by years_emp_worked desc;

```

## Output:
<img width="226" alt="image" src="https://github.com/user-attachments/assets/c4920942-c6de-4f67-8874-ee90ae018996" />
<img width="226" alt="image" src="https://github.com/user-attachments/assets/bc2bc5f9-b89d-41de-81a6-d9a88c3ef891" />
<img width="226" alt="image" src="https://github.com/user-attachments/assets/3cb8a06d-c06d-49f9-8998-4681ffeb0d12" />
<img width="226" alt="image" src="https://github.com/user-attachments/assets/adddcf6a-9aea-477c-af83-f468c3678f60" />


## 12. Group employees into tenure buckets: `<1`, `1–3`, `3–5`, `5+` years.
```sql
select name,round(datediff(curdate(),hire_date)/365,0) as Experience,(case when round(datediff(curdate(),hire_date)/365,0) > 5 then '5+ years'
                   when round(datediff(curdate(),hire_date)/365,0) between 3 and 5 then '3-5 years'
                    when round(datediff(curdate(),hire_date)/365,0) between 1 and 3 then '1-3 years'
                     when round(datediff(curdate(),hire_date)/365,0) < 1 then ' < 1 year' end) as emp_tenure
from hr_data
order by Experience desc;
```

## Output:
<img width="251" alt="image" src="https://github.com/user-attachments/assets/15b5c093-f39b-417f-98ad-f975eecfedae" />
<img width="251" alt="image" src="https://github.com/user-attachments/assets/9ca55cb4-7f55-491e-8df4-df90ba18e667" />
<img width="251" alt="image" src="https://github.com/user-attachments/assets/5772adf5-c45a-4040-98f4-57b76225fc7c" />
<img width="251" alt="image" src="https://github.com/user-attachments/assets/7135c2b0-0f70-4a47-954d-4c013008bec2" />


## 13. What is the average tenure per department?
```sql
with tenure as (
select department,round(datediff(curdate(),hire_date)/365,0) as experience
from hr_data )
select department,round(Avg(experience),2) as Avg_emp_tenure 
from tenure 
group by department;
```

## Output:
<img width="170" alt="image" src="https://github.com/user-attachments/assets/db003988-f458-4bef-a91a-729e5d1f89c3" />


## 14. How many employees were hired monthly in the last 2 years?
```sql
select monthname(hire_date) as  Month, date_format(hire_date,'%Y-%m') as Date ,count(*) employees
from hr_data
where date_format(hire_date,'%Y-%m') between '2023-01' and '2025-12'
group by Month,Date
order by Date desc;

```

## Output:
<img width="183" alt="image" src="https://github.com/user-attachments/assets/dc6ba2b0-86a8-49f7-9c81-05bfcda97949" />
<img width="183" alt="image" src="https://github.com/user-attachments/assets/37e61ec6-4339-4fae-a759-e56b70421231" />


## 15. Who has completed more than 5 years in the organization?
```sql
select name,round(datediff(curdate(),hire_date)/365,0) as Years_completed
from hr_data
where round(datediff(curdate(),hire_date)/365,0) > 5
order by Years_completed;
```
## Output:
<img width="216" alt="image" src="https://github.com/user-attachments/assets/8b6b8889-88d5-4fd5-a9a7-0e6ec973874a" />

## 16. Which department has the highest attrition rate?
```sql
with attritioncount as
(select department,count(*) as employees,
count(case when attrition = 'Yes' then 1  end) as Attrition
from hr_data
group by department)
select department,round((Attrition/employees)*100,1) as AttritionRate
from attritioncount
order by AttritionRate  desc
limit 1 ;


```

## Output:
<img width="143" alt="image" src="https://github.com/user-attachments/assets/a28d161d-fa49-4260-b6f1-039a1da774b8" />


## 17. What percentage of employees were promoted in the last 2 years?
```sql
with promotion as 
(select year(last_promotion_date) as Promotion_date,count(employee_id) as Employees
from hr_data
group by year(last_promotion_date))
select Promotion_date,round((sum(Employees)/300)*100,1) as " %ofEmp_Promoted "
from promotion
where Promotion_date between '2023' and '2025'
group by Promotion_date
order by Promotion_date ;

```

## Output:
<img width="231" alt="image" src="https://github.com/user-attachments/assets/6d0ffe3c-d2cd-4ab3-81b3-ab82c55cf307" />


## 18. What is the most common education level among those who left?
```sql
select education_level,attrition,count(*) as Emp_left
from hr_data
where attrition = 'Yes'
group by  education_level
order by  Emp_left desc
limit 1;


```

## Output:
<img width="216" alt="image" src="https://github.com/user-attachments/assets/1dda004f-7e86-443e-b675-10fccb540b81" />


## 19. Identify “at-risk” employees (low performance, no promotion, specific age criteria).
```sql
select name,performance_rating,year(last_promotion_date) as year,age
from hr_data
where performance_rating < 3 and
year(last_promotion_date) not between '2023' and '2025' 
and age between '30' and '50';
```

## Output:
<img width="328" alt="image" src="https://github.com/user-attachments/assets/45c38836-07c0-402e-8ad4-2bd4bb503589" />


## 20. What percentage of each department’s employees are “at-risk”?
```sql
with percentage as 
(select department,count(*) as total_employees,
count(case when performance_rating < 3 then 1 end) as at_risk
from hr_data 
group by department)
select department,total_employees,at_risk,
round((at_risk*100/total_employees),1) as risk_percent
from percentage
order by risk_percent desc;
```

## 📈 Output:
<img width="308" alt="image" src="https://github.com/user-attachments/assets/8bc47969-3df8-4c16-91cd-733fe4668396" />



The project consists of 20 SQL queries with structured output addressing the business questions above. These can be extended into a Power BI dashboard for further visualization.

---

## 📎 File Structure

| File Name            | Description                                 |
|----------------------|---------------------------------------------|
| `hr_analytics.sql`   | All 20 SQL queries used in this analysis    |
| `README.md`          | Project documentation                       |
| `hr_analytics_dataset.csv` (optional) | Dataset used for analysis       |

---

## 💡 Learnings

- Gained hands-on experience writing optimized SQL queries
- Learned to translate real-world HR problems into SQL-based solutions
- Practiced using analytical functions like `RANK()`, `ROW_NUMBER()`, `CASE`, and `DATEDIFF()`
- Improved skills in calculating attrition, tenure, and performance segmentation

---

## 🔗 Connect with Me

If you liked this project or have feedback, feel free to connect:

- 💼 LinkedIn: [https://www.linkedin.com/in/akhil-madanu/]
- 📧 Email: [akhilmadanu21@gmail.com]

---

⭐ *If you found this project useful, don’t forget to give it a star on GitHub!*
