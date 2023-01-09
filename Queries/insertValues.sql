
INSERT INTO Bank VALUES(1, "Saman");

INSERT INTO Customer VALUES
                            ("2283281903", 1, "Farhad", "Esmaeilzadeh", 21),
                            ("0441065635", 1, "Amirmahdi", "Daraie", 20),
                            ("2020710234", 1, "Amirreza", "Abootalebi", 20),
                            ("2020599951", 1, "Ardalan", "Sadieh", 22),
                            ("1819418189", 1, "Hossein", "Esmaeilzadeh", 60),
                            ("1", 1, "Ali", "Daraie", 51),
                            ("2384", 1, "Mokhtar", "Abootalebi", 62);

INSERT INTO Address VALUES
                            ("2283281903", "KhajeNasirEdinToosi-Rahimian-Pelak7-Zang3"),
                            ("0441065635", "Aghdasie-DovomGharbi-Pelak13-Zang32"),
                            ("2020710234", "Tarasht-Tarasht3"),
                            ("2020599951", "Niavaran-Kakh-Pelak24-Zang43"),
                            ("1819418189", "Shiraz-SepahJonoobi"),
                            ("1", "Aghdasie-DovomGharbi-Pelak13-Zang32"),
                            ("2384", "Zirab-Khaghani");                                                       

INSERT INTO Employee VALUES
                            ("2", 1, "Ali", "Shahheidar", "AliDB1", 12000, 1),
                            ("3", 1, "Sania", "Masoodi", "Saniasania", 8000, 1),
                            ("4", 1, "Amirali", "Yaghoobi", "amirali1380", 20000, 1),
                            ("5", 1, "Parmida", "Hashemi", "Parmida8585", 30000, 1),
                            ("6", 1, "Mohammad", "Barzamini", "BarzaminiMmd", 30000, 1);

INSERT INTO Hall VALUES
                        (1, 2, 6, NULL, "2"),
                        (2, 6, 6, NULL, "3"),
                        (3, 8, 12, NULL, "4"),
                        (4, 4, 3, NULL, "5"),
                        (5, 5, 1, NULL, "6");

INSERT INTO SafeBox VALUES
                            (1, 1, 5, 0),
                            (2, 2, 12, 0),
                            (3, 3, 25, 0),
                            (4, 1, 5, 0),
                            (5, 5, 3, 0);
                
INSERT INTO TimePlan VALUES
                            (100, 3),
                            (300, 6),
                            (400, 12);
                            
INSERT INTO Account VALUES
                            (1, "2283281903", 40000),
                            (2, "0441065635", 75000),
                            (3, "2020710234", 110000),
                            (4, "2020599951", 135000),
                            (5, "1819418189", 250000),
                            (6, "1", 222000),
                            (7, "2384", 267972);                            

                            
INSERT INTO Contract VALUES
                            (1, "2021-11-11", "0441065635", 300, 6, 900),
                            (1, "2022-08-02", "0441065635", 100, 3, 400),
                            (1, "2022-12-10", "2283281903", 400, 12, 900),
                            (2, "2020-04-23", "0441065635", 300, 6, 900),
                            (2, "2022-07-01", "0441065635", 400, 12, 900),
                            (3, "2018-09-12", "2020710234", 300, 6, 900),
                            (4, "2022-11-11", "0441065635", 300, 6, 900),
                            (5, "2022-11-11", "0441065635", 300, 6, 900),
                            (3, "2022-08-12", "2283281903", 100, 3, 2250);

INSERT INTO Expiration VALUES
                                (1, "2021-11-11", "2022-06-11", 0),
                                (2, "2022-07-01", "2022-10-12", 0),
                                (5, "2022-11-11", "2024-05-11", 0);
