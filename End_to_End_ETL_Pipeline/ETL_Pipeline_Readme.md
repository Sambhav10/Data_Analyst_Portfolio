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


![image](https://github.com/user-attachments/assets/8003e9f8-2f21-43f4-a3e3-a4b2a587483e)



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




























