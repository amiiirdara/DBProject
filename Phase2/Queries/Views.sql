
CREATE VIEW DamagedCustomer AS
   SELECT DISTINCT Customer.first_name, Customer.last_name, Customer.national_id, Contract.safebox_id
   FROM Customer, Damage, Contract,
    ((SELECT Contract.safebox_id AS safebox_id,
            Contract.time AS start_time,
            Contract.customer_national_id AS national_id FROM Contract)
    UNION 
    (SELECT Expiration.safebox_id AS safebox_id,
            Expiration.start_time AS start_time,
            Expiration.customer_national_id AS national_id FROM Expiration)) AS contracts
   WHERE contracts.safebox_id = Damage.safebox_id 
   AND contracts.start_time = Damage.start_time 
   AND contracts.national_id = Customer.national_id 
   AND contracts.national_id = Contract.customer_national_id;

SELECT * FROM DamagedCustomer;

