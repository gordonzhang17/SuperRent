drop table ret;
drop table rent_reserve;
drop table rent;
drop table reservation;
drop table vehicle;
drop table vehicle_type;
drop table vehicle_type_name;
drop table vehicle_status;
drop table customer;
drop table branch;


create table branch (
    location varchar(100) not null,
    city varchar(30) not null,
    PRIMARY KEY (location, city)
);

create table customer (
cellphone integer not null,
name varchar(100) not null,
address varchar(50) not null,
dlicense integer not null PRIMARY KEY
);

create table vehicle_status
(
status varchar(11) not null PRIMARY KEY
);


create table vehicle_type_name
(
vtname varchar(30) not null PRIMARY KEY
);

create table vehicle_type
(
vtname varchar(30) not null PRIMARY KEY,
features varchar(30),
weekly_rate decimal(10, 2),
daily_rate decimal(10, 2),
hourly_rate decimal(10, 2),
kilo_rate decimal(10,2),
hourly_insurance_rate decimal(10,2),
daily_insurance_rate decimal(10,2),
weekly_insurance_rate decimal(10,2),
foreign key (vtname) references vehicle_type_name
);


create table vehicle(
    id integer not null PRIMARY KEY,
    license varchar(10),
    make varchar(50),
    model varchar(50),
    year integer,
    color varchar(20),
    odometer integer,
    status varchar(30) default 'available',
    vtname varchar(30) not null ,
    location varchar(100) not null,
    city varchar(30) not null,
    foreign key (status) references vehicle_status,
    foreign key (location, city) references branch,
    foreign key (vtname) references vehicle_type
);

create table reservation (
      confNo integer not null PRIMARY KEY,
      vtname varchar(30) not null,
      location varchar(100) not null,
      city varchar(30) not null,
      dlicense integer not null,
      fromDate timestamp not null,
      toDate timestamp not null,
      foreign key (vtname) references vehicle_type,
      foreign key (dlicense) references customer,
      foreign key (location, city) references branch
);

create table rent (
    rent_id integer not null PRIMARY KEY,
    vehicle_id integer not null,
    dlicense integer not null,
    fromDate timestamp not null,
    toDate timestamp not null,
    odometer integer,
    cardName varchar(100) not null,
    cardNo integer not null,
    expDate varchar(5) not null, -- of form xx/xx (eg 12/15, month/year)
    reservation_confNo integer not null,
    foreign key (vehicle_id) references vehicle,
    foreign key (dlicense) references customer,
    foreign key (reservation_confNo) references reservation
);

create table rent_reserve
(
rent_id integer not null UNIQUE,
reservation_confNo integer not null UNIQUE,
PRIMARY KEY (rent_id, reservation_confNo),
foreign key (rent_id) references rent,
foreign key (reservation_confNo) references reservation
);

create table ret (
    rent_id integer not null,
    return_date timestamp not null,
    odometer integer,
    fullTank char(1) not null,
    cost decimal(10, 2) not null,
    PRIMARY KEY (rent_id, odometer, fullTank, cost),
    foreign key (rent_id) references rent
);

insert into branch (location, city) values ('A', 'NY');
insert into branch (location, city) values ('B', 'Vancouver');
insert into branch (location, city) values ('C', 'Montreal');
insert into branch (location, city) values ('D', 'Chicago');

insert into vehicle_status values('maintenance');
insert into vehicle_status values('rented');
insert into vehicle_status values('available');

insert into vehicle_type_name values('Economy');
insert into vehicle_type_name values('Compact');
insert into vehicle_type_name values('Mid-size');
insert into vehicle_type_name values('Standard');
insert into vehicle_type_name values('Full-size');
insert into vehicle_type_name values('SUV');
insert into vehicle_type_name values('Truck');

insert into vehicle_type values('Economy', 'Heated Seats', 68.25, 87.03, 43.16, 81.37, 51.13, 29.97, 10.73);
insert into vehicle_type values('Compact', 'Sport Mode', 2.24, 89.93, 97.59, 72.66, 44.2, 67.48, 14.39);
insert into vehicle_type values('Mid-size', 'Cup Holders', 42.08, 34.07, 16.58, 47.49, 54.22, 33.67, 82.3);
insert into vehicle_type values('Standard', 'GPS', 90.67, 71.11, 40.56, 29.4, 40.12, 39.55, 75.01);
insert into vehicle_type values('Full-size', 'Phone Holder', 4.44, 58.13, 37.64, 37.42, 95.22, 56.39, 70.47);
insert into vehicle_type values('SUV', 'Wooden Dashboard', 35.71, 5.91, 42.74, 36.4, 17.18, 8.95, 5.72);
insert into vehicle_type values('Truck', 'Television', 76.68, 52.01, 7.67, 50.15, 37.81, 72.84, 64.99);


insert into customer (cellphone, name, address, dlicense) values (1800260724, 'Evy Wauchope', '9970 Mcbride Road', 1464760813904568);
insert into customer (cellphone, name, address, dlicense) values (1188376342, 'Charlton Shann', '87592 Scott Plaza', 1003431773364583);
insert into customer (cellphone, name, address, dlicense) values (1913453414, 'Tildy Dulinty', '4 Burrows Trail', 1138205853540272);
insert into customer (cellphone, name, address, dlicense) values (1413391325, 'Lindsey Danilin', '69 Reindahl Junction', 1287221161963293);
insert into customer (cellphone, name, address, dlicense) values (1218427272, 'Denys Maycock', '483 Corry Road', 1599568771456998);
insert into customer (cellphone, name, address, dlicense) values (1643479770, 'Payton Filippucci', '53 Graedel Crossing', 1043198149577716);
insert into customer (cellphone, name, address, dlicense) values (1608493927, 'Kayne Kleanthous', '26017 Schlimgen Trail', 1301353898013687);
insert into customer (cellphone, name, address, dlicense) values (1247924582, 'Townie Debenham', '2701 Village Green Center', 1364304856015215);
insert into customer (cellphone, name, address, dlicense) values (1769557982, 'Nalani Sabathe', '56 Golf Course Lane', 1328602499376275);
insert into customer (cellphone, name, address, dlicense) values (1309821584, 'Rachael MacKartan', '1957 Upham Place', 1967745399184925);
insert into customer (cellphone, name, address, dlicense) values (1048639632, 'Byran Jojic', '74 Village Way', 1923809249233930);
insert into customer (cellphone, name, address, dlicense) values (1440986221, 'Kelley Desson', '53 Oriole Way', 1377812102957912);
insert into customer (cellphone, name, address, dlicense) values (1251587618, 'Aindrea Tacker', '1 Maple Circle', 1844434452180749);
insert into customer (cellphone, name, address, dlicense) values (1515810868, 'Torry Deetlof', '581 Rusk Road', 1881744304904937);
insert into customer (cellphone, name, address, dlicense) values (1727860604, 'Evangeline Moxon', '187 Ilene Center', 1620955592575593);
insert into customer (cellphone, name, address, dlicense) values (1133607004, 'Maximo Withrop', '009 Summer Ridge Terrace', 1773239088216297);
insert into customer (cellphone, name, address, dlicense) values (1323950555, 'Jacobo Benettolo', '412 Anderson Crossing', 1117346580190544);
insert into customer (cellphone, name, address, dlicense) values (1407611711, 'Donavon Mayhow', '58750 Lighthouse Bay Court', 1118010399074756);
insert into customer (cellphone, name, address, dlicense) values (1533580749, 'Rudiger Wisden', '82938 Talisman Hill', 1831466418060809);
insert into customer (cellphone, name, address, dlicense) values (1154042840, 'Glyn Blabber', '3 Elgar Plaza', 1442939731768603);
insert into customer (cellphone, name, address, dlicense) values (1716017420, 'Cloe Forty', '1225 Rusk Terrace', 1735120774428266);
insert into customer (cellphone, name, address, dlicense) values (1745791389, 'Carmelita Vanner', '3641 Surrey Avenue', 1770075089475797);
insert into customer (cellphone, name, address, dlicense) values (1012708187, 'Cherilynn Squeers', '97 Lighthouse Bay Court', 1436347351254680);
insert into customer (cellphone, name, address, dlicense) values (1785442570, 'Fleurette Olliffe', '792 Golf View Alley', 1978301779036105);
insert into customer (cellphone, name, address, dlicense) values (1708704499, 'Bree Denyukhin', '8 Granby Avenue', 1023349034522005);
insert into customer (cellphone, name, address, dlicense) values (1029947068, 'Erina Allison', '4 Linden Drive', 1565532435282445);
insert into customer (cellphone, name, address, dlicense) values (1702428423, 'Barbaraanne Smallpeace', '916 Dakota Crossing', 1305318398071937);
insert into customer (cellphone, name, address, dlicense) values (1718851142, 'Carlynne Oxbe', '49 Montana Road', 1088688095889315);
insert into customer (cellphone, name, address, dlicense) values (1120863960, 'Ellene Wellings', '35129 Northfield Circle', 1134043023652833);
insert into customer (cellphone, name, address, dlicense) values (1945906763, 'Filmore Lothlorien', '2 Mifflin Park', 1928909016898343);
insert into customer (cellphone, name, address, dlicense) values (1840193388, 'Sadella Cunradi', '7 Nelson Hill', 1330869763255269);
insert into customer (cellphone, name, address, dlicense) values (1066161726, 'Celine Shovelton', '80147 Charing Cross Lane', 1881435156120368);
insert into customer (cellphone, name, address, dlicense) values (1062551976, 'Gwenette Larkin', '6 Dakota Crossing', 1770254962613656);
insert into customer (cellphone, name, address, dlicense) values (1690808349, 'Larina Lavington', '18 Golf Terrace', 1198218472696347);
insert into customer (cellphone, name, address, dlicense) values (1568140440, 'Eduardo Cowpertwait', '361 Heath Road', 1851150051204974);
insert into customer (cellphone, name, address, dlicense) values (1207052995, 'Valma Demicoli', '3129 Pleasure Court', 1497672859615595);
insert into customer (cellphone, name, address, dlicense) values (1651024571, 'Fleurette Payn', '7885 2nd Center', 1019574222708347);
insert into customer (cellphone, name, address, dlicense) values (1761513395, 'Vida Hillett', '2415 Anthes Junction', 1088166428802582);
insert into customer (cellphone, name, address, dlicense) values (1191775750, 'Wayland Dacombe', '6071 Red Cloud Hill', 1071927217225382);
insert into customer (cellphone, name, address, dlicense) values (1813434118, 'Dennison Elizabeth', '338 Brown Junction', 1244509306123938);
insert into customer (cellphone, name, address, dlicense) values (1863275934, 'Feliza Ricci', '90 Lindbergh Place', 1370183302859003);
insert into customer (cellphone, name, address, dlicense) values (1122723145, 'Monique Ebbers', '6 Talisman Circle', 1918942858230626);

insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (142548224707, 'AZEA1A', 'Buick', 'Lucerne', 2006, 'Khaki', 9944, 'rented', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (146848623756, '5AUD0V', 'Kia', 'Optima', 2009, 'Goldenrod', 9988, 'rented', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (125311816455, 'H6EWSJ', 'Mazda', 'B-Series Plus', 1998, 'Goldenrod', 9782, 'rented', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (125485725811, 'PIE7H8', 'Porsche', '911', 1993, 'Mauv', 9179, 'rented', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (159187916154, 'WQAPAF', 'Mitsubishi', 'Diamante', 2004, 'Mauv', 9991, 'rented', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (118565172797, 'MXGNU0', 'BMW', 'M3', 1995, 'Pink', 9639, 'rented', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (161537388948, 'II1COI', 'Pontiac', 'Safari', 1987, 'Goldenrod', 9863, 'rented', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (171593772918, 'D21VXH', 'Chevrolet', '2500', 1998, 'Mauv', 9784, 'rented', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (119676370689, 'QI1CXW', 'Chevrolet', 'Express 2500', 2007, 'Aquamarine', 9521, 'rented', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (190527399900, 'JGJA0Y', 'Mitsubishi', 'Raider', 2006, 'Orange', 9059, 'rented', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (166754780135, 'ZZWDVM', 'Chevrolet', 'Equinox', 2005, 'Purple', 9232, 'rented', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (169511630929, '936DMR', 'Lamborghini', 'MurciÃ©lago', 2008, 'Green', 9867, 'rented', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (193828714691, 'XWH7DE', 'Kia', 'Rio', 2013, 'Aquamarine', 9274, 'rented', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (100160612388, '64KK0H', 'Audi', 'A3', 2006, 'Goldenrod', 9333, 'rented', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (101817161507, 'T3RVQX', 'Mitsubishi', 'Diamante', 1992, 'Mauv', 9663, 'rented', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (196864116718, 'MVJFC3', 'Acura', 'TSX', 2005, 'Khaki', 9468, 'rented', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (161539380367, 'RUKAOW', 'Chrysler', '300', 2005, 'Crimson', 9919, 'rented', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (138222261337, 'LNREWT', 'Mazda', '323', 1995, 'Blue', 9162, 'rented', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (176070596393, '9L7E23', 'Subaru', 'Forester', 2007, 'Aquamarine', 9689, 'rented', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (105447055003, '9JIKWK', 'Audi', 'S4', 2000, 'Teal', 9530, 'rented', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (123161806558, 'MLLF0I', 'Lincoln', 'Continental Mark VII', 1988, 'Mauv', 9813, 'rented', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (118319517556, '3TWDRD', 'Mercedes-Benz', 'SL65 AMG', 2006, 'Maroon', 9135, 'rented', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (183747695712, '2YD77L', 'Mercury', 'Grand Marquis', 1995, 'Goldenrod', 9980, 'rented', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (158633884137, 'SZZATQ', 'Chevrolet', 'Camaro', 2011, 'Blue', 9542, 'rented', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (115403559213, 'S4X4PG', 'Ford', 'F250', 2003, 'Mauv', 9360, 'rented', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (167732356154, 'UDA3KL', 'Ford', 'Escort', 1996, 'Crimson', 9677, 'rented', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (169139734657, 'SUGA7W', 'Chevrolet', 'Lumina', 1998, 'Khaki', 9155, 'rented', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (178776492331, '37B1OX', 'Nissan', 'Sentra', 2012, 'Goldenrod', 9416, 'rented', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (194212082763, 'X73HIW', 'Dodge', 'Ram 1500 Club', 1997, 'Red', 9873, 'rented', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (197262805517, '58N0NI', 'Kia', 'Sportage', 1996, 'Turquoise', 9115, 'rented', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (108778379495, 'GI8A5E', 'Dodge', 'Ramcharger', 1992, 'Teal', 9926, 'rented', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (158647124988, '044741', 'Mercedes-Benz', 'SL-Class', 1996, 'Pink', 9404, 'rented', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (198565662476, 'JJM9PT', 'Toyota', 'Sequoia', 2012, 'Blue', 9455, 'rented', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (147497424893, '06FH1T', 'Volkswagen', 'GTI', 1997, 'Fuscia', 9948, 'rented', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (137643194277, 'X4P85O', 'Chevrolet', 'Prizm', 1998, 'Turquoise', 9238, 'rented', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (129037495457, 'BP8APR', 'Ford', 'Explorer Sport Trac', 2010, 'Indigo', 9792, 'rented', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (156078107133, '78KW8X', 'Audi', 'A8', 2006, 'Red', 9783, 'rented', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (199657303957, '251NVF', 'Bentley', 'Azure T', 2010, 'Puce', 9829, 'rented', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (155158587031, '3QWOUS', 'Land Rover', 'LR3', 2009, 'Red', 9035, 'rented', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (112188410557, 'ZSMCAL', 'Ford', 'Fusion', 2007, 'Orange', 9285, 'rented', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (176650219557, 'PBPRPQ', 'Volkswagen', 'Golf', 1985, 'Red', 9726, 'rented', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (161361477960, 'HUCR80', 'Chevrolet', 'Cavalier', 2000, 'Yellow', 9698, 'rented', 'Truck', 'B', 'Vancouver');

insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (16310328826, 'Economy', 'A', 'NY', 1978301779036105, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (18332760343, 'Compact', 'B', 'Vancouver', 1464760813904568, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (19218678046, 'Mid-size', 'C', 'Montreal', 1773239088216297, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (19132909178, 'Standard', 'D', 'Chicago', 1599568771456998, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (17150525547, 'Full-size', 'A', 'NY', 1831466418060809, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (12863716884, 'SUV', 'B', 'Vancouver', 1851150051204974, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (12252659448, 'Truck', 'C', 'Montreal', 1364304856015215, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (18356377370, 'Economy', 'D', 'Chicago', 1773239088216297, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (10507614359, 'Compact', 'A', 'NY', 1844434452180749, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (17860780367, 'Mid-size', 'B', 'Vancouver', 1244509306123938, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (15485742758, 'Standard', 'C', 'Montreal', 1735120774428266, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (19516002645, 'Full-size', 'D', 'Chicago', 1287221161963293, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (17735379039, 'SUV', 'A', 'NY', 1134043023652833, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (14808640064, 'Truck', 'B', 'Vancouver', 1967745399184925, to_timestamp('2019-11-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (14477553595, 'Economy', 'C', 'Montreal', 1844434452180749, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (11471234499, 'Compact', 'D', 'Chicago', 1198218472696347, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (14753622286, 'Mid-size', 'A', 'NY', 1287221161963293, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (11765265923, 'Standard', 'B', 'Vancouver', 1003431773364583, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (18323762743, 'Full-size', 'C', 'Montreal', 1442939731768603, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (17268485830, 'SUV', 'D', 'Chicago', 1978301779036105, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (10419602187, 'Truck', 'A', 'NY', 1370183302859003, to_timestamp('2019-11-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (13115959590, 'Economy', 'B', 'Vancouver', 1198218472696347, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (12585001040, 'Compact', 'C', 'Montreal', 1773239088216297, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (12250255718, 'Mid-size', 'D', 'Chicago', 1967745399184925, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (19219050323, 'Standard', 'A', 'NY', 1364304856015215, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (13528951170, 'Full-size', 'B', 'Vancouver', 1497672859615595, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (11364418112, 'SUV', 'C', 'Montreal', 1565532435282445, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (14406775716, 'Truck', 'D', 'Chicago', 1117346580190544, to_timestamp('2019-11-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (15143667742, 'Economy', 'A', 'NY', 1773239088216297, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (12086901040, 'Compact', 'B', 'Vancouver', 1923809249233930, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (17861026401, 'Mid-size', 'C', 'Montreal', 1118010399074756, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (11933609639, 'Standard', 'D', 'Chicago', 1198218472696347, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (19891588746, 'Full-size', 'A', 'NY', 1364304856015215, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (11263294283, 'SUV', 'B', 'Vancouver', 1844434452180749, to_timestamp('2019-11-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (18870679015, 'Truck', 'C', 'Montreal', 1851150051204974, to_timestamp('2019-11-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (11095722695, 'Economy', 'D', 'Chicago', 1928909016898343, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (18280015032, 'Compact', 'A', 'NY', 1599568771456998, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (10921419427, 'Mid-size', 'B', 'Vancouver', 1464760813904568, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (19004813820, 'Standard', 'C', 'Montreal', 1023349034522005, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (13282481381, 'Full-size', 'D', 'Chicago', 1305318398071937, to_timestamp('2019-11-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (16019781244, 'SUV', 'A', 'NY', 1023349034522005, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (10629675837, 'Truck', 'B', 'Vancouver', 1967745399184925, to_timestamp('2019-11-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));

insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1308228375, 142548224707, 1978301779036105, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10073, 'Sadella Cunradi', 503812399096420160, '12/23', 16310328826);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1394810376, 146848623756, 1464760813904568, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10030, 'Rachael MacKartan', 3546099895160726, '12/23', 18332760343);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1452103843, 125311816455, 1773239088216297, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10095, 'Barbaraanne Smallpeace', 3571540289925727, '12/23', 19218678046);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1721667525, 125485725811, 1599568771456998, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10022, 'Tildy Dulinty', 4903376377511161, '12/23', 19132909178);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1988996211, 159187916154, 1831466418060809, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10041, 'Barbaraanne Smallpeace', 633110375246820480, '12/23', 17150525547);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1647965573, 118565172797, 1851150051204974, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10067, 'Fleurette Olliffe', 5602247503824698, '12/23', 12863716884);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1873284099, 161537388948, 1364304856015215, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10069, 'Aindrea Tacker', 5048377107504669, '12/23', 12252659448);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1428659116, 171593772918, 1773239088216297, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10021, 'Carlynne Oxbe', 4017953775434, '12/23', 18356377370);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1437953156, 119676370689, 1844434452180749, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10088, 'Kelley Desson', 374283665562732, '12/23', 10507614359);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1351280236, 190527399900, 1244509306123938, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10036, 'Celine Shovelton', 5602226624546197504, '12/23', 17860780367);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1481090647, 166754780135, 1735120774428266, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10100, 'Fleurette Olliffe', 201971799977185, '12/23', 15485742758);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1097053727, 169511630929, 1287221161963293, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10042, 'Carlynne Oxbe', 3535846939459958, '12/23', 19516002645);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1010478826, 193828714691, 1134043023652833, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10082, 'Evy Wauchope', 3567899672094723, '12/23', 17735379039);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1264607099, 100160612388, 1967745399184925, to_timestamp('2019-11-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10081, 'Torry Deetlof', 30529432579953, '12/23', 14808640064);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1264639805, 101817161507, 1844434452180749, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10048, 'Rachael MacKartan', 3551643112327089, '12/23', 14477553595);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1424399404, 196864116718, 1198218472696347, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10099, 'Rachael MacKartan', 6709888597124675, '12/23', 11471234499);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1335325690, 161539380367, 1287221161963293, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10056, 'Payton Filippucci', 501826947290637632, '12/23', 14753622286);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1433847894, 138222261337, 1003431773364583, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10021, 'Kayne Kleanthous', 30345629823546, '12/23', 11765265923);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1626523549, 176070596393, 1442939731768603, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10019, 'Byran Jojic', 4026531340121207, '12/23', 18323762743);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1323236440, 105447055003, 1978301779036105, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10048, 'Glyn Blabber', 201905984680873, '12/23', 17268485830);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1682935587, 123161806558, 1370183302859003, to_timestamp('2019-11-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10091, 'Lindsey Danilin', 3580032826312816, '12/23', 10419602187);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1499805709, 118319517556, 1198218472696347, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10048, 'Aindrea Tacker', 6706303353195722, '12/23', 13115959590);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1864188597, 183747695712, 1773239088216297, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10047, 'Maximo Withrop', 3567858409101276, '12/23', 12585001040);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1258148662, 158633884137, 1967745399184925, to_timestamp('2019-11-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10050, 'Lindsey Danilin', 5184876026189175, '12/23', 12250255718);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1692275316, 115403559213, 1364304856015215, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10072, 'Larina Lavington', 4508580414171413, '12/23', 19219050323);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1532294319, 167732356154, 1497672859615595, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10067, 'Lindsey Danilin', 3544868255062298, '12/23', 13528951170);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1705337805, 169139734657, 1565532435282445, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10061, 'Lindsey Danilin', 3586761178276948, '12/23', 11364418112);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1620083875, 178776492331, 1117346580190544, to_timestamp('2019-11-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10066, 'Vida Hillett', 3531014847030064, '12/23', 14406775716);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1175989699, 194212082763, 1773239088216297, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10063, 'Kelley Desson', 6304315711777867776, '12/23', 15143667742);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1299508137, 197262805517, 1923809249233930, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10097, 'Fleurette Payn', 3572693140777438, '12/23', 12086901040);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1491247718, 108778379495, 1118010399074756, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10030, 'Fleurette Payn', 67619107751636152, '12/23', 17861026401);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1266307426, 158647124988, 1198218472696347, to_timestamp('2019-11-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10098, 'Celine Shovelton', 3589079269524697, '12/23', 11933609639);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1553366528, 198565662476, 1364304856015215, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10078, 'Sadella Cunradi', 201776746445438, '12/23', 19891588746);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1142570688, 147497424893, 1844434452180749, to_timestamp('2019-11-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10048, 'Feliza Ricci', 5562630236150598, '12/23', 11263294283);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1907338358, 137643194277, 1851150051204974, to_timestamp('2019-11-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10040, 'Cloe Forty', 337941880907182, '12/23', 18870679015);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1119360149, 129037495457, 1928909016898343, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10021, 'Kelley Desson', 5602225065774803968, '12/23', 11095722695);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1440181468, 156078107133, 1599568771456998, to_timestamp('2019-11-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10097, 'Denys Maycock', 5010124616249848, '12/23', 18280015032);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1010150066, 199657303957, 1464760813904568, to_timestamp('2019-11-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10099, 'Vida Hillett', 30277842481127, '12/23', 10921419427);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1215765157, 155158587031, 1023349034522005, to_timestamp('2019-11-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10099, 'Gwenette Larkin', 30432190970516, '12/23', 19004813820);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1809279545, 112188410557, 1305318398071937, to_timestamp('2019-11-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10026, 'Vida Hillett', 3566574184249104, '12/23', 13282481381);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1757067005, 176650219557, 1023349034522005, to_timestamp('2019-11-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10019, 'Kelley Desson', 3564262961855598, '12/23', 16019781244);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (1128355015, 161361477960, 1967745399184925, to_timestamp('2019-11-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10063, 'Torry Deetlof', 3570216817471218, '12/23', 10629675837);

insert into rent_reserve (rent_id, reservation_confno) values (1308228375, 16310328826);
insert into rent_reserve (rent_id, reservation_confno) values (1647965573, 12863716884);
insert into rent_reserve (rent_id, reservation_confno) values (1873284099, 12252659448);
insert into rent_reserve (rent_id, reservation_confno) values (1428659116, 18356377370);
insert into rent_reserve (rent_id, reservation_confno) values (1437953156, 10507614359);
insert into rent_reserve (rent_id, reservation_confno) values (1351280236, 17860780367);
insert into rent_reserve (rent_id, reservation_confno) values (1481090647, 15485742758);
insert into rent_reserve (rent_id, reservation_confno) values (1097053727, 19516002645);
insert into rent_reserve (rent_id, reservation_confno) values (1010478826, 17735379039);
insert into rent_reserve (rent_id, reservation_confno) values (1264607099, 14808640064);
insert into rent_reserve (rent_id, reservation_confno) values (1264639805, 14477553595);
insert into rent_reserve (rent_id, reservation_confno) values (1424399404, 11471234499);
insert into rent_reserve (rent_id, reservation_confno) values (1335325690, 14753622286);
insert into rent_reserve (rent_id, reservation_confno) values (1433847894, 11765265923);
insert into rent_reserve (rent_id, reservation_confno) values (1626523549, 18323762743);
insert into rent_reserve (rent_id, reservation_confno) values (1323236440, 17268485830);
insert into rent_reserve (rent_id, reservation_confno) values (1682935587, 10419602187);
insert into rent_reserve (rent_id, reservation_confno) values (1499805709, 13115959590);
insert into rent_reserve (rent_id, reservation_confno) values (1864188597, 12585001040);
insert into rent_reserve (rent_id, reservation_confno) values (1258148662, 12250255718);
insert into rent_reserve (rent_id, reservation_confno) values (1692275316, 19219050323);
insert into rent_reserve (rent_id, reservation_confno) values (1532294319, 13528951170);
insert into rent_reserve (rent_id, reservation_confno) values (1705337805, 11364418112);
insert into rent_reserve (rent_id, reservation_confno) values (1620083875, 14406775716);
insert into rent_reserve (rent_id, reservation_confno) values (1175989699, 15143667742);
insert into rent_reserve (rent_id, reservation_confno) values (1299508137, 12086901040);
insert into rent_reserve (rent_id, reservation_confno) values (1491247718, 17861026401);
insert into rent_reserve (rent_id, reservation_confno) values (1266307426, 11933609639);
insert into rent_reserve (rent_id, reservation_confno) values (1553366528, 19891588746);
insert into rent_reserve (rent_id, reservation_confno) values (1142570688, 11263294283);
insert into rent_reserve (rent_id, reservation_confno) values (1907338358, 18870679015);
insert into rent_reserve (rent_id, reservation_confno) values (1119360149, 11095722695);
insert into rent_reserve (rent_id, reservation_confno) values (1440181468, 18280015032);
insert into rent_reserve (rent_id, reservation_confno) values (1010150066, 10921419427);
insert into rent_reserve (rent_id, reservation_confno) values (1215765157, 19004813820);
insert into rent_reserve (rent_id, reservation_confno) values (1809279545, 13282481381);
insert into rent_reserve (rent_id, reservation_confno) values (1757067005, 16019781244);
insert into rent_reserve (rent_id, reservation_confno) values (1128355015, 10629675837);

insert into customer (cellphone, name, address, dlicense) values (2922122656, 'Annis Caton', '53039 Corscot Center', 2572446259503098);
insert into customer (cellphone, name, address, dlicense) values (2293212483, 'Niles Ritchings', '75 Eastlawn Place', 2548539565817465);
insert into customer (cellphone, name, address, dlicense) values (2839352278, 'Corissa Marchenko', '97 Hooker Junction', 2694438515812297);
insert into customer (cellphone, name, address, dlicense) values (2941113376, 'Judye Gove', '17100 Roxbury Pass', 2477518636321758);
insert into customer (cellphone, name, address, dlicense) values (2586801308, 'Lawton Kwiek', '938 Del Mar Parkway', 2723249744462956);
insert into customer (cellphone, name, address, dlicense) values (2931069015, 'Norean Amthor', '680 Amoth Terrace', 2670121699890688);
insert into customer (cellphone, name, address, dlicense) values (2973673634, 'Torey Barwood', '87 Division Way', 2176155852252261);
insert into customer (cellphone, name, address, dlicense) values (2205326006, 'Verne Reid', '06 Anniversary Hill', 2240697189980022);
insert into customer (cellphone, name, address, dlicense) values (2909689152, 'Calla Rupprecht', '51556 Magdeline Terrace', 2550562094506542);
insert into customer (cellphone, name, address, dlicense) values (2096832639, 'Demeter Shrubshall', '7369 Transport Pass', 2900004698496957);
insert into customer (cellphone, name, address, dlicense) values (2393966383, 'Marquita Pitman', '8397 Hanson Drive', 2441310509849012);
insert into customer (cellphone, name, address, dlicense) values (2411537916, 'Alyssa Foddy', '52 Talisman Plaza', 2375693694535069);
insert into customer (cellphone, name, address, dlicense) values (2951894594, 'Inness Muggeridge', '5 Towne Center', 2382893829855313);
insert into customer (cellphone, name, address, dlicense) values (2897939731, 'Griz Squibbes', '1061 Sauthoff Park', 2546171033577062);
insert into customer (cellphone, name, address, dlicense) values (2402798769, 'Gerardo Beslier', '82 Eastwood Street', 2000265972908510);
insert into customer (cellphone, name, address, dlicense) values (2822149901, 'Randall Paddingdon', '1 Independence Plaza', 2782541119907559);
insert into customer (cellphone, name, address, dlicense) values (2596499936, 'Vanda Wiszniewski', '80174 Crownhardt Street', 2845467341445120);
insert into customer (cellphone, name, address, dlicense) values (2226740495, 'Iver Antuoni', '211 Quincy Lane', 2406675965364908);
insert into customer (cellphone, name, address, dlicense) values (2844528511, 'Dorry Davley', '9 Novick Place', 2765664461124252);
insert into customer (cellphone, name, address, dlicense) values (2423421968, 'Alphonso Adney', '85218 Karstens Place', 2999712506861100);
insert into customer (cellphone, name, address, dlicense) values (2636653182, 'Lyndsay Royl', '97902 Eastlawn Parkway', 2692995883024012);
insert into customer (cellphone, name, address, dlicense) values (2594238176, 'Zia Perroni', '63535 Manufacturers Avenue', 2911841831556093);
insert into customer (cellphone, name, address, dlicense) values (2990561398, 'Theresa Woodson', '3076 Hazelcrest Trail', 2499696832811337);
insert into customer (cellphone, name, address, dlicense) values (2920952457, 'Pavla Hulkes', '29134 Hermina Circle', 2694146450030708);
insert into customer (cellphone, name, address, dlicense) values (2064245455, 'Virginie Ondrak', '0 Heffernan Alley', 2073188947066800);
insert into customer (cellphone, name, address, dlicense) values (2334447896, 'Nikolia Copping', '847 South Pass', 2109526838937190);
insert into customer (cellphone, name, address, dlicense) values (2777007931, 'Dianna Andres', '96 Moland Junction', 2080108661976742);
insert into customer (cellphone, name, address, dlicense) values (2448351766, 'Germain Cakes', '51 Acker Place', 2671986621318344);
insert into customer (cellphone, name, address, dlicense) values (2058774241, 'Ludwig Jeannard', '75 Prentice Terrace', 2415504436476149);
insert into customer (cellphone, name, address, dlicense) values (2219485966, 'Eldon Wadworth', '7 Vermont Street', 2064807827851674);
insert into customer (cellphone, name, address, dlicense) values (2965060939, 'Freddie Kemish', '1 Springview Way', 2092004208711840);
insert into customer (cellphone, name, address, dlicense) values (2008222807, 'Bil De Vaux', '2 Garrison Trail', 2537393469244572);
insert into customer (cellphone, name, address, dlicense) values (2627352336, 'Conrade Giraths', '4 Glendale Way', 2072046361687871);
insert into customer (cellphone, name, address, dlicense) values (2262568559, 'Juieta Feavearyear', '773 Comanche Point', 2625002380534414);
insert into customer (cellphone, name, address, dlicense) values (2593007760, 'Humfried Tryhorn', '8 Eggendart Plaza', 2812946166601912);
insert into customer (cellphone, name, address, dlicense) values (2153274306, 'Brenda Slade', '472 Comanche Drive', 2643043183073393);
insert into customer (cellphone, name, address, dlicense) values (2679336172, 'Walther Piper', '3 Surrey Road', 2881847743973028);
insert into customer (cellphone, name, address, dlicense) values (2105193137, 'Esme Geddes', '427 Declaration Avenue', 2043019920185353);
insert into customer (cellphone, name, address, dlicense) values (2339210813, 'Melania Fendlow', '362 Mockingbird Plaza', 2456530445972539);
insert into customer (cellphone, name, address, dlicense) values (2816690252, 'Eulalie Whayman', '8542 Melby Trail', 2946761092596025);
insert into customer (cellphone, name, address, dlicense) values (2161791302, 'Eugenia Andraud', '0048 Sutherland Plaza', 2122551634103995);
insert into customer (cellphone, name, address, dlicense) values (2044428979, 'Frederich Jacqueminet', '5 Commercial Circle', 2285204882614318);

insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (243320283359, 'YM7G28', 'Hyundai', 'Elantra', 1997, 'Mauv', 9451, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (271564005987, 'QR4BLV', 'Ford', 'Festiva', 1993, 'Goldenrod', 9710, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (202602509005, '493R4R', 'Saturn', 'VUE', 2004, 'Mauv', 9006, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (211069683349, 'NRLM7D', 'Nissan', 'Cube', 2010, 'Puce', 9716, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (225807259222, 'U4G4UH', 'Jaguar', 'XJ Series', 2000, 'Orange', 9341, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (261963456527, '2KVZ8X', 'Chevrolet', 'Equinox', 2007, 'Yellow', 9164, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (233641493816, 'JJ69NT', 'Suzuki', 'Forenza', 2005, 'Maroon', 9587, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (269440553378, '0IWNLE', 'Mitsubishi', 'Mighty Max', 1993, 'Teal', 9084, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (221548829525, '73MVVZ', 'GMC', 'Sierra', 2012, 'Turquoise', 9458, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (252168141744, 'PT0EXI', 'Land Rover', 'Defender 90', 1994, 'Turquoise', 9547, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (266646305373, 'U6AG4K', 'Buick', 'Electra', 1986, 'Yellow', 9082, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (224050569405, '8M0K8Q', 'Jeep', 'Liberty', 2003, 'Aquamarine', 9702, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (259503961606, '7AL7ZM', 'Chevrolet', 'Avalanche', 2008, 'Green', 9722, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (246552338985, 'S9S52V', 'GMC', 'Yukon', 1999, 'Aquamarine', 9439, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (295405830070, 'DT4P83', 'Volvo', 'S40', 2010, 'Violet', 9560, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (237559774208, 'GGT67G', 'Toyota', 'Camry Hybrid', 2008, 'Puce', 9423, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (236191005744, 'FM73UB', 'BMW', '3 Series', 2000, 'Teal', 9548, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (213369076769, 'AWBN4R', 'Dodge', 'Nitro', 2009, 'Mauv', 9920, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (244078508639, '77VXLK', 'Ford', 'F450', 2009, 'Red', 9041, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (253307557941, 'WCM6FG', 'Buick', 'Roadmaster', 1993, 'Blue', 9754, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (264780245396, 'RO8NJF', 'Isuzu', 'i-Series', 2007, 'Fuscia', 9827, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (227304199446, '9X7GM1', 'Lexus', 'ES', 1998, 'Maroon', 9786, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (265254178615, 'HK8Y8Q', 'Suzuki', 'Daewoo Lacetti', 2007, 'Blue', 9709, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (241069501436, '3B7FV7', 'Saab', '9-3', 2008, 'Mauv', 9331, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (274398993055, 'RL0EFI', 'Chevrolet', 'Malibu', 2001, 'Indigo', 9068, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (277182142363, 'VDX731', 'Buick', 'Regal', 1999, 'Orange', 9364, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (205380620577, '1PDP54', 'Chrysler', 'PT Cruiser', 2006, 'Orange', 9133, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (260730032729, 'PTQCF8', 'Mitsubishi', 'Precis', 1986, 'Fuscia', 9486, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (258871846090, 'P1DFR4', 'Dodge', 'Durango', 2006, 'Mauv', 9205, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (221734465420, '05V4MN', 'Pontiac', 'Grand Prix', 1969, 'Violet', 9764, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (204903261602, '11HNRK', 'Lincoln', 'Navigator', 2012, 'Indigo', 9529, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (290088671909, '244768', 'Volvo', 'S60', 2008, 'Teal', 9379, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (243908428330, 'T65E57', 'GMC', 'Yukon XL 2500', 2004, 'Khaki', 9458, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (277032019852, 'E4RMTV', 'Volkswagen', 'GTI', 2010, 'Mauv', 9046, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (236029794631, 'W0WJUD', 'Chevrolet', 'Prizm', 2002, 'Pink', 9987, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (289600687310, 'GL4WM3', 'Pontiac', 'Trans Sport', 1991, 'Puce', 9298, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (293341961053, '7W4A22', 'Chevrolet', 'Silverado 1500', 2012, 'Goldenrod', 9992, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (217579428871, 'SRLH1E', 'Maserati', 'Spyder', 2002, 'Turquoise', 9326, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (205945250660, 'KOBXUG', 'Mazda', 'Millenia', 1999, 'Green', 9966, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (297663774455, 'T4A0YF', 'Cadillac', 'Brougham', 1992, 'Puce', 9018, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (278976692898, 'A3WM4M', 'Mercedes-Benz', 'S-Class', 2011, 'Green', 9034, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (207213404012, 'OTLDNN', 'Honda', 'CR-V', 2008, 'Crimson', 9591, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (258273705611, 'PAX17A', 'Geo', 'Metro', 1993, 'Maroon', 9344, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (243445780177, 'SM4KZC', 'Jaguar', 'XJ', 2006, 'Aquamarine', 9588, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (214779300073, 'Y3XSTC', 'Chevrolet', 'Uplander', 2007, 'Pink', 9056, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (203239195512, 'U52C1L', 'Maybach', '57', 2003, 'Crimson', 9897, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (245793050870, '6KS02T', 'Honda', 'Prelude', 1992, 'Red', 9154, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (275473360134, 'TQW8CC', 'Pontiac', 'Grand Prix', 1967, 'Pink', 9117, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (211719949565, '6PETS4', 'Chevrolet', 'Corvette', 1962, 'Aquamarine', 9195, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (219937408546, '3NGNMY', 'Mitsubishi', 'Montero', 1992, 'Pink', 9134, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (261808556102, 'T7L4D4', 'Dodge', 'Grand Caravan', 1998, 'Mauv', 9330, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (224041059279, 'ZGYW2V', 'Buick', 'LeSabre', 2001, 'Puce', 9827, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (286428471702, 'U1J1EL', 'BMW', '3 Series', 1993, 'Maroon', 9420, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (205324705624, 'BUQ0XM', 'Chevrolet', 'Express 2500', 2003, 'Pink', 9963, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (272529891558, 'KMYAKV', 'Mitsubishi', 'Galant', 1991, 'Fuscia', 9479, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (258490377397, 'GWA9YD', 'Ford', 'E-Series', 1990, 'Red', 9431, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (222344793941, 'PNNKTQ', 'Ford', 'Edge', 2007, 'Puce', 9241, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (225835921137, '9ARVWM', 'Mitsubishi', 'Galant', 1996, 'Goldenrod', 9599, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (224147575626, 'WVEEPL', 'GMC', 'Savana 1500', 1996, 'Green', 9363, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (287910098275, 'ZPJU44', 'Ford', 'Mustang', 2002, 'Pink', 9361, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (257257044601, '3P9ET6', 'Volkswagen', 'GTI', 2005, 'Orange', 9078, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (209456250763, '0LDZP1', 'Toyota', 'Camry', 2001, 'Crimson', 9111, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (285687882141, 'LKZX7H', 'Chevrolet', 'Aveo', 2009, 'Indigo', 9604, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (276741111447, '18G67H', 'Mercedes-Benz', '400SE', 1992, 'Blue', 9621, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (245866581587, 'A08BJX', 'Ford', 'Taurus', 1992, 'Maroon', 9126, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (206166511412, 'BPIDU4', 'Mazda', 'CX-9', 2010, 'Pink', 9777, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (267267900235, 'NN2FJT', 'GMC', 'Yukon', 1993, 'Aquamarine', 9658, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (255182041149, 'FMJS34', 'Mazda', '626', 1990, 'Red', 9242, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (223268760286, 'PSP0X2', 'Cadillac', 'Escalade EXT', 2007, 'Crimson', 9650, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (259262075998, '2YWRJ4', 'Infiniti', 'J', 1997, 'Fuscia', 9408, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (272969043130, 'YGWZVK', 'MINI', 'Clubman', 2012, 'Fuscia', 9143, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (286426369600, 'O8BV8Z', 'Audi', '100', 1989, 'Puce', 9346, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (224209302183, '0MKG45', 'Chevrolet', 'Cavalier', 1994, 'Maroon', 9220, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (233916191274, 'QWENN8', 'Acura', 'RL', 2008, 'Aquamarine', 9068, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (247643121007, 'OX6485', 'Toyota', 'Tacoma Xtra', 2004, 'Orange', 9821, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (229623937588, '17HFBG', 'Chevrolet', 'Express 1500', 2008, 'Blue', 9013, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (287170310164, 'V8X28J', 'Volvo', 'XC90', 2003, 'Crimson', 9414, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (292810984367, 'EQNCMQ', 'Volkswagen', 'Golf', 1998, 'Blue', 9198, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (203157263157, 'NHODY4', 'Mercury', 'Mountaineer', 2001, 'Maroon', 9950, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (254316939155, '28SDIF', 'Volkswagen', 'Golf', 1994, 'Crimson', 9946, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (234574712409, '5F4ZG6', 'Nissan', 'Quest', 2011, 'Green', 9194, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (233129624211, 'GT9X7I', 'Subaru', 'SVX', 1997, 'Indigo', 9401, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (241665249282, '1FMR7V', 'Porsche', '944', 1990, 'Blue', 9661, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (200705177342, 'TKUX11', 'BMW', '525', 2005, 'Yellow', 9700, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (202634299193, 'EAW0SO', 'Mercury', 'Tracer', 1991, 'Violet', 9456, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (251396535174, 'SA7OKS', 'Mercury', 'Milan', 2010, 'Puce', 9629, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (293425768156, 'UZ9I8A', 'Dodge', 'Ram Van 2500', 1998, 'Red', 9511, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (261983869023, 'V7OWYT', 'Dodge', 'D350', 1992, 'Fuscia', 9190, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (222302497095, '4HWL4E', 'Ford', 'Econoline E250', 2002, 'Orange', 9241, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (288740167600, 'FDWM7Y', 'Mazda', '626', 1984, 'Teal', 9804, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (272689399739, '3HXBEJ', 'Infiniti', 'I', 2004, 'Goldenrod', 9883, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (233458177743, 'V106QR', 'Dodge', 'Grand Caravan', 2007, 'Goldenrod', 9200, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (286979063242, 'OH9PHA', 'Toyota', 'Solara', 2001, 'Fuscia', 9993, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (278088324480, 'UKGTA8', 'Chevrolet', 'Tahoe', 2010, 'Aquamarine', 9512, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (208341884253, 'IPNKOA', 'Ford', 'F250', 2007, 'Orange', 9884, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (208361121978, 'FAGR1N', 'Maserati', 'Spyder', 1990, 'Pink', 9329, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (269018281571, 'B1QF2I', 'BMW', '330', 2006, 'Yellow', 9723, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (262910399191, 'B63GWC', 'Chevrolet', 'Tahoe', 2009, 'Turquoise', 9593, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (253711567548, 'PKJI2W', 'Toyota', 'Tacoma', 2004, 'Aquamarine', 9099, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (283098658119, 'K0ZI6C', 'Lexus', 'LX', 2003, 'Green', 9516, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (211489747102, 'OJFM34', 'Daewoo', 'Leganza', 1999, 'Fuscia', 9967, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (224342802595, 'HEBAVC', 'Dodge', 'Dakota', 1999, 'Blue', 9826, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (202949059580, 'ICK2PN', 'Ford', 'F150', 2007, 'Yellow', 9420, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (298760322432, '521KI1', 'Lexus', 'GS', 2006, 'Green', 9904, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (217651294118, 'OPBWB7', 'Dodge', 'Stratus', 1999, 'Green', 9707, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (263197758340, 'JEX2YW', 'BMW', 'Z3', 1998, 'Blue', 9279, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (283862078691, 'OZO85O', 'Mercedes-Benz', '400SEL', 1993, 'Goldenrod', 9302, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (261396293496, 'X1HR36', 'Volvo', 'C70', 2002, 'Violet', 9037, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (275647968687, 'W9BJJX', 'Mercury', 'Mountaineer', 2005, 'Khaki', 9113, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (240510316001, '9YO2A1', 'Toyota', 'TundraMax', 2009, 'Yellow', 9179, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (219846984739, 'CWOZTM', 'Mazda', 'CX-7', 2008, 'Puce', 9132, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (238296004642, 'D8HA1J', 'Mercury', 'Marquis', 1986, 'Aquamarine', 9780, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (201583845575, 'M9SIIM', 'Ram', 'C/V', 2012, 'Violet', 9130, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (228764732680, '9L0FEX', 'Volkswagen', 'GTI', 2011, 'Indigo', 9568, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (284473895881, 'I8IHVI', 'Nissan', 'JUKE', 2011, 'Fuscia', 9453, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (245325869283, 'ID4R75', 'Mercury', 'Grand Marquis', 2003, 'Blue', 9987, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (292667296185, 'A3EHU6', 'Mercedes-Benz', 'SL-Class', 1992, 'Violet', 9257, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (275340651348, '7SF2NJ', 'Hyundai', 'Azera', 2011, 'Blue', 9852, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (235303427025, 'R87EFS', 'Pontiac', 'Aztek', 2002, 'Yellow', 9510, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (227596429838, 'Q3HA7D', 'Toyota', 'Tundra', 2010, 'Fuscia', 9992, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (224008333269, 'SSBXHU', 'Daewoo', 'Nubira', 1999, 'Khaki', 9539, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (247724730522, '3A3HYD', 'Ford', 'Econoline E350', 1994, 'Fuscia', 9577, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (204207290805, 'GJMD6W', 'Audi', 'Q7', 2007, 'Green', 9909, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (261097118093, 'J0TYDX', 'Chevrolet', 'G-Series 1500', 1996, 'Yellow', 9983, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (236347765726, 'DX3NJ5', 'Chrysler', '300', 2008, 'Indigo', 9801, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (277554467782, 'F72QJK', 'Saturn', 'L-Series', 2000, 'Goldenrod', 9692, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (221339706894, 'HMEJ3I', 'Buick', 'Regal', 2001, 'Goldenrod', 9395, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (204808947845, '7MPZHN', 'Audi', '4000s', 1986, 'Teal', 9481, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (290838065498, 'M3GZ7N', 'Audi', 'Coupe GT', 1986, 'Red', 9991, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (270329858836, '2802ZE', 'Mercedes-Benz', 'SL-Class', 1987, 'Aquamarine', 9903, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (241768473054, 'DI8VS3', 'BMW', '6 Series', 2012, 'Khaki', 9087, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (235825189131, 'Z1OD0A', 'Nissan', 'Maxima', 1999, 'Green', 9228, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (277075638230, 'NV4M99', 'Volkswagen', 'rio', 1995, 'Red', 9035, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (253491580986, 'VGNFRZ', 'Infiniti', 'M', 2010, 'Purple', 9456, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (229919333427, '29RNII', 'Volkswagen', 'Eos', 2008, 'Blue', 9490, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (258865341436, '57MJCV', 'Lexus', 'HS', 2010, 'Red', 9243, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (266645323822, 'D54LYE', 'Toyota', 'Corolla', 1995, 'Pink', 9418, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (212833586417, 'MTTRAR', 'Audi', 'A6', 2011, 'Khaki', 9058, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (255898922162, 'YBDBHY', 'Lotus', 'Elise', 2006, 'Blue', 9843, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (280065828243, 'MKQ087', 'Lotus', 'Esprit', 2002, 'Red', 9620, 'available', 'Truck', 'D', 'Chicago');

insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (25717416552, 'Economy', 'A', 'NY', 2572446259503098, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26044564116, 'Compact', 'B', 'Vancouver', 2548539565817465, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28298807967, 'Mid-size', 'C', 'Montreal', 2694438515812297, to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26126360114, 'Standard', 'D', 'Chicago', 2477518636321758, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (23895072742, 'Full-size', 'A', 'NY', 2723249744462956, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (27551694356, 'SUV', 'B', 'Vancouver', 2670121699890688, to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22256709867, 'Truck', 'C', 'Montreal', 2176155852252261, to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (29080707361, 'Economy', 'D', 'Chicago', 2240697189980022, to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28953199128, 'Compact', 'A', 'NY', 2550562094506542, to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26140754487, 'Mid-size', 'B', 'Vancouver', 2900004698496957, to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (20879158768, 'Standard', 'C', 'Montreal', 2441310509849012, to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (24979995974, 'Full-size', 'D', 'Chicago', 2375693694535069, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (24140941882, 'SUV', 'A', 'NY', 2382893829855313, to_timestamp('2019-12-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26803497197, 'Truck', 'B', 'Vancouver', 2546171033577062, to_timestamp('2019-12-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (21059621131, 'Economy', 'C', 'Montreal', 2000265972908510, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22138775326, 'Compact', 'D', 'Chicago', 2782541119907559, to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (25681939333, 'Mid-size', 'A', 'NY', 2845467341445120, to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28744119819, 'Standard', 'B', 'Vancouver', 2406675965364908, to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26409080876, 'Full-size', 'C', 'Montreal', 2765664461124252, to_timestamp('2019-12-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28597098526, 'SUV', 'D', 'Chicago', 2999712506861100, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (27955045581, 'Truck', 'A', 'NY', 2692995883024012, to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (20063104115, 'Economy', 'B', 'Vancouver', 2911841831556093, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (21547972832, 'Compact', 'C', 'Montreal', 2499696832811337, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28107386621, 'Mid-size', 'D', 'Chicago', 2694146450030708, to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28925948354, 'Standard', 'A', 'NY', 2073188947066800, to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22932568902, 'Full-size', 'B', 'Vancouver', 2109526838937190, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28010385891, 'SUV', 'C', 'Montreal', 2080108661976742, to_timestamp('2019-12-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22010704486, 'Truck', 'D', 'Chicago', 2671986621318344, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26791732434, 'Economy', 'A', 'NY', 2415504436476149, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (20621265095, 'Compact', 'B', 'Vancouver', 2064807827851674, to_timestamp('2019-12-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22363590683, 'Mid-size', 'C', 'Montreal', 2092004208711840, to_timestamp('2019-12-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (26844942696, 'Standard', 'D', 'Chicago', 2537393469244572, to_timestamp('2019-12-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (29693131277, 'Full-size', 'A', 'NY', 2072046361687871, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22369482142, 'SUV', 'B', 'Vancouver', 2625002380534414, to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (23006335476, 'Truck', 'C', 'Montreal', 2812946166601912, to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (20953942858, 'Economy', 'D', 'Chicago', 2643043183073393, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22037107299, 'Compact', 'A', 'NY', 2881847743973028, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (29161470319, 'Mid-size', 'B', 'Vancouver', 2043019920185353, to_timestamp('2019-12-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (27927276825, 'Standard', 'C', 'Montreal', 2456530445972539, to_timestamp('2019-12-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22369911027, 'Full-size', 'D', 'Chicago', 2946761092596025, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-26 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (22971106606, 'SUV', 'A', 'NY', 2122551634103995, to_timestamp('2019-12-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (28897135779, 'Truck', 'B', 'Vancouver', 2285204882614318, to_timestamp('2019-12-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-12-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));

insert into customer (cellphone, name, address, dlicense) values (3464527865, 'Lindy Lashley', '9 Butterfield Junction', 3863935167961634);
insert into customer (cellphone, name, address, dlicense) values (3491947436, 'Lucky Frayn', '4 Sheridan Avenue', 3277775734559788);
insert into customer (cellphone, name, address, dlicense) values (3951502989, 'Jodi MacDermid', '43 Bonner Point', 3619380317706146);
insert into customer (cellphone, name, address, dlicense) values (3450337868, 'Bald Bradie', '3 Bay Lane', 3495135869696407);
insert into customer (cellphone, name, address, dlicense) values (3330666826, 'Gussie Milham', '642 Lakeland Drive', 3024759364665462);
insert into customer (cellphone, name, address, dlicense) values (3126240939, 'Geri McAnalley', '835 Messerschmidt Terrace', 3092790557763093);
insert into customer (cellphone, name, address, dlicense) values (3057478170, 'Marlowe Pirrone', '5390 Hallows Parkway', 3231256504832475);
insert into customer (cellphone, name, address, dlicense) values (3603940603, 'Jakie Levicount', '77093 Kipling Hill', 3206542505269527);
insert into customer (cellphone, name, address, dlicense) values (3632540964, 'Fanny Gall', '354 Badeau Court', 3896367689451810);
insert into customer (cellphone, name, address, dlicense) values (3394897231, 'Leeanne Nickolls', '1552 Dexter Place', 3952496227376420);
insert into customer (cellphone, name, address, dlicense) values (3782847145, 'Lorrie Minty', '1 Springs Parkway', 3232474263612997);
insert into customer (cellphone, name, address, dlicense) values (3350210318, 'Evelin Belward', '207 Sullivan Park', 3957857309222010);
insert into customer (cellphone, name, address, dlicense) values (3515581230, 'Thornton Swyne', '6 Crownhardt Trail', 3698292726013273);
insert into customer (cellphone, name, address, dlicense) values (3172943982, 'Reidar Ensten', '079 Park Meadow Center', 3412165584895479);
insert into customer (cellphone, name, address, dlicense) values (3380993336, 'Luella Fairn', '87680 Florence Lane', 3930658950048658);
insert into customer (cellphone, name, address, dlicense) values (3334587345, 'Katy Nunan', '5 Browning Court', 3438518543060638);
insert into customer (cellphone, name, address, dlicense) values (3044182759, 'Gwyn Kemer', '348 Colorado Park', 3279036988510882);
insert into customer (cellphone, name, address, dlicense) values (3590320738, 'Yorker Comiam', '202 Randy Trail', 3223385306112223);
insert into customer (cellphone, name, address, dlicense) values (3026979166, 'Esteban Lidster', '83709 Lerdahl Crossing', 3035843545111512);
insert into customer (cellphone, name, address, dlicense) values (3973588836, 'Annmarie Durrell', '412 Eagan Junction', 3839593791994295);
insert into customer (cellphone, name, address, dlicense) values (3301820283, 'Thacher Gallihawk', '78 Stuart Street', 3362903463020346);
insert into customer (cellphone, name, address, dlicense) values (3423153798, 'Amalle Laye', '020 Roxbury Drive', 3941779289630841);
insert into customer (cellphone, name, address, dlicense) values (3463208822, 'Oliy Vannacci', '039 Knutson Terrace', 3370346536949807);
insert into customer (cellphone, name, address, dlicense) values (3368687579, 'Willi Ballance', '40 Orin Terrace', 3375953008749159);
insert into customer (cellphone, name, address, dlicense) values (3836376716, 'Keene Arnfield', '30 Monument Road', 3162211982675479);
insert into customer (cellphone, name, address, dlicense) values (3025603063, 'Linette Corss', '11466 Corry Circle', 3404352383813820);
insert into customer (cellphone, name, address, dlicense) values (3828793269, 'Linell Eversley', '96 Grim Place', 3748283578978929);
insert into customer (cellphone, name, address, dlicense) values (3112853575, 'Hew Bayley', '016 Summer Ridge Terrace', 3479542758413650);
insert into customer (cellphone, name, address, dlicense) values (3306911204, 'Tomas Bussens', '71 Vahlen Alley', 3641347840167351);
insert into customer (cellphone, name, address, dlicense) values (3502819069, 'Shannon Aime', '64 Shopko Pass', 3730341675242763);
insert into customer (cellphone, name, address, dlicense) values (3605740604, 'Konstantin Naisbitt', '17 Lakewood Plaza', 3659776132966071);
insert into customer (cellphone, name, address, dlicense) values (3110258308, 'Hadlee Klageman', '644 Rowland Lane', 3677828984366390);
insert into customer (cellphone, name, address, dlicense) values (3407746333, 'Guillaume Abercrombie', '5 Oneill Terrace', 3694951472341123);
insert into customer (cellphone, name, address, dlicense) values (3082749362, 'Patsy Joddins', '20702 Brentwood Street', 3369315415347404);
insert into customer (cellphone, name, address, dlicense) values (3842472361, 'Marco Windebank', '8606 Old Gate Way', 3252794881703877);
insert into customer (cellphone, name, address, dlicense) values (3532473543, 'Adham Center', '92 Montana Park', 3752752762149606);
insert into customer (cellphone, name, address, dlicense) values (3875432278, 'Jesse Tomala', '7 Towne Parkway', 3069216364043183);
insert into customer (cellphone, name, address, dlicense) values (3273568508, 'Sande Juzek', '15288 Petterle Place', 3843174226492296);
insert into customer (cellphone, name, address, dlicense) values (3489071622, 'Bambie Quimby', '86110 Larry Lane', 3391759106746421);
insert into customer (cellphone, name, address, dlicense) values (3923861189, 'Dominick Furphy', '7 Pearson Terrace', 3644750948875360);
insert into customer (cellphone, name, address, dlicense) values (3506765347, 'Jarad Childerhouse', '71062 Carey Lane', 3463292548557302);
insert into customer (cellphone, name, address, dlicense) values (3721742578, 'Alfi Dunnan', '36601 Nancy Trail', 3426369245183065);

insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (388167058974, 'Z3V3MU', 'Suzuki', 'Aerio', 2007, 'Aquamarine', 9775, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (366248106992, 'NO65V2', 'Honda', 'Civic', 2010, 'Yellow', 9310, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (337833852894, 'CSOVDP', 'GMC', 'Vandura G1500', 1995, 'Blue', 9762, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (364197254377, 'ZR7TZR', 'Saturn', 'Astra', 2008, 'Green', 9947, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (331037170266, 'SP1YZH', 'Acura', 'RDX', 2009, 'Red', 9499, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (365257692740, 'ST13AG', 'Mercury', 'Villager', 2001, 'Red', 9177, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (314275387669, 'L31WF7', 'Lexus', 'ES', 2005, 'Purple', 9684, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (332571531993, 'NWDOGV', 'Chevrolet', 'Colorado', 2011, 'Indigo', 9230, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (399978453537, 'KHCYI7', 'Ford', 'F-Series', 1987, 'Puce', 9725, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (301930450372, 'DHBIP2', 'BMW', '600', 1957, 'Yellow', 9180, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (392477324114, 'LNIJYO', 'Rolls-Royce', 'Phantom', 2007, 'Maroon', 9012, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (380627410609, 'BHL52O', 'Kia', 'Sportage', 1997, 'Maroon', 9554, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (324058634577, 'AZ6490', 'Corbin', 'Sparrow', 2004, 'Mauv', 9046, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (390971654061, 'QIBOMC', 'GMC', 'Safari', 1999, 'Goldenrod', 9274, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (391309287042, 'LU2XYQ', 'Ford', 'Econoline E250', 1994, 'Khaki', 9957, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (344597366637, 'ACSWF8', 'Mercury', 'Tracer', 1995, 'Teal', 9155, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (336381370131, 'LUVTC1', 'Nissan', 'Titan', 2005, 'Yellow', 9248, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (332008376052, '6I6GY4', 'Volkswagen', 'Jetta', 2010, 'Fuscia', 9970, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (373601617907, 'FFAY01', 'Dodge', 'Grand Caravan', 2004, 'Teal', 9405, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (399240933197, '0SCUAP', 'Lincoln', 'MKT', 2013, 'Fuscia', 9837, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (302671792892, '29DHAW', 'Suzuki', 'Samurai', 1993, 'Indigo', 9228, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (353633439171, 'HWAZN0', 'BMW', '1 Series', 2009, 'Violet', 9209, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (369522751218, 'KOD18Y', 'Saturn', 'VUE', 2002, 'Blue', 9246, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (307804389115, 'KIMBQN', 'Mercury', 'Sable', 1998, 'Crimson', 9899, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (354526541155, 'YZVCMN', 'Buick', 'LeSabre', 1998, 'Turquoise', 9233, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (336181135718, 'RXQV02', 'Acura', 'RL', 2011, 'Goldenrod', 9289, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (377751428105, 'FHFNO6', 'Chevrolet', 'Corsica', 1993, 'Turquoise', 9939, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (325576996437, 'YIJ4CC', 'Cadillac', 'Escalade EXT', 2004, 'Puce', 9013, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (353509017884, 'I66KFB', 'Ferrari', 'F430 Spider', 2006, 'Khaki', 9381, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (394773782825, '6DGONB', 'Dodge', 'Ram 2500', 2006, 'Indigo', 9457, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (355197616911, '62IWUD', 'Mazda', '626', 2001, 'Indigo', 9604, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (382624721426, 'QJL0PI', 'BMW', '525', 2001, 'Yellow', 9565, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (313607657075, 'KDGL6E', 'Lexus', 'GX', 2006, 'Crimson', 9596, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (303648359218, 'IP4XKG', 'Chevrolet', 'Camaro', 1978, 'Teal', 9931, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (376415784387, 'CFZ3EW', 'Oldsmobile', 'Achieva', 1994, 'Mauv', 9994, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (399011955139, '2JORCS', 'Nissan', 'Quest', 1995, 'Orange', 9906, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (339592444301, 'W7BFDB', 'Chrysler', 'Voyager', 2003, 'Pink', 9399, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (318846228733, '62ZNUN', 'Oldsmobile', 'Bravada', 1999, 'Yellow', 9002, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (326451937018, 'L7O56W', 'Lexus', 'LS', 2006, 'Yellow', 9118, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (353031436564, '6KEFWX', 'Infiniti', 'QX', 2005, 'Violet', 9686, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (399309420882, 'Y3IERY', 'Honda', 'Odyssey', 2008, 'Puce', 9127, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (348580651307, '40IVBI', 'Toyota', 'Avalon', 1997, 'Indigo', 9238, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (315686783117, 'ROUUP8', 'Hyundai', 'Scoupe', 1995, 'Indigo', 9135, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (366435767980, 'UWX9KC', 'Volkswagen', 'Jetta', 2000, 'Orange', 9389, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (397269003244, 'ZSN8E8', 'BMW', '3 Series', 2011, 'Red', 9086, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (394444831827, '19ARH0', 'Oldsmobile', 'Cutlass', 1997, 'Yellow', 9498, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (313786857058, 'VDHP3M', 'Acura', 'TL', 1997, 'Turquoise', 9499, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (313085905703, '2NCQVW', 'Ford', 'Flex', 2011, 'Crimson', 9377, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (325375169354, 'ATJ6FI', 'Dodge', 'Ram Van 2500', 1999, 'Yellow', 9141, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (376831824400, '2D0OSJ', 'Nissan', 'Murano', 2004, 'Indigo', 9152, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (313953261868, 'QJ9JHR', 'Mazda', 'Protege5', 2002, 'Blue', 9677, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (394484935534, 'KVCD6B', 'Acura', 'SLX', 1996, 'Turquoise', 9908, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (301009177221, 'QI77DT', 'Chrysler', '300', 2006, 'Pink', 9747, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (305099315519, 'DZ03FD', 'Mitsubishi', 'Montero', 2004, 'Red', 9170, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (308184128258, 'UX5POU', 'Ford', 'Expedition', 2010, 'Red', 9531, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (346912818704, '8ZQL6S', 'GMC', 'Envoy', 2002, 'Fuscia', 9286, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (324221978668, 'Z4IBDE', 'Cadillac', 'DTS', 2010, 'Purple', 9615, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (383512920525, 'UOSGV6', 'Ford', 'Thunderbird', 1980, 'Orange', 9634, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (364525529752, 'OA6UAX', 'Acura', 'RDX', 2012, 'Violet', 9024, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (373355237956, 'N4JRUU', 'Hyundai', 'Tiburon', 1999, 'Pink', 9649, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (395809239494, 'VQ0CHY', 'Jeep', 'Wrangler', 1993, 'Purple', 9445, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (393965025042, 'QSZ7P8', 'Mitsubishi', 'RVR', 1994, 'Khaki', 9639, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (334662680899, '56GHDM', 'Ford', 'Fairlane', 1966, 'Mauv', 9071, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (326677200726, 'CYBTH6', 'Dodge', 'Ram 3500', 2006, 'Mauv', 9948, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (388681098509, '6MOZDK', 'Cadillac', 'Escalade EXT', 2002, 'Mauv', 9258, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (385799999817, '12Z1OK', 'Audi', 'A4', 2006, 'Turquoise', 9258, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (380476938318, 'HZEWTS', 'Mercedes-Benz', 'C-Class', 1993, 'Violet', 9767, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (337379610880, 'XANXNP', 'Nissan', 'Pathfinder', 2011, 'Mauv', 9026, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (321937382639, '4F1KXM', 'Ford', 'E-Series', 2001, 'Blue', 9677, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (376016467411, 'Z56XI8', 'Nissan', 'Sentra', 1994, 'Fuscia', 9727, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (305032356940, 'EWJ270', 'Chrysler', 'Sebring', 1995, 'Pink', 9897, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (313215339523, 'CJRF22', 'Toyota', 'Tacoma Xtra', 1998, 'Pink', 9718, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (341285841214, 'DWYFKD', 'Suzuki', 'Forenza', 2006, 'Turquoise', 9613, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (392826128155, 'F7T1CL', 'Dodge', 'Caravan', 2008, 'Green', 9515, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (307537154723, '39O83R', 'Volkswagen', 'GTI', 2009, 'Yellow', 9844, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (342943977463, 'CYFZHO', 'Buick', 'Lucerne', 2006, 'Purple', 9352, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (322681749905, '5IH7AY', 'Mitsubishi', 'Starion', 1985, 'Mauv', 9501, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (334287058635, 'GPCEXM', 'Suzuki', 'Reno', 2006, 'Indigo', 9261, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (351445950433, '99WZAC', 'Mitsubishi', 'Raider', 2006, 'Violet', 9146, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (377472939465, 'KAP4DD', 'GMC', 'Rally Wagon G3500', 1995, 'Puce', 9840, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (318557861425, 'XA76H0', 'Saab', '9-5', 2009, 'Green', 9053, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (386306817088, '53F2OL', 'Nissan', '350Z', 2003, 'Green', 9649, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (322489033756, '26BJE2', 'Dodge', 'Caravan', 2009, 'Indigo', 9660, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (393228552937, 'VGXF7R', 'Dodge', 'Ram', 2007, 'Blue', 9299, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (312337192357, 'E42ZXO', 'Toyota', 'Celica', 1976, 'Purple', 9720, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (318598626694, '139Q6V', 'Mercury', 'Capri', 1994, 'Orange', 9520, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (397607416957, 'U28A1Y', 'Ford', 'Laser', 1984, 'Pink', 9899, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (300404947698, 'QRQ3W8', 'Ford', 'Courier', 1989, 'Aquamarine', 9035, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (385124861960, 'AUNZAM', 'Saab', '9-7X', 2009, 'Teal', 9611, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (385460522020, 'LYB8AX', 'Land Rover', 'Range Rover', 2002, 'Blue', 9659, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (399764270633, 'TA7LE8', 'Toyota', 'Land Cruiser', 2000, 'Puce', 9320, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (318482159364, 'NVNOTD', 'Mercedes-Benz', '600SEL', 1992, 'Violet', 9391, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (344777714550, 'L4THMA', 'Mercedes-Benz', 'C-Class', 2010, 'Purple', 9233, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (376231469398, '1URP58', 'Cadillac', 'Catera', 1997, 'Goldenrod', 9849, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (313577781147, 'ROB5EN', 'Dodge', 'Ram Van 1500', 1999, 'Indigo', 9786, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (337637844023, 'FIJUBM', 'Cadillac', 'CTS-V', 2011, 'Green', 9858, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (363894814679, 'LMM3LG', 'Pontiac', 'G8', 2009, 'Mauv', 9052, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (344760560139, 'BANE0B', 'Land Rover', 'Defender 90', 1995, 'Teal', 9757, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (343130204411, '9J2WMT', 'Kia', 'Optima', 2011, 'Fuscia', 9663, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (346779898463, 'GTRGMP', 'Isuzu', 'Rodeo', 2004, 'Red', 9790, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (317033973912, 'VO5SKZ', 'Ford', 'C-MAX Hybrid', 2013, 'Indigo', 9626, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (367781179754, '93O9BK', 'Land Rover', 'Discovery', 1996, 'Pink', 9371, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (356856049178, 'SESXX0', 'Cadillac', 'CTS', 2012, 'Goldenrod', 9193, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (330490773220, 'W72Y18', 'BMW', '5 Series', 1993, 'Blue', 9146, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (397443895666, '2XJ10L', 'Mazda', 'Mazdaspeed6', 2006, 'Pink', 9353, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (342498964084, '1FXS2M', 'Ford', 'Econoline E350', 1994, 'Crimson', 9041, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (370489780921, 'W29LNU', 'Mazda', 'Mazda5', 2010, 'Indigo', 9319, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (357416219977, '1M5UV0', 'Acura', 'MDX', 2005, 'Pink', 9225, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (357201705520, '6FYNUE', 'Lincoln', 'Town Car', 1996, 'Indigo', 9876, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (382376408514, 'I7DWFF', 'Pontiac', 'Grand Prix', 1975, 'Purple', 9067, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (300159230182, 'YQXZFO', 'Plymouth', 'Colt', 1993, 'Khaki', 9711, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (361272231595, '6EGFCP', 'BMW', '3 Series', 1997, 'Turquoise', 9037, 'available', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (353151886937, 'U395OM', 'Ford', 'Econoline E350', 1992, 'Pink', 9472, 'available', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (363468113332, 'ZZBTYU', 'Ford', 'Excursion', 2005, 'Red', 9740, 'available', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (336596644927, 'AYFXGG', 'Suzuki', 'Sidekick', 1994, 'Blue', 9045, 'available', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (310735399270, 'K26TAK', 'GMC', '3500 Club Coupe', 1992, 'Khaki', 9980, 'available', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (372648494055, 'MXYTTJ', 'Ford', 'E250', 2003, 'Teal', 9874, 'available', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (321849309133, 'R7R1R9', 'Dodge', 'D250 Club', 1993, 'Puce', 9695, 'available', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (389657306743, '5LHH8W', 'Mitsubishi', 'GTO', 1997, 'Mauv', 9250, 'available', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (340177987260, 'IXPETP', 'Mercedes-Benz', 'M-Class', 2005, 'Crimson', 9852, 'available', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (399914133625, 'YIAX31', 'Chevrolet', 'Beretta', 1993, 'Crimson', 9388, 'available', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (355085557867, 'KKAPLU', 'GMC', 'Sierra 3500', 2002, 'Purple', 9331, 'available', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (385287460203, 'BAPLRP', 'Toyota', 'Prius v', 2012, 'Teal', 9609, 'available', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (352387538079, 'BBIL5N', 'Mercury', 'Marauder', 2004, 'Teal', 9043, 'available', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (317818690246, 'X4B5UE', 'Suzuki', 'Grand Vitara', 2010, 'Crimson', 9825, 'available', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (336308963631, 'MMNQ76', 'Mitsubishi', 'Mirage', 2000, 'Mauv', 9041, 'available', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (322418061524, 'ZRTO9M', 'Ford', 'Freestyle', 2007, 'Puce', 9681, 'available', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (314760763020, 'ZWI271', 'Chevrolet', 'Silverado', 2007, 'Yellow', 9702, 'available', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (383698135853, 'Z95H1K', 'Lexus', 'GX', 2011, 'Fuscia', 9291, 'available', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (367482769188, 'CQ1C2K', 'Ford', 'Thunderbird', 1990, 'Maroon', 9137, 'available', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (355224650250, 'UZRPEH', 'Acura', 'MDX', 2003, 'Aquamarine', 9249, 'available', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (345348746492, '9XR7QH', 'Geo', 'Tracker', 1992, 'Violet', 9649, 'available', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (302946403425, '763ZMK', 'Chevrolet', 'Cobalt SS', 2009, 'Turquoise', 9188, 'available', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (309807900994, 'IGP4KS', 'Volvo', 'XC70', 2003, 'Orange', 9381, 'available', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (341140812468, 'D9T8S8', 'Jaguar', 'XK', 2008, 'Blue', 9217, 'available', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (390650041862, 'N9FE2T', 'Ford', 'Thunderbird', 1983, 'Green', 9746, 'available', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (303301505855, 'UNCJ9R', 'Chrysler', 'Crossfire', 2004, 'Green', 9991, 'available', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (395375020470, '2V337E', 'Ford', 'F450', 2010, 'Mauv', 9710, 'available', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (338209213019, 'EDA3X1', 'Daewoo', 'Nubira', 1999, 'Puce', 9320, 'available', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (304266501554, 'WL3Z51', 'Eagle', 'Vision', 1995, 'Fuscia', 9368, 'available', 'Truck', 'D', 'Chicago');

insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (37100128591, 'Economy', 'A', 'NY', 3863935167961634, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (37012577286, 'Compact', 'B', 'Vancouver', 3277775734559788, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32195000515, 'Mid-size', 'C', 'Montreal', 3619380317706146, to_timestamp('2019-10-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33925767988, 'Standard', 'D', 'Chicago', 3495135869696407, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33204994513, 'Full-size', 'A', 'NY', 3024759364665462, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38340894305, 'SUV', 'B', 'Vancouver', 3092790557763093, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (39620502362, 'Truck', 'C', 'Montreal', 3231256504832475, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38234493161, 'Economy', 'D', 'Chicago', 3206542505269527, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (35892729386, 'Compact', 'A', 'NY', 3896367689451810, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33609911129, 'Mid-size', 'B', 'Vancouver', 3952496227376420, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38896864445, 'Standard', 'C', 'Montreal', 3232474263612997, to_timestamp('2019-10-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38599569031, 'Full-size', 'D', 'Chicago', 3957857309222010, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (37637955917, 'SUV', 'A', 'NY', 3698292726013273, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32070031491, 'Truck', 'B', 'Vancouver', 3412165584895479, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33003571237, 'Economy', 'C', 'Montreal', 3930658950048658, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (30210098607, 'Compact', 'D', 'Chicago', 3438518543060638, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (34058043412, 'Mid-size', 'A', 'NY', 3279036988510882, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32642309923, 'Standard', 'B', 'Vancouver', 3223385306112223, to_timestamp('2019-10-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (34564809044, 'Full-size', 'C', 'Montreal', 3035843545111512, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38985868036, 'SUV', 'D', 'Chicago', 3839593791994295, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38074403403, 'Truck', 'A', 'NY', 3362903463020346, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (35974064866, 'Economy', 'B', 'Vancouver', 3941779289630841, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (38055218348, 'Compact', 'C', 'Montreal', 3370346536949807, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33107393731, 'Mid-size', 'D', 'Chicago', 3375953008749159, to_timestamp('2019-10-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (37850209328, 'Standard', 'A', 'NY', 3162211982675479, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (37736976699, 'Full-size', 'B', 'Vancouver', 3404352383813820, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (39021720637, 'SUV', 'C', 'Montreal', 3748283578978929, to_timestamp('2019-10-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (39507341331, 'Truck', 'D', 'Chicago', 3479542758413650, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (30720186604, 'Economy', 'A', 'NY', 3641347840167351, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33404443833, 'Compact', 'B', 'Vancouver', 3730341675242763, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32258798415, 'Mid-size', 'C', 'Montreal', 3659776132966071, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (35955215157, 'Standard', 'D', 'Chicago', 3677828984366390, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (35889896936, 'Full-size', 'A', 'NY', 3694951472341123, to_timestamp('2019-10-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33761081557, 'SUV', 'B', 'Vancouver', 3369315415347404, to_timestamp('2019-10-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33447542668, 'Truck', 'C', 'Montreal', 3252794881703877, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (36798161687, 'Economy', 'D', 'Chicago', 3752752762149606, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33611245356, 'Compact', 'A', 'NY', 3069216364043183, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32561245729, 'Mid-size', 'B', 'Vancouver', 3843174226492296, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32967529356, 'Standard', 'C', 'Montreal', 3391759106746421, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (32651879362, 'Full-size', 'D', 'Chicago', 3644750948875360, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (30262387324, 'SUV', 'A', 'NY', 3463292548557302, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));
insert into reservation (confno, vtname, location, city, dlicense, fromDate, toDate) values (33575096688, 'Truck', 'B', 'Vancouver', 3426369245183065, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'));

insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3934418470, 388167058974, 3863935167961634, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10010, 'Lindy Lashley', 3563422906716583, '12/26', 37100128591);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3875859857, 366248106992, 3277775734559788, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10037, 'Lucky Frayn', 6767278756349755392, '12/29', 37012577286);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3705118410, 337833852894, 3619380317706146, to_timestamp('2019-10-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10055, 'Jodi MacDermid', 3580189345822855, '12/28', 32195000515);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3676167431, 364197254377, 3495135869696407, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10055, 'Bald Bradie', 4911753699977294848, '12/29', 33925767988);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3788043482, 331037170266, 3024759364665462, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10071, 'Gussie Milham', 676205422626048640, '12/29', 33204994513);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3182313966, 365257692740, 3092790557763093, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10083, 'Geri McAnalley', 3563463234356734, '12/24', 38340894305);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3411143306, 314275387669, 3231256504832475, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10046, 'Marlowe Pirrone', 3565472927340796, '12/22', 39620502362);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3642061510, 332571531993, 3206542505269527, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10096, 'Jakie Levicount', 3588895065133735, '12/21', 38234493161);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3269325536, 399978453537, 3896367689451810, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10039, 'Fanny Gall', 201595128360886, '12/23', 35892729386);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3338094444, 301930450372, 3952496227376420, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10028, 'Leeanne Nickolls', 5610931000651049, '12/20', 33609911129);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3884046295, 392477324114, 3232474263612997, to_timestamp('2019-10-25 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10037, 'Lorrie Minty', 3531611135898738, '12/27', 38896864445);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3336331235, 380627410609, 3957857309222010, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10066, 'Evelin Belward', 201497807743732, '12/24', 38599569031);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3638745828, 324058634577, 3698292726013273, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10096, 'Thornton Swyne', 6762670698606196, '12/20', 37637955917);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3919625468, 390971654061, 3412165584895479, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10039, 'Reidar Ensten', 4026654957420645, '12/21', 32070031491);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3636353133, 391309287042, 3930658950048658, to_timestamp('2019-10-20 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10063, 'Luella Fairn', 5602241182607003, '12/21', 33003571237);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3629945362, 344597366637, 3438518543060638, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10087, 'Katy Nunan', 6304893674989791, '12/27', 30210098607);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3181046851, 336381370131, 3279036988510882, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10017, 'Gwyn Kemer', 5549556037007281, '12/24', 34058043412);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3699307095, 332008376052, 3223385306112223, to_timestamp('2019-10-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10062, 'Yorker Comiam', 3562648627899909, '12/24', 32642309923);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3376117382, 373601617907, 3035843545111512, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10068, 'Esteban Lidster', 5124533103330270, '12/23', 34564809044);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3020372107, 399240933197, 3839593791994295, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10035, 'Annmarie Durrell', 4405925665815909, '12/22', 38985868036);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3392993460, 302671792892, 3362903463020346, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10082, 'Thacher Gallihawk', 5398353632545861, '12/24', 38074403403);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3093267123, 353633439171, 3941779289630841, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10073, 'Amalle Laye', 3543443644007783, '12/22', 35974064866);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3287014518, 369522751218, 3370346536949807, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10080, 'Oliy Vannacci', 4041372474957, '12/21', 38055218348);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3495133816, 307804389115, 3375953008749159, to_timestamp('2019-10-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10099, 'Willi Ballance', 4788770531437935, '12/29', 33107393731);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3908405551, 354526541155, 3162211982675479, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10049, 'Keene Arnfield', 676392551956773888, '12/24', 37850209328);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3294666969, 336181135718, 3404352383813820, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10017, 'Linette Corss', 374283044275170, '12/24', 37736976699);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3406604047, 377751428105, 3748283578978929, to_timestamp('2019-10-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10025, 'Linell Eversley', 5490372048690332, '12/29', 39021720637);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3947714146, 325576996437, 3479542758413650, to_timestamp('2019-10-28 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10051, 'Hew Bayley', 5266413597750812, '12/24', 39507341331);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3409412888, 353509017884, 3641347840167351, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10010, 'Tomas Bussens', 3546259001355285, '12/27', 30720186604);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3322207109, 394773782825, 3730341675242763, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10091, 'Shannon Aime', 370467763140731, '12/22', 33404443833);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3889451197, 355197616911, 3659776132966071, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10028, 'Konstantin Naisbitt', 4844919637579726, '12/26', 32258798415);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3518460234, 382624721426, 3677828984366390, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10078, 'Hadlee Klageman', 30021158746354, '12/22', 35955215157);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3320974097, 313607657075, 3694951472341123, to_timestamp('2019-10-22 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10054, 'Guillaume Abercrombie', 3577232260117417, '12/24', 35889896936);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3137162736, 303648359218, 3369315415347404, to_timestamp('2019-10-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10027, 'Patsy Joddins', 4175007763814775, '12/29', 33761081557);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3809975271, 376415784387, 3252794881703877, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10070, 'Marco Windebank', 3558652126929312, '12/25', 33447542668);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3156945975, 399011955139, 3752752762149606, to_timestamp('2019-10-23 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10056, 'Adham Center', 6377229381570974, '12/29', 36798161687);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3654768051, 339592444301, 3069216364043183, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10061, 'Jesse Tomala', 374283523522548, '12/21', 33611245356);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3129247673, 318846228733, 3843174226492296, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10023, 'Sande Juzek', 6759840159358133, '12/24', 32561245729);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3251238877, 326451937018, 3391759106746421, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10028, 'Bambie Quimby', 4844987619968993, '12/29', 32967529356);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3032244766, 353031436564, 3644750948875360, to_timestamp('2019-10-21 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10075, 'Dominick Furphy', 3543043085667473, '12/24', 32651879362);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3784009536, 399309420882, 3463292548557302, to_timestamp('2019-10-29 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10081, 'Jarad Childerhouse', 3540997271774356, '12/23', 30262387324);
insert into rent (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardname, cardno, expdate, reservation_confno) values (3286484511, 348580651307, 3426369245183065, to_timestamp('2019-10-24 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10080, 'Alfi Dunnan', 4405138889588373, '12/24', 33575096688);

insert into rent_reserve (rent_id, reservation_confno) values (3934418470, 37100128591);
insert into rent_reserve (rent_id, reservation_confno) values (3875859857, 37012577286);
insert into rent_reserve (rent_id, reservation_confno) values (3705118410, 32195000515);
insert into rent_reserve (rent_id, reservation_confno) values (3676167431, 33925767988);
insert into rent_reserve (rent_id, reservation_confno) values (3788043482, 33204994513);
insert into rent_reserve (rent_id, reservation_confno) values (3182313966, 38340894305);
insert into rent_reserve (rent_id, reservation_confno) values (3411143306, 39620502362);
insert into rent_reserve (rent_id, reservation_confno) values (3642061510, 38234493161);
insert into rent_reserve (rent_id, reservation_confno) values (3269325536, 35892729386);
insert into rent_reserve (rent_id, reservation_confno) values (3338094444, 33609911129);
insert into rent_reserve (rent_id, reservation_confno) values (3884046295, 38896864445);
insert into rent_reserve (rent_id, reservation_confno) values (3336331235, 38599569031);
insert into rent_reserve (rent_id, reservation_confno) values (3638745828, 37637955917);
insert into rent_reserve (rent_id, reservation_confno) values (3919625468, 32070031491);
insert into rent_reserve (rent_id, reservation_confno) values (3636353133, 33003571237);
insert into rent_reserve (rent_id, reservation_confno) values (3629945362, 30210098607);
insert into rent_reserve (rent_id, reservation_confno) values (3181046851, 34058043412);
insert into rent_reserve (rent_id, reservation_confno) values (3699307095, 32642309923);
insert into rent_reserve (rent_id, reservation_confno) values (3376117382, 34564809044);
insert into rent_reserve (rent_id, reservation_confno) values (3020372107, 38985868036);
insert into rent_reserve (rent_id, reservation_confno) values (3392993460, 38074403403);
insert into rent_reserve (rent_id, reservation_confno) values (3093267123, 35974064866);
insert into rent_reserve (rent_id, reservation_confno) values (3287014518, 38055218348);
insert into rent_reserve (rent_id, reservation_confno) values (3495133816, 33107393731);
insert into rent_reserve (rent_id, reservation_confno) values (3908405551, 37850209328);
insert into rent_reserve (rent_id, reservation_confno) values (3294666969, 37736976699);
insert into rent_reserve (rent_id, reservation_confno) values (3406604047, 39021720637);
insert into rent_reserve (rent_id, reservation_confno) values (3947714146, 39507341331);
insert into rent_reserve (rent_id, reservation_confno) values (3409412888, 30720186604);
insert into rent_reserve (rent_id, reservation_confno) values (3322207109, 33404443833);
insert into rent_reserve (rent_id, reservation_confno) values (3889451197, 32258798415);
insert into rent_reserve (rent_id, reservation_confno) values (3518460234, 35955215157);
insert into rent_reserve (rent_id, reservation_confno) values (3320974097, 35889896936);
insert into rent_reserve (rent_id, reservation_confno) values (3137162736, 33761081557);
insert into rent_reserve (rent_id, reservation_confno) values (3809975271, 33447542668);
insert into rent_reserve (rent_id, reservation_confno) values (3156945975, 36798161687);
insert into rent_reserve (rent_id, reservation_confno) values (3654768051, 33611245356);
insert into rent_reserve (rent_id, reservation_confno) values (3129247673, 32561245729);
insert into rent_reserve (rent_id, reservation_confno) values (3251238877, 32967529356);
insert into rent_reserve (rent_id, reservation_confno) values (3032244766, 32651879362);
insert into rent_reserve (rent_id, reservation_confno) values (3784009536, 30262387324);
insert into rent_reserve (rent_id, reservation_confno) values (3286484511, 33575096688);

insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3934418470, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10132, 1, 96.75);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3875859857, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10136, 0, 70.39);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3705118410, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10157, 1, 77.63);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3676167431, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10121, 0, 89.37);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3788043482, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10169, 1, 61.98);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3182313966, to_timestamp('2019-11-27 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10190, 0, 67.66);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3411143306, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10176, 1, 90.83);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3642061510, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10172, 0, 70.79);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3269325536, to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10146, 1, 69.66);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3338094444, to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10172, 0, 97.03);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3884046295, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10149, 1, 71.79);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3336331235, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10135, 0, 48.2);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3638745828, to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10122, 1, 38.26);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3919625468, to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10167, 0, 71.77);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3636353133, to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10167, 1, 60.67);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3629945362, to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10132, 0, 91.37);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3181046851, to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10185, 1, 56.47);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3699307095, to_timestamp('2019-11-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10126, 0, 89.81);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3376117382, to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10136, 1, 92.92);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3020372107, to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10151, 0, 83.94);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3392993460, to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10128, 1, 73.46);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3093267123, to_timestamp('2019-11-17 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10162, 0, 69.74);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3287014518, to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10128, 1, 57.55);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3495133816, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10184, 0, 60.65);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3908405551, to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10176, 1, 48.42);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3294666969, to_timestamp('2019-11-11 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10184, 0, 55.49);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3406604047, to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10160, 1, 81.11);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3947714146, to_timestamp('2019-11-15 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10187, 0, 98.26);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3409412888, to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10160, 1, 70.91);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3322207109, to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10182, 0, 55.65);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3889451197, to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10171, 1, 62.97);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3518460234, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10185, 0, 77.6);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3320974097, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10143, 1, 93.01);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3137162736, to_timestamp('2019-11-18 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10119, 0, 86.28);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3809975271, to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10146, 1, 53.89);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3156945975, to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10186, 0, 66.58);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3654768051, to_timestamp('2019-11-10 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10135, 1, 91.48);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3129247673, to_timestamp('2019-11-14 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10113, 0, 57.41);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3251238877, to_timestamp('2019-11-19 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10127, 1, 34.18);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3032244766, to_timestamp('2019-11-12 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10130, 0, 62.31);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3784009536, to_timestamp('2019-11-13 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10139, 1, 99.38);
insert into ret (rent_id, return_date, odometer, fulltank, cost) values (3286484511, to_timestamp('2019-11-16 00:00:00', 'YYYY-MM-DD:HH24:MI:SS'), 10198, 0, 65.47);

insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (431913705865, '4DF6WW', 'Buick', 'Electra', 1990, 'Fuscia', 9390, 'maintenance', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (487251854499, '2VD0S0', 'Chrysler', 'Crossfire', 2006, 'Puce', 9296, 'maintenance', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (413895609511, '3Z8SXQ', 'Ford', 'F350', 2003, 'Violet', 9131, 'maintenance', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (414852129635, 'KOTV2R', 'Saab', '9-7X', 2008, 'Pink', 9235, 'maintenance', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (444113856890, 'K25ZUC', 'Cadillac', 'STS', 2005, 'Pink', 9002, 'maintenance', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (428821966947, 'N9MDJU', 'Toyota', 'Ipsum', 2000, 'Teal', 9950, 'maintenance', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (498250212819, 'K6WMT7', 'Nissan', '370Z', 2012, 'Blue', 9394, 'maintenance', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (423819985588, 'M0X65Q', 'Acura', 'MDX', 2004, 'Mauv', 9845, 'maintenance', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (425276198136, 'MSUDCN', 'Mercury', 'Cougar', 1990, 'Aquamarine', 9490, 'maintenance', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (453141641245, 'U71LG2', 'Ford', 'Econoline E150', 2000, 'Orange', 9204, 'maintenance', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (400602535783, 'X2KTQL', 'Mazda', 'MPV', 1998, 'Orange', 9064, 'maintenance', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (436006321620, 'D21IPE', 'Chevrolet', 'Silverado 1500', 2006, 'Pink', 9553, 'maintenance', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (456882610840, '4N29M9', 'Ford', 'Fusion', 2011, 'Yellow', 9319, 'maintenance', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (494245712418, 'UVGZVT', 'Ford', 'Thunderbird', 1987, 'Goldenrod', 9306, 'maintenance', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (440795859909, '0DCDWL', 'Chevrolet', 'Cavalier', 1994, 'Maroon', 9216, 'maintenance', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (487930859230, 'VEISUW', 'Nissan', 'Sentra', 2009, 'Indigo', 9940, 'maintenance', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (468811313353, '78PCXR', 'Chevrolet', 'G-Series 1500', 1998, 'Pink', 9738, 'maintenance', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (472384599015, '0INC9L', 'BMW', 'X3', 2010, 'Fuscia', 9404, 'maintenance', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (401248004717, '8WCZJG', 'Chevrolet', 'Corvette', 1970, 'Red', 9644, 'maintenance', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (474948438011, '2FJI06', 'Toyota', 'Matrix', 2011, 'Violet', 9505, 'maintenance', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (443697663039, 'JKH96U', 'Honda', 'CR-Z', 2011, 'Green', 9247, 'maintenance', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (430095879929, '8JOYS2', 'Ford', 'F150', 2009, 'Aquamarine', 9470, 'maintenance', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (481618504364, 'H9CR7G', 'Scion', 'xB', 2011, 'Red', 9194, 'maintenance', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (432203598304, 'O76UT8', 'Chevrolet', 'Silverado', 2001, 'Red', 9977, 'maintenance', 'Standard', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (464486053001, 'BTK47K', 'Cadillac', 'Escalade', 2011, 'Turquoise', 9384, 'maintenance', 'Full-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (444008363494, 'HDXHT4', 'Bentley', 'Continental Flying Spur', 2007, 'Violet', 9590, 'maintenance', 'SUV', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (415104662594, 'NJ72F5', 'Land Rover', 'LR4', 2011, 'Yellow', 9943, 'maintenance', 'Truck', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (417136067843, '7XDKV8', 'Suzuki', 'SX4', 2009, 'Goldenrod', 9375, 'maintenance', 'Economy', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (451998223751, 'ZQGKK1', 'Lexus', 'GS', 2009, 'Goldenrod', 9679, 'maintenance', 'Compact', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (484240328593, 'LDD3TE', 'Hyundai', 'Accent', 2011, 'Maroon', 9379, 'maintenance', 'Mid-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (460582078180, '60FAB1', 'Mazda', '626', 1998, 'Pink', 9071, 'maintenance', 'Standard', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (419009567377, 'IG893T', 'Honda', 'Prelude', 1993, 'Orange', 9614, 'maintenance', 'Full-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (460617981746, 'OH32UY', 'Scion', 'xD', 2012, 'Maroon', 9443, 'maintenance', 'SUV', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (426421346572, '2DOV21', 'Toyota', 'Sienna', 1999, 'Yellow', 9472, 'maintenance', 'Truck', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (419336696197, 'OMP3V2', 'Daewoo', 'Leganza', 1999, 'Mauv', 9627, 'maintenance', 'Economy', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (458995509633, '9Z49PC', 'Toyota', 'Land Cruiser', 1998, 'Teal', 9581, 'maintenance', 'Compact', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (403837483813, 'P9PPS0', 'Porsche', 'Cayman', 2006, 'Fuscia', 9023, 'maintenance', 'Mid-size', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (409658038852, 'VIC789', 'Volkswagen', 'Touareg', 2004, 'Goldenrod', 9919, 'maintenance', 'Standard', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (403261300844, 'CU2I5E', 'Mazda', 'Miata MX-5', 2012, 'Blue', 9608, 'maintenance', 'Full-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (401480376340, 'O9FX0E', 'Volkswagen', 'Touareg', 2008, 'Crimson', 9512, 'maintenance', 'SUV', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (421423139489, 'GASNXA', 'Chevrolet', 'Camaro', 1971, 'Maroon', 9068, 'maintenance', 'Truck', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (425375880930, '4X6VKF', 'Toyota', 'RAV4', 2000, 'Aquamarine', 9979, 'maintenance', 'Economy', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (412964355117, 'NVSRRH', 'Volkswagen', 'New Beetle', 2006, 'Mauv', 9589, 'maintenance', 'Compact', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (403054714755, '7IT0OS', 'Saab', '9000', 1988, 'Orange', 9146, 'maintenance', 'Mid-size', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (496482642462, 'WZC9MJ', 'Maserati', 'Gran Sport', 2005, 'Violet', 9877, 'maintenance', 'Standard', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (406785012103, 'P20B3H', 'Dodge', 'D150 Club', 1992, 'Crimson', 9953, 'maintenance', 'Full-size', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (487733855993, 'MUGMIF', 'Nissan', 'Pathfinder', 1997, 'Teal', 9336, 'maintenance', 'SUV', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (461862597681, 'WGBWO2', 'Nissan', 'Altima', 2007, 'Fuscia', 9869, 'maintenance', 'Truck', 'A', 'NY');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (489498394559, '6VEVR5', 'Mitsubishi', 'Pajero', 2003, 'Red', 9671, 'maintenance', 'Economy', 'B', 'Vancouver');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (412448987532, 'K6PI3Q', 'Suzuki', 'Grand Vitara', 2002, 'Purple', 9875, 'maintenance', 'Compact', 'C', 'Montreal');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (440625275903, 'BF7UNI', 'Audi', '200', 1989, 'Pink', 9671, 'maintenance', 'Mid-size', 'D', 'Chicago');
insert into vehicle (id, license, make, model, year, color, odometer, status, vtname, location, city) values (465248014764, '8CBMKW', 'Lexus', 'IS-F', 2010, 'Mauv', 9869, 'maintenance', 'Standard', 'A', 'NY');
