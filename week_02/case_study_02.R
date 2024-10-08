library(tidyverse)

# dataurl = "https://data.giss.nasa.gov/tmp/gistemp/STATIONS_v4/tmp_USW00014733_14_0_1/station.txt"
# httr::GET(dataurl)
# websitedata = read_csv(dataurl, 
#               na="999.90", # tell R that 999.90 means missing in this dataset
#              skip=1, # we will use our own column names as below so we'll skip the first row
#              col_names = c("YEAR","JAN","FEB","MAR", # define column names
#                            "APR","MAY","JUN","JUL",
#                            "AUG","SEP","OCT","NOV",
#                            "DEC","DJF","MAM","JJA",
#                            "SON","metANN"))

## create a dataset from station.csv file, skipping 999.90, and skipping the first row. Creating 18 variables
FullTempReport = read_csv("station.csv", 
                          na = "999.90",
                          skip = 1,
                          col_names = c("YEAR","JAN","FEB","MAR", #define column names 
                                        "APR","MAY","JUN","JUL",  
                                        "AUG","SEP","OCT","NOV",  
                                        "DEC","DJF","MAM","JJA",  
                                        "SON","metANN"))

## create a new data set with only YEAR and summer months 
JJATempReport = FullTempReport[, c(1,16)]

#create a plot with year on x axis and summer months on y axis
#alpha is the transparency of the confidence interval
#color = alpha() sets the transparency of the red regression line
#labs has all the title labels
ggplot(JJATempReport, aes (x = YEAR, y = JJA))+
  geom_line(size = .6)+
  geom_smooth(alpha = .5 , color = alpha ("red",.5))+
  labs (title = 'MEAN SUMMER TEMPERATURES IN BUFFALO, NY',
        x = 'YEAR', y = 'MEAN SUMMER TEMPERATURE (C)',
        subtitle = 'Summer includes June, July, and August\nData from the Global Historical Climate Network\nRed line is a LOESS smooth',
        caption = 'Case Study 2')+
  theme(plot.caption = element_text(face = "italic"))

ggsave('Mean Summer Temp in Buff, NY.png', plot = last_plot(), scale = 1, width = 5.42, height = 4.00, limitsize = TRUE, dpi = 400)

