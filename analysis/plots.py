import numpy as np
import pandas as pd
import altair as alt


def plot_arrivals(data, year_to, country_codes, countries, range_):

    source = data.loc[(np.isin(data.Code, country_codes)) & (data.Year <= year_to)]

    # Create a selection that chooses the nearest point & selects based on x-value
    highlight = alt.selection(type='single', on='mouseover',
                            fields=['Entity'], nearest=True)

    base = alt.Chart(source, width="container").encode(
            alt.X('Year', type='ordinal', title=""),
            alt.Y('International tourism, number of arrivals', type='quantitative'),
            alt.Color('Entity', scale=alt.Scale(domain=countries, range=range_), sort=countries, legend=alt.Legend(title=""))  
    )

    points = base.mark_circle().encode(
        opacity=alt.value(0)
    ).add_selection(
        highlight
    ).properties(
        width=600
    )

    scatter = base.mark_point().encode(
        tooltip = ["Entity", "Code", "Year", alt.Tooltip("International tourism, number of arrivals", format=",.0f")]
    )

    lines = base.mark_line().encode(
        size=alt.condition(~highlight, alt.value(1), alt.value(3))
    )

    # Draw a rule at the location of the selection
    # Put the five layers into a chart and bind the data
    chart = alt.layer(
        points, lines, scatter
    ).properties(
        width="container",    
        title={
        "text": ["International Tourist Arrivals in South East Asia (excl. China)"], 
        "subtitle": ["Thailand has seen increasing numbers of tourists since 1995 and has ", 
                    "become the second biggest tourist hub in SEA surpassed only by China"],
        "color": "black",
        "subtitleColor": "gray"
        }
    ).configure(autosize="fit-x")

    return chart