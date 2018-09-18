/** This script is to find 1 employees with highest expenses**/
--Load the dataset employee details
empDetails = LOAD 'employee_details.txt' USING PigStorage(',') AS (empId:int, empName:chararray); 

--Load the dataset employee expenses
empExpenses = LOAD 'employee_expenses.txt' USING PigStorage('	') AS (empId:int, expenses:int); 

--Join the two resultsets empDetails and empExpenses on empId
joinData = JOIN empDetails BY empId, empExpenses by empId;

--Sort the resultset by expenses in descending order and then by name
sortedData = ORDER joinData by empExpenses::expenses DESC,empDetails::empName ;

--Get first entry of resultset
firstRecord = LIMIT sortedData 1;

--Get only empId and empName
requiredEmp = FOREACH firstRecord generate empDetails::empId,empDetails::empName; 

--dump the final resultset
dump requiredEmp;
