# Urban Accessibility Analysis

An R-based geospatial research project investigating why Beijing feels like a "bigger city" than Shanghai by comparing urban accessibility, street network structure, POI distribution, population layout, and routing efficiency across major Chinese cities.

The primary comparison is between **Beijing** and **Shanghai**, with extended analysis of **Tianjin** and **Hangzhou**.

<!-- To add sample output figures, place representative PNGs in the repo and uncomment:
![POI density comparison](path/to/figure.png)
-->

## Research Questions

- Why does Beijing feel like a "bigger city" than Shanghai, despite similar population sizes?
- How do street network density, POI distribution, and population layout differ between cities?
- What urban structural factors cause longer detours in some cities than others?
- How well do commercial resources (shops, restaurants, entertainment) align with where people actually live?

## Project Structure

```
.
├── main/                          # Analysis code
│   ├── data_clean_map.R           # Spatial data loading and CRS setup
│   ├── data_etl.R                 # Data combination and preparation
│   ├── main_plot.qmd              # Main Quarto visualization document
│   ├── main_plot_canger.qmd       # Alternative plot variant
│   ├── main_plot_icon.qmd         # Icon-annotated variant
│   ├── osrm.R                     # OSRM routing examples
│   ├── _coordTrans_sampling.R     # Coordinate transforms + route sampling
│   ├── _getDis.R                  # OSRM distance queries
│   ├── _cityCentre_highway.R      # Road density from city center
│   ├── _cityCentre_highway2.R     # Road density variant
│   ├── _cityCentre_population.R   # Population distribution from center
│   ├── _geom_flat_violin.R        # Custom half-violin ggplot2 geom
│   ├── _data_sampling.R           # Point sampling utilities
│   ├── _icon.R                    # Icon image processing
│   ├── _showtext.R                # Font configuration
│   ├── risingCoord/               # Custom R package for coordinate transforms
│   ├── city/                      # City-specific scripts
│   └── xkcd/                      # XKCD-style plotting
├── ICON/                          # Project branding assets
├── data/                          # Geospatial data (~735MB, not in repo)
├── outputs/                       # Generated plots & presentations (not in repo)
├── CLEANUP_REPORT.md
├── README.md
├── CLAUDE.md
└── .gitignore
```

## Methods

### Spatial Analysis
- **POI Density Analysis** -- Computing points-of-interest (restaurants, shops, transit stations) density per km² and visualizing the results as continuous heatmaps
- **Buffer / Concentric Ring Analysis** -- Calculating metrics in 1 km-interval rings radiating outward from city centers (up to 20 km) to reveal how density decays with distance
- **Spatial Intersection** -- Counting POIs within administrative polygons and buffer zones to quantify resource availability
- **Population-POI Mismatch** -- Overlaying commercial resource distribution against population density to identify areas where services are over- or under-supplied relative to residents
- **Coordinate Transformation** -- Converting Amap (GCJ-02) and Baidu coordinates to standard WGS-84 using the custom `risingCoord` R package, ensuring spatial accuracy before all downstream analysis

### Routing & Network Analysis
- **OSRM Route Calculation** -- Computing walking and driving routes for 10,000 population-weighted sample pairs per city via the OpenStreetMap Routing Machine
- **Detour Index** -- Measuring the ratio of actual route distance to straight-line (Euclidean) distance; higher values indicate less efficient street networks that force longer detours
- **Street Network Density** -- Quantifying kilometers of road per km² at varying distances from city centers to characterize how road network structure changes from core to periphery

### Visualization Techniques
- Custom half-violin plots with embedded box plots (`geom_flat_violin`, a custom ggplot2 geometry)
- Kernel density heatmaps with continuous color gradients for POI concentration
- Faceted multi-city comparative maps for side-by-side spatial patterns
- Line charts showing distance-dependent trends (road density, cumulative population share)
- High-resolution output at 300 DPI (4000 x 2500 px)

## Data Sources

| Source | Description |
|--------|-------------|
| **Amap (Gaode) POI** | 2022 point-of-interest data covering shopping, food, entertainment, life services, and sports |
| **OpenStreetMap / OSRM** | Road networks and route calculation via the public OSRM API (`https://routing.openstreetmap.de/`) |
| **Population Density Grids** | China population density shapefiles for spatial population analysis |
| **City Boundary Shapefiles** | Beijing Ring Roads, Shanghai Outer Ring, Tianjin, and Hangzhou administrative boundaries |

## R Packages

### Geospatial & Routing
| Package | Purpose |
|---------|---------|
| `sf` | Simple features for spatial vector data |
| `terra` | Raster and vector geospatial analysis |
| `tidyterra` | Tidy interface for `terra` objects |
| `tmap` | Thematic map visualization |
| `basemaps` | OpenStreetMap basemap tile fetching |
| `osrm` | Interface to the OSRM routing API |

### Visualization
| Package | Purpose |
|---------|---------|
| `ggplot2` | Core plotting framework |
| `ggpubr` | Publication-ready plot arrangement |
| `ggrepel` | Non-overlapping text labels on plots |
| `ggalt` | Extra coordinate systems and geoms |
| `ggthemes` | Additional plot themes |
| `MetBrewer` | Color palettes inspired by museum artworks |
| `colorspace` | Color manipulation and palette generation |
| `magick` | Image processing and compositing |
| `showtext` | CJK (Chinese) font rendering in plots |

### Data Manipulation
| Package | Purpose |
|---------|---------|
| `dplyr` | Data transformation and filtering |
| `data.table` | High-performance data operations |
| `purrr` | Functional programming and iteration |
| `magrittr` | Pipe operator (`%>%`) |
| `glue` | String interpolation |
| `stringr` | String manipulation |
| `combinat` | Combinatorial sampling of route pairs |
| `svMisc` | Progress tracking for long-running loops |

### Custom
| Package | Purpose |
|---------|---------|
| `risingCoord` | In-repo package for GCJ-02 / Baidu / WGS-84 coordinate transformations |

## Workflow

1. **Load spatial data** -- `data_clean_map.R` reads city boundary shapefiles, applies CRS projections, and fetches basemap tiles
2. **Process POI data** -- `_coordTrans_sampling.R` transforms Amap coordinates (GCJ-02 -> WGS-84) and samples 10,000 population-weighted route pairs per city
3. **Calculate routes** -- `_getDis.R` queries the OSRM API for actual walking and driving distances between each sample pair
4. **Compute ring metrics** -- `_cityCentre_highway.R` and `_cityCentre_population.R` calculate road density and population share in concentric rings from each city center
5. **Combine datasets** -- `data_etl.R` merges distance, POI, and population data into unified analysis-ready tables
6. **Generate visualizations** -- `main_plot.qmd` produces 50+ figures covering POI maps, density heatmaps, detour distributions, and multi-city comparisons

## Data Setup

Data files (`.rds`, `.shp`, `.dbf`, etc.) are excluded from the repository via `.gitignore` due to their combined size (~735MB). To reproduce the analysis:

1. **Obtain source data**:
   - Amap POI CSV exports (shopping, food, entertainment, life services, sports categories) for each city
   - China population density grid shapefiles
   - City boundary shapefiles (Beijing Ring Roads, Shanghai Outer Ring, etc.)
2. **Place files** in the `data/` directory at the project root
3. **Run scripts** in the workflow order listed above

## Output

- **118+ PNG figures** at 300 DPI, organized with `Fig X-Y` chapter-figure numbering
- **Quarto HTML report** rendered from `main_plot.qmd`
- **PowerPoint presentations** for Beijing, Shanghai, and Taipei comparisons

All generated outputs are saved to `outputs/` (git-ignored).

## Author

**t.s.helianthus** -- [t.s.helianthus@outlook.com](mailto:t.s.helianthus@outlook.com)
