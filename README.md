# 🚲 Cyclistic Bike-Share Case Study

## 📌 About the Project
This case study explores **how annual members and casual riders use Cyclistic bikes differently**, using real-world Divvy bike-share data.  
The goal: **Provide insights that will help convert casual riders into annual members**.

---

## 1️⃣ Ask – Business Task
- **Business Question:** How do annual members and casual riders use Cyclistic bikes differently?  
- **Why it matters:** Annual members are more profitable. Understanding usage patterns can guide marketing strategies.  
- **Stakeholders:**  
  - Lily Moreno (Marketing Director)  
  - Cyclistic Marketing Analytics Team  
  - Cyclistic Executive Team  

---

## 2️⃣ Prepare – Data Sources
- **Source:** [Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)  
- **Timeframe:** Last 12 months  
- **Format:** CSV files  
- **Credibility:** Published by Motivate International Inc. (reliable, public).  
- **Limitations:**  
  - Anonymized data (no demographics).  
  - Cannot link casual riders across trips.  

---

## 3️⃣ Process – Data Cleaning
Steps taken:  
✔️ Combined 12 monthly CSVs into one dataset.  
✔️ Standardized column names.  
✔️ Removed duplicates, null values, and outliers (negative/24h+ ride times).  
✔️ Created new columns:  
- `ride_length` = `ended_at - started_at`  
- `day_of_week` = weekday of `started_at`  

---

## 4️⃣ Analyze – Findings
Key insights:  
- 📏 **Ride Length:** Casual riders’ trips are longer on average.  
- 📅 **Day of Week:**  
  - Members: consistent weekday rides (commuting).  
  - Casuals: peak on weekends (leisure).  
- 🌞 **Seasonality:** Casual usage spikes in summer.  
- 🕒 **Time of Day:** Members ride during rush hours; casuals spread throughout the day.  

---

## 5️⃣ Share – Visualizations
Visualizations created:  
- **Rides by User Type and Day of Week**  
- **Monthly Ride Trends**  
- **Ride Length Distributions**  
- **Hourly Ride Patterns**  

👉 Example:  
![Rides by Day](visualizations/rides_by_day.png)  

---

## 6️⃣ Act – Recommendations
Based on findings:  
1. 🎯 **Target Weekend Leisure Riders**  
   - Promote annual memberships to casual riders who ride mostly on weekends.  
2. 🚴 **Highlight Commuter Benefits**  
   - Market reliability & cost savings for weekday commuters.  
3. 🌱 **Seasonal Campaigns**  
   - Launch spring promos to capture casual riders before summer surge.  

---

## 📂 Project Structure
```bash
cyclistic-case-study/
├── data/              # raw and cleaned datasets (samples only)
├── scripts/           # Python/Excel/R scripts for cleaning & analysis
├── visualizations/    # charts & graphs
├── outputs/           # summary tables, pivot results
└── README.md          # full case study (this file)
