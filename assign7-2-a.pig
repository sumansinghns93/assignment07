/** This script is to find 5 employees with highest rating**/

--Load the dataset
empDetails = LOAD 'employee_details.txt' USING PigStorage(',') AS (empId:int, empName:chararray,empSalary:int,empRating:int);  

--Sort the resultset by rating in descending order
sortByRating = ORDER empDetails by empRating DESC,empName ;


--Get first 5 entries of resultset
limitedRecords = LIMIT sortByRating 5;

--Get only empId and empName
requiredEmps = FOREACH limitedRecords generate empId,empName; 

--dump the final resultset
dump requiredEmps;

