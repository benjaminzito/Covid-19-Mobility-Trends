# link to the data
"https://www.apple.com/covid19/mobility"

# creating a copy
data <- applemobilitytrends_2020_08_29

# selecting where region = US. I also wanted to demonstrate sqldf.
library(sqldf)

UnitedStates <- sqldf(
  "Select *
 From data
 Where region = 'United States'
 "
)

#subsetting the columns I need.

UnitedStates <- UnitedStates[,-c(1,2,4,5,6)]

library(tidyverse)

#pivoting from wide to long
US_Transposed <- UnitedStates %>%
  pivot_longer(cols = c(`2020-01-13`:`2020-08-29`), names_to = "date", values_to = "index")

#removing some text from the new "date" column
US_Transposed$date <- str_replace_all(US_Transposed$date, "2020-", "")

# plotting

US_Transposed %>%
  ggplot(aes(x = date, y = index, group = transportation_type))+
  geom_line(aes(color = transportation_type))+
  scale_x_discrete(breaks = c("01-13", "02-13", "03-13", "04-13", "05-13", "06-13", "07-13", "08-13"))+
  scale_color_discrete(breaks = c("driving", "transit", "walking"), labels = c("Driving", "Transit", "Walking"))+
  xlab("Date")+
  ylab("Index")+
  labs(title = "Rate of Request for Directions in Apple Maps",
       subtitle = "Throughout the United States",
       caption = "Data Source: Apple.com")+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5),  
        legend.position = "bottom", legend.title = element_blank())
