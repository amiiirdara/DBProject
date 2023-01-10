
-- query 1       
select  hall1.security_level, Contract.customer_national_id, safebox1.safebox_id
        from Contract, SafeBox as safebox1, Hall as hall1
        where Contract.safebox_id not in (select Expiration.safebox_id from Expiration where Expiration.safebox_id=Contract.safebox_id and Expiration.start_time=Contract.time)
            and Contract.safebox_id = safebox1.safebox_id
            and safebox1.hall_floor = hall1.floor;


-- query 2
select (SafeBox.price_class * 1000) - (select TimePlan.discount from TimePlan where TimePlan.duration = 3)
    from SafeBox, Hall
    where SafeBox.hall_floor = Hall.floor and Hall.security_level = 2;


-- query 3
select round(avg(Customer.age), 2)
    from Customer, SafeBox, Contract, Expiration
    where Customer.is_commercial = 1
        and Customer.business_plan_id = 2  -- plan_id     
        and (Customer.national_id = Contract.customer_national_id or Customer.national_id = Expiration.customer_national_id)
        and (Contract.safebox_id = SafeBox.safebox_id or Expiration.safebox_id = SafeBox.safebox_id)
        and SafeBox.hall_floor = 1; -- room_id


-- query 4
select Employee.salary
    from Employee, Hall
    where Employee.is_responsible = 1 and
    Employee.national_id = Hall.employee_national_id and
    Hall.security_level >= 3 and Hall.security_level <= 5
    ORDER BY RAND();

-- query 5
select Safebox.safebox_id, SafeBox.hall_floor
    from SafeBox, Hall, Contract  
    where SafeBox.hall_floor = Hall.floor
    and Hall.security_level = 2 -- security_level
    and SafeBox.safebox_id in (select SafeBox.safebox_id from SafeBox where (SafeBox.price_class * 1000) < 4000) -- max_price = 4000
    and SafeBox.safebox_id not in (select Contract.safebox_id from Contract);


-- query 6




-- query 7
select Contract.safebox_id
    from Contract
    where month(CURRENT_TIMESTAMP) = month(DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH))
    and cast(CURRENT_TIMESTAMP as date) > DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH)
    and Contract.safebox_id not in (select Expiration.safebox_id from Expiration where Expiration.safebox_id = Contract.safebox_id and Expiration.start_time = Contract.time);
