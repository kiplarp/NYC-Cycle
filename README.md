# Cyclistic Case Study – Understanding Rider Behavior

**Author:** Kip Larpenter 
**Date:** 2025-9-18

---

## Overview

This project analyzes Divvy bike share trip data from 2019 and 2020 to answer the question:  

**How do annual members and casual riders use Cyclistic bikes differently?**  

By combining the two datasets, cleaning the data, and creating visualizations, we can draw actionable insights for marketing and operational decisions.

---

## Data Source
- **Source:** [Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)
- **Divvy_Trips_2019_Q1.csv** – raw 2019 trip data  
- **Divvy_Trips_2020_Q1.csv** – raw 2020 trip data  
- **Usage License:**[Data License Agreement] (https://divvybikes.com/data-license-agreement)
- **Timeframe:** Last 12 months  
- **Format:** CSV files  
- **Credibility:** Published by Motivate International Inc. (reliable, public).  
- **Limitations:**  
  - Anonymized data (no demographics).  
  - Cannot link casual riders across trips.  


**Data Preparation Steps:**

1. Loaded both raw CSVs into R.  
2. Combined datasets into a single dataframe.  
3. Standardized rider types:  
   - `Subscriber` → `member`  
   - `Customer` → `casual`  
4. Removed columns not present in both datasets (`start_lat`, `start_lng`, `end_lat`, `end_lng`, `birthyear`, `gender`, `tripduration`).  
5. Saved cleaned dataset as `clean.csv` for analysis.

---

## Analysis & Visualizations

### 1. Ride Counts by Rider Type

- Members ride more frequently than casual riders.  
- Casual riders represent fewer rides overall.

![Ride Counts](visuals/ride_count.png)

---

### 2. Ride Length Distribution

- Casual riders tend to take longer rides.  
- Members take shorter, more frequent rides, especially on weekdays.  

![Ride Length Distribution](visuals/ride_length_distribution.png)

---

### Key Findings

- **Members**: Predominantly weekday commuters, shorter trips.  
- **Casual riders**: Weekend/longer leisure trips.  
- Rider behavior patterns are clear and can guide marketing, promotions, and retention strategies.

---

### Recommendations

1. **Promote weekend deals for casual riders** → encourage conversion to annual memberships.  
2. **Highlight commuting benefits** → build loyalty among existing members.  
3. **Target marketing by ride length** → suggest membership perks for casual riders taking long trips.

---

## Conclusion

By analyzing combined trip data from 2019 and 2020, we identified distinct usage patterns between members and casual riders.  

This analysis provides actionable insights for Cyclistic to improve customer acquisition, retention, and operational planning.

---

## Repository Structure

- `data/` – raw and cleaned CSVs  
- `scripts/` – analysis and visualization code  
- `visuals/` – exported plots  
- `README.md` – project story, findings, and recommendations



