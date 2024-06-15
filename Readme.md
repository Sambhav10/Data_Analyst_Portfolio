                                         ************* Coffee Sales Data Analysis *************

Data Source - https://mavenanalytics.io/data-playground?order=date_added%2Cdesc&page=4&pageSize=5

Business Task 
-Trends of sales over time 
- Busiest time , date, and month 
-Best sold products and least sold products
-What sizes coffees do people generally prefer

Process 
Data Cleaning 
-Checked if there is any duplicate data 
-Named the table header properly.
-Corrected the format of the data
-Checked if there is any null values. 

Data Analysis 
-	Extracting month and date from the  transaction_date column using 
= Text(B2 ,”mmm”) , Text(B2, “ddd”)

-	Extracting  the size from the product detail using the formula below .
=IF(ISNUMBER(SEARCH("Sm", N10)), "Small", IF(ISNUMBER(SEARCH("Lg", N10)), "Large", IF(ISNUMBER(SEARCH("Rg", N10)), "Regular", "Not Defined")))

-	Also for the busiest_hour analysis I extract the hour from the transaction_time 
=Hour(E2)
-	Calculating the total amount of the single transaction made
Transaction quantity * unit price 
Once I transform the data , I am gonna format it as a table so it will be easier to put the info in a pivot table. 


Dashboard
![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/761dafd6-d304-4ab9-a005-75fba5302a55)








  

