
<!-- README.md is generated from README.Rmd. Please edit that file -->
Tree GenViz
===========

Todo

-   variable branch peice length \[✓\]
-   Make work with data instead of Gen \[\]
-   Save direction as variable \[✓\]

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
#> # A tibble: 105 x 6
#>     x_from    x_to y_from  y_to group  angle
#>      <dbl>   <dbl>  <dbl> <dbl> <int>  <dbl>
#>  1  0      -0.326    1.00  1.95     1  0.332
#>  2 -0.326  -0.841    1.95  2.80     1  0.209
#>  3 -0.841  -1.08     2.80  3.77     1 -0.297
#>  4 -1.08   -1.10     3.77  4.77     1 -0.227
#>  5 -1.10   -0.808    4.77  5.73     1 -0.314
#>  6 -0.808  -0.338    5.73  6.61     1 -0.192
#>  7 -0.338  -0.0962   6.61  7.58     1  0.244
#>  8 -0.0962  0.358    7.58  8.47     1 -0.227
#>  9  0.358   1.04     8.47  9.20     1 -0.279
#> 10  1.04    1.84     9.20  9.81     1 -0.175
#> # ... with 95 more rows
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

``` r
treeViz(1, angle_fun, length_fun) %>%
  mutate(turn_col = angle > 0) %>%
  ggplot(aes(x = x_from, xend = x_to,
             y = y_from, yend = y_to, 
             group = group, color = turn_col)) +
  geom_curve(curvature = 0) +
  coord_fixed() +
  theme_void() +
  guides(color = "none")
```

![](README_files/figure-markdown_github/unnamed-chunk-6-1.png)

Whole tree

``` r
treeViz(25, angle_fun, length_fun) %>%
    mutate(turn_col = angle > 0) %>%
  ggplot(aes(x = x_from, xend = x_to,
             y = y_from, yend = y_to, 
             group = group, color = turn_col)) +
  geom_curve(curvature = 0, alpha = 0.4) +
  coord_fixed() +
  theme_void() +
  guides(color = "none")
```

![](README_files/figure-markdown_github/unnamed-chunk-7-1.png)

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

![](README_files/figure-markdown_github/unnamed-chunk-8-1.png)

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

![](README_files/figure-markdown_github/unnamed-chunk-9-1.png)
