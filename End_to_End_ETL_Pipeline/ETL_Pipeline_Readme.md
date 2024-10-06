                               **   ************* Student Performance Factor End to End Porject  ***************
# Description
 
In this student performance factor data engineering and analysis project,I have build and automate a Python ETL (Extract, Transform, Load) pipeline using AWS 
services. The process begins by leveraging AWS Glue to load data from an S3 bucket into an Amazon Redshift data warehouse. An AWS Glue Crawler will infer schemas 
and create a data catalog, allowing us to use Amazon Athena for serverless SQL querying on the data. Subsequently, the crawled data will be loaded into Redshift for 
advanced analytics. To visualize the insights, we will connect Power BI to the Redshift cluster, creating interactive dashboards. Finally, Apache Airflow will
orchestrate and automate the entire pipeline, ensuring each step is executed in the correct sequence, providing a comprehensive hands-on experience in data
engineering and analytics.

**Data Source** -[a link](https://www.kaggle.com/datasets/lainguyn123/student-performance-factors/)

# Tools Used
1. **AWS S3 (Simple Storage Service)** - Data storage. Used to store the raw data files before processing.
2. **AWS Glue** -  ETL service. Utilized to automate the extraction, transformation, and loading of data. Glue Crawlers infer schemas and create a data catalog.
3. **AWS Glue Crawler**- Schema inference. Scans the S3 bucket to determine the structure of the data and creates a corresponding data catalog.
4. **Amazon Athena**- Serverless querying. Used to run SQL queries directly on the data catalog created by AWS Glue, enabling ad-hoc analysis without the need for infrastructure management.
5. **Amazon Redshift**- Data warehousing. Serves as the destination for the processed data, allowing for complex analytical queries and reporting.
6. **Power BI*- Data visualization. Connects to the Redshift cluster to create interactive dashboards and reports that provide insights into student performance.
7. **Apache Airflow**- Workflow orchestration. Automates and manages the ETL pipeline, ensuring tasks are executed in the correct sequence and monitoring their progress.


![image](https://github.com/user-attachments/assets/e9a07e48-7aa3-4553-b24b-70a635393853)



# Project Process

## Steps Taken

1. **Download the Dataset**
   - Downloaded the student performance dataset from Kaggle and stored it locally.

2. **Start EC2 Service**
   - Launched an EC2 instance from the AWS console.
   - Configured the instance with the following settings:
     - **OS**: Ubuntu Server
     - **Type**: t2.medium (to ensure proper functioning of Apache Airflow; t2.small and t2.micro do not run Airflow effectively).

       ![image](https://github.com/user-attachments/assets/42addcc8-1b7e-4528-99d5-9e14ff65d971)


3. **Set Up the Virtual Environment**
   - Executed the following commands to set up the environment:
     ```bash
     sudo apt update
     sudo apt install python3-pip
     sudo apt install python3-venv
     python3 -m venv [virtual_env_name]
     source [virtual_env_name]/bin/activate 
     sudo pip install apache-airflow
     pip install apache-airflow-providers-amazon
     airflow standalone
     ```

4. **Configure Security Group**
   - Modified the security group to add a new inbound rule for port 8080 to open the Airflow web interface.
     ![image](https://github.com/user-attachments/assets/fabd4392-873c-4f61-beb4-350e75bd860c)


5. **Connect to EC2 via SSH**
   - Configured SSH to connect Visual Studio Code with the Amazon EC2 instance, enabling code development directly from Visual Studio Code instead of using the EC2 CLI.

6. **Create and Upload Data to S3 Bucket**
   - Created an S3 bucket to store the downloaded Kaggle dataset and uploaded the data to this bucket.

     ![image](https://github.com/user-attachments/assets/fc37842b-996e-46c4-a8eb-fc56155fe660)


7. **Set Up AWS Glue Crawler**
   - Created a Glue Crawler to crawl the data from the S3 bucket into the Glue Data Catalog, which stores the dataset's metadata.
   - After the crawler finished running, verified successful crawling by querying the data using AWS Athena.

     ![image](https://github.com/user-attachments/assets/865cca3b-b5bd-4ac9-8d90-96658cbf140b)


8. **Check Data with Athena**
   - Used AWS Athena (an interactive query service) to run some queries and confirmed successful data retrieval.

     ![image](https://github.com/user-attachments/assets/c5131f6c-ae56-40bc-a8a1-f1094b2ab7e6)


9. **Create Amazon Redshift**
   - Created a Redshift cluster, opting for serverless due to the $300 credit available for first-time users.
   - Ran a query to create a table with the specified schema.

10. **Set Up Glue Crawler for Redshift**
    - Once the table was confirmed to be created, created another Glue Crawler to crawl data into Amazon Redshift.
    - Established a connector to set up the connection between Redshift and the S3 bucket.

      ![image](https://github.com/user-attachments/assets/33069bb9-c000-4ae2-b49a-0be548db945a)


11. **Create ETL Job in Glue**
    - Created an ETL job in Glue where:
      - **Data Source**: Glue Data Catalog
      - **Transformation**: Changed the data type
      - **Data Target**: Amazon Redshift (database: `dev`, schema: `public`, table: `student_performance_factors`)

12. **Configure Airflow DAG**
    - Configured the `student_performance_etl_dag.py` file to automate the ETL process. The DAG includes three tasks:
      1. Trigger the ETL job.
      2. Grab the latest job ID to check the job's status.
      3. Determine whether the job has finished running.
         
         ![image](https://github.com/user-attachments/assets/b119a9ee-125d-4438-ac8f-6d6af4ef391a)

         ![image](https://github.com/user-attachments/assets/8ecb621a-30d9-4773-a5b3-33edd27859dd)




13. **Verify Data in Redshift**
    - Queried the Redshift database using `SELECT *` to confirm that the data was successfully loaded.
      
     ![image](https://github.com/user-attachments/assets/ccadf93c-acb9-47bf-aa52-c91b49d7239b)



14. **Load Data into Power BI**
    - Connected Power BI to Redshift using the endpoint name, database name, and admin credentials.
    - Used the "Transform" feature in Power BI to standardize the data for analysis and visualization.
   
      ![image](https://github.com/user-attachments/assets/ff9ab564-2c3f-47b8-9fe6-77bb9806bf73)

# Key Findings and Conclusions

## Key Performance Indicators (KPIs)
- **Average Attendance**: 79.98%
- **Average Exam Score**: 67
- **Average Sleep Hours**: 7.03 hours
- **Average Hours Studied per Week**: 19.87 hours
- **Average Physical Activity per Week**: 2.97 hours

## Impact of Attendance and Tutoring
- Analysis showed that lower attendance, combined with fewer or no tutoring sessions, correlates with lower exam scores.
- Students who participated in more tutoring sessions tended to score higher.
- Interestingly, students with high attendance (80-100%) often took fewer tutoring sessions but achieved better exam scores, indicating a direct relationship between attendance and performance.

## Public vs. Private School Performance
- The average exam score of public school students is higher than that of students in private schools.

## Study Hours and Exam Performance
- A significant decrease in average exam scores was observed for students who studied fewer hours than previously. In contrast, those who dedicated more time to studying tended to perform better.

## Sleep and Exam Scores
- To achieve average exam scores, students need approximately 7 hours of sleep. Most data points clustered around 60-70 exam scores for students averaging 7 hours of sleep.
- To achieve higher marks, the data indicates a decline in average sleep hours.

## Extracurricular Activities Participation
- A pie chart revealed that 59% of students participate in extracurricular activities (ECA), while about 40.4% do not. This suggests that engaging in ECAs could be linked to better overall performance and student well-being.

## Conclusions
- Attendance significantly influences exam scores, emphasizing the importance of regular class participation.
- The effectiveness of tutoring is clear, especially for students with lower attendance.
- Public school students outperform private school students on average, warranting further investigation into curriculum differences or resource availability.
- Increased study hours correlate positively with higher exam scores, highlighting the need for effective study habits.
- Adequate sleep (around 7 hours) appears critical for optimal performance, yet high achievers may sacrifice sleep.
- The high participation rate in extracurricular activities suggests a positive contribution to student engagement and performance.




























