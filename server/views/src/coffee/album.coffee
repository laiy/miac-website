window.onload = ->
    pictures = $(".pic");
    timer = (a, b)->
    	timeA = getYear(a)
    	timeB = getYear(b)
    	return timeA > timeB
    getYear = (picture)->
    	return $(picture).find(".time")[0].innerHTML.split('/')[0]
    pictures.sort timer
    years = []
    domYears = []
    index = 0
    counter = 0
    for picture in pictures
    	year = getYear picture
    	if !(year in years)
    		years.push year
    		newyear = domYears[index++] = $("<div class='year'></div>")
    		$("<header></heder>").html(year).appendTo newyear
    		newyear.append $("<div class='row'></div>")
    		counter = 0
    	Rows = domYears[index - 1].find(".row")
    	lastRow = Rows[Rows.length - 1]
    	$(lastRow).append picture
    	++counter
    	if counter == 3
    		counter = 0
    		domYears[index - 1].append("<div class='row'></div>")
    for domYear in domYears
        domYear.appendTo $('#content')
