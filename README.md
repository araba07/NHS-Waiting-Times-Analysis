# NHS Waiting Times & Operational Performance Analysis
![SQL](https://img.shields.io/badge/sql-D95B5B?style=for-the-badge&labelColor=black)
![powerbi](https://img.shields.io/badge/powerbi-D4B853?style=for-the-badge&labelColor=black)
![mysql](https://img.shields.io/badge/mysql-%232A6DA7?style=for-the-badge&logo=mysql&labelColor=black)
![vscode](https://img.shields.io/badge/visual%20studio%20code-%231B395A?style=for-the-badge&labelColor=black)
![git](https://img.shields.io/badge/git-%23D47553?style=for-the-badge&logo=git&labelColor=black)
![excel](https://img.shields.io/badge/excel-%234E8350?style=for-the-badge&logo=excel)

## Project Overview
This project aims to analyse historical NHS waiting time data (2018–2025) and cross-analyse it with a recent regional snapshot from January 2026 to gain a deeper understanding of regional disparities. The core objective was to track operational performance against the national 92% standard (patients treated within 18 weeks) over a multi-year period encompassing pre- and post-COVID pandemic eras, identifying geographical backlogs using a diverse data pipeline.

## Project Structure
```
├── .gitignore                      <- Prevents tracking of temporary/local system files.
├── LICENSE                         <- MIT License detailing open-source usage permissions.
├── README.md                       <- Executive summary, technical documentation, and insights.
├── nhs_data_cleaning_queries.sql   <- Production SQL scripts for ETL and aggregation.
├── data/                    <- Storage directory for raw data source files.
│   ├── RTT-Overview-Timeseries-Including-Estimates-for-Missing-Trusts-Dec25-XLS-115K-6jPlxd.xlsx
│   └── WLMDS-Demographics-Summary-to-25-January-2025-v1.xlsx
│
└── dashboard/               <- Final visualisation files and interactive assets.
    ├─ nhs waiting data prsentation.pbix
    ├─ nhs_waiting_list_dashboard_recording.mp4
    └── nhs_waiting_list_dashboard_recording.gif
```
## My Dashboard 
![NHS Interactive Dashboard Walkthrough](dashboard/nhs_waiting_list_dashboard_recording.gif)
## Data Source & Environment
The analysis combines two distinct operational datasets to evaluate systemic performance:

1. **Historical Waiting Times (2018–2025):** Extracted from the official [NHS England Consultant-Led Referral to Treatment (RTT) Waiting Times Statistics](https://www.england.nhs.uk/statistics/statistical-work-areas/rtt-waiting-times/). This raw data was initially filtered to isolate the most valuable metrics and cleaned in Excel, then ingested into a local MySQL database for data engineering, structural cleaning, and baseline validation queries.
2. **Regional Snapshot (January 2026):** Sourced as a secondary, point-in-time Excel spreadsheet tracking regional case backlogs across England to provide modern context to the historical timeline and to pinpoint which specific regions are the biggest contributors to performance dips.

## Data Processing & SQL Engineering 
During the process of querying the data, I encountered some technical challenges. A key issue I came across was when I ran `DESCRIBE` on the dataset to check the data types. I noticed that the `% within 18 weeks` column had been imported as a `TEXT` type due to the literal percentage characters inside the cells. 

This type mismatch would completely prevent me from running any mathematical queries or aggregations (like averages or minimums) on the performance figures. In order to fix this data quality issue, I wrote the following transformation query:

```sql
SELECT 
    CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2)) AS `% within 18 weeks`
FROM nhs_waiting_data;
```
## Conclusion & Findings
This end-to-end analysis successfully combines historical operational trends (2018–2025) with a modern real-time snapshot (January 2026) to evaluate NHS performance against the baseline 92% standard. 

### Key Operational Insights
* **The Post-Pandemic Deficit:** The historical trend line demonstrates that while the 92% target was consistently approached in earlier years, a systemic downward trend began post-2020. Recovery patterns have stalled, with performance remaining below the red baseline through 2025.
* **Geographical Imbalance:** The January 2026 snapshot reveals that patient backlog volume is heavily concentrated in specific high-density zones. While systemic strain affects every region across the UK, the visual data from the dashboard pie chart clearly highlights London and the Midlands as the primary volume drivers, demonstrating that the absolute scale of the operational backlog is disproportionately worse in these massive population centres.
* **Seasonal Pressures:** Crucially, because this snapshot was captured in January 2026, these figures reflect peak NHS "winter pressures", a seasonal period of maximum operational strain where emergency admissions spike, disproportionately worsening the backlog in these massive population centres.

### Key Technical Takeaways
This project demonstrates a complete data analytics lifecycle: ingesting and cleaning a disorganised SQL database using type casting, combining it with secondary Excel data sources, and translating complex time-series data into an intuitive and interactive visual story.

[← Back to Main Portfolio](https://github.com/araba07/Analytics-Portfolio)

