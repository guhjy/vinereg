% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.vinereg.R
\name{predict.vinereg}
\alias{predict.vinereg}
\alias{fitted.vinereg}
\title{Predict conditional mean and quantiles from a D-vine regression model}
\usage{
\method{predict}{vinereg}(object, newdata, alpha = 0.5, uscale = FALSE,
  ...)

\method{fitted}{vinereg}(object, alpha = 0.5, ...)
}
\arguments{
\item{object}{an object of class \code{vinereg}.}

\item{newdata}{matrix of covariate values for which to predict the quantile.}

\item{alpha}{vector of quantile levels; \code{NA} predicts the mean based on an
average of the \code{1:10 / 11}-quantiles.}

\item{uscale}{if \code{TRUE} input (newdata) and output is on copula scale.}

\item{...}{unused.}
}
\value{
A data.frame of quantiles where each column corresponds to one
value of \code{alpha}.
}
\description{
Predict conditional mean and quantiles from a D-vine regression model
}
\examples{
# simulate data
x <- matrix(rnorm(200), 100, 2)
y <- x \%*\% c(1, -2)
dat <- data.frame(y = y, x = x, z = as.factor(rbinom(100, 2, 0.5)))

# fit vine regression model
(fit <- vinereg(y ~ ., dat))

# inspect model
summary(fit)
plot_effects(fit)

# model predictions
mu_hat  <- predict(fit, newdata = dat, alpha = NA)          # mean
med_hat <- predict(fit, newdata = dat, alpha = 0.5)         # median

# observed vs predicted
plot(cbind(y, mu_hat))

## fixed variable order (no selection)
(fit <- vinereg(y ~ ., dat, order = c("x.2", "x.1", "z.1")))

}
\seealso{
\code{\link{vinereg}}
}
