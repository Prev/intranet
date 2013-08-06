function selectorChecked(sel){
	var inputTitleS = document.getElementsByClassName("input-title-s");
	var inputTitleP = document.getElementsByClassName("input-title-p");
	var inputTitleT = document.getElementsByClassName("input-title-t");
	
	if(sel.value == 's')
	{
		if(inputTitleP.length != 0)
		{
			inputTitleP.item(0).innerHTML = "이름";
			inputTitleP.item(0).className = "input-title-s";
			inputTitleP.item(0).innerHTML = "학번";
			inputTitleP.item(0).className = "input-title-s";
		}
		else
		{
			inputTitleT.item(0).innerHTML = "이름";
			inputTitleT.item(0).className = "input-title-s";
			inputTitleT.item(0).innerHTML = "학번";
			inputTitleT.item(0).className = "input-title-s";
			
			var depart = document.getElementById("input-department-container");
			depart.style.display = "none";
			var num = document.getElementById("input-number-container");
			num.style.display = "inline-block";
		}
	}
	else if(sel.value == 'p')
	{
		if(inputTitleS.length != 0)
		{
			inputTitleS.item(0).innerHTML = "본인 이름";
			inputTitleS.item(0).className = "input-title-p";
			inputTitleS.item(0).innerHTML = "자녀 학번";
			inputTitleS.item(0).className = "input-title-p";	
		}
		else
		{
			inputTitleT.item(0).innerHTML = "본인 이름";
			inputTitleT.item(0).className = "input-title-p";
			inputTitleT.item(0).innerHTML = "자녀 학번";
			inputTitleT.item(0).className = "input-title-p";
			
			var depart = document.getElementById("input-department-container");
			depart.style.display = "none";
			var num = document.getElementById("input-number-container");
			num.style.display = "inline-block";
		}
	}
	else if(sel.value == 't')
	{
		if(inputTitleS.length != 0)
		{
			inputTitleS.item(0).innerHTML = "이름";
			inputTitleS.item(0).className = "input-title-t";
			inputTitleS.item(0).innerHTML = "소속";
			inputTitleS.item(0).className = "input-title-t";	
		}
		else
		{
			inputTitleP.item(0).innerHTML = "이름";
			inputTitleP.item(0).className = "input-title-t";
			inputTitleP.item(0).innerHTML = "소속";
			inputTitleP.item(0).className = "input-title-t";	
		}

		var num = document.getElementById("input-number-container");
		num.style.display = "none";
		var depart = document.getElementById("input-department-container");
		depart.style.display = "inline-block";
	}
}