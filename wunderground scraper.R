library(lubridate)
library(rvest)

# function
# get_weather parameters
# desired_date = date in string format for July 4, 2019 use "7/4/2019" 
# city = city in the USA in string format
# state = state in the USA in string format

get_weather <- function(desired_date,city,state)
{
  # parse date into parts
  date_parsed <- mdy(desired_date)
  month <- month(date_parsed)
  day   <- day(date_parsed)
  year  <- year(date_parsed)
  
  # combine month, day, and year into a single string
  date <- paste0(year,"-",month,"-",day)

  options(stringsAsFactors = FALSE)

  # create wunderground url
  url <- paste0("https://www.wunderground.com/history/daily/us/",state,"/",city,"/date/",date)
  ## change Phantom.js scrape file
  lines <- readLines("scrape.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape.js")
  
  print("This is the URL:")
  print(url)
  
  ## Download website using phantomjs
  system("phantomjs scrape.js")
  
  ## read downloaded website
  pg <- read_html("1.html",base_url="https://www.wunderground.com")
  
  #css selector from browser inspector tools
  avg_temp <- html_nodes(pg,'.summary-table > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(3) > td:nth-child(2)') %>% html_text()
  
  # can also be used to get temperate at times of day which returns a list of temperatures
  #prec = as.numeric(unlist(strsplit(rank_data_html, split=" ")))

  return(avg_temp)
  
}

# test the function

# create a list of dates from July 1, 2018 to July 31, 2018
dates <- format(seq(as.Date("2018-07-01"), as.Date("2018-07-31"), by="days"), format="%m/%d/%Y")
dates <- strsplit(dates, " ")

# create empty dataframe to hold date and average temp
df <- data.frame(date=character(),
                 avg_temp=character(), 
                 stringsAsFactors=FALSE) 

# loop through list of dates and insert date and corresponding average temperature into dataframe df
for (day in dates)
{
  avg_temp = get_weather(day,"Miami","FL")
  df[nrow(df) + 1,] = list(day,avg_temp)    
}


