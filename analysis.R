 # loading library
library(tidyverse)

# loading the dataset
namma <- read_csv("namma_yatri_bengaluru_ward_wise_all_time_data.csv")

# removing commas from drivers earning and distance travelled bcz it will read it as string
namma <- namma %>%
  mutate(
    `Driver's Earnings` = as.numeric(gsub("[^0-9.]", "", `Driver's Earnings`)),
    `Distance Travelled (km)` = as.numeric(gsub("[^0-9.]", "", `Distance Travelled (km)`))
  )

# creating columns 
namma <- namma %>%
  mutate(
    estimate_rate_calc = (`Searches which got estimate` / Searches) * 100,
    conversion_rate_calc = (Bookings / Searches) * 100,
    completion_rate_calc = (`Completed Trips` / Bookings) * 100,
    total_cancellation_rate_calc = (`Cancelled Bookings` / Bookings) * 100,
    earnings_per_km = `Driver's Earnings` / `Distance Travelled (km)`
  )

# creating namma metrics 
namma_metrics <- namma %>%
  select(
    Ward,
    estimate_rate_calc,
    conversion_rate_calc,
    completion_rate_calc,
    total_cancellation_rate_calc,
    earnings_per_km,
    Searches,
    Bookings,
    `Completed Trips`,
    `Cancelled Bookings`,
    `Distance Travelled (km)`
  )
write_csv(namma_metrics, "namma_yatri_metrics_clean.csv")

# avg of the columns that we craeted
summary_stats <- namma_metrics %>%    
  summarise(
    avg_estimate = mean(estimate_rate_calc, na.rm = TRUE),
    avg_conversion = mean(conversion_rate_calc, na.rm = TRUE),
    avg_completion = mean(completion_rate_calc, na.rm = TRUE),
    avg_cancellation = mean(total_cancellation_rate_calc, na.rm = TRUE),
    avg_earnings_per_km = mean(earnings_per_km, na.rm = TRUE)
  )
print(summary_stats)

# making of service efficiency index
namma <- namma %>%
  mutate(
    service_efficiency_index =
      (estimate_rate_calc * 0.40) +
      (conversion_rate_calc * 0.30) +
      (completion_rate_calc * 0.30)
  )
# top 10 wards according to service efficiency index
top_efficiency <- namma %>%
  select(Ward, service_efficiency_index) %>%
  arrange(desc(service_efficiency_index)) %>%
  head(10)

print(top_efficiency)

# bottom 10 wards according to service efficiency index
bottom_efficiency <- namma %>%
  select(Ward, service_efficiency_index) %>%
  arrange(service_efficiency_index) %>%
  head(10)

print(bottom_efficiency)

# final namma metrics
namma_metrics <- namma %>%
  select(
    Ward,
    estimate_rate_calc,
    conversion_rate_calc,
    completion_rate_calc,
    total_cancellation_rate_calc,
    earnings_per_km,
    service_efficiency_index,
    Searches,
    Bookings,
    `Completed Trips`,
    `Cancelled Bookings`,
    `Distance Travelled (km)`
  )
write_csv(namma_metrics, "namma_yatri_metrics_clean.csv")

# data visualization

library(dplyr)
library(plotly)

# 1. bubble plot
bubble_df <- namma %>%
  mutate(
    hover_text = paste0(
      "Ward: ", Ward, "\n",
      "SEI: ", round(service_efficiency_index, 2), "\n",
      "Estimate Rate: ", round(estimate_rate_calc, 2), "%\n",
      "Conversion Rate: ", round(conversion_rate_calc, 2), "%\n",
      "Completion Rate: ", round(completion_rate_calc, 2), "%"
    )
  )
interactive_bubble <- plot_ly(
  data = bubble_df,
  x = ~total_cancellation_rate_calc,
  y = ~service_efficiency_index,
  size = ~Searches,
  color = ~conversion_rate_calc,
  text = ~hover_text,
  type = "scatter",
  mode = "markers"
) %>%
  layout(
    title = "Interactive Bubble: Cancellation vs SEI",
    xaxis = list(title = "Total Cancellation Rate (%)"),
    yaxis = list(title = "Service Efficiency Index (SEI)")
  )
interactive_bubble

library(htmlwidgets)

saveWidget(
  interactive_bubble,
  file = "interactive_bubble_sei.html",
  selfcontained = TRUE
)

# 2. top 10 wards with their service efficiency index
library(dplyr)
library(ggplot2)

top10 <- namma %>%
  select(Ward, service_efficiency_index) %>%
  arrange(desc(service_efficiency_index)) %>%
  slice_head(n = 10) %>%
  mutate(Ward = factor(Ward, levels = rev(Ward)))  # keep top at top

p_top10_clear <- ggplot(top10, aes(x = service_efficiency_index, y = Ward)) +
  geom_segment(aes(x = min(service_efficiency_index), 
                   xend = service_efficiency_index,
                   y = Ward, 
                   yend = Ward), 
               linewidth = 1) +
  geom_point(size = 4) +
  geom_text(aes(label = sprintf("%.1f", service_efficiency_index)),
            hjust = -0.15, size = 4) +
  labs(
    title = "Top 10 Wards by SEI (Clear Ward Names)",
    x = "Service Efficiency Index (SEI)",
    y = ""
  ) +
  theme_minimal(base_size = 12) +
  theme(axis.text.y = element_text(size = 11))

print(p_top10_clear)
ggsave("top10_sei_clear.png", p_top10_clear, width = 11, height = 7, dpi = 300)

# bottom 10 with their service efficeincy index 
bottom10 <- namma %>%
  select(Ward, service_efficiency_index) %>%
  arrange(service_efficiency_index) %>%
  slice_head(n = 10) %>%
  mutate(Ward = factor(Ward, levels = rev(Ward)))

p_bottom10_clear <- ggplot(bottom10, aes(x = service_efficiency_index, y = Ward)) +
  geom_segment(aes(x = min(service_efficiency_index), 
                   xend = service_efficiency_index,
                   y = Ward, 
                   yend = Ward), 
               linewidth = 1) +
  geom_point(size = 4) +
  geom_text(aes(label = sprintf("%.1f", service_efficiency_index)),
            hjust = -0.15, size = 4) +
  labs(
    title = "Bottom 10 Wards by SEI (Clear Ward Names)",
    x = "Service Efficiency Index (SEI)",
    y = ""
  ) +
  theme_minimal(base_size = 12) +
  theme(axis.text.y = element_text(size = 11))

print(p_bottom10_clear)
ggsave("bottom10_sei_clear.png", p_bottom10_clear, width = 11, height = 7, dpi = 300)

# 4.SEI vs earnings per km
# 4) SEI vs earnings per km  (SAVE PROPERLY)
p_earn_vs_sei <- ggplot(namma, aes(x = service_efficiency_index,
                                   y = earnings_per_km)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Operational Efficiency vs Revenue Efficiency",
    x = "Service Efficiency Index (SEI)",
    y = "Earnings per KM"
  ) +
  theme_minimal()

print(p_earn_vs_sei)

ggsave("earnings_per_km_vs_sei.png",
       plot = p_earn_vs_sei,
       width = 9,
       height = 6,
       dpi = 300)

