# 🌧️ Precipitation Indices Analysis using `precintcon`

This project provides a complete R workflow for computing a range of precipitation-based indices from daily rainfall data across multiple meteorological stations. The workflow is based on the [`precintcon`](https://cran.r-project.org/web/packages/precintcon/index.html) R package, and includes the calculation of several standard indices used in climate variability analysis.

---

## 📂 Project Structure

```
.
├── clmto.csv                  # Input file: daily rainfall data in long format
├── precipitation_indices.R    # Main R script
├── pcd_result.xlsx            # Output: Precipitation Concentration Degree
├── pci_seasonal_result.xlsx   # Output: PCI Seasonal
├── pci_supraseasonal_result.xlsx # Output: PCI Supraseasonal
├── pcp_result.xlsx            # Output: Precipitation Concentration Period
├── spi_result.xlsx            # Output: Standardized Precipitation Index (3-month)
├── rai_result.xlsx            # Output: Rainfall Anomaly Index (monthly)
├── tii_result.xlsx            # Output: Temporally Irregularity Index
└── README.md                  # Project documentation
```

---

## 📊 Indices Computed

1. **PCD** – Precipitation Concentration Degree  
2. **PCI (Seasonal and Supraseasonal)** – Precipitation Concentration Index  
3. **PCP** – Precipitation Concentration Period  
4. **SPI** – Standardized Precipitation Index (3-month aggregation)  
5. **RAI** – Rainfall Anomaly Index (monthly)  
6. **TII** – Temporally Irregularity Index  

---

## 🧪 Requirements

- R ≥ 4.0
- Packages:
  - `tidyverse`
  - `precintcon`
  - `writexl`
  - `readr`
  - `purrr`
  - `tibble`

Install all required packages using:

```r
install.packages(c("tidyverse", "precintcon", "writexl"))
```

---

## 🧬 Data Format

Input CSV file `clmto.csv` must contain the following columns:

| Station_Name | Year | Month | Day | RR |
|--------------|------|-------|-----|----|
| Station_A    | 1991 | 1     | 1   | 0  |
| Station_A    | 1991 | 1     | 2   | 5  |
| ...          | ...  | ...   | ... | ... |

---

## 🚀 Running the Analysis

Simply source the main script in R:

```r
source("precipitation_indices.R")
```

This will generate Excel files with the computed indices for each station.

---

## 📈 Applications

- Climatological research
- Drought analysis
- Climate variability assessment
- Early warning systems
- Agricultural planning

---

## 📘 References

- **precintcon** package documentation: https://cran.r-project.org/web/packages/precintcon/
- Martinaitis, S.M. et al. (2015). Application of precipitation concentration indices in climate studies.
- WMO Guidelines on Climate Indices

---

## 👤 Author

**Adaman Yoda**  
National Meteorological Agency of Burkina Faso  
PhD Candidate, AI for Weather Forecasting  
Email: [adamouyod@gmail.com]

---

## 📄 License

This project is open-source and available under the MIT License.
