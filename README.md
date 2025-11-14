**Bank Loan Report - Financial Analysis Project**

**📊 Project Overview**

A comprehensive Bank Loan Report system that monitors lending activities, portfolio health, and performance metrics through interactive Power BI dashboards. The solution tracks KPIs, distinguishes between good and bad loans, and identifies trends across multiple dimensions to enable data-driven decision-making.

![Summary Dashboard](https://github.com/user-attachments/assets/870015e6-940d-4bd4-aaec-68db2cf5e6f7)

![Overview Dashboard](https://github.com/user-attachments/assets/5bf82d8d-1e61-4af1-b5bb-917d3cffdc37)

![Details Dashboard](https://github.com/user-attachments/assets/6f22819c-e26c-4ec4-8858-9244cb800528)

**📁 Dataset**

The bank_loan_data table contains 38.6K loan records with:

Loan Details: Amount, interest rate, installment, grade, term

Borrower Info: Employment length, home ownership, income, DTI ratio

Performance: Loan status (Fully Paid, Current, Charged Off), payments

Dimensions: Issue date, state, purpose

Analysis Period: Full year 2021 (MTD: December 2021, PMTD: November 2021)

**🛠️ Tools & Technologies**

Database: PostgreSQL

Visualization: Microsoft Power BI

Query Language: SQL

**🔄 Project Workflow**

**1. SQL Analysis (PostgreSQL)**

Developed queries for KPIs (applications, funded amount, received amount, interest rate, DTI)

Calculated MTD, PMTD, and MoM percentage changes

Created good vs bad loan classification logic

Built multi-dimensional queries (state, term, purpose, employment, home ownership)

**2. Power BI Dashboard Development**
   
Advanced Power BI Techniques Implemented:

Date Table Creation: Built separate calendar table for time intelligence

One-to-many relationship: Date Table (Date) → Bank Loan Data (Issue Date)

Enabled MTD, PMTD, and MoM calculations

DAX Measures for KPIs:

Total Loan Applications, MTD Applications, PMTD Applications, MoM %

Total Funded Amount, MTD Funded, PMTD Funded, MoM %

Total Amount Received, MTD Received, PMTD Received, MoM %

Average Interest Rate, Average DTI with time intelligence

Custom Month Sorting: Applied custom sort order to display months chronologically (Jan-Dec)

Good/Bad Loan Grouping:

Good Loans: Loan Status = "Fully Paid" OR "Current"

Bad Loans: Loan Status = "Charged Off"

Calculated percentages, counts, and amounts for each category

Dynamic Measures (Field Parameters): Created parameter to switch between metrics (Applications, Funded Amount, Received Amount)

New Card Visual: Utilized modern card visuals for KPI display with MTD and MoM indicators

Navigation: Page Navigator buttons for seamless transition between Summary, Overview, and Details dashboards

**Dashboard Structure:**

Summary Dashboard: KPIs, Good vs Bad Loan analysis, Loan Status grid

Overview Dashboard: 6 visual analyses (Monthly trends, State map, Term donut, Employee bar, Purpose bar, Home ownership treemap)

Details Dashboard: Granular loan-level table with interactive filters

**📈 Key Results**

**Portfolio Performance:**

Total Loan Applications: 38.6K (MoM: +6.91%)

Total Funded Amount: $435.8M (MoM: +13.04%)

Total Amount Received: $473.1M (MoM: +15.84%)

Good Loan Rate: 86.2% | Bad Loan Rate: 13.8%

**Top Insights:**

Debt consolidation dominates with 18K applications (46.6%)

73.2% prefer 36-month terms over 60-month

10+ years employment borrowers lead with 8.9K applications

Strong growth trajectory across all metrics

Geographic concentration presents opportunity and risk

**🎯 Business Recommendations**

**Risk Management:** Review underwriting for 13.8% bad loan rate; improve $37.3M recovery on $65.5M charged-off loans

**Growth Opportunity:** Market 60-month term products (only 26.8% adoption); target experienced borrowers (10+ years)

**Product Strategy:** Develop specialized debt consolidation products; replicate successful regional strategies

**Revenue Enhancement:** Monitor 3.47% MoM interest rate increase for market competitiveness


**🚀 How to Run**

Database Setup: Import data into PostgreSQL as bank_loan_data table

Run SQL Queries: Execute queries from documentation to validate data

Open Power BI:

Open .pbix file in Power BI Desktop
Update PostgreSQL connection string
Refresh data


Explore: Navigate through Summary, Overview, and Details dashboards using sidebar buttons

📝 **Skills Demonstrated**

Advanced SQL (CTEs, window functions, aggregations, time-series analysis)

Power BI (DAX, data modeling, time intelligence, interactive visualizations)

Financial metrics analysis and KPI development

Business intelligence and data storytelling

Problem-solving with data-driven insights


**Portfolio Project | Financial Analytics | SQL + Power BI**

**📬 Contact**

Author: Jinal Khona

LinkedIn: www.linkedin.com/in/jinal-khona-84835523a

Email: jinal.khona01@gmail.com
