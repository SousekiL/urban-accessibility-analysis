# Urban Accessibility Analysis

## Project Overview

**Urban Accessibility Analysis** is an R-based geospatial research project that compares urban accessibility and community structure across major Chinese cities, primarily **Beijing** and **Shanghai**, with extended comparisons to **Tianjin** and **Hangzhou**.

The central research question: Why does Beijing feel like a "bigger city" than Shanghai, and what urban structural factors (street networks, POI distribution, population layout, routing efficiency) explain this?

## Language & Runtime

- **R** (no Python) -- all analysis, data processing, and visualization
- **Quarto** (`.qmd`) for reproducible report generation

## Project Structure

```
.
├── main/                        # All analysis code
│   ├── data_etl.R               # Data loading and preparation
│   ├── data_clean_map.R         # Spatial data cleaning, CRS transforms, basemaps
│   ├── osrm.R                   # OSRM routing examples
│   ├── main_plot.qmd            # Primary visualization document (Quarto)
│   ├── main_plot_canger.qmd     # Alternative plot variant
│   ├── main_plot_icon.qmd       # Icon-annotated variant
│   ├── _coordTrans_sampling.R   # POI coordinate transform + route pair sampling
│   ├── _getDis.R                # OSRM distance/route queries
│   ├── _cityCentre_highway.R    # Road density by distance from center
│   ├── _cityCentre_highway2.R   # Road density variant
│   ├── _cityCentre_population.R # Population distribution by distance from center
│   ├── _data_sampling.R         # Random point sampling
│   ├── _geom_flat_violin.R      # Custom ggplot2 half-violin geometry
│   ├── _icon.R                  # Icon/image processing
│   ├── _showtext.R              # Font setup for CJK text
│   ├── risingCoord/             # Custom R package for coordinate transforms
│   │   └── R/                   # GCJ-02 <-> WGS84, Baidu <-> WGS84
│   ├── city/                    # City-specific sampling scripts
│   └── xkcd/                    # XKCD-style plot utilities
├── ICON/                        # Project branding assets
├── data/                        # Geospatial data (git-ignored, ~735MB)
├── outputs/                     # Generated plots and presentations (git-ignored)
├── CLEANUP_REPORT.md            # Repo cleanup documentation
├── README.md
├── CLAUDE.md
└── .gitignore
```

## Execution Order

1. `data_clean_map.R` -- load shapefiles, apply CRS, create basemaps
2. `_coordTrans_sampling.R` -- process Amap POI CSVs, GCJ02->WGS84, sample 10k route pairs
3. `_getDis.R` -- query OSRM for walking/driving distances
4. `_cityCentre_highway.R` / `_cityCentre_population.R` -- concentric ring metrics
5. `data_etl.R` -- combine all processed data
6. `main_plot.qmd` -- generate all visualizations

## Key R Packages

- **Geospatial**: `sf`, `terra`, `tidyterra`, `tmap`, `basemaps`
- **Routing**: `osrm`
- **Visualization**: `ggplot2`, `ggpubr`, `ggrepel`, `ggalt`, `ggthemes`, `MetBrewer`, `colorspace`
- **Data**: `dplyr`, `data.table`, `purrr`, `magrittr`, `glue`
- **Image/Text**: `magick`, `showtext`, `stringr`
- **Custom**: `risingCoord` (in-repo coordinate transformation package)

## Data Sources

- **Amap (Gaode) POI data** (2022) -- shopping, food, entertainment, life services, sports
- **OpenStreetMap** -- road networks via OSRM routing API (`https://routing.openstreetmap.de/`)
- **Population density grids** -- China population shapefiles
- **City boundaries** -- Beijing Ring Roads, Shanghai Outer Ring, Tianjin, Hangzhou

## Data Files

All `.rds`, `.rda`, `.shp`, `.dbf` files are git-ignored. They must be obtained separately and placed in `data/`. Key processed data files include:
- `bj_amap_poi.rds` / `sh_amap_poi.rds` -- processed POI points
- `bj_amap_dis.rds` / `sh_amap_dis.rds` -- route distance calculations
- `bj_sh_pop_density.rds` -- population by radius
- `bj_sh_highway_density.rds` -- road density by distance

## Style Conventions

- Project color palette: `#E47250`, `#5A4A6F`, `#EBB261`, `#9D5A6C`
- Plots: 300 DPI, 4000x2500px or 16x12 inches
- Figure numbering: `Fig X-Y` (chapter-figure)
- Chinese fonts via `showtext` for CJK text rendering

## Common Tasks

- **Regenerate plots**: Render `main/main_plot.qmd` via Quarto
- **Add a new city**: Follow the pattern in `_coordTrans_sampling.R` and `_getDis.R`, add city boundary shapefile to `data/`
- **Update POI data**: Replace CSV in `data/`, re-run `_coordTrans_sampling.R`

## External Services

- OSRM routing API: `https://routing.openstreetmap.de/` (public, no auth required)
- OSM basemap tiles fetched automatically by `basemaps` package
