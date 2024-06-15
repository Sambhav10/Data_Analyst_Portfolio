                                      **   ************* Coffee Sales Data Analysis ***************

Data Source - https://mavenanalytics.io/data-playground?order=date_added%2Cdesc&page=4&pageSize=5

**Business Task**
      
1.Trends of sales over time           
2. Busiest time , date, and month     
3. Best sold products and least sold products      
4. What sizes coffees do people generally prefer      


  **Process**
      
a. Data Cleaning 

1.Checked if there is any duplicate data      
2.Named the table header properly     
3.Corrected the format of the data    
4.Checked if there is any null values    


b. Data Analysis

-	Extracting month and date from the  transaction_date column using 
= Text(B2 ,”mmm”) , Text(B2, “ddd”)

-	Extracting  the size from the product detail using the formula below .
=IF(ISNUMBER(SEARCH("Sm", N10)), "Small", IF(ISNUMBER(SEARCH("Lg", N10)), "Large", IF(ISNUMBER(SEARCH("Rg", N10)), "Regular", "Not Defined")))

-	Also for the busiest_hour analysis I extract the hour from the transaction_time 
=Hour(E2)

-	Calculating the total amount of the single transaction made
Transaction quantity * unit price

Once I transform the data , I am gonna format it as a table so it will be easier to put the info in a pivot table. 




**Dashboard**



![image](https://github.com/Sambhav10/Data_Analyst_Portfolio/assets/85670420/b9639ba7-8084-46e6-8b5b-b2f3238dff78)








  
