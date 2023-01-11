
-- query 1       
select hall1.security_level, Contract.customer_national_id, safebox1.safebox_id
    from Contract, SafeBox as safebox1, Hall as hall1
    where Contract.safebox_id = safebox1.safebox_id
        and safebox1.hall_floor = hall1.floor;


-- query 2
select safebox_id, ((SafeBox.price_class * 3 * 30) - (select TimePlan.discount from TimePlan where TimePlan.duration = 3)) as SafeBoxRentCost -- month = 3
    from SafeBox, Hall
    where hall_floor = floor and Hall.security_level = 2;   



-- query 3
select round(avg(Customer.age), 2)
    from Customer, SafeBox, Contract, Expiration
    where Customer.is_commercial = 1
        and Customer.business_plan_id = 2  -- plan_id     
        and (Customer.national_id = Contract.customer_national_id and Contract.safebox_id = SafeBox.safebox_id)
        or (Customer.national_id = Expiration.customer_national_id and Expiration.safebox_id = SafeBox.safebox_id)
        and SafeBox.hall_floor = 1; -- room_id


-- query 4
select Employee.national_id, Employee.first_name, Employee.last_name, Employee.salary
    from Employee, Hall
    where Employee.is_responsible = 1 and
    Employee.national_id = Hall.employee_national_id and
    Hall.security_level >= 2 and Hall.security_level <= 4
    ORDER BY RAND();

-- query 5
select distinct SafeBox.safebox_id, SafeBox.hall_floor
    from SafeBox, Hall, Contract  
    where SafeBox.hall_floor = Hall.floor
    and Hall.security_level = 2 -- security_level
    and SafeBox.safebox_id in (select SafeBox.safebox_id from SafeBox where (SafeBox.price_class * 30 * 3) < 200) -- max_price = 200
    and SafeBox.safebox_id not in (select Contract.safebox_id from Contract);


-- query 6
select CASE
    when (select sum(balance) as userCredit from `Account` where Account.national_id = "20") >= ((select min(price_class) FROM `SafeBox`, Hall where SafeBox.hall_floor = Hall.floor AND Hall.security_level = 2) * 360 - (select discount from `TimePlan` where duration = 12)) - (select case when EXISTS(select * from Customer where Customer.is_commercial = 1 and Customer.national_id = "20") then (select discount from `BusinessPlan`, Customer where BusinessPlan.business_plan_id = Customer.business_plan_id and Customer.national_id = "20") else 0 end as business_discount)                                                      
        then 12                                                                                      
    when (select sum(balance) as userCredit from `Account` where Account.national_id = "20") >= ((select min(price_class) FROM `SafeBox`, Hall where SafeBox.hall_floor = Hall.floor AND Hall.security_level = 2) * 180 - (select discount from `TimePlan` where duration = 6)) - (select case when EXISTS(select * from Customer where Customer.is_commercial = 1 and Customer.national_id = "20") then (select discount from `BusinessPlan`, Customer where BusinessPlan.business_plan_id = Customer.business_plan_id and Customer.national_id = "20") else 0 end as business_discount)
        then 6   
    when (select sum(balance) as userCredit from `Account` where Account.national_id = "20") >= ((select min(price_class) FROM `SafeBox`, Hall where SafeBox.hall_floor = Hall.floor AND Hall.security_level = 2) * 90 - (select discount from `TimePlan` where duration = 3)) - (select case when EXISTS(select * from Customer where Customer.is_commercial = 1 and Customer.national_id = "20") then (select discount from `BusinessPlan`, Customer where BusinessPlan.business_plan_id = Customer.business_plan_id and Customer.national_id = "20") else 0 end as business_discount)
        then 3
    else 0
    end as max_month;


-- query 7
select Contract.safebox_id, Contract.time as StartTime, Contract.customer_national_id as OwnerNationalID
    from Contract
    where month(CURRENT_TIMESTAMP) = month(DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH))
    and cast(CURRENT_TIMESTAMP as date) > DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH)
    and Contract.safebox_id not in (select Expiration.safebox_id from Expiration where Expiration.safebox_id = Contract.safebox_id and Expiration.start_time = Contract.time);


-- query 8
select * from Report where Report.national_id = "0441065635"; -- usr_id = 0441065635   
