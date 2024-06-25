# Marketing common data modelling
Welcome to Marketing common data modelling!
We use map data from various ad platforms into a single one. it can help marketers with questions like: "Where clicks better on facebook or tiktok?"

The model behind dashboard uses Google Big Query as the DWH, DBT Cloud for development, Google Looker Studio for dashboard visualization, and contains:
	— raw data from the ad systems (seeds folder),
	- the MCDM table structure for the report, 
	- and [dashboard](https://lookerstudio.google.com/reporting/aa8eb6cc-b97f-433a-b41f-8a6ee0b13af2)


### How to add data from new ad platforms into the MCDM:

1. Place your .csv raw data from new ad platform into the 'seeds' folder in the repositary.
2. Add a code block, extracting and adding your raw data to the model in the file 'models/ads_basic_performance_report.sql', using commented example of code in the file and matching metrics directly or using formulas.   
3. Execute 'dbt seeds'  and 'dbt run' command using DBT Cloud IDE, to activate your changes.
4. [dashboard](https://lookerstudio.google.com/reporting/aa8eb6cc-b97f-433a-b41f-8a6ee0b13af2) will include new data for added ad platform after all steps are done.

- 
