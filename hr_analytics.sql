use Hr_analytics;
select * from hr_data;


#1.	What is the attrition rate per department as a percentage of department size?

select department,
count(*) as total_emp,
count(case when attrition = 'Yes' then 1 end) as attrition_count,
(count(case when attrition = 'Yes' then 1 end)*100.0)/count(*) as attrition_percentage 
from hr_data
group by department;


#2.	Which employees earn more than their department’s average salary?\
with deptsal as 
(select department,avg(salary) as AvgSalary
from hr_data
group by department)
select e.name,e.department,e.salary
from hr_data as e
join deptsal as d on e.department = d.department
where e.salary > d.AvgSalary;


#3.	What is the current active headcount by location and department?
select location,department,count(attrition) as Active_emp
from hr_data
where attrition = 'No'
group by location,department;


#4.	Which departments have the highest average salary?
select department,round(avg(salary),0)  AvgSalary
from hr_data
group by department
order by AvgSalary desc
limit 3;



#5.	Which job roles have the highest attrition count?
select job_role,count(attrition) as Attrition_count
from hr_data
where attrition = 'No'
group by job_role
order by Attrition_count;


#6.	List employees who haven’t been promoted in the last 3 years.
select name,year(last_promotion_date) Yearofpromotion
from hr_data
where year(last_promotion_date) not in (2023,2024,2025)
order by Yearofpromotion;




#7.	Who are the top 3 earners in each department?

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



#8.	Which employees had low performance ratings (less than 3) and have also left the company?
select name as Low_Performers,performance_rating,attrition
from hr_data
where performance_rating < 3 and attrition = 'Yes';


#9.	What is the average performance rating per department?
select department,round(avg(performance_rating),1) as AvgRating
from hr_data
group by department;



#10. Which departments have the highest proportion of high performers (rating 4 or 5)?
select department,performance_rating,count(*) as performers,
count(*)*1.0/sum(count(*)) over(order by performance_rating desc) as Proportion
from hr_data
where performance_rating > 3
group by department,performance_rating;



#11. How many years has each employee worked in the company (rounded)?
select name,round(datediff(curdate(),hire_date)/365,0) as years_emp_worked 
from hr_data 
order by years_emp_worked desc;



#12. Group employees into tenure buckets: <1 Year, 1–3 Years, 3–5 Years, 5+ Years.

select name,round(datediff(curdate(),hire_date)/365,0) as Experience,(case when round(datediff(curdate(),hire_date)/365,0) > 5 then '5+ years'
                   when round(datediff(curdate(),hire_date)/365,0) between 3 and 5 then '3-5 years'
                    when round(datediff(curdate(),hire_date)/365,0) between 1 and 3 then '1-3 years'
                     when round(datediff(curdate(),hire_date)/365,0) < 1 then ' < 1 year' end) as emp_tenure
from hr_data
order by Experience desc;




#13. What is the average employee tenure per department?
with tenure as (
select department,round(datediff(curdate(),hire_date)/365,0) as experience
from hr_data )
select department,round(Avg(experience),2) as Avg_emp_tenure 
from tenure 
group by department;



#14. How many employees were hired each month in the last 2 years?
select monthname(hire_date) as  Month, date_format(hire_date,'%Y-%m') as Date ,count(*)
from hr_data
where date_format(hire_date,'%Y-%m') between '2023-01' and '2025-12'
group by Month,Date
order by Date desc;


#15. How many employees have completed more than 5 years in the organization?
select name,round(datediff(curdate(),hire_date)/365,0) as Years_completed
from hr_data
where round(datediff(curdate(),hire_date)/365,0) > 5
order by Years_completed;




#16. Which department has the highest attrition rate?

with attritioncount as
(select department,count(*) as employees,
count(case when attrition = 'Yes' then 1  end) as Attrition
from hr_data
group by department)
select department,round((Attrition/employees)*100,1) as AttritionRate
from attritioncount
order by AttritionRate  desc
limit 1 ;


#17. What is the percentage of employees promoted in the last 2 years?
with promotion as 
(select year(last_promotion_date) as Promotion_date,count(employee_id) as Employees
from hr_data
group by year(last_promotion_date))
select Promotion_date,round((sum(Employees)/300)*100,1) as " %ofEmp_Promoted "
from promotion
where Promotion_date between '2023' and '2025'
group by Promotion_date
order by Promotion_date ;




#18. What is the most common education level among employees who left?
select education_level,attrition,count(*) as Emp_left
from hr_data
where attrition = 'Yes'
group by  education_level
order by  Emp_left desc
limit 1;



#19.	Create a list of “at-risk” employees based on:Performance < 3,No promotion in 3 years ,Age < 30 or > 50

select name,performance_rating,year(last_promotion_date) as year,age
from hr_data
where performance_rating < 3 and
year(last_promotion_date) not between '2023' and '2025' 
and age between '30' and '50';



#20. What percentage of each department’s employees are “at-risk”?
with percentage as 
(select department,count(*) as total_employees,
count(case when performance_rating < 3 then 1 end) as at_risk
from hr_data 
group by department)
select department,total_employees,at_risk,
round((at_risk*100/total_employees),1) as risk_percent
from percentage
order by risk_percent desc;

