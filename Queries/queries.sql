
-- query 1       
select  hall1.security_level, Contract.customer_national_id, safebox1.safebox_id
        from Contract, SafeBox as safebox1, Hall as hall1
        where Contract.safebox_id not in (select Expiration.safebox_id from Expiration where Expiration.safebox_id=Contract.safebox_id and Expiration.start_time=Contract.time)
            and Contract.safebox_id = safebox1.safebox_id
            and safebox1.hall_floor = hall1.floor;


-- query 4
select Employee.salary
    from Employee, Hall
    where Employee.is_responsible = 1 and
    Employee.national_id = Hall.employee_national_id and
    Hall.security_level >= 3 and Hall.security_level <= 5
    ORDER BY RAND();
    

-- query 7
select Contract.safebox_id
    from Contract
    where month(CURRENT_TIMESTAMP) = month(DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH))
    and cast(CURRENT_TIMESTAMP as date) > DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH)
    and Contract.safebox_id not in (select Expiration.safebox_id from Expiration where Expiration.safebox_id = Contract.safebox_id and Expiration.start_time = Contract.time);
