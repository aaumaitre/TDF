---
  title: "TDF"
author: "Ari"
output: 
  flexdashboard::flex_dashboard:
  orientation: rows
social: menu
source_code: embed
runtime: shiny
---
  
  ```{r global, include=FALSE}
# load data in 'global' chunk so it can be shared by all users of the dashboard
library(biclust)
tdf_winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-07/tdf_winners.csv')
```

Inputs {.sidebar}
-----------------------------------------------------------------------
  
  ```{r}
selectInput("clusterNum", label = h3("Cluster number"), 
            choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5), 
            selected = 1)
```

Microarray data matrix for 80 experiments with Saccharomyces Cerevisiae
organism extracted from R's `biclust` package.

Sebastian Kaiser, Rodrigo Santamaria, Tatsiana Khamiakova, Martin Sill, Roberto
Theron, Luis Quintales, Friedrich Leisch and Ewoud De Troyer. (2015). biclust:
BiCluster Algorithms. R package version 1.2.0.
http://CRAN.R-project.org/package=biclust

Row
-----------------------------------------------------------------------

### Heatmap

```{r}

num <- reactive(as.integer(input$clusterNum))

col = colorRampPalette(c("red", "white", "darkblue"), space="Lab")(10)
renderPlot({
p = par(mai=c(0,0,0,0))
heatmapBC(BicatYeast, res, number=num(), xlab="", ylab="",
order=TRUE, useRaster=TRUE, col=col)
par(p)
})
```


Row {.tabset}
-----------------------------------------------------------------------

### Parallel Coordinates

```{r}
renderPlot(
parallelCoordinates(BicatYeast, res, number=num())
)
```

### Data for Selected Cluster

```{r}
# only display table for values in cluster 4
renderTable(
BicatYeast[which(res@RowxNumber[, num()]), which(res@NumberxCol[num(), ])]
)
```
