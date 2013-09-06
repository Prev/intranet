var typeSelector, typeBoxes, typeBoxTexts, boxIntervals, overedBox;
var BOXES_WIDTH = [{min:120, max:240}, {min:170, max:280}, {min:120, max:240}];

window.addEventListener("load", function () {
	typeBoxes = [], typeBoxTexts = [], boxIntervals = [];
	
	typeSelector = document.getElementById("type-selector");
	
	typeBoxes[0] = document.getElementById("type-box1");
	typeBoxes[1] = document.getElementById("type-box2");
	typeBoxes[2] = document.getElementById("type-box3");
	
	typeBoxTexts[0] = document.getElementById("type-box-text1");
	typeBoxTexts[1] = document.getElementById("type-box-text2");
	typeBoxTexts[2] = document.getElementById("type-box-text3");
	
	typeBoxes[0].addEventListener("mouseover", function () { typeBoxOverHandler(typeBoxes[0]); });
	typeBoxes[1].addEventListener("mouseover", function () { typeBoxOverHandler(typeBoxes[1]); });
	typeBoxes[2].addEventListener("mouseover", function () { typeBoxOverHandler(typeBoxes[2]); });
	
	typeBoxes[0].addEventListener("mouseout", function () { typeBoxOutHandler(typeBoxes[0]); });
	typeBoxes[1].addEventListener("mouseout", function () { typeBoxOutHandler(typeBoxes[1]); });
	typeBoxes[2].addEventListener("mouseout", function () { typeBoxOutHandler(typeBoxes[2]); });
});


function typeBoxOverHandler(target) {
	var boxIndex = typeBoxes.indexOf(target);
	clearInterval(boxIntervals[boxIndex]);
	boxIntervals[boxIndex] = setInterval(function () { boxIntervalHandler('increase', target) }, 20);
}

function typeBoxOutHandler(target) {
	var boxIndex = typeBoxes.indexOf(target);
	clearInterval(boxIntervals[boxIndex]);
	boxIntervals[boxIndex] = setInterval(function () { boxIntervalHandler('decrease', target) }, 20);
}

function boxIntervalHandler(type, target) {
	var boxIndex = typeBoxes.indexOf(target);
	var goalValue, alpha;
	
	switch (type) {
		case "increase" :
			goalValue = BOXES_WIDTH[boxIndex].max;
			break;
		
		case "decrease" :
			goalValue = BOXES_WIDTH[boxIndex].min;
			break;
		
		default :
			return;
			break;
	}
	
	target.style.width = ((target.offsetWidth - 20) + ((goalValue - (target.offsetWidth - 20)) * 0.1)) + "px";
	
	alpha = (target.offsetWidth - 20 - BOXES_WIDTH[boxIndex].min) / (BOXES_WIDTH[boxIndex].max - (target.offsetWidth - 20)) * 1.1 - 0.3;
	typeBoxTexts[boxIndex].style.opacity = alpha;
	typeBoxTexts[boxIndex].style.filter = "alpha(opacity="+parseInt(alpha*100)+")";
	
	var totalWidth = 0;
	for (var i=0; i<typeBoxes.length; i++)
		totalWidth += typeBoxes[i].offsetWidth;
	typeSelector.style.width = totalWidth + 10 + "px";
	
	if (similar(goalValue, (target.offsetWidth - 20), 3)) {
		target.style.width = goalValue + "px";
		
		if (type == "increase") alpha = 1;
		else if (type == "decrease") alpha = 0;
		
		typeBoxTexts[boxIndex].style.opacity = alpha;
			typeBoxTexts[boxIndex].style.filter = "alpha(opacity="+parseInt(alpha*100)+")";
		clearInterval(boxIntervals[boxIndex]);
	}
}

function similar(data1, data2, errorLimit) {
	if (data1 + errorLimit >= data2 && data1 - errorLimit <= data2) {
		return true
	}else if (data2 + errorLimit >= data1 && data2 - errorLimit <= data1) {
		return true
	}else {
		return false
	}
}