/** This script is to list all the emlpoyees that have entry in employee expenses**/
--Load the dataset employee details
empDetails = LOAD 'employee_details.txt' USING PigStorage(',') AS (empId:int, empName:chararray); 

--Load the dataset employee expenses
empExpenses = LOAD 'employee_expenses.txt' USING PigStorage('	') AS (empId:int); 

--Join the two resultsets empDetails and empExpenses on empId
joinData = JOIN empDetails BY empId, empExpenses by empId;

--Remove duplicate record
distinctRecords = DISTINCT joinData;

--Get only empId and empName
requiredEmps = FOREACH distinctRecords generate empDetails::empId,empDetails::empName; 


--dump the final resultset
dump requiredEmps;

