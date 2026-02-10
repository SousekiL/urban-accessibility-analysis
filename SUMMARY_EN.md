## Accessibility and Street Network Differences between Beijing and Shanghai: Project Summary

This project uses AMap (Gaode) POI data, gridded population data, and OpenStreetMap (OSM) road networks to systematically compare **urban scale, distribution of commercial and daily-life facilities, population patterns, detour index, and street network density** in the main urban areas of Beijing and Shanghai. The goal is to provide a data-driven explanation for why everyday trips in Beijing often feel **farther, more circuitous, and less convenient** than in Shanghai.

- **Data and Study Area**
  - **Spatial extent**: The comparable “main urban area” is defined as the area within Beijing’s 5th Ring Road and Shanghai’s Outer Ring Road, with additional concentric buffers from the city center to the suburbs for radial analysis.
  - **Data sources**: AMap POIs (shopping, restaurants, leisure, daily services, sports & fitness, etc.), gridded population data, OSM highways and urban streets, and route calculations (by car and on foot) based on the road network plus great-circle (straight-line) distances.
  - **Key indicators**: POI density per km², population density and rank curves, **detour index** (actual route distance / straight-line distance), and road network density (km/km²).

- **Main Findings**
  - **Beijing’s “city is larger”, but accessible facilities per unit area are fewer**  
    The built-up area of Beijing’s main urban region is significantly larger than that of Shanghai. Within the 5th Ring (Beijing) and the Outer Ring (Shanghai), both the **total count and density per km²** of entertainment and daily-life POIs are clearly lower in Beijing. Public transport POIs (bus stops and metro stations) are also less dense, meaning that within a comparable travel radius, residents in Beijing can reach **fewer** destinations.
  - **Population is more spatially dispersed, and is partially mismatched with commercial resources**  
    Population grids show that high-population cells in Beijing are spread across a broader area. When we sort grid cells by population or commercial density, Beijing’s tail of high-density cells is longer, while commercial density does not increase at the same pace. This leads to a **spatial mismatch between where people live and where commercial resources concentrate**.
  - **Detour index is systematically higher: similar straight-line distances translate into longer actual routes in Beijing**  
    For both short walking trips (0–3 km) and longer driving trips (>10 km), Beijing’s detour index is consistently a few percentage points higher than Shanghai across distance groups. In practice, this means that for two origins and destinations that “look similarly far” on the map, the actual route in Beijing tends to be **longer and more circuitous**.
  - **Overall street network density and core-area “fine-grainedness” are lower in Beijing**  
    Within the same areal extent, Beijing’s total road length and road density are lower than Shanghai’s. The radial road-density curve from city center to suburbs shows that Beijing starts from a lower density in the core and decreases more gently, while Shanghai builds a more **fine-grained, dense mesh** in its core area, which shortens paths and improves accessibility.  
    When Tianjin and Hangzhou are added for comparison, Beijing’s road density within the central 5 km radius still remains on the lower side.

- **Overall Conclusion**
  - At the same “main urban area” scale, the combination of **a larger urban footprint, more dispersed population, sparser commercial and public transport facilities, and slightly lower road density** makes everyday trips in Beijing more likely to feel long, indirect, and poorly served.
  - Shanghai, by contrast, benefits from a more compact urban form, higher POI and transit-stop densities, and a denser core street network, providing **better accessibility and service coverage** for similar travel distances.

---

## Selected Figures

> Below are several representative figures that illustrate the key findings. Image paths refer to outputs rendered under `main/plot/canger`.

- **Figure 1: Comparable main urban areas of Beijing and Shanghai**

  Using the 5th Ring (Beijing) and the Outer Ring (Shanghai) to define comparable main urban areas highlights striking differences in **spatial scale and shape** between the two cities.

  ![Fig 1. Extent of main urban areas (Beijing 5th Ring, Shanghai Outer Ring)](main/plot/canger/Fig 1.png)

- **Figure 2: Spatial distribution of commercial and daily-life POIs**

  Commercial, restaurant, leisure and daily-service POIs form more continuous, dense “bright belts” in Shanghai, while within Beijing’s 5th Ring the same facilities are **less dense and more patchy**, with visible gaps.

  ![Fig 2-1. Major commercial POIs in the main urban areas](main/plot/canger/Fig 2-1.png)

- **Figure 3: Population grids and high-population areas**

  Population grids show that high-population cells in Beijing spread over a larger area, rather than concentrating in a few compact cores as in Shanghai. This pattern underpins later analyses of **population–commercial mismatches**.

  ![Fig 3-1. Population density in the main urban areas](main/plot/canger/Fig 3-1.png)

- **Figure 4: Population-weighted OD samples and routes**

  By sampling a large number of origin–destination pairs based on population weights and computing routes on the road network, we visualize typical everyday trip patterns in both cities, which form the empirical basis for detour index and network density analysis.

  ![Fig 4-1. Population-weighted sample origins/destinations and routes](main/plot/canger/Fig 4-1.png)

- **Figure 5: Road network density from city center to suburbs**

  Radial road-density curves demonstrate that Shanghai maintains higher road density in core buffers, with a different decay pattern compared with Beijing. This structural difference aligns closely with the observed **differences in detour index**.

  ![Fig 5-1. Comparison of road network density in Beijing and Shanghai](main/plot/canger/Fig 5-1.png)

