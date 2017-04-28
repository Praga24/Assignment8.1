--Loading Data

A = load ‘/home/acadgild/Desktop/petrol-dataset.txt’ USING PigStorage(‘,’) AS (ID:chararray, name:chararray, buy:chararray, 
    sell:chararray, in:int ,year:int);

--Total amount of petrol in volume sold by every distributor

B = group A by name;
C = foreach B GENERATE group,SUM(a.out)

--Top 10 distributors ID's for selling petrol? Also display the amount of petrol sold in volume.

C = foreach B GENERATE group,SUM(A.out) as sum;
D = order C by sum DESC;
E =limit D 10;

--List 10 years where consumption of petrol is more with the distributer id who sold it.

B = group A (ID, year);
C = foreach B GENERATE A.ID as id, A.year as year, SUM(A.in) as cons;
D = order  C by cons DESC;
E = foreach D GENERATE id,year;
E = foreach D GENERATE flatten(id), flatten(year);
F = limit E 10;

--The distributer name who sold petrol in least amount. 

B = group A by year;
C = foreach B {
temp = foreach A GENERATE in-out;
generate A.name as name, A.year as year, sum(temp) as sale;};
D = order C by sale DESC;
E = foreach C generate flatten(name);
F = limit E 1;

