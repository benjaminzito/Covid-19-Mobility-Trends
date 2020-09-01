# filtering for Maryland counties
Maryland <- data %>%
  filter(`sub-region` == 'Maryland',
         geo_type == 'county')

# subsetting columns I need
View(colnames(Maryland))
Maryland <- Maryland[,-c(1,4:6)] 

#pivoting from wide to long
Md_transposed <- Maryland %>%
  pivot_longer(cols = c(`2020-01-13`:`2020-08-29`), names_to = "date", values_to = "index")

# using str_replace and gsub to remove unwanted text
Md_transposed$date <- str_replace_all(Md_transposed$date, "2020-", "")
Md_transposed$region <- gsub(pattern = " County", replacement = "", Md_transposed$region)

#plotting
library(ggthemes)

# same relative y-axis
windows()
Md_transposed %>%
  ggplot(aes(x = date, y = index))+
  geom_line(group = 1)+
  xlab("Date")+
  ylab("Index")+
  labs(title = "Rate of Request for Driving Directions in Apple Maps",
       subtitle = "Throughout the Maryland Counties",
       caption = "Data Source: Apple.com")+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5),  
        legend.title = element_blank())+
  labs(fill = FALSE)+
  facet_wrap(~region, scales = "free_x")+
  scale_x_discrete(breaks = c("01-13", "03-13", "05-13", "07-13"))

# "free" y-axis
windows()
Md_transposed %>%
  ggplot(aes(x = date, y = index))+
  geom_line(group = 1)+
  xlab("Date")+
  ylab("Index")+
  labs(title = "Rate of Request for Driving Directions in Apple Maps",
       subtitle = "Throughout the Maryland Counties",
       caption = "Data Source: Apple.com")+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5),  
        legend.title = element_blank())+
  labs(fill = FALSE)+
  facet_wrap(~region, scales = "free")+
  scale_x_discrete(breaks = c("01-13", "03-13", "05-13", "07-13"))

