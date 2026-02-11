# Urban Accessibility Analysis

A geospatial research project analyzing urban accessibility and community structure differences across major Chinese cities. The primary comparison is between **Beijing** and **Shanghai**, with extended analysis of **Tianjin** and **Hangzhou**.

## Project Overview

**Urban Accessibility Analysis** is an R-based geospatial research project that compares urban accessibility and community structure across major Chinese cities, primarily **Beijing** and **Shanghai**, with extended comparisons to **Tianjin** and **Hangzhou**.

The central research question: Why does Beijing feel like a "bigger city" than Shanghai, and what urban structural factors (street networks, POI distribution, population layout, routing efficiency) explain this?

## Language & Runtime

- **R** (no Python) -- all analysis, data processing, and visualization
- **Quarto** (`.qmd`) for reproducible report generation

## Project Summaries

- **中文摘要 (`SUMMARY_CH.md`)**: 城市可达性与路网差异研究的中文总结，概括北京与上海在城市尺度、人口与商业资源分布、绕路指数和路网密度等方面的主要发现，并附部分代表性图示。
- **English Summary (`SUMMARY_EN.md`)**: English research summary of the project, highlighting key questions, methods, and findings on accessibility and street network differences between Beijing and Shanghai, with selected figures for quick overview.

## Research Questions

- Why does Beijing feel like a "bigger city" compared to Shanghai?
- How do street network density, POI distribution, and population layout differ between cities?
- What causes routing inefficiency (detours) in different urban structures?
- How well do commercial resources align with population distribution?

## Methods

### Spatial Analysis
- **POI Density Analysis** -- Points of interest (restaurants, shops, transit stations) per km², visualized as continuous heatmaps
- **Buffer/Concentric Ring Analysis** -- Metrics computed in 1km-interval rings radiating from city centers (up to 20km)
- **Spatial Intersection** -- POI counts within administrative polygons and buffer zones
- **Population-POI Mismatch** -- Comparing commercial resource distribution against population density

### Routing & Network Analysis
- **OSRM Route Calculation** -- Walking and driving routes computed for 10,000 population-weighted sample pairs per city using the OpenStreetMap Routing Machine
- **Detour Index** -- Ratio of actual route distance to straight-line (Euclidean) distance, measuring street network efficiency
- **Street Network Density** -- Kilometers of road per km² at varying distances from city centers

### Coordinate Systems
- **GCJ-02 to WGS-84 transformation** -- Converting Amap (Gaode) coordinates to standard WGS-84 using the custom `risingCoord` R package
- **Baidu to WGS-84** -- Additional coordinate system support

### Visualization
- Half-violin plots with embedded box plots (custom `geom_flat_violin` ggplot2 geometry)
- Density heatmaps with continuous color gradients
- Faceted multi-city comparative maps
- Line charts for distance-dependent trends (road density, population share)
- High-resolution output (300 DPI, 4000x2500px)

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
│   ├── _cityCentre_population.R   # Population distribution from center
│   ├── _geom_flat_violin.R        # Custom half-violin ggplot2 geom
│   ├── _data_sampling.R           # Point sampling utilities
│   ├── _icon.R                    # Icon image processing
│   ├── _showtext.R                # Font configuration
│   ├── risingCoord/               # Coordinate transformation package
│   │   └── R/                     # GCJ-02 <-> WGS84, Baidu <-> WGS84
│   ├── city/                      # City-specific scripts
│   └── xkcd/                      # XKCD-style plotting
├── ICON/                          # Project branding assets
├── data/                          # Geospatial data (not in repo)
├── outputs/                       # Generated plots & presentations (not in repo)
├── CLEANUP_REPORT.md              # Repo cleanup documentation
└── .gitignore
```

## Workflow / Execution Order

1. **Load spatial data** -- `data_clean_map.R` reads shapefiles, applies CRS projections, fetches basemap tiles
2. **Process POI data** -- `_coordTrans_sampling.R` transforms Amap coordinates (GCJ-02 -> WGS-84) and samples 10,000 population-weighted route pairs per city
3. **Calculate routes** -- `_getDis.R` queries the OSRM API for actual walking and driving distances
4. **Compute ring metrics** -- `_cityCentre_highway.R` and `_cityCentre_population.R` calculate road density and population share in concentric rings from each city center
5. **Combine datasets** -- `data_etl.R` merges distance, POI, and population data
6. **Generate visualizations** -- `main_plot.qmd` produces 50+ figures covering POI maps, density heatmaps, detour distributions, and multi-city comparisons

## Data Sources

| Source | Description |
|--------|-------------|
| **Amap (Gaode) POI** | 2022 point-of-interest data -- shopping, food, entertainment, life services, sports |
| **OpenStreetMap** | Road networks and routing via OSRM (`https://routing.openstreetmap.de/`) |
| **Population Grids** | China population density shapefiles |
| **City Boundaries** | Beijing Ring Roads, Shanghai Outer Ring, Tianjin, Hangzhou administrative boundaries |

## Data Files

All `.rds`, `.rda`, `.shp`, `.dbf` files are git-ignored. They must be obtained separately and placed in `data/`. Key processed data files include:
- `bj_amap_poi.rds` / `sh_amap_poi.rds` -- processed POI points
- `bj_amap_dis.rds` / `sh_amap_dis.rds` -- route distance calculations
- `bj_sh_pop_density.rds` -- population by radius
- `bj_sh_highway_density.rds` -- road density by distance

## R Packages

### Geospatial & Mapping
| Package | Purpose |
|---------|---------|
| `sf` | Simple features for spatial data handling |
| `terra` | Raster and vector geospatial analysis |
| `tidyterra` | Tidy interface for `terra` objects |
| `tmap` | Thematic map visualization |
| `basemaps` | OpenStreetMap basemap tile fetching |
| `osrm` | Interface to OSRM routing API |

### Visualization
| Package | Purpose |
|---------|---------|
| `ggplot2` | Core plotting framework |
| `ggpubr` | Publication-ready plot utilities |
| `ggrepel` | Non-overlapping text labels |
| `ggalt` | Extra coordinate systems and geoms |
| `ggthemes` | Additional themes |
| `MetBrewer` | Color palettes inspired by museum artworks |
| `colorspace` | Color manipulation and palettes |
| `magick` | Image processing and compositing |
| `showtext` | CJK font rendering in plots |

### Data Manipulation
| Package | Purpose |
|---------|---------|
| `dplyr` | Data transformation verbs |
| `data.table` | High-performance data operations |
| `purrr` | Functional programming tools |
| `magrittr` | Pipe operator (`%>%`) |
| `glue` | String interpolation |
| `stringr` | String manipulation |

### Custom
| Package | Purpose |
|---------|---------|
| `risingCoord` | In-repo package for GCJ-02/Baidu/WGS-84 coordinate transformations |

## Style Conventions

- Project color palette: `#E47250`, `#5A4A6F`, `#EBB261`, `#9D5A6C`
- Plots: 300 DPI, 4000x2500px or 16x12 inches
- Figure numbering: `Fig X-Y` (chapter-figure)
- Chinese fonts via `showtext` for CJK text rendering

## Common Tasks

- **Regenerate plots**: Render `main/main_plot.qmd` via Quarto
- **Add a new city**: Follow the pattern in `_coordTrans_sampling.R` and `_getDis.R`, add city boundary shapefile to `data/`
- **Update POI data**: Replace CSV in `data/`, re-run `_coordTrans_sampling.R`

## Output

- **118+ PNG figures** organized as `Fig X-Y` (chapter-figure numbering)
- **Quarto HTML report** rendered from `main_plot.qmd`
- **PowerPoint presentations** for Beijing, Shanghai, and Taipei comparisons

## External Services

- OSRM routing API: `https://routing.openstreetmap.de/` (public, no auth required)
- OSM basemap tiles fetched automatically by `basemaps` package

## Author

**Felix Liu**