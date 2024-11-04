use `bankloandb`;
Select * from finance_1;
Select * from finance_2;

-- Total Loan Apllication -- (KPI_1)
select concat(round(count(id)/1000),"k") as Total_Loan_Application from finance_1;

-- Total_Funded_Amount -- (KPI_2)
Select concat("$",round(sum(loan_amnt)/1000000,2),"M") as Total_Funded_Amount from finance_1;

-- Total_Received_Amount -- (KPI_3)
Select concat("$",round(sum(total_pymnt)/1000000,2),"M") as Total_Received_Amount from finance_2;

-- Average_interest_Rate -- ( kpi_4)
select concat(round(avg(int_rate)/100,2),"%") as Average_Interest_Rate from finance_1;

 -- YEAR WISE LOAN AMOUNT-- (KPI_5)
 Select year(issue_d) as Year_of_issue_d, sum(loan_amnt) as Total_loan_amnt 
from finance_1 
group by Year_of_issue_d 
order by Year_of_issue_d ;

-- Grade & Sub-Grade wise Revol_bal -- (KPI_6)
SELECT grade,sub_grade, sum(revol_bal) as Total_Revol_bal
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by Grade, sub_grade
order by Grade, sub_grade;
 
-- Total Payment for Verified Status vs Non Verified Status -- (KPI_7)
Select verification_status, 
concat("$", format(round(sum(total_pymnt)/1000000,2),2),"M") as Total_Payment

from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by verification_status
order by verification_status;

-- State wise & Month wise Loan Status -- (KPI_8)
Select addr_state,issue_d,loan_status
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by addr_state,issue_d,loan_status
order by addr_state;

-- Home_Ownership vs Last Payment Date Status -- (KPI_9)
select home_ownership,last_pymnt_amnt,
concat("$", format(round(sum(last_pymnt_amnt)/10000,2),2),"k") as Total_amount
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by home_ownership,last_pymnt_amnt
order by last_pymnt_amnt desc,home_ownership desc;