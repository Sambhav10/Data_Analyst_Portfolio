                                      **   ************* Airlines Customer Data Analysis ***************

Data Source - https://mavenanalytics.io/data-playground

**Recommended  Analysis**
      
1.	Which percentage of airline passengers are satisfied? Does it vary by customer type? What about types of travel?
2.	What is the customer profile for a repeating airline passenger?
3.	Does flight distance affect customer preferences or flight patterns?
4.	Which factors contribute to customer satisfaction the most? What about dissatisfaction?
  


  **Process**
      
a. Data Cleaning 

- Duplicate entries were identified and removed to ensure the dataset's accuracy.
- Approximately 390 entries with null or empty values were detected and replaced with zeros to maintain data integrity.
- Flight distances recorded in miles were converted to kilometers for easier interpretation.
  This conversion used the formula: Distance in Kilometers = Distance in Miles × 1.60934.
   For example, the distance in cell G2 was converted using the formula G2 × 1.60934.
- Age data was categorized into distinct groups using a conditional formula:
  if age is 12 or younger, the individual is classified as a "Child";
  ages between 13 and 19 are classified as "Teen";
  ages between 20 and 39 are classified as "Adult";
  ages between 40 and 59 are classified as "Middle Aged";
  and ages 60 or older are classified as "Senior."

b. Data Analysis

 - The analysis reveals that approximately **57%** of customers are dissatisfied with the service provided,   
 while only **43%** report satisfaction. This indicates a substantial area for improvement in the overall customer experience.

- Returning customers, typically **middle-aged** (40-59 years), frequently undertake longer flights for business purposes,
  averaging **3036.27** kilometers. Notably, about **70%** of these middle-aged travelers are satisfied with the airline's service,
  suggesting that business travelers have a relatively positive view of the service offered.

- Regarding class preferences, **47.86%** of passengers opt for Business Class for longer flights, with an average distance of
  **2696.3** kilometers. In contrast, **44.89%** prefer Economy Class for shorter flights, averaging **1197.09** kilometers.
  This data highlights a clear distinction in travel preferences based on flight distance.

- The analysis also identified the primary areas of customer dissatisfaction. **Inflight Wi-Fi Service, Online Booking,
  and Gate Locations** received the lowest average ratings of **2.73, 2.76, and 2.98**, respectively. These services represent
  key opportunities for substantial improvement.

- Conversely, the services that received the highest levels of customer satisfaction include **In-Flight Services,
  Baggage Handling, and Seat Comfort**, with average ratings of **3.64, 3.63, and 3.44**, respectively. These areas
  are performing well and should be maintained to continue fostering high levels of customer satisfaction.



**Dashboard**

![airlines_customer_analysis](https://github.com/user-attachments/assets/df4c05a1-40c8-4ded-b016-fa26ee8d7af9)





  
