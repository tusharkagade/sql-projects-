use uddanous;
select * from churn_modelling;
-- How many total customers are there?
select count(*) from churn_modelling;

-- What is the churn rate (percentage of customers who stayed  and who exited  )
select exited,round(count(exited) / (select count(exited) from churn_modelling)*100,2) as churn_rate from churn_modelling
group by exited;

-- How many customers are active vs inactive?
select isactivemember,count(isactivemember) as total_members from churn_modelling 
group by isactivemember;

-- 	What's the average balance and salary by geography?
select geography,round(avg(balance),2) as average_balance,round(avg(estimatedsalary),2) as avg_salary from churn_modelling
group by geography;

-- How many customers have credit cards vs don’t?
select hascrcard,count(hascrcard) as total_members from churn_modelling
group by hascrcard;

-- What is the average credit score by churn status?
select * from churn_modelling;
select exited,round(avg(creditscore),2) as average_credit_score from churn_modelling
group by exited;

-- Which age group has the highest churn rate?
select 
  case 
      when age < 30 then "Under 30"
      when age between 30 and 50 then "30 - 50"
      else "Over_50"
      end as age_group,
      count(*) as total_customers,
      sum(exited) as churned_customers,
	  round(100.0 * sum(exited)/count(*),2) as churn_rate_percentage
from churn_modelling 
group by 
    case 
       when age < 30 then "Under 30"
       when age between 30 and 50 then "30 - 50"
       else "Over_50"
	end;


-- Top 5 most common surnames among exited customers?
select surname,count(*) as total_customers from churn_modelling
where exited = 1
group by surname
order by total_customers desc 
limit 5;

-- Problem: Identify key customer segments to target for retention campaigns.
select geography,age,count(*) as total_customers,
sum(case when exited = 1 then 1 else 0 end) as churned_customers
from churn_modelling
group by geography,age
order by churned_customers desc;


-- Problem: Which behaviors indicate high risk of churn?
select isactivemember, numofproducts, round(avg(creditscore),2)  as avgcreditscore,
sum(case when exited = 1 then 1 else 0 end) as churned
from churn_modelling
group by isactivemember, NumOfProducts;

--  KPI Dashboard Metrics (Churn Rate, Average Balance, etc.)
select count(*) as total_customers,
sum(case when exited = 1 then 1 else 0 end) as total_churned,
round(sum(case when exited = 1 then 1 else 0 end) * 100.0 / count(*),2) as churn_rate_percent,
round(avg(balance),2) as avg_balance,
round(avg(estimatedsalary),2) as avg_salary 
from churn_modelling;

-- Problem: Are there churn patterns across regions or between men and women?
select geography,gender,count(*) as total,round(sum(case when exited = 1 then 1 else 0 end) * 100.0 / count(*),2) as churn_rate 
from churn_modelling
group by geography,gender 
order by churn_rate desc;

-- Estimate potential revenue lost due to customer churn.
select 
    round(sum(case when exited = 1 then estimatedsalary else 0 end),2) as lost_salary_estimated,
    round(avg(case when exited = 1 then estimatedsalary else null end),2) as avg_salary_churned,
    round(avg(case when exited = 0 then estimatedsalary else null end),2) as avg_salary_retained 
from churn_modelling;

-- Create a View for Reuse
create view churn_summary_by_geog as 
select 
     geography, count(*) as total_customers,
     sum(case when exited = 1 then 1 else 0 end) as churned_customers,
     round(100.0 * sum(case when exited = 1 then 1 else 0 end) / count(*),2) as churn_rate 
from churn_modelling
group by geography;

     