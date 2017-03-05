bCBA.regression <- function(formula, data, support = 0.1, confidence = 0.8, gamma = 0.02, cost = 1, num_levels = 20,
                           verbose=FALSE, parameter = NULL, control = NULL, sort.parameter = NULL, lhs.support=TRUE){

  formula <- as.formula(formula)
  class <- as.character(formula[[2]])

  data <- as.data.frame(data)

  mean <- mean(data[[class]])
  data[[class]] <- discretize(data[[class]], categories = num_levels)

  clf <- bCBA(formula, data, support=support, confidence=confidence, gamma=gamma, cost=cost,
              verbose=verbose, parameter=parameter, control=control, sort.parameter=sort.parameter, lhs.support=lhs.support)
  clf$means <- unlist(lapply(strsplit(levels(data[[clf$class]]), ','), function(x) (as.numeric(substr(x[1], 2, nchar(x[1]))) +  as.numeric(substr(x[2], 1, nchar(x[2]) - 1))) /2 ))
  clf$mean <- mean
  clf$method <- "weightedmean"
  return(clf)

}
