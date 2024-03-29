# Final-Project-Transforming-and-Analyzing-Data-with-SQL

## Project/Goals
In this SQL project, my goals are to improve my SQL knowledge and  experience within the language through practicing. Including:
  - Get familiar with data cleaning and its process. Using SQL to clean and preprocess the data in the provided database to improve data quality and ensure that it       is suitable for analysis.
  - Apply data into business intelligence by using SQL to generate reports and insights that can be useful to inform business decisions and strategies.
  - Have better understanding about data engineering process includes develop and maintain data pipelines that collect, process, and store data from various sources.
  - Practicing data visualization by using SQL to create charts, graphs, and other visualizations to help communicate insights from the data.
  - Learn new concept of data modeling which helps create database schemas and models that can be used to organize and store data effectively.
  - Experimenting with data exploration by using SQL to explore and analyze a database to better understand the data and identify patterns and relationships.

## Process
### Step 1
I took time to carefully read through the assignment and its requirements. I also previewed all of the provided materials and the Evaluation Rubric to make sure my approach to this assignment is on the right path and meets the expectation.
### Step 2
Started my assignment with the installation process and setting up 
  - Clone repo to my local device
  - Download files
  - Run test query and commit/push test file to Github through Github Deskstop
  - Create all of the required tables with their columns and assigning data types
 ### Step 3
1. I started with Part 2 - Data Cleaning. I managed to clean some of the data such as change data type, remove some columns that offer no attributes, manipulate some input values.
2. Next I moved on to Part 3 - Start with Questions. I discussed with some of my peers and also follow the group chat along with the request-assistant chat box in Discord to help me have a better understanding for those questions, get tips from my peers and from there choosing the right approach to solve the questions.
3. I tried to come up with simple but efficient questions and solutions for Part 4 - Start with Data. I found myself enjoying doing this task the most compared to the rest of the tasks in this SQL assignment.
4. The Part 5 - QA Your Data took me a long time to get through since I tried to create alternative queries or run test by pulling out result based on expected value for every single query that I create in this assignment.
5. Final step was to create the ERD and have the tables linked properly. Then creating and preparing for the presentation.

## Results

Based on the provided data and through all the queries I have created, below are some of what I learned about this database:
 
 - Total revenue generated from each city:
      + The query calculates the total transaction revenue for each city by summing the totaltransactionrevenue column. This information helps identify cities that contribute the most to revenue generation.

  - Unique visitors with multiple visits:
      + The query counts the number of distinct fullvisitorid values that appear more than once in the dataset. This information helps identify visitors who have made multiple visits to the site.

  - Total number of unique visitors:
      + The query counts the number of distinct fullvisitorid values in the dataset. This information provides an overall count of unique visitors to the site.

  - Unique visitors by channel grouping:
      + The query counts the number of distinct fullvisitorid values grouped by channelgrouping. This information helps analyze the distribution of unique visitors across different channels.

  - Distinct visitor-product combinations with first view time:
      + The query retrieves distinct combinations of fullvisitorid and productsku, considering the earliest pageviews value for each combination. This information helps identify the first time a visitor viewed a specific product.

  - Total visitors, visitors with a purchase, and purchase conversion rate:
      + The query calculates the total number of unique visitors, the number of visitors who made a purchase (where unitsold > 0), and the purchase conversion rate as a percentage. This information helps analyze the effectiveness of converting visitors into customers.

Based on the above information that we were able to pulled out from this database, I used the SQL queries to retrieve and aggregate the necessary data mostly from the allsessions and analytics tables. And by analyzing these query results, in the business environment, insights can be gained regarding revenue generation, visitor behavior, conversion rates, and other relevant metrics.

## Challenges 

As someone who has no experience in coding before entering this boothcamp, i have learned that I faced quite many challenges during this SQL assignment:

  - Syntax and Query Structure: Choosing the right approach, remembering and applying the proper syntax and query structure for each of the problems/questions are quite challenging at first for me, especially for complex queries involving multiple tables, joins, aggregations, and window functions.

  - Data Cleaning process: This process took me a lot of time since I'm still new to working with data and the provided database is quite messy and challenging to clean. I had a hard time to decide whether or not I have to get rid of a row/column for instant. Also, I'm still not quite familiar with the suitable data type for the data input.

  - QA the queries: As mentioned, I found that the process of QA the queries meaning verifying the accuracy of query results and comparing them to expected outcomes is quite time-consuming and it took me a long time to come up with alternative queries.

  - Troubleshooting and Debugging: Many times when encountering errors or unexpected results, troubleshooting and debugging queries are also challenging for me. In these case I tried to spend some time on carefully review my code before consulting with my peers and seeking help from mentors.

## Future Goals
If I had more time, definitely would go back and start doing data cleaning more

  - Understand more about the data, tables and their relationships
  - QA process - Testing by using calculation MIN MAX 
  - Remove duplicates
  - Locate primary and foreign keys
  - Come up with more questions and solutions through the dataset

