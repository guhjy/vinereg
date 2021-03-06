context("cpit()")

# simulate data
set.seed(3)
x <- matrix(rnorm(60), 20, 3)
y <- x %*% c(1, -1, 2)
dat <- data.frame(y = y, x = x, z = as.factor(rbinom(20, 3, 0.5)))
fit <- vinereg(y ~ ., family = "gauss", dat)

test_that("catches missing variables", {
    fit <- vinereg(y ~ ., dat[1:3])
    expect_error(cpit(fit, dat[1:2]))
})

test_that("catches incorrect type", {
    fit <- vinereg(y ~ ., dat[1:2])
    dat[2] <- ordered(1:20)
    expect_error(cpit(fit, dat[1:2]))
})

test_that("catches incorrect levels", {
    fit <- vinereg(y ~ ., dat)
    levels(dat[[5]]) <- 1:50
    expect_error(cpit(fit, dat))
})

test_that("works in bivariate case", {
    fit <- vinereg(y ~ ., dat[1:2])
    expect_silent(cpit(fit, dat[1:2]))
})

test_that("works with continuous response", {
    # simulate more data for test to work appropriately
    x <- matrix(rnorm(600), 200, 3)
    y <- x %*% c(1, -1, 2)
    dat <- data.frame(y = y, x = x, z = as.factor(rbinom(200, 3, 0.5)))
    fit <- vinereg(y ~ ., dat, selcrit = "loglik")
    expect_gt(ks.test(cpit(fit, dat), "punif")$p, 0.01)
})

test_that("works with discrete response", {
    dat$y <- as.ordered(dat$y)
    fit <- vinereg(y ~ ., dat, fam = "tll")
    expect_silent(cpit(fit, dat))
})

fit <- vinereg(y ~ ., dat[-5])
u <- vinereg:::get_pits(fit$margins, 1)
fit_uscale <- vinereg(y ~ ., as.data.frame(u), uscale = TRUE)

test_that("works on uscale", {
    expect_silent(cpit(fit, u, uscale = TRUE))
})
