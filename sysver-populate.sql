CREATE OR REPLACE SCHEMA temporal_tables;
USE temporal_tables;

CREATE OR REPLACE TABLE user (
    uuid UUID DEFAULT UUID(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
        WITHOUT SYSTEM VERSIONING,
    address TEXT NOT NULL DEFAULT '',
    subscription_type VARCHAR(20) NOT NULL,
    ip INET4 NOT NULL,
    valid_since TIMESTAMP(6) GENERATED ALWAYS AS ROW START INVISIBLE,
    valid_until TIMESTAMP(6) GENERATED ALWAYS AS ROW END INVISIBLE,
    PRIMARY KEY (uuid),
    UNIQUE unq_email (email),
    PERIOD FOR SYSTEM_TIME(valid_since, valid_until)
)
    WITH SYSTEM VERSIONING
;

ALTER TABLE user
    PARTITION BY SYSTEM_TIME (
        PARTITION p_history HISTORY,
        PARTITION p_current CURRENT
    )
;


INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Bethany', 'Williams', 'fwilliams@example.net', '401 Murray Pass
South Barrymouth, CA 72376', 'BRONZE', '199.216.199.54', '2023-01-01')
    , ('Stephen', 'Jones', 'qglenn@example.org', '1245 Decker Knoll
Janicestad, KY 39166', 'SILVER', '156.30.67.39', '2023-01-01')
    , ('Robert', 'Gonzalez', 'berrypaul@example.org', '423 Jeremy Prairie
Millerstad, KS 10626', 'SILVER', '123.97.125.174', '2023-01-01')
    , ('Erica', 'Osborne', 'alyssa50@example.com', '547 Crystal Highway
North Katherinehaven, WI 96616', 'SILVER', '67.137.30.37', '2023-01-01')
    , ('Kevin', 'Barber', 'brownheather@example.com', 'Unit 2962 Box 5453
DPO AP 68588', 'DIAMOND', '173.245.211.194', '2023-01-01')
    , ('Christopher', 'Aguirre', 'aguirrenicholas@example.net', '80376 Christopher Port Apt. 742
Perezborough, AK 01228', 'SILVER', '172.171.134.209', '2023-01-01')
    , ('Elizabeth', 'Williams', 'bsmith@example.org', '480 Melanie Dam Apt. 835
Adkinschester, CO 11180', '', '23.152.37.46', '2023-01-01')
    , ('Craig', 'Miller', 'kennethdillon@example.net', '20939 Patrick Branch Apt. 136
New Matthewbury, UT 08045', 'BRONZE', '172.131.214.132', '2023-01-01')
    , ('Dennis', 'Walton', 'ymckay@example.org', '2164 Moore Stream Apt. 655
New Cynthia, AZ 44332', 'SILVER', '206.133.122.204', '2023-01-01')
    , ('Maria', 'Holmes', 'xdiaz@example.com', '1168 Phillips Ferry
New Rachelborough, DE 77878', 'DIAMOND', '74.140.251.59', '2023-01-01')
    , ('Patricia', 'Smith', 'joshua44@example.net', 'Unit 6259 Box 1266
DPO AE 51887', 'BRONZE', '29.169.186.159', '2023-01-01')
    , ('Michael', 'Stewart', 'larrybooth@example.com', '587 Katherine Mountain Suite 121
Griffinmouth, NJ 53052', 'BRONZE', '129.125.2.121', '2023-01-01')
    , ('Larry', 'Chandler', 'msolis@example.org', '29192 Franco Crossroad Suite 481
South Cameron, TN 73307', 'DIAMOND', '112.63.9.102', '2023-01-01')
    , ('Tiffany', 'Gillespie', 'mayermaria@example.org', '06166 Hardy Street Suite 676
Jonesview, ND 51286', 'GOLD', '52.74.110.112', '2023-01-01')
    , ('Mark', 'Lucas', 'phillip95@example.net', '8112 Evans Turnpike
Matthewside, MP 45460', 'GOLD', '64.44.20.2', '2023-01-01')
    , ('Stanley', 'Boyd', 'robertsonjohn@example.net', '982 Cindy Squares
Pamelaton, GA 56026', 'BRONZE', '93.68.181.115', '2023-01-01')
    , ('Jennifer', 'Krause', 'qblanchard@example.com', '1163 Brian Court
Lauraton, CT 42573', 'SILVER', '145.227.253.247', '2023-01-01')
    , ('Lisa', 'Gross', 'zwhite@example.org', '1225 Joseph Road
Savannahville, IN 63193', 'GOLD', '149.74.167.213', '2023-01-01')
    , ('James', 'Manning', 'james03@example.net', '49940 Jade Walks
Barryside, TN 91408', 'BRONZE', '109.178.146.159', '2023-01-01')
    , ('Stephanie', 'Fletcher', 'lweeks@example.net', '493 Anderson Inlet
Claytonton, CO 16768', 'SILVER', '194.49.94.142', '2023-01-01')
    , ('Jason', 'Gardner', 'james22@example.net', '29050 Adams Squares
East Eric, FM 64987', 'GOLD', '75.58.205.147', '2023-01-01')
    , ('Andrew', 'Nelson', 'shannonmercado@example.com', '1820 Ellis Spurs
New Matthew, OR 09201', 'DIAMOND', '91.228.71.212', '2023-01-01')
    , ('Kristi', 'Smith', 'dianejenkins@example.net', '859 King Curve Suite 857
Nataliefort, AL 55320', 'GOLD', '124.155.72.252', '2023-01-01')
    , ('Lori', 'Cox', 'hickskevin@example.net', '518 Robinson Fork Suite 921
Basstown, NH 68728', 'SILVER', '195.102.35.160', '2023-01-01')
    , ('Bradley', 'Campbell', 'qwoods@example.net', '353 Jennifer Mill
Richardhaven, WA 22248', '', '70.90.211.223', '2023-01-01')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jonathan', 'Berg', 'charles86@example.org', '85588 Clark Streets Suite 604
Jacobport, TN 00916', 'SILVER', '183.91.83.105', '2023-01-05')
    , ('Alicia', 'Henderson', 'aliciacollins@example.com', 'Unit 3388 Box 9908
DPO AA 63790', 'GOLD', '49.118.42.142', '2023-01-05')
    , ('Kimberly', 'Mullen', 'david59@example.com', '6214 Barbara Viaduct Apt. 637
South Barbaraburgh, TX 63710', 'GOLD', '214.149.206.207', '2023-01-05')
    , ('Sarah', 'Weeks', 'ian93@example.com', '5592 Green Field Suite 928
Yatesmouth, AR 90211', '', '121.249.237.115', '2023-01-05')
    , ('Donna', 'Sexton', 'carterphillip@example.org', '9750 James Glens Apt. 284
Lake Sarahburgh, MD 41590', '', '80.169.62.221', '2023-01-05')
    , ('Melinda', 'Ryan', 'kristina60@example.com', 'USNV Taylor
FPO AA 44362', 'BRONZE', '68.12.169.166', '2023-01-05')
    , ('Katie', 'Ramirez', 'jessica00@example.com', '7931 Charles Fords Apt. 600
Barryville, WV 74862', 'BRONZE', '187.239.220.23', '2023-01-05')
    , ('Andrew', 'Brown', 'bmorgan@example.org', '5965 Bates Oval
East Whitneyville, CA 82464', 'GOLD', '134.114.253.178', '2023-01-05')
    , ('Charles', 'Thomas', 'robert65@example.org', '575 Huffman Rapids
Farrellton, ME 23475', 'DIAMOND', '40.133.71.31', '2023-01-05')
    , ('Angela', 'Robbins', 'rhenry@example.net', '2034 Johnson Estates Apt. 653
Fosterland, WV 82565', 'DIAMOND', '84.60.71.27', '2023-01-05')
    , ('James', 'Rice', 'hernandezerika@example.org', '794 Elliott Fort Suite 721
Mosesland, VA 63043', 'DIAMOND', '18.185.138.100', '2023-01-05')
    , ('Alan', 'Wood', 'michaelgraham@example.org', '761 Castro Bypass
West Sandy, IL 18948', 'GOLD', '117.79.73.128', '2023-01-05')
    , ('Jenna', 'Reyes', 'tiffany86@example.net', '8752 Jones Station
Mccannchester, NY 47265', 'GOLD', '47.183.19.11', '2023-01-05')
    , ('Joseph', 'Cruz', 'hawkinsjennifer@example.org', '844 Wallace Trafficway Suite 838
Ericfort, ND 51356', 'SILVER', '120.80.144.72', '2023-01-05')
    , ('Robert', 'Johnson', 'fguzman@example.org', '1334 Marquez Flat Suite 861
Andersonfort, UT 22009', 'DIAMOND', '157.236.185.136', '2023-01-05')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Joseph', 'Hodges', 'rickyvazquez@example.net', '00983 Ellis Locks Apt. 978
Kramermouth, NY 55003', 'GOLD', '209.27.153.96', '2023-01-22')
    , ('Rebecca', 'Castillo', 'michael13@example.org', '972 Anthony Pass
East Michael, OK 87453', 'DIAMOND', '161.98.135.181', '2023-01-22')
    , ('Michael', 'Rogers', 'jamesherring@example.net', '1288 Contreras Road
New Steven, SD 17361', 'SILVER', '148.152.51.212', '2023-01-22')
    , ('Amber', 'Miller', 'amy58@example.com', '3688 Neal Island
East Mauricestad, MP 81962', 'SILVER', '174.2.65.29', '2023-01-22')
    , ('Becky', 'Gonzales', 'michelle63@example.net', '64105 Adam Hollow Suite 443
Allenside, AZ 54234', 'GOLD', '146.231.151.12', '2023-01-22')
    , ('Philip', 'Wilson', 'joseph01@example.org', '6032 Williams Squares
Victorberg, DC 40744', '', '195.82.98.221', '2023-01-22')
    , ('Bradley', 'Huang', 'olsonsavannah@example.com', '54912 Jasmine Ridge Apt. 697
New Donnaport, NC 58636', 'DIAMOND', '196.212.153.148', '2023-01-22')
    , ('Tammy', 'Williams', 'mcohen@example.org', '58551 Merritt Point Suite 074
Port Maryport, ME 60778', 'BRONZE', '167.8.94.227', '2023-01-22')
    , ('Tammy', 'Mcdaniel', 'amandadavis@example.org', '658 Christopher Mission Suite 881
Ethanton, OK 74384', 'BRONZE', '84.180.101.194', '2023-01-22')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Ryan', 'Taylor', 'adamsbecky@example.org', 'Unit 9841 Box 6105
DPO AA 53711', '', '116.228.139.36', '2023-01-27')
    , ('Teresa', 'Fletcher', 'chapmanjacob@example.com', '684 Guzman Coves
Meyersmouth, WY 83797', '', '34.220.40.26', '2023-01-27')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Amy', 'Barnett', 'haley25@example.org', '07096 Sanchez Ridge Suite 243
West Haleyborough, AZ 23658', 'SILVER', '27.120.180.241', '2023-01-29')
    , ('Stephanie', 'Brown', 'kimberly21@example.net', '10467 Mary Key
Mitchellview, NE 42033', 'DIAMOND', '36.238.146.13', '2023-01-29')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Michael', 'Lewis', 'martincody@example.com', '5302 Ramirez Canyon Suite 514
Collinsview, WA 97175', '', '11.181.87.217', '2023-02-02')
    , ('Haley', 'Krueger', 'beckkyle@example.org', '72670 Alisha Field
Lamberthaven, AS 82404', 'SILVER', '35.214.40.119', '2023-02-02')
    , ('Michael', 'Mcneil', 'melissastewart@example.org', '77459 Richard Fork Suite 763
Bridgesport, WA 23405', 'BRONZE', '54.73.199.184', '2023-02-02')
    , ('Christine', 'Frazier', 'mosleyjoseph@example.org', '1391 Michael Port Apt. 898
West Susan, WA 03289', '', '116.33.22.5', '2023-02-02')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Linda', 'Baxter', 'diana21@example.org', '4594 Elijah Ramp
Barbaratown, CA 38482', 'GOLD', '99.224.41.157', '2023-02-03')
    , ('Dennis', 'Hill', 'bushcarolyn@example.org', '7989 Larson Turnpike
West Robert, OK 31470', 'GOLD', '96.159.163.127', '2023-02-03')
    , ('Jimmy', 'Brown', 'ibrown@example.com', '95452 Nicole Expressway
Cooperberg, FM 03182', 'DIAMOND', '119.57.38.213', '2023-02-03')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jesus', 'Scott', 'rojaslaura@example.net', 'Unit 6536 Box 8964
DPO AA 90953', 'DIAMOND', '23.63.137.30', '2023-02-05')
    , ('Benjamin', 'Jones', 'kyle50@example.net', '86293 Charles Port
Mccarthyland, OR 90492', 'DIAMOND', '33.154.231.171', '2023-02-05')
    , ('Keith', 'Robles', 'powerssteven@example.com', '273 Mcgee Viaduct
West Kristinchester, MI 34723', 'GOLD', '133.38.190.142', '2023-02-05')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Lucas', 'Brown', 'oavery@example.org', 'Unit 1790 Box 4590
DPO AE 24810', 'DIAMOND', '136.215.76.130', '2023-02-06')
    , ('Jennifer', 'Silva', 'daniel72@example.net', '2028 Kelly Alley
Ericton, NV 51015', 'GOLD', '94.227.76.216', '2023-02-06')
    , ('Timothy', 'Cook', 'jane86@example.com', '453 Clark Motorway Suite 832
Port Nicole, TX 14310', 'DIAMOND', '42.254.72.199', '2023-02-06')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Alexandra', 'Harris', 'carolyngarcia@example.net', 'PSC 8614, Box 6699
APO AP 68006', '', '158.243.78.233', '2023-02-13')
    , ('Claudia', 'Stevens', 'charles56@example.org', '358 Kennedy Hills
East Jordan, MT 23471', 'DIAMOND', '158.104.168.12', '2023-02-13')
    , ('Jordan', 'Kidd', 'fball@example.net', '945 Lisa Turnpike Apt. 410
New Rebeccaville, UT 49771', 'SILVER', '50.250.42.237', '2023-02-13')
    , ('Yvonne', 'Hanson', 'justinhill@example.com', '896 Brooks Field
Vangburgh, NE 26723', 'GOLD', '61.233.17.238', '2023-02-13')
    , ('Jeffrey', 'Davis', 'smithbrenda@example.org', '48127 Andrea Parkway Suite 973
West Brianview, NY 62890', 'GOLD', '195.194.108.26', '2023-02-13')
    , ('Jeffrey', 'Cunningham', 'nmoss@example.net', '692 Lane Manors
North Donna, TX 10507', 'SILVER', '97.235.218.245', '2023-02-13')
    , ('Michael', 'Gamble', 'qsingh@example.org', '8475 William Glens
North Aaronville, VA 55277', 'BRONZE', '188.109.34.100', '2023-02-13')
    , ('Amy', 'Evans', 'ncasey@example.com', '5735 Don Cliffs
Harrisonchester, FM 64028', '', '1.52.118.125', '2023-02-13')
    , ('Christopher', 'Mosley', 'turnerronald@example.net', '15909 Donna Drive
South Brianmouth, LA 83005', 'BRONZE', '181.42.33.149', '2023-02-13')
    , ('William', 'Mason', 'petersonbrianna@example.net', '2712 Price Rue Apt. 856
Michellemouth, MD 39623', 'SILVER', '99.144.80.92', '2023-02-13')
    , ('Andrea', 'Olson', 'jeffreystout@example.net', '68910 Delgado Lake Suite 050
Joanneland, VA 94140', 'SILVER', '78.222.172.237', '2023-02-13')
    , ('Sharon', 'Johnson', 'stephaniegray@example.com', '77153 Humphrey Ports Suite 359
West Denniston, AL 26997', '', '91.241.53.239', '2023-02-13')
    , ('Charles', 'Cortez', 'estevenson@example.org', '67822 Sandoval Motorway Apt. 283
Jessicatown, TX 44086', 'BRONZE', '89.54.134.249', '2023-02-13')
    , ('Daryl', 'Ortega', 'murraykimberly@example.org', '63283 Adams Stream Suite 601
Lake Peterstad, MA 94595', 'GOLD', '129.151.152.166', '2023-02-13')
    , ('Jeanne', 'Wang', 'ismith@example.com', '247 Austin Plaza
Snowside, PA 02244', '', '197.70.116.212', '2023-02-13')
    , ('Charlene', 'Smith', 'cindycarter@example.org', '821 John Route
Shirleyborough, PR 34856', 'BRONZE', '187.159.70.15', '2023-02-13')
    , ('Sherry', 'Smith', 'rivasjack@example.net', '26072 David Forges Apt. 902
Port Angelaland, MN 58050', 'DIAMOND', '171.60.109.216', '2023-02-13')
    , ('Katherine', 'Welch', 'julia53@example.net', '6549 Lauren Island
New Melanie, LA 82130', '', '216.31.188.48', '2023-02-13')
    , ('Joshua', 'Cohen', 'rachaelsims@example.org', '60559 Nicholas Prairie
Port Tiffany, AL 71659', '', '207.102.75.194', '2023-02-13')
    , ('Paul', 'Silva', 'brownjonathan@example.net', '46766 Anderson Locks
New Diane, FM 53000', 'DIAMOND', '13.33.16.140', '2023-02-13')
    , ('Nicole', 'Kim', 'hubbardthomas@example.org', '8139 Julie Stream
South Christianberg, KS 15242', 'GOLD', '199.120.99.74', '2023-02-13')
    , ('Angela', 'Walter', 'jacobmonroe@example.org', '42443 Michael Drive
Amyborough, UT 22935', 'DIAMOND', '190.62.57.126', '2023-02-13')
    , ('Joshua', 'Johnson', 'theresalee@example.net', '882 Brandon Freeway Apt. 984
Fieldsberg, WA 08189', 'DIAMOND', '222.192.14.46', '2023-02-13')
    , ('Tracy', 'Sullivan', 'adam51@example.net', '651 Burch Lake Apt. 520
Martinmouth, WV 03948', 'GOLD', '157.37.19.155', '2023-02-13')
    , ('Mackenzie', 'Ferrell', 'theresa79@example.org', '998 Obrien Stravenue
New Jeffreyport, WV 53080', 'BRONZE', '222.29.89.103', '2023-02-13')
    , ('Omar', 'Graham', 'jonathan25@example.com', '1268 Michael Fords Suite 837
Dawnland, NY 97254', '', '124.190.104.193', '2023-02-13')
    , ('Aaron', 'Blair', 'laurenhudson@example.net', '497 Thomas Plain Apt. 369
Curtismouth, IL 47290', 'BRONZE', '172.62.62.111', '2023-02-13')
    , ('Lee', 'Velasquez', 'edwardflores@example.com', '2181 Lisa Haven
New Amanda, AS 37036', 'BRONZE', '85.34.183.79', '2023-02-13')
    , ('Christina', 'Taylor', 'kleinjoseph@example.com', '8448 Gonzales Crest Apt. 534
Johnsonville, SD 55093', 'DIAMOND', '168.49.152.161', '2023-02-13')
    , ('Jennifer', 'Johnson', 'sarah19@example.org', '9190 Evans Village Suite 079
Ashleyview, OK 43162', 'SILVER', '147.163.158.111', '2023-02-13')
    , ('Deanna', 'Crawford', 'thomasnichole@example.org', '50640 Heidi Ports
North Ashleyville, IN 98375', 'DIAMOND', '1.25.253.100', '2023-02-13')
    , ('Brianna', 'Stewart', 'millercurtis@example.com', '31646 Payne Station Suite 374
Jennifermouth, SC 69767', 'BRONZE', '48.124.79.254', '2023-02-13')
    , ('Johnathan', 'Smith', 'anthonymorales@example.net', '156 Cheryl Bypass Suite 902
West Lauren, SD 69965', 'DIAMOND', '1.152.99.101', '2023-02-13')
    , ('Audrey', 'Eaton', 'cdavis@example.com', '347 Martin Village Apt. 261
Kyleville, ND 21512', 'SILVER', '39.40.47.111', '2023-02-13')
    , ('Jennifer', 'Calhoun', 'paultorres@example.com', '769 Billy Row
West Carolyn, PW 96637', 'DIAMOND', '115.150.44.235', '2023-02-13')
    , ('Xavier', 'Carter', 'thorntonchristopher@example.com', '26633 Collier Curve
Lake Charlesside, PR 51613', '', '126.32.50.52', '2023-02-13')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Scott', 'Hicks', 'david39@example.com', 'PSC 8655, Box 1295
APO AE 85686', '', '92.21.119.240', '2023-02-16')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Melissa', 'Thomas', 'lrobertson@example.com', '023 Vanessa Dale Suite 839
Alexisfurt, MI 27613', 'BRONZE', '156.134.123.237', '2023-02-17')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Gary', 'White', 'ingramtimothy@example.com', '22424 Amanda Forges Apt. 402
Bryanhaven, NM 40528', 'BRONZE', '134.74.60.172', '2023-02-19')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Karen', 'Hunter', 'duarteashley@example.org', '7121 May Island
North Marybury, MI 82764', '', '196.13.51.87', '2023-02-28')
    , ('Mark', 'Price', 'payneamy@example.com', '21295 Emily Rue Suite 555
Port Teresamouth, MN 82157', 'GOLD', '163.165.221.115', '2023-02-28')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Tammy', 'Russell', 'ramosadrienne@example.net', '560 Kiara Key
New Jesus, MD 44060', 'DIAMOND', '67.89.201.212', '2023-03-18')
    , ('Eric', 'Nunez', 'josepruitt@example.net', '35594 Bradley Fields
North Davidberg, AL 56269', 'SILVER', '213.207.140.221', '2023-03-18')
    , ('Belinda', 'Simmons', 'charles81@example.net', 'Unit 4338 Box 5566
DPO AE 15418', '', '129.41.250.60', '2023-03-18')
    , ('Christine', 'Morales', 'kimberly36@example.net', '02303 John Street Suite 327
Port Mary, OH 95375', 'SILVER', '28.208.214.230', '2023-03-18')
    , ('Richard', 'Conner', 'williamlee@example.com', '5035 Harris Neck
Georgechester, AZ 69873', 'DIAMOND', '221.126.147.58', '2023-03-18')
    , ('Brenda', 'Zimmerman', 'johnsonjerry@example.com', '1654 Williams Hill
Serranoborough, TN 61522', 'GOLD', '169.174.18.242', '2023-03-18')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jermaine', 'Hardin', 'wagnercrystal@example.net', 'Unit 0034 Box 5130
DPO AA 29516', 'GOLD', '71.174.196.105', '2023-03-19')
    , ('Patricia', 'Cuevas', 'erictaylor@example.net', 'Unit 8306 Box 6076
DPO AA 54295', 'SILVER', '144.113.101.134', '2023-03-19')
    , ('Alisha', 'Webster', 'krista97@example.org', '83925 Hansen Knolls Suite 052
Lifort, LA 88892', 'GOLD', '218.99.134.42', '2023-03-19')
    , ('Jennifer', 'Harper', 'james92@example.org', '135 Shaw Roads
West Sean, NJ 40022', 'DIAMOND', '191.125.130.56', '2023-03-19')
    , ('Taylor', 'Thomas', 'loveeric@example.org', '110 Michelle Ridges
New Maryborough, AL 10677', 'GOLD', '207.178.156.195', '2023-03-19')
    , ('Cynthia', 'Williams', 'kingjacob@example.net', 'USS Peters
FPO AA 73091', 'DIAMOND', '5.95.101.36', '2023-03-19')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jacob', 'Rogers', 'heather12@example.net', '998 Patty Parks Suite 404
Johnsonmouth, ND 97440', 'BRONZE', '183.95.37.22', '2023-03-27')
    , ('Jessica', 'Baker', 'vlong@example.net', '2580 Smith Neck
Danielview, IL 76661', 'GOLD', '91.105.102.202', '2023-03-27')
    , ('Lisa', 'Edwards', 'jeremyrusso@example.org', '83263 Allen Pines
West Kimberly, PA 28489', '', '178.86.163.158', '2023-03-27')
    , ('Lauren', 'Decker', 'ulin@example.com', '734 Linda Bypass Apt. 922
Port Renee, OH 07486', 'BRONZE', '119.247.11.219', '2023-03-27')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Shari', 'Martinez', 'gregoryduffy@example.com', '947 Jessica Ridges Apt. 866
Christinaland, VA 16008', 'SILVER', '186.60.96.133', '2023-04-03')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Cassandra', 'Glover', 'timothy29@example.net', '08241 Andrew Landing
East Hollyport, MI 87817', 'GOLD', '23.186.209.37', '2023-04-05')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Susan', 'Harrison', 'alicelong@example.net', '7049 Mccarthy Passage
Port Kelly, OH 80973', 'GOLD', '73.253.227.251', '2023-04-012')
    , ('John', 'Contreras', 'smithlucas@example.com', '60911 Thomas Mountain Suite 663
Lake Robertobury, OK 24696', 'SILVER', '123.109.92.199', '2023-04-012')
    , ('Glenda', 'Hart', 'amyramirez@example.net', '0117 Andrea Loop
New Elizabeth, FM 33454', 'SILVER', '155.231.252.221', '2023-04-012')
    , ('Robert', 'Rodriguez', 'psmith@example.org', 'USCGC Hodges
FPO AE 63168', 'SILVER', '79.65.12.69', '2023-04-012')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Tyler', 'King', 'katiehines@example.com', '0291 Kent Roads
Carneytown, SD 07290', 'DIAMOND', '3.54.71.154', '2023-04-22')
    , ('William', 'Torres', 'cohenrobert@example.net', '894 Sherri Field
Williamview, HI 05325', 'GOLD', '153.62.210.119', '2023-04-22')
    , ('Diane', 'West', 'evan77@example.net', '319 Garcia Pines Suite 657
Webbborough, MN 86771', 'BRONZE', '59.229.163.173', '2023-04-22')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Karen', 'Franco', 'hawkinsrichard@example.net', '97730 Robert Forks Apt. 500
Lake Annaland, NH 70207', 'BRONZE', '204.234.106.44', '2023-05-07')
    , ('Ryan', 'Smith', 'tammy72@example.org', '1033 Ashley Street
North Cindy, OK 22771', 'DIAMOND', '129.249.74.187', '2023-05-07')
    , ('Roger', 'Gross', 'denise20@example.org', '0301 Gordon Hollow
North Richard, PR 17144', 'BRONZE', '59.143.174.147', '2023-05-07')
    , ('Jessica', 'Benson', 'tdavis@example.net', '0737 Ashley Inlet Apt. 389
East Karashire, VI 36384', '', '96.87.233.18', '2023-05-07')
    , ('Elizabeth', 'King', 'marvinrangel@example.org', '2764 Richard Motorway
Port Amanda, MN 02550', 'GOLD', '196.154.164.177', '2023-05-07')
    , ('Julie', 'Medina', 'ojones@example.org', '268 Brittany Ville
New Richard, WV 63878', 'GOLD', '3.186.235.19', '2023-05-07')
    , ('Samantha', 'Warren', 'fosterryan@example.org', '650 Holder Canyon Apt. 795
Johnsonburgh, CO 32103', 'SILVER', '64.177.61.190', '2023-05-07')
    , ('Christine', 'Moore', 'acooper@example.com', '0155 Thomas Mountain Suite 866
Nataliefurt, NE 69395', 'DIAMOND', '180.5.220.89', '2023-05-07')
    , ('Michael', 'Martinez', 'timothyhatfield@example.org', '707 Jeremy Forest Apt. 490
Stewartview, DE 84325', 'BRONZE', '186.248.0.49', '2023-05-07')
    , ('Gerald', 'Wolfe', 'rodriguezkelly@example.org', '742 Gregory Plains Apt. 112
Schroederbury, MA 24368', 'SILVER', '58.250.51.111', '2023-05-07')
    , ('Jackson', 'Fisher', 'samanthagray@example.com', '1694 Gabriel Burgs
South Kenneth, NY 05770', 'BRONZE', '141.249.70.41', '2023-05-07')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Frank', 'Walters', 'ericwalker@example.com', '4596 Jennifer Ways
Port Kaitlyn, NV 37831', 'DIAMOND', '219.205.113.95', '2023-05-024')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Courtney', 'Green', 'melvin95@example.net', 'PSC 8388, Box 8925
APO AP 41606', 'GOLD', '176.145.83.223', '2023-05-28')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Carrie', 'Daniel', 'ywalker@example.org', '166 Rios Vista Suite 325
Turnerburgh, TN 87251', '', '15.94.248.123', '2023-06-01')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jill', 'Elliott', 'davislisa@example.net', '815 Williams Lake Suite 614
Thomastown, TN 82153', 'GOLD', '168.183.26.61', '2023-06-09')
    , ('David', 'Jones', 'chungedward@example.org', '898 Diana Vista
Garciaview, CO 64953', 'BRONZE', '72.201.86.242', '2023-06-09')
    , ('Ralph', 'Callahan', 'akline@example.org', '55628 Laura Street Apt. 100
Jackfort, MD 94545', 'GOLD', '73.94.204.108', '2023-06-09')
    , ('Raymond', 'Morgan', 'susanobrien@example.com', 'PSC 5952, Box 5138
APO AE 51162', 'DIAMOND', '201.230.241.72', '2023-06-09')
    , ('Deanna', 'Nicholson', 'ryandaniels@example.com', '84159 Manning Road Suite 361
South Andrew, MO 39660', '', '59.59.32.228', '2023-06-09')
    , ('Alexandra', 'Young', 'boydedward@example.net', '3821 Park Meadow
West Jonathan, ID 29953', 'BRONZE', '126.9.6.122', '2023-06-09')
    , ('Tyler', 'Baker', 'loganbrendan@example.com', '94194 Brendan Fords Apt. 703
West Anna, NV 02724', '', '183.21.122.168', '2023-06-09')
    , ('Edward', 'Barton', 'hammondleroy@example.net', '1710 Kim Locks
New Craig, CA 84002', '', '117.236.71.114', '2023-06-09')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Gabriel', 'Davis', 'jhoward@example.net', '5145 Kristy River Suite 039
Lake Alyssa, MI 01632', 'BRONZE', '173.242.177.219', '2023-06-25')
    , ('Keith', 'Shaw', 'samantha95@example.com', '4755 Samantha Island
Helenberg, AS 66397', 'BRONZE', '55.153.39.66', '2023-06-25')
    , ('Holly', 'Campbell', 'simskyle@example.net', '58934 Rachel Falls Suite 870
Lake Ashleyfort, WV 18192', '', '160.111.83.6', '2023-06-25')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Miguel', 'Osborne', 'chris40@example.net', '323 Burton Land
Port Isabella, NE 14420', 'BRONZE', '41.187.215.2', '2023-07-03')
    , ('Rebecca', 'Robinson', 'lenicholas@example.net', '596 Theodore Union Apt. 361
South Kristenhaven, SC 55714', 'SILVER', '174.163.152.165', '2023-07-03')
    , ('Jason', 'Williams', 'holly20@example.com', '70238 Jessica Glens Apt. 783
Jonestown, MH 47435', 'GOLD', '188.183.173.107', '2023-07-03')
    , ('Christina', 'Delgado', 'qalvarez@example.net', '7571 Jennifer Lane Apt. 663
Marksfurt, VT 85867', 'BRONZE', '81.139.82.29', '2023-07-03')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Julia', 'Matthews', 'kbaldwin@example.org', '828 Sullivan Drive
West Matthew, MI 28028', 'DIAMOND', '1.36.160.150', '2023-07-13')
    , ('Colin', 'Johnson', 'briangarcia@example.net', 'Unit 2781 Box 8203
DPO AP 90396', 'BRONZE', '120.189.116.100', '2023-07-13')
    , ('Caleb', 'Brooks', 'kevin06@example.org', '44817 Walker Trace
New Shellyside, GU 98878', '', '177.37.61.203', '2023-07-13')
    , ('Timothy', 'Strong', 'sharongonzales@example.org', '367 Young Squares
East Debraberg, UT 39772', 'BRONZE', '22.132.199.0', '2023-07-13')
    , ('James', 'Russell', 'alexander19@example.com', 'PSC 5041, Box 3599
APO AE 72418', 'BRONZE', '1.160.250.203', '2023-07-13')
    , ('Rhonda', 'Alvarez', 'deannabyrd@example.net', '24327 Porter Springs Suite 608
Port Patrick, NM 95515', '', '161.24.124.11', '2023-07-13')
    , ('Charlene', 'Phelps', 'elizabeth49@example.com', '6921 Rogers Plains
West Renee, MP 40059', 'BRONZE', '189.107.179.66', '2023-07-13')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('David', 'Hayes', 'alyssa10@example.com', '63493 Dougherty Stream Apt. 419
Martinland, WI 10546', 'GOLD', '25.167.160.175', '2023-07-22')
    , ('Joshua', 'Perry', 'alvaradoalexis@example.net', '422 Robin Cliff Apt. 255
Vickishire, DE 93157', '', '67.120.117.139', '2023-07-22')
    , ('James', 'Turner', 'john10@example.com', '25520 Johnson Branch
East Lindsay, WI 60163', 'DIAMOND', '61.234.26.183', '2023-07-22')
    , ('Erin', 'Roberson', 'jesse36@example.com', '8423 Juan Locks
East Cheryl, FL 20375', 'GOLD', '161.201.234.34', '2023-07-22')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Donna', 'Pierce', 'keith82@example.org', '914 George Well Apt. 177
Robertoton, VA 71147', 'SILVER', '216.168.240.47', '2023-08-02')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Erik', 'Smith', 'ukidd@example.org', 'PSC 0413, Box 6285
APO AP 44444', 'GOLD', '86.193.16.132', '2023-08-03')
    , ('Jeffrey', 'Davis', 'anthony03@example.com', '37184 Swanson Spur Apt. 417
Cookfort, MD 67913', 'BRONZE', '10.16.40.11', '2023-08-03')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Gail', 'Perry', 'michael38@example.com', '39399 Washington Rue
Loganside, MN 10082', 'BRONZE', '179.128.89.71', '2023-08-09')
    , ('Brandi', 'Campbell', 'bgoodwin@example.com', '25088 Whitney Points Apt. 223
Lake Janice, PA 83166', 'GOLD', '103.33.72.155', '2023-08-09')
    , ('Thomas', 'Marshall', 'michellejackson@example.com', '302 Stephen Estates
North Linda, MT 53411', 'DIAMOND', '185.215.67.254', '2023-08-09')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Kayla', 'Burch', 'davidguerrero@example.com', '42239 Thomas Villages
Savannahshire, IL 66079', 'DIAMOND', '68.68.78.193', '2023-08-024')
    , ('Jeffrey', 'Flores', 'michelle99@example.org', '1161 Pacheco Lock
Timothyborough, FM 17514', '', '78.12.21.34', '2023-08-024')
    , ('Kristen', 'Farrell', 'adam86@example.com', 'PSC 1919, Box 0518
APO AA 69867', 'DIAMOND', '118.123.182.92', '2023-08-024')
    , ('Cynthia', 'Thompson', 'kferguson@example.net', 'USCGC Campbell
FPO AE 42591', '', '40.18.59.86', '2023-08-024')
    , ('Eddie', 'Carpenter', 'kfisher@example.com', '5353 Shaw Knolls Apt. 858
East Matthewville, UT 70090', 'SILVER', '105.126.80.171', '2023-08-024')
    , ('David', 'Dickson', 'dunndeborah@example.com', '3090 Lori Islands Apt. 813
South Cameron, WA 73588', 'DIAMOND', '118.243.157.58', '2023-08-024')
    , ('Nicole', 'Ruiz', 'rnichols@example.net', 'USNV Fisher
FPO AP 08907', 'BRONZE', '91.118.103.211', '2023-08-024')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jason', 'Lucas', 'hmora@example.com', '7975 Schwartz Creek Suite 689
Jonesland, VA 67147', 'BRONZE', '31.97.235.5', '2023-09-01')
    , ('Paul', 'Saunders', 'staceywoodard@example.com', '3020 Ochoa Stream Suite 986
Brittanyshire, MP 92353', 'DIAMOND', '161.219.183.149', '2023-09-01')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Andrew', 'Adams', 'charles68@example.org', 'USS Thomas
FPO AA 06998', 'GOLD', '197.147.236.160', '2023-09-02')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Brenda', 'Scott', 'nadkins@example.net', '8262 Bishop Streets Suite 724
Lake Jason, MA 76756', 'GOLD', '112.183.223.14', '2023-09-03')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Sandra', 'Cantrell', 'johnsonsara@example.net', 'USS Cruz
FPO AA 21878', 'SILVER', '103.66.69.129', '2022-12-03')
    , ('Janice', 'Ryan', 'wattsjessica@example.org', '98293 Nancy Hollow
New Angela, IL 28573', 'DIAMOND', '136.41.31.58', '2022-12-03')
    , ('Kevin', 'Mason', 'princetimothy@example.com', '5068 Scott Islands Apt. 449
South Scott, MN 66262', 'SILVER', '108.7.162.94', '2022-12-03')
    , ('Janet', 'Mason', 'rachelwong@example.org', '40796 Peterson Track Apt. 919
South Kimmouth, VA 30025', 'DIAMOND', '116.216.50.10', '2022-12-03')
    , ('Michelle', 'Cole', 'ediaz@example.net', '067 Garza Stravenue Suite 994
Reedton, SC 62873', 'GOLD', '83.126.44.141', '2022-12-03')
    , ('Daniel', 'Gonzalez', 'ashleybradley@example.com', '0585 Gregory Common Suite 048
Bobbystad, VI 85241', 'GOLD', '189.73.35.66', '2022-12-03')
    , ('Daniel', 'Valdez', 'virginia17@example.com', 'PSC 4494, Box 2353
APO AA 17794', 'BRONZE', '11.7.120.210', '2022-12-03')
    , ('Amanda', 'Joseph', 'calvin09@example.net', '0051 Miller Inlet
West Bryanshire, MA 40610', 'DIAMOND', '75.240.172.90', '2022-12-03')
    , ('Margaret', 'Gray', 'bryantamber@example.org', '682 Michelle Ranch Apt. 441
Martinland, NV 36147', 'GOLD', '62.134.203.241', '2022-12-03')
    , ('Joshua', 'Ayers', 'gmcclure@example.org', '1585 Miranda Knolls Suite 574
Murrayborough, ND 94227', 'SILVER', '192.131.130.108', '2022-12-03')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('James', 'Johnson', 'zcampbell@example.org', '96226 Williams Greens Apt. 717
Morganville, VA 58848', 'DIAMOND', '183.39.95.109', '2022-12-12')
    , ('Paula', 'Woodard', 'edwardrivera@example.net', '19043 Yoder Square
Whitetown, WI 81225', 'GOLD', '21.110.111.167', '2022-12-12')
    , ('Brian', 'Phillips', 'eric33@example.net', 'USNS Mendoza
FPO AA 56574', 'GOLD', '154.125.140.133', '2022-12-12')
    , ('Charles', 'Salazar', 'johnhall@example.com', '62561 Lin Vista
North Laurenshire, PW 68961', 'BRONZE', '205.192.96.147', '2022-12-12')
    , ('Jennifer', 'Franklin', 'jsawyer@example.net', '3474 Sarah Shoals
North Heatherfort, HI 60278', 'DIAMOND', '67.245.102.251', '2022-12-12')
    , ('Beverly', 'Mack', 'melissa80@example.org', 'USS Garrett
FPO AP 26383', 'GOLD', '26.211.71.83', '2022-12-12')
    , ('Kyle', 'Spence', 'itorres@example.net', '152 Kaitlyn Highway Suite 830
Lake Charles, MN 58786', 'GOLD', '91.3.178.25', '2022-12-12')
    , ('Angie', 'Williams', 'lewisrebecca@example.com', '053 Martinez Dale Suite 088
Collierton, TN 84486', 'DIAMOND', '27.35.30.31', '2022-12-12')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Jonathan', 'Stewart', 'shannonshaw@example.com', 'PSC 6828, Box 4170
APO AA 34805', 'SILVER', '121.76.184.207', '2022-12-17')
    , ('Mike', 'Long', 'brownrodney@example.net', '26556 Serrano Light Suite 176
Bullocktown, ME 67553', 'DIAMOND', '8.250.205.89', '2022-12-17')
    , ('Jeffrey', 'Bentley', 'shannon59@example.org', '27406 Steven Brook Apt. 612
New Abigail, MI 18998', 'DIAMOND', '112.37.67.123', '2022-12-17')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('Barbara', 'Mccullough', 'kellywest@example.net', '0008 Henderson Falls
Thomasstad, IL 31128', '', '37.64.109.73', '2022-11-16')
    , ('Jared', 'Bryant', 'mary56@example.org', '3567 Evans Fork Suite 907
Campbellhaven, WY 57847', 'BRONZE', '121.183.147.73', '2022-11-16')
    , ('Linda', 'Rose', 'michelleclark@example.com', '8754 Mcdonald Plains
New Evelynview, MD 79241', 'GOLD', '79.164.120.53', '2022-11-16')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since) VALUES
      ('John', 'Lewis', 'wtrevino@example.org', '0485 Jane Point
Port Feliciaberg, GU 87140', '', '183.48.72.96', '2022-11-14')
    , ('James', 'White', 'kelsey68@example.org', '59956 Kimberly Inlet
Port Suzanneshire, MO 32261', 'DIAMOND', '115.212.36.121', '2022-11-14')
;

DELETE FROM user ORDER BY email ASC LIMIT 6;
DELETE FROM user ORDER BY email DESC LIMIT 6;
DELETE FROM user ORDER BY first_name ASC LIMIT 2;
DELETE FROM user ORDER BY first_name ASC LIMIT 2;
DELETE FROM user ORDER BY first_name ASC LIMIT 2;
DELETE FROM user ORDER BY last_name DESC LIMIT 3;

-- simulate UPDATEs

SET @uuid := UUID();
INSERT INTO user (uuid, first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      (@uuid, 'Amanda', 'Lawson', 'jocelynporter@example.org', '30834 Michael Isle Apt. 109
Jenniferville, FL 13441', '', '57.218.73.62', '2023-02-03 08:00:00', '2023-04-15 09:00:00'),
      (@uuid, 'Amanda', 'Lawson', 'jocelynporter@example.org', '30834 Michael Isle Apt. 109
Jenniferville, FL 13441', 'SILVER', '57.218.73.62', '2023-04-15 09:00:00', '2023-05-15 10:00:00'),
      (@uuid, 'Amanda', 'Lawson', 'jocelynporter@example.org', '22 Greene Cape
Griffinstad, FL 13441', 'SILVER', '57.218.73.62', '2023-05-15 10:00:00', '2023-07-20 11:00:00'),
      (@uuid, 'Amanda', 'Lawson', 'jocelynporter@example.org', '22 Greene Cape
Griffinstad, FL 13441', 'GOLD', '57.218.73.62', '2023-07-20 11:00:00', '2038-01-19 03:14:07.999999')
;

SET @uuid := UUID();
INSERT INTO user (uuid, first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      (@uuid, 'David', 'Simpson', 'williamscrystal@example.com', '9538 Flores Mountains
Ewingchester, NM 52424', 'SILVER', '128.248.247.252', '2023-01-02 08:00:00', '2023-02-09 09:00:00'),
      (@uuid, 'David', 'Simpson', 'williamscrystal@example.com', '9538 Flores Mountains
Ewingchester, NM 52424', 'GOLD', '128.248.247.252', '2023-02-09 09:00:00', '2038-01-19 03:14:07.999999')
;

SET @uuid := UUID();
INSERT INTO user (uuid, first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      (@uuid, 'James', 'Frederick', 'stokestroy@example.org', '06725 Davidson Ford
Port Joseph, CT 44596', 'SILVER', '146.126.228.77', '2023-04-02 08:00:00', '2023-07-21 09:00:00'),
      (@uuid, 'James', 'Frederick', 'stokestroy@example.org', '76997 Young Mall Apt. 268
Port Monica, MI 25700', 'SILVER', '146.126.228.77', '2023-07-21 09:00:00', '2038-01-19 03:14:07.999999')
;

-- simulate DELETEs

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      ('Monica', 'Martinez', 'hwells@example.net', '867 Palmer Stream Suite 287
South Christinemouth, NM 45215', '', '199.22.220.109', '2022-12-29 08:00:00', '2023-06-10 09:00:00')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      ('Barbara', 'Hamilton', 'nathanielvilla@example.net', '29194 Myers Knoll
Port Barry, IN 14581', '', '166.167.166.143', '2023-01-13 08:00:00', '2023-03-23 09:00:00')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      ('Sheila', 'Contreras', 'ryanschroeder@example.org', '99932 Rodgers Road
Johnsonfort, LA 04743', '', '158.44.131.6', '2023-01-19 08:00:00', '2023-04-07 09:00:00')
;

INSERT INTO user (first_name, last_name, email, address, subscription_type, ip, valid_since, valid_until) VALUES
      ('Maria', 'Martin', 'smithmichael@example.com', '41836 Edward Stravenue
West Oscar, OH 89050', 'GOLD', '26.69.189.241', '2023-01-30 08:00:00', '2023-04-02 08:00:00')
;

