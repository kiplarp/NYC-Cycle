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

```r
# ============================================================
# Cyclistic Case Study Analysis
# ============================================================

library(tidyverse)
library(lubridate)

# Step 1: Load raw datasets
q1_2019 <- read_csv("data/Divvy_Trips_2019_Q1.csv")
q1_2020 <- read_csv("data/Divvy_Trips_2020_Q1.csv")

# Step 2: Combine & clean
all_trips <- bind_rows(q1_2019, q1_2020) %>%
  mutate(member_casual = recode(member_casual,
                                "Subscriber" = "member",
                                "Customer"   = "casual")) %>%
  select(-any_of(c("start_lat", "start_lng", "end_lat", "end_lng",
                   "birthyear", "gender", "tripduration"))) 

write_csv(all_trips, "data/clean.csv")
```


### 1. Ride Counts by Rider Type

- Members ride more frequently than casual riders.  
- Casual riders represent fewer rides overall.

![Ride Counts](visuals/ride_count.png)

```r
p1 <- all_trips %>%
  count(member_casual) %>%
  ggplot(aes(x = member_casual, y = n, fill = member_casual)) +
  geom_col() +
  labs(title = "Total Rides by Rider Type",
       x = "Rider Type", y = "Number of Rides", fill = "Rider Type") +
  theme_minimal()
ggsave("visuals/ride_count.png", p1, width = 6, height = 4)
```

---

### 2. Ride Length Distribution

- Casual riders tend to take longer rides.  
- Members take shorter, more frequent rides, especially on weekdays.  

![Ride Length Distribution](visuals/ride_length_distribution.png)

```r
p2 <- all_trips %>%
  filter(ride_length <= 7200) %>%
  mutate(ride_length_min = ride_length / 60) %>%
  ggplot(aes(x = ride_length_min, fill = member_casual)) +
  geom_histogram(binwidth = 5, position = "identity", alpha = 0.6) +
  labs(title = "Ride Length Distribution (up to 2 hours)",
       x = "Ride Length (minutes)", y = "Count", fill = "Rider Type") +
  theme_minimal()
ggsave("visuals/ride_length_distribution.png", p2, width = 6, height = 4)
```

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

cyclistic-case-study/
data/           # sample CSVs for reproducibility
scripts/        # R scripts for analysis and visualizations
visuals/        # screenshots of plots and tables
README.md       # project story, code, insights




