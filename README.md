# flights
A case study to ingest a flat file into Snowflake, normalise the data into star schema and provide a view where dim and fact tables are joined back as OBT.

## :file_folder: Contents
-   Goal
-   Overview
-   Prerequisites
-   Installation
-   Usage
-   Challenges
-   Future Improvements
-   Author

## :soccer: Goal
-   Work with unfamiliar data and quickly gain familiarity with that data.
-   Load the data from a file-based source into a target Snowflake database. 
-   Transform the data into a normalised, dimensional data model with appropriate data types.
-   Think critically about preparing data for business users and analytics consultants.

## :rocket: Overview
-   dbt Cloud was used to develop the SQL scripts.
-   The dbt project code was stored in a GitHub repo.
-   dbt Cloud orchestrates the execution of the SQL models generating tables and views.

## :memo: Prerequisites
-   GitHub repo
-   dbt Cloud account
-   Snowflake account

## :hammer_and_wrench: Installation

**To be completed**

## :computer: Usage 
1.  Log in to the dbt Cloud IDE and run the command `dbt run`.

2.  Log in to Snowflake to see the database objects that were created.

## :muscle: Challenges
-   The time fields contained the numeric value **2400**. I made the assumption this meant midnight i.e. **0000** of that day (flightdate). Therefore, when converting to midnight I did not add one day to the flightdate.

-   There was no indication of timezone, therefore I assumed UTC as this is to my knowledge standard practice when storing time related information.

-   I was unsure whether further cleanup of **origairportname** and **destairportname** was required as I saw some airport names had compound names with the forward slash e.g. George Bush Intercontinental/Houston.

-   Removed the `@` symbol from **tailnum**, however I'm unsure if this is malformed character encoding.

-   Numerous null values were found across multiple fields, not just in those typically associated with cancelled flights.

## :crystal_ball: Future Improvements
-   Liaise with the business to understand the compound airport names to determine if further cleaning is necessary e.g. George Bush Intercontinental/Houston. If so, consider a mapping table or dbt seed file.

-   Update the README.md **Installation** section with details on forking the repo to your GitHub account, configuring your dbt Cloud IDE with your repo and snowflake account.

## :pencil2: Author
Luke Huntley
