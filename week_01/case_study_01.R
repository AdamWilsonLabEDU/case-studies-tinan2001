## Install package(s) onto the computer 
#install.packages("tidyverse")

## Activates the package tidyverse or ggplot2 to be used 
library(tidyverse)
## Loads the data set "iris"
data(iris)
## Looks up information about the data set "iris"
?iris
help(iris)
## Creates a variable of the mean of petal lengths from the iris data set
petal_length_mean = mean(iris$Petal.Length)


## creates a histogram for the frequency of petal lengths and xlab and ylab and main relabels
## main, x, y axis

hist(iris$Petal.Length,
     xlab = "Petal Length", ylab = "Frequency", main = "Distribution of Petal Lengths",
     ylim = c(0,40)
)
## inserts a line the mean line as red
abline(v = petal_length_mean, col='red', lwd = 3)

## uses ggplot function instead of hist() to create a histogram graph of petal length
p <- ggplot(iris, aes (x = Petal.Length))+
  ## actually creates the histogram  and makes the outline black and filling the inside blue
  ## then labels the x and y axis
  geom_histogram(color = "black", fill = "blue")+
  geom_vline(aes(xintercept = petal_length_mean), color = "red", linewidth = 1) +
  ##geom_density(color = "green", linewidth = 1)+
  labs (x = "Petal Length", y = "Frequency")

#Summary of the iris data set
summary (iris)
#Summarize using dplyr summerize() function better for data frames
summarize (iris)
#Can also summarize the data set by looking at the structure (how many observations and variables)
str(iris)

ggsave(p, filename = "plot.png")

##plot(iris$Sepal.Length, iris$Sepal.Width)
##plot(Sepal.Length - Sepal.Width, dataframe = iris)

##checks if package is installed, if not will be installed
##require(tidyverse)

