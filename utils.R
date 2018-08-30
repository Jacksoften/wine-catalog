showpdf = function(num){
	# num is the last four digits of the name of files
	inputstring = sprintf("UCD_Lehmann_%04s.jpg", num)
	commandstring = sprintf('open sample/%s', inputstring)
	system(commandstring)
}

newplot = function(x, resetplot=TRUE, color='black', confidence = 0) {
  
	# if(!is.matrix(x)) stop("Input is not a matrix")
	# if(dim(x)[1] == 0) stop("Input is empty")

	# coords = sapply(x, range)
    # plot(c(min(coords[,2:4]), max(coords[,2:4])),
	#      c(min(coords[,1:3]), max(coords[,1:3])), type = 'n')
    if(is.data.frame(x[[1]])) x = x[[3]]
    
	if(!is.na(match('text', names(x)) && confidence > 0))
	   x = x[x$confidence > confidence, ]

	if(ncol(x) != 4) x = x[,1:4]

	if(resetplot) plot(c(0,5000), c(0,6000), type='n')

	for(i in 1:nrow(x)){
		rect(x[i,1],6000-x[i,2],x[i,3],6000-x[i,4], border=color)
	}
}

library(ggplot2)
wordplot = function(x, confidence=0, size = 3){

	# this function uses ggplot2 package to build a plot which
	# displays grasped words from the picture
	if(!is.data.frame(x)) stop("Input is not a data frame")

	plt = ggplot(x) + geom_text(aes(x = (left + right) / 2,
									y = 6000 - (top + bottom) / 2,
									label = text), size = size)
	plt
}

