# First time checking data and getting familiar with them

library(readxl)
df = read_excel("Sherry Lehmann Crosswalk Page to Catalog.xlsx")

ocrdata = readRDS("FullBoxes.rds")

# class(ocrdata) # list
# length(ocrdata) # 100

# jpgnames = names(ocrdata)
# prefix = 'UCD_Lehmann_'
# suffix = '.jpg'

source("utils.R") # plotting method for this dataset

# # choose one file to check
# testdata = ocrdata[1][[1]]
#
# # set a threshold to ignore the extremely unimportant objects
# newplot(testdata[testdata$confidence > 90,]) # from utils.R
#

# let us check all files
main = function(){
    for(i in 1:length(jpgnames)){
    	print(i)
    	systemstring = sprintf("open %s%s", 'sample/', jpgnames[i])
    	system(systemstring)
    	newplot(ocrdata[i], confidence = 90)
    }
}
# quick command to open all jpeg files from R interactive mode
# system('open sample/*jpg')

# calculate the height and width of objects 
lapply(ocrdata, 
  function(x){
    x$height = x$top - x$bottom
    x$width = x$right - x$left
  }
)

# check if text contains certain words or letters
# grep("\\$", ocrdata[1][[1]])

# One example
data0208 = ocrdata$UCD_Lehmann_0208.jpg

# newplot(data0208)
wordplot(data0208)
showpdf(0208)
