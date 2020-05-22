# Creating-a-Shiny-App-in-R-for-Investing-Scenarios

## This is workout 2 of 3 I did when completing STAT 133 "Concepts in Computing with Data" at UC Berkeley. Each individual workout had 2 warmups (smaller projects) and 3 labs done preemptively as a build up to the larger workout project. All code is in R.

Workout 02: Shiny App Stat 133, Fall 2019

The purpose of this assignment is to create a shiny app that allows you to visualize — in an interactive way — a couple of simple investing scenarios.

Three Investing Scenarios:

We are going to consider three investing instruments:

•High Yield Savings Account

•U.S. Fixed Income Index Fund (U.S. Bonds)

•U.S. Equity Index Fund (U.S. Stocks)

High Yield Savings Account: A high-yield savings account is a type of savings account that typically pays 20-25 times the national average of a standard savings account. Interest rates as of this writing (Oct 2019) tend to range between 1.8% and 2%. Keep in mind that these rates can change over time (i.e. there’s a little bit of volatility). For simulation purposes, let’s assume the following rate of return and volatility:

•Average annual return: μ = 2%

•Volatility (standard deviation): σ = 0.1%

U.S. Fixed Income Index Fund (U.S. Bonds): This type of funds have a portfolio formed by government-related issues, corporate bonds, agency mortgage-backed pass-throughs, consumer asset-backed securities, and commercial mortgage-backed securities. In general, fixed income instruments offer conservative investors opportunities to obtain current income at a reasonable amount of risk. For simulation purposes, let’s assume the following rate of return and volatility:

•Average annual return: μ = 5%

•Volatility (standard deviation): σ = 4.5%

U.S. Equity Index Fund (U.S. Stocks): These types of funds tend to have a portfolio formed by stocks of American companies across different industries. The most popular funds seek to track the performance of market indices such as S&P 500, Dow Jones, or NASDAQ. For simulation purposes, let’s assume the following rate of return and volatility:

•Average annual return: μ = 10%

•Volatility (standard deviation): σ = 15%
