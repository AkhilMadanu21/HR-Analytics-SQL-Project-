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

1. What is the attrition rate per department?
2. Which employees earn more than their department’s average salary?
3. What is the current active headcount by location and department?
4. Which departments have the highest average salary?
5. Which job roles have the highest attrition count?
6. List employees who haven’t been promoted in the last 3 years.
7. Who are the top 3 earners in each department?
8. Which employees had low performance ratings and also left?
9. What is the average performance rating per department?
10. Which departments have the highest proportion of high performers?
11. How many years has each employee worked in the company?
12. Group employees into tenure buckets: `<1`, `1–3`, `3–5`, `5+` years.
13. What is the average tenure per department?
14. How many employees were hired monthly in the last 2 years?
15. Who has completed more than 5 years in the organization?
16. Which department has the highest attrition rate?
17. What percentage of employees were promoted in the last 2 years?
18. What is the most common education level among those who left?
19. Identify “at-risk” employees (low performance, no promotion, specific age criteria).
20. What percentage of each department’s employees are “at-risk”?

---

## 📈 Output:


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
