/** This script is to find 3 employees with highest salary and whose employee id is odd**/

--Load the dataset
empDetails = LOAD 'employee_details.txt' USING PigStorage(',') AS (empId:int, empName:chararray,empSalary:int);  

--Filter resultset to get employees with odd empId
filteredEmps = FILTER empDetails BY empId % 2 != 0;

--Sort the resultset by salary in descending order
sortBySalary = ORDER filteredEmps by empSalary DESC,empName ;


--Get first 3 entries of resultset
limitedRecords = LIMIT sortBySalary 3;

--Get only empId and empName
requiredEmps = FOREACH limitedRecords generate empId,empName; 

--dump the final resultset
dump requiredEmps;

