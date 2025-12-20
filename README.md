# 📡 EMF Field Analyzer

[![MATLAB](https://img.shields.io/badge/MATLAB-R2020b+-0076A8.svg)](https://mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**MATLAB toolkit for monitoring and analyzing electromagnetic field pollution (electrosmog).**

## Overview

EMF Field Analyzer provides tools to collect, process, and visualize electromagnetic field data for environmental monitoring. The project helps researchers, environmental agencies, and enthusiasts assess the electromagnetic quality of their surroundings.

## Frequency Ranges Covered

| Category | Frequency Range | Sources |
|----------|-----------------|---------|
| ELF (Extremely Low Frequency) | ~50 Hz | Power lines, electrical infrastructure |
| HF (High Frequency) | 10⁵ - 10¹¹ Hz | Antennas, radio transmitters, cellular towers |

## Features

- 📊 **Data Visualization** — Dashboards for EM field analysis
- 📈 **Trend Analysis** — Monitor changes over time
- 🗺️ **Spatial Mapping** — Geographic distribution of EM sources
- 📉 **Statistical Reports** — Exposure level assessments
- ⚠️ **Threshold Alerts** — Compliance with safety standards

## Tech Stack

| Component | Technology |
|-----------|------------|
| Analysis | MATLAB R2020b+ |
| Visualization | MATLAB Plotting Tools |
| Data Format | CSV, MAT files |

## Project Structure

```
emf-field-analyzer/
├── antenne (HF - [10^5-10^11] Hz)/
│   ├── data/              # HF measurement data
│   ├── scripts/           # Analysis scripts
│   └── results/           # Output visualizations
├── elettrodotti (eLF - [50]Hz)/
│   ├── data/              # ELF measurement data
│   ├── scripts/           # Power line analysis
│   └── results/           # Reports
└── README.md
```

## Quick Start

### Prerequisites

- MATLAB R2020b or later
- Signal Processing Toolbox (optional)
- Statistics and Machine Learning Toolbox (optional)

### Running the Analysis

```matlab
% Navigate to project directory
cd('emf-field-analyzer')

% Run main analysis script
run('main_analysis.m')

% Generate report
generate_report('output/report.pdf')
```

## Data Sources

| Type | Description |
|------|-------------|
| Power Lines | Measurements near electrical infrastructure |
| Cell Towers | RF emissions from mobile base stations |
| WiFi/Bluetooth | Indoor wireless device emissions |
| Radio Transmitters | Broadcast antenna measurements |

## Safety Standards Reference

| Standard | Organization | Limit (Public Exposure) |
|----------|--------------|------------------------|
| ICNIRP 2020 | International | 100 μT (50 Hz) |
| IEEE C95.1 | USA | 904 μT (60 Hz) |
| D.P.C.M. 8/7/2003 | Italy | 3 μT (quality target) |

*Note: This tool is for informational purposes. Consult official regulations for compliance.*

## Use Cases

- 🏛️ **Environmental Agencies** — Monitor public exposure levels
- 🏠 **Home Assessments** — Evaluate residential EM environments
- 🔬 **Research** — Collect data for scientific studies
- 📋 **Compliance Audits** — Verify adherence to safety standards

## Visualizations

The toolkit generates:
- Time-series plots of field intensity
- Frequency spectrum analysis
- Geographic heat maps
- Statistical distribution charts
- Threshold compliance reports

## Future Enhancements

- [ ] Real-time sensor integration
- [ ] Mobile app companion
- [ ] Machine learning anomaly detection
- [ ] Cloud data storage
- [ ] Multi-language reports

## License

MIT License — See [LICENSE](LICENSE) for details.

---

**Disclaimer**: This tool provides informational data only. For official assessments, consult certified electromagnetic field measurement professionals.
