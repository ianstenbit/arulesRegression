\name{bCBA.regression}
\alias{bCBA.regression}
\alias{bcba.regression}
\title{Regression Based on Association Rules}
\description{
  Build a regression model using a transaction boosting classification by association algorithm.
  The algorithm is currently in development, and is not yet formally documented.
}
\usage{
bCBA.regressor(formula, data, support = 0.2,
    confidence = 0.8, gamma = 0.05, cost = 10.0,
    num_levels = 20, verbose=FALSE, parameter = NULL,
    control = NULL, sort.parameter=NULL, lhs.support=TRUE)
}

\arguments{
  \item{formula}{A symbolic description of the model to be fitted. Has to be of form \code{class ~ .}. The class is the variable name (part of the item label before \code{=}).}
  \item{data}{A data.frame containing the training data.}
  \item{support, confidence}{Minimum support and confidence for creating association rules.}
  \item{gamma, cost}{Hyperparameters for the bCBA algorithm.}
  \item{num_levels}{The number of levels into which the target will be quantized for classification.}
  \item{verbose}{Optional logical flag to allow verbose execution, where additional intermediary execution information is printed at runtime.}
  \item{parameter, control}{Optional parameter and control lists for apriori.}
  \item{sort.parameter}{Ordered vector of arules interest measures (as characters) which are used to sort rules in preprocessing.}
  \item{lhs.support}{Logical variable, which, when set to default value of True, indicates that LHS support should be used for rule mining.}
}
\details{
  Uses the bCBA algorithm from arulesCBA to build a transaction-boosted classifier with weighted rules for predicting the target variable. The weighted rules are used in regression by calculating the weighted sum of the means of the class values for the rules which match the new item.
}
\value{
  Returns an object of class \code{CBA} representing the trained classifier
  with fields:
  \item{rules}{the classifier rule base.}
  \item{default}{deault class label.}
  \item{levels}{levels of the class variable.}
  \item{means}{the means of each discretized bucket of the target variable.}
}

\author{Ian Johnson}
\seealso{
\code{\link[arulesCBA]{predict.CBA}},
\code{\link[arulesCBA]{bCBA}},
\code{\link[arules]{apriori}},
\code{\link[arules]{rules}},
\code{\link[arules]{transactions}}.
}
\examples{
  library(arulesCBA)

  data(iris)
  irisDisc <- as.data.frame(lapply(iris[2:4], function(x) discretize(x, categories=9)))
  irisDisc$Sepal.Length <- iris$Sepal.Length
  irisDisc$Species <- iris$Species

  regressor <- bCBA.regression(Sepal.Length ~ ., irisDisc, support = .01)
result <- predict(regressor, irisDisc)

  #Mean squared error
  sum((result - iris$Sepal.Length)^2) / length(result)
  summary(result)
  summary(iris$Sepal.Length)
}
