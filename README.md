
<!-- README.md is generated from README.Rmd. Please edit that file -->
Tree GenViz
===========

Todo

-   variable branch peice length \[✓\]
-   Make work with data instead of Gen \[\]
-   Save direction as variable \[\]

Packages
========

``` r
library(tidyverse)
#> ── Attaching packages ──────────────────
#> ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
#> ✔ tibble  1.4.2          ✔ dplyr   0.7.4.9000
#> ✔ tidyr   0.8.0          ✔ stringr 1.2.0     
#> ✔ readr   1.1.1          ✔ forcats 0.2.0
#> ── Conflicts ── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(ehlib)
```

Loading custom functions
========================

``` r
sapply(paste0("R/", list.files("R/")), source, .GlobalEnv)
#>         R/viz_functions.R
#> value   ?                
#> visible FALSE
```

``` r
angle_fun <- function(n, min_angle = 10, max_angle = 20) {
  sign <- sample(c(-1, 1), size = n, replace = TRUE) / 360 * 2 * pi
  size <- sample(min_angle:max_angle, size = n, replace = TRUE)
  sign * size
}
length_fun <- function(n) rpois(n = n, lambda = 20)

twig_fun <- function(n) ehlib::rztpois(n = n, lambda = 2)
```

Example
-------

``` r
treeViz(5, angle_fun, length_fun)
#> # A tibble: 119 x 5
#>     x_from    x_to y_from  y_to group
#>      <dbl>   <dbl>  <dbl> <dbl> <int>
#>  1  0       0.174    1.00  1.98     1
#>  2  0.174   0.0345   1.98  2.98     1
#>  3  0.0345 -0.275    2.98  3.93     1
#>  4 -0.275  -0.257    3.93  4.93     1
#>  5 -0.257  -0.482    4.93  5.90     1
#>  6 -0.482  -0.447    5.90  6.90     1
#>  7 -0.447  -0.706    6.90  7.87     1
#>  8 -0.706  -1.16     7.87  8.76     1
#>  9 -1.16   -1.44     8.76  9.72     1
#> 10 -1.44   -1.38     9.72 10.7      1
#> # ... with 109 more rows
```

Try of single branch

``` r
treeViz(1, angle_fun, length_fun) %>%
  ggplot(aes(x = x_from, xend = x_to,
             y = y_from, yend = y_to, 
             group = group)) +
  geom_curve(curvature = 0) +
  coord_fixed() +
  theme_void()
```

![](README_files/figure-markdown_github/unnamed-chunk-5-1.png)

Whole tree

``` r
treeViz(25, angle_fun, length_fun) %>%
  ggplot(aes(x = x_from, xend = x_to,
             y = y_from, yend = y_to, 
             group = group, color = group)) +
  geom_curve(curvature = 0, alpha = 0.4) +
  coord_fixed() +
  theme_void() +
  guides(color = "none")
```

![](README_files/figure-markdown_github/unnamed-chunk-6-1.png)

``` r
angle_fun <- function(n, min_angle = 20, max_angle = 40) {
  sign <- sample(c(-1, 1), size = n, replace = TRUE) / 360 * 2 * pi
  size <- sample(min_angle:max_angle, size = n, replace = TRUE)
  sign * size
}
length_fun <- function(n) rpois(n = n, lambda = 20)

twig_fun <- function(n) ehlib::rztpois(n = n, lambda = 1)

treeViz(25, angle_fun, length_fun, twig_fun) %>%
  ggplot(aes(x = x_from, xend = x_to,
             y = y_from, yend = y_to, 
             group = group, color = group)) +
  geom_curve(curvature = 0, alpha = 0.4) +
  coord_fixed() +
  theme_void() +
  guides(color = "none")
```

![](README_files/figure-markdown_github/unnamed-chunk-7-1.png)
