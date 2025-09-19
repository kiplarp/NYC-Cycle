# ============================================================
# Cyclistic Case Study Analysis
# ============================================================
# Load required libraries
library(dplyr)
library(lubridate)

# Load the raw CSV files
df1 <- read.csv("Divvy_Trips_2019_Q1.csv")
df2 <- read.csv("Divvy_Trips_2020_Q1.csv")

# Combine datasets into a single dataframe
df <- bind_rows(df1, df2)

# Standardize rider types
df$member_casual <- recode(df$usertype, Subscriber = "member", Customer = "casual")

# Remove columns not present in both datasets
cols_to_remove <- c("start_lat", "start_lng", "end_lat", "end_lng", "birthyear", "gender")
df <- df[ , !(names(df) %in% cols_to_remove)]

# (Optional) Create ride length in seconds and hh:mm:ss
df$ride_length <- as.numeric(difftime(df$ended_at, df$started_at, units = "secs"))
df$ride_length_hms <- seconds_to_period(df$ride_length)

# Save cleaned dataset as clean.csv for analysis
write.csv(df, "divvy_combined_clean.csv", row.names = FALSE)

#HeatMapViz

library(dplyr)
library(ggplot2)

# Extract hour and weekday from the datetime column
df$hour <- format(as.POSIXct(df$started_at), "%H")
df$weekday <- weekdays(as.Date(df$started_at))
df$weekday <- factor(df$weekday, levels = c('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'))

# Summarize total rides by weekday, hour, and user type
rides_by_hour_day <- df %>%
  group_by(weekday, hour, member_casual) %>%
  tally(name = "rides")

# Make the heatmap (separate for each user type)
ggplot(rides_by_hour_day, aes(x=hour, y=weekday, fill=rides)) +
  geom_tile(color="white") +
  facet_wrap(~member_casual) +
  scale_fill_viridis_c(option = "plasma") +
  labs(
    title = "Ride Frequency Heatmap by Hour and Day",
    x = "Hour of Day",
    y = "Day of Week",
    fill = "Number of Rides"
  ) +
  theme_minimal()

#RidesByWeekViz
df$weekday <- weekdays(as.Date(df$started_at))
# Ensuring chronological order for weekday labels:
df$weekday <- factor(df$weekday, 
                     levels = c('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'))

by_day <- df %>%
  group_by(weekday, member_casual) %>%
  tally()

ggplot(by_day, aes(x=weekday, y=n, fill=member_casual)) +
  geom_col(position='dodge') +
  labs(
    title = "Rides by Day of Week", 
    y = "Number of Rides", 
    x = "Day of Week"
  ) +
  theme_minimal()

#RidesOverTimeByUserTypeViz

library(dplyr)
df$date <- as.Date(df$started_at)  # Make sure started_at is a valid date
by_month <- df %>%
  mutate(month = format(date, "%Y-%m")) %>%
  group_by(month, member_casual) %>%
  tally()

ggplot(by_month, aes(x=month, y=n, color=member_casual, group=member_casual)) +
  geom_line(size=1.2) +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  labs(
    title = "Rides per Month",
    y = "Number of Rides", x = "Month"
  ) +
  theme_minimal()

#MeanAndSDTable
summary_tbl <- df %>%
  group_by(member_casual) %>%
  summarize(mean_length = mean(ride_length, na.rm=TRUE),
            sd_length = sd(ride_length, na.rm=TRUE)) %>%
  mutate(
    mean_length_hms = sprintf('%02d:%02d:%02d',
                              as.integer(mean_length) %/% 3600,
                              (as.integer(mean_length) %% 3600) %/% 60,
                              as.integer(mean_length) %% 60)
  )

#UserTpyeBoxPlot
library(ggplot2)

ggplot(df, aes(x=member_casual, y=ride_length, fill=member_casual)) +
  geom_boxplot(outlier.shape=NA) +
  coord_cartesian(ylim=c(0, 3600)) + # Up to 1 hour
  scale_y_continuous(
    breaks = seq(0, 3600, by = 900),
    labels = function(x) sprintf('%02d:%02d:%02d', x %/% 3600, (x %% 3600) %/% 60, x %% 60)
  ) +
  labs(
    title = "Ride Length Distribution by User Type", 
    y = "Ride Length (hh:mm:ss)", 
    x = "User Type"
  ) +
  theme_minimal()
