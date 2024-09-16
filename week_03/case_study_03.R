#Case Study 3
## Wealth over time


# install.packages ('tidyverse')
# install.packages ('gapminder')
# install.packages('here')
# install.packages ('ggpubr')
library(tidyverse)
library(gapminder)
library(here)
library (ggpubr)

data <- gapminder

## GDPperCap vs Life Expectancy 
data_noK <- data %>%
  filter (country != "Kuwait" )

GDPvLife <- (

ggplot(data_noK, aes(x= lifeExp, y = gdpPercap, color = continent, fill = pop, size = pop/100000))+
geom_point()+
facet_wrap(~year,nrow = 1)+
scale_y_continuous(trans = "sqrt")+
scale_x_continuous(limits = c(0,100), breaks = seq ( 0, 100, 20))+
theme_bw()+
theme(axis.text=element_text(size=8), panel.spacing = unit(1, "lines"))+
labs (x = "Life Expectancy", y = "GDP Per Capita",
      color = "Continent", size = "Population (100k)")+
guides (fill = "none")

)

ggsave(filename = here ("week_03", "GDP v LifeExp.png"), plot = last_plot(), width = 18, height = 5)

##GDPperCap vs Year

gapminder_continent <- data_noK %>%
  group_by(continent, year)
  
gapminder_weighted <- gapminder_continent %>%
    summarize(gdpweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))

GDPvYear <- (
  ggplot ()+
#----------------- 
  geom_line(data = gapminder_continent,
            aes(year, gdpPercap, colour = continent, group= country))+
  geom_point(data = gapminder_continent,
             aes(year,gdpPercap, colour = continent,size = pop/100000, fill = pop))+
#-----------------
  geom_line(data = gapminder_weighted,
            aes (year,gdpweighted, group = continent))+
  geom_point(data = gapminder_weighted,
             aes(year,gdpweighted, size = pop/100000, fill = pop))+
  #-----------------
  facet_wrap(~continent,nrow = 1)+
  
  theme_bw()+
  theme(axis.text = element_text(size = 8), panel.spacing = unit(1, "lines"))+
  labs(x = "Year", y = "GDP per Capita", size = "Population (100k)", colour = "Continent")+
  guides (fill = "none")
)

  ggsave(filename = here ("week_03","GDP vs Year.png"), plot = last_plot(), width = 17, height = 5)

#Both graphs
  ggarrange(GDPvLife, GDPvYear, ncol= 1, nrow= 2)
  ggsave (filename = here ("week_03", "GPD vs Year and GDP vs Life Exp.png"), plot = last_plot(), width = 25, height = 10)

        