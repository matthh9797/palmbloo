import numpy as np
import pandas as pd
import altair as alt

from plots import plot_arrivals

## Parameters

### Data
DATAREPO = "../repository/"
DATAREPO_OWD = "ourworldindata/"
PLOTREPO = "../../site/static/plots/"

## Read
arrivals = pd.read_csv(f"{DATAREPO}{DATAREPO_OWD}international-tourist-arrivals.csv")

## Plot 1 - International Tourist Arrivals in South East Asia (excl. China)
country_codes = ["JPN", "IDN", "VNM", "IND", "MYS", "THA"]
countries = ["Thailand", "Japan", "Malaysia", "India", "Vietnam", "Indonesia"]
range_ = ["#0487D9","#97BF04","#F2913D","#8C6C5A","#04AAB8","#F2622E","#BF9595","#4F7302","#0388A6","#6C7D8C","#D98452"]

chart1 = plot_arrivals(arrivals, "2019", country_codes, countries, range_)
chart1.save(f'{PLOTREPO}chart.json')