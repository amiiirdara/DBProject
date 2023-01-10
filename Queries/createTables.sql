
create table Bank (bank_id int primary key,
                  bank_name varchar(20) not null);

create table Employee (national_id varchar(10) primary key,
                      bank_id int, 
                      first_name varchar(20) not null, 
                      last_name varchar(20) not null, 
                      password varchar(32) not null, 
                      salary bigint,
                      is_responsible boolean, 
                      foreign key (bank_id) references Bank(bank_id) on delete cascade on update cascade);
                      

create table BusinessPlan (business_plan_id int primary key,
                           discount int not null);                      

create table Customer (national_id varchar(10) primary key,
                      bank_id int,
                      first_name varchar(20) not null,
                      last_name varchar(20) not null,
                      age int,
                      is_commercial int not null,
                      business_plan_id int,
                      foreign key (bank_id) references Bank(bank_id) on delete cascade on update cascade,
                      foreign key (business_plan_id) references BusinessPlan(business_plan_id) on delete cascade on update cascade,
                      check (age >= 18),
                      check (is_commercial in (0, 1)));
                    
create table Address (national_id varchar(10),
                      address varchar(75),
                      primary key (national_id, address),
                      foreign key (national_id) references Customer(national_id) on delete cascade on update cascade);


create table Hall (floor int primary key,
                  wall_material int not null,
                  number_of_cameras int not null,
                  security_level int,
                  employee_national_id varchar(10),
                  foreign key (employee_national_id) references Employee(national_id) on delete cascade on update cascade,
                  check (wall_material between 1 and 8));
                  
                  
create table SafeBox (safebox_id int primary key,
                     hall_floor int,
                     price_class int,
                     foreign key (hall_floor) references Hall(floor) on delete cascade on update cascade,
                     check (price_class between 1 and 4));
                     

create table TimePlan (discount int,
                       duration smallint,
                       primary key (discount, duration),
                       check (duration in (3, 6, 12)));                     
                     
				
create table Contract (safebox_id int,
                      time date,
                      customer_national_id varchar(10),
                      time_plan_discount int,
                      time_plan_duration smallint,
                      cost bigint,
                      primary key (safebox_id, time),
                      foreign key (safebox_id) references SafeBox(safebox_id) on delete cascade on update cascade,
                      foreign key (customer_national_id) references Customer(national_id) on delete cascade on update cascade,
					            foreign key (time_plan_discount, time_plan_duration) references TimePlan(discount, duration) on delete cascade on update cascade);
                      
                      

create table ContractService (safebox_id int,
                              contract_time date,
                              service varchar(20),
                              primary key (safebox_id, contract_time, service),
                              foreign key (safebox_id, contract_time) references Contract(safebox_id, time) on delete cascade on update cascade,
                              check (service in ("insurance", "guide", "fullservice")));
                              
                              
create table Fiduciary (safebox_id int,
                       time date,
                       description varchar(150),
                       value bigint not null,
                       primary key (safebox_id, time),
                       foreign key (safebox_id, time) references Contract(safebox_id, time) on delete cascade on update cascade);
                       

create table Expiration (safebox_id int,
                        start_time date,
                        end_time date,
                        customer_national_id varchar(10),
                        type varchar(9),
                        primary key (safebox_id, start_time),
                        foreign key (safebox_id) references SafeBox(safebox_id) on delete cascade on update cascade,
                        foreign key (customer_national_id) references Customer(national_id) on delete cascade on update cascade,
                        check (type in ("discharge", "clearing")));                         
                     
                         
create table Account (account_id int primary key,
                      national_id varchar(10),
                      balance bigint,
                      foreign key (national_id) references Customer(national_id) on delete cascade on update cascade);

                         
create table Damage (safebox_id int,
                     contract_time date,
                     time date not null,
                     description varchar(150),
                     primary key (safebox_id, contract_time),
                     foreign key (safebox_id, contract_time) references Contract(safebox_id, time) on delete cascade on update cascade);
                         

create table SafeBoxInfo (safebox_id int,
                          info varchar(50),
                          primary key(safebox_id, info),
                          foreign key (safebox_id) references SafeBox(safebox_id) on delete cascade on update cascade);
			  
