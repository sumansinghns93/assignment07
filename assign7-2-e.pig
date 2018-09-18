/** This script is to find list of employees not having entry in employess expenses**/

--Load the dataset employee details
empDetails = LOAD 'employee_details.txt' USING PigStorage(',') AS (empId:int, empName:chararray); 

--Load the dataset employee expenses
empExpenses = LOAD 'employee_expenses.txt' USING PigStorage('	') AS (empId:int); 

/**Use COGROUP to take cross product of the two resultsets empDetails and empExpenses on empId as well as group them. **/
coGroupData = COGROUP empDetails BY empId, empExpenses by empId;

/**Filter the records to get ones which have null value for expenses column**/
filteredData = FILTER coGroupData BY IsEmpty(empExpenses);

--Get only empId and empName
flattenedData = FOREACH filteredData generate FLATTEN(empDetails); 

--dump the final resultset
dump flattenedData;


