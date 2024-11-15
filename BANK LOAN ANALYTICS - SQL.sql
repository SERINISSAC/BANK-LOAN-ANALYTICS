select * from finance_1;
select * from finance_2;

-- KPI 1
select year(issue_d) as Year_loan_issue , concat("$"," ",round((sum(loan_amnt))/1000000,0)," ","millions") as Loan_amount from finance_1
group by Year_loan_issue
order by Year_loan_issue;

-- KPI 2
select f1.grade, f1.sub_grade, concat("$", round((sum(f2.revol_bal)/1000000),2), " ", "millions") as revol_balance from finance_1 f1 inner join finance_2 f2
using (id)
group by f1.grade, f1.sub_grade
order by f1.grade;

-- KPI 3
select f1.verification_status, concat("$"," ",round((sum(f2.total_pymnt)/1000000),0)," ", "millions") as total_payment from finance_1 f1 inner join finance_2 f2
using(id) where verification_status not in ("Source Verified")
group by f1.verification_status;

-- KPI 4
with cte as
(select addr_state,  month(issue_d) as month_no, monthname(issue_d) as month_n, loan_status, count(loan_status) as count_loan from finance_1
group by addr_state, month_no, month_n, loan_status 
order by addr_state)
select addr_state, month_n, loan_status, count_loan from cte  ;

-- KPI 5
select  left(f2.last_pymnt_d,4) as paymnt_yr,f1.home_ownership , count(f2.last_pymnt_d) as count_paymnt  from finance_1 f1 inner join finance_2 f2
using(id) 
group by paymnt_yr, f1.home_ownership
order by paymnt_yr desc;



 