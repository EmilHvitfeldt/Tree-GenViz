one_branch <- function(n, angle_degree, group_number = 1) {
  data <- tibble(x_from = 0, x_to = 0,
                 y_from = 0, y_to = 1,
                 group = group_number)
  
  for(i in 2:(n + 1)) {
    x_2 <- cos(angle_degree[i - 1]) * (data[i - 1, ]$x_to-data[i - 1, ]$x_from) - 
      sin(angle_degree[i - 1]) * (data[i - 1, ]$y_to-data[i - 1,   ]$y_from)
    y_2 <- sin(angle_degree[i - 1]) * (data[i - 1, ]$x_to-data[i - 1, ]$x_from) + 
      cos(angle_degree[i - 1]) * (data[i - 1, ]$y_to-data[i - 1,   ]$y_from)
    data <- data %>%
      add_case(x_from = round(data[i - 1, ]$x_to, 6),
               y_from = round(data[i - 1, ]$y_to, 6),
               x_to = round(data[i - 1, ]$x_to + x_2, 6),
               y_to = round(data[i - 1, ]$y_to + y_2, 6),
               group = group_number)
  }
  data[-1, ]
}

treeViz <- function(n_branches, angle_fun, length_fun) {
  map2_dfr(1:n_branches, length_fun(n = n_branches),
           ~ one_branch(.y, 
                        angle_fun(n = .y),
                        .x)
  )
}