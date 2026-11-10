# Namma Yatri Ward Performance Analysis

An exploratory analysis of ward-level Namma Yatri metrics for Bengaluru. The project compares the ride funnel, cancellation rates and driver earnings per kilometre, using R and interactive and static visualizations.

**[Explore the project page](https://mohitloonia.github.io/Namma_Yatri_Analysis/)**

## Questions explored

- How do estimated, booked and completed rides vary across wards?
- Which wards rank highest and lowest under a custom service efficiency index?
- How do cancellation rates and earnings per kilometre compare with that index?

## Metrics

All rates are percentages. Each row is a ward-level aggregate.

| Metric | Calculation |
| --- | --- |
| Estimate rate | Searches with estimate / searches × 100 |
| Conversion rate | Bookings / searches × 100 |
| Completion rate | Completed trips / bookings × 100 |
| Cancellation rate | Cancelled bookings / bookings × 100 |
| Earnings per km | Driver earnings / distance travelled |
| Service Efficiency Index (SEI) | 0.40 × estimate rate + 0.30 × conversion rate + 0.30 × completion rate |

SEI is a custom analytical score. Its weights are chosen for this analysis and are not an official Namma Yatri metric. Rankings depend on the chosen weights and may be sensitive to small denominators.

## Interpreting the results

The cancellation-versus-SEI chart shows a downward pattern. Completion rate is a component of SEI, and completed and cancelled bookings have a close mathematical relationship; therefore this pattern is partly mechanical. It does not establish that changing SEI causes cancellations to change. The earnings chart is exploratory and does not establish independence or causality. Ward-level totals also do not describe individual driver experiences.

## Data and reproducibility

The included `namma_yatri_metrics_clean.csv` contains the derived ward-level metrics used in this analysis. The original input is described in the script as Bengaluru ward-wise all-time data, but its source URL, extraction date and reuse terms have not yet been documented. The original raw file is not included; the cleaned data alone does not contain every input needed to reproduce the R script. Add and document the original data before making claims about its provenance or fully reproducing the analysis.

## Run the analysis

1. Install R and the R packages `tidyverse`, `plotly`, and `htmlwidgets` (the self-contained HTML export may also require Pandoc).
2. Place the original dataset named `namma_yatri_bengaluru_ward_wise_all_time_data.csv` in the project folder. This file is currently missing.
3. Set the R working directory to the project folder and run `source("analysis.R")`.
4. The script regenerates the cleaned CSV, PNG charts and `interactive_bubble_sei.html`. It does not automatically update the published `interactive_bubble.html` copy.

To browse the project locally, serve the folder with `python -m http.server 8000` and visit `http://localhost:8000`. The site includes the pre-existing Plotly chart and PNG visualizations.

## Files

- `analysis.R` — cleaning, metric calculations and chart generation.
- `namma_yatri_metrics_clean.csv` — derived ward-level metrics.
- `index.html` — project overview and visualizations.
- `interactive_bubble.html` — existing interactive Plotly chart.
- `top10_sei_clear.png`, `bottom10_sei_clear.png`, `earnings_per_km_vs_sei.png` — existing charts.

## Tools

R, tidyverse, dplyr, ggplot2, Plotly and HTML.

**Author:** Mohit Loonia
