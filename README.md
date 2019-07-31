# Weather-Scraper
Get the average temperature for a specific day and city.


## Requirements
1. Install https://phantomjs.org/ in your R working directory.
2. Place javascript file in R working directory.

## How it works
1. R runs the PhantomJS using a script written in Javascript.
2. PhantomJS downloads the weather webpage and stores the html file in the R working directory.
3. R then reads the html file and uses CSS selectors to get the specific value in the html.

## Use Case
This script and looped to get multiple days of a city. This can then be joined with another dataset for further analysis. 
