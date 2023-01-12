
-- query 1       
DELIMITER $$
create procedure query1(usr_id varchar(10))
    begin 
        select Contract.customer_national_id, safebox1.safebox_id, hall1.security_level
            from Contract, SafeBox as safebox1, Hall as hall1
            where Contract.safebox_id = safebox1.safebox_id
                and safebox1.hall_floor = hall1.floor
                and Contract.customer_national_id = usr_id;
    end $$
DELIMITER ;

call query1("0441065635");


-- query 2
DELIMITER $$
create procedure query2(level int, month int)
    begin
        select safebox_id, ((SafeBox.price_class * month * 30) - (select TimePlan.discount from TimePlan where TimePlan.duration = month)) as SafeBoxRentCost
            from SafeBox, Hall
            where hall_floor = floor and Hall.security_level = level;   
    end $$
DELIMITER ;

call query2(2, 3);


-- query 3
DELIMITER $$
create procedure query3(room_id int, plan_id int)
    begin 
        select round(avg(Customer.age), 2)
        from Customer, SafeBox, Contract, Expiration
        where Customer.is_commercial = 1
            and Customer.business_plan_id = plan_id     
            and (Customer.national_id = Contract.customer_national_id and Contract.safebox_id = SafeBox.safebox_id)
            or (Customer.national_id = Expiration.customer_national_id and Expiration.safebox_id = SafeBox.safebox_id)
            and SafeBox.hall_floor = room_id; 
    end $$
DELIMITER;    

call query3(2, 1);



-- query 4
DELIMITER $$
create procedure query4(from_level int, to_level int)
    begin
        select Employee.national_id, Employee.first_name, Employee.last_name, Employee.salary
            from Employee, Hall
            where Employee.is_responsible = 1 and
            Employee.national_id = Hall.employee_national_id and
            Hall.security_level >= from_level and Hall.security_level <= to_level
            ORDER BY RAND();
    end $$
DELIMITER ;

call query4(2, 4);


-- query 5
DELIMITER $$
create procedure query5(max_price bigint, level int)
    begin
        select distinct SafeBox.safebox_id, SafeBox.hall_floor
            from SafeBox, Hall, Contract  
            where SafeBox.hall_floor = Hall.floor
            and Hall.security_level = level
            and SafeBox.safebox_id in (select SafeBox.safebox_id from SafeBox where (SafeBox.price_class * 30 * 3) < max_price)
            and SafeBox.safebox_id not in (select Contract.safebox_id from Contract);
        end $$
DELIMITER ;

call query5(200, 2);



-- query 6
DELIMITER $$
create procedure query6(level int, usr_id varchar(10))
    begin
        select CASE
            when (select sum(balance) as userCredit from `Account` where Account.national_id = "20") >= ((select min(price_class) FROM `SafeBox`, Hall where SafeBox.hall_floor = Hall.floor AND Hall.security_level = level) * 360 - (select discount from `TimePlan` where duration = 12)) - (select case when EXISTS(select * from Customer where Customer.is_commercial = 1 and Customer.national_id = usr_id) then (select discount from `BusinessPlan`, Customer where BusinessPlan.business_plan_id = Customer.business_plan_id and Customer.national_id = usr_id) else 0 end as business_discount)                                                      
                then 12                                                                                      
            when (select sum(balance) as userCredit from `Account` where Account.national_id = "20") >= ((select min(price_class) FROM `SafeBox`, Hall where SafeBox.hall_floor = Hall.floor AND Hall.security_level = level) * 180 - (select discount from `TimePlan` where duration = 6)) - (select case when EXISTS(select * from Customer where Customer.is_commercial = 1 and Customer.national_id = usr_id) then (select discount from `BusinessPlan`, Customer where BusinessPlan.business_plan_id = Customer.business_plan_id and Customer.national_id = usr_id) else 0 end as business_discount)
                then 6   
            when (select sum(balance) as userCredit from `Account` where Account.national_id = "20") >= ((select min(price_class) FROM `SafeBox`, Hall where SafeBox.hall_floor = Hall.floor AND Hall.security_level = level) * 90 - (select discount from `TimePlan` where duration = 3)) - (select case when EXISTS(select * from Customer where Customer.is_commercial = 1 and Customer.national_id = usr_id) then (select discount from `BusinessPlan`, Customer where BusinessPlan.business_plan_id = Customer.business_plan_id and Customer.national_id = usr_id) else 0 end as business_discount)
                then 3
            else 0
        end as max_month;
    end $$
DELIMITER ;

call query6(2, "20");



-- query 7
DELIMITER $$
create procedure query7()
    begin
        select Contract.safebox_id, Contract.time as StartTime, Contract.customer_national_id as OwnerNationalID
            from Contract
            where month(CURRENT_TIMESTAMP) = month(DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH))
            and cast(CURRENT_TIMESTAMP as date) > DATE_ADD(Contract.time, INTERVAL Contract.time_plan_duration MONTH)
            and Contract.safebox_id not in (select Expiration.safebox_id from Expiration where Expiration.safebox_id = Contract.safebox_id and Expiration.start_time = Contract.time);
    end $$
DELIMITER ;

call query7();


-- query 8
DELIMITER $$
create procedure query8(usr_id varchar(10))
    begin
        select * from Report where Report.national_id = usr_id;
    end $$
DELIMITER ;

call query8("0441065635");

