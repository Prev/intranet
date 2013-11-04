var next, prev, null_next, null_prev, popup;
var allergy_info;
var division;

window.onload = function() {
	next       = document.getElementById("next");
	prev       = document.getElementById("prev");
	null_next  = document.getElementById("null-next");
	null_prev  = document.getElementById("null-prev");
	next_txt   = document.getElementById("next-txt");
	prev_txt   = document.getElementById("prev-txt");
	null_ntxt   = document.getElementById("null-ntxt");
	null_ptxt   = document.getElementById("null-ptxt");

	popup        = document.getElementById("allergy-popup");
	allergy_mark = document.getElementById("allergy-mark");
	allergy_info = document.getElementById("allergy-info");
	stars        = document.getElementsByClassName("stars");
	
	division     = document.getElementById("division");
	day_food     = document.getElementsByClassName("day-food");
	nutrition    = document.getElementsByClassName("nutrition-table");
	origin       = document.getElementsByClassName( "origin-table" );
	inf_detail   = document.getElementById("inf-detail");
	inf_menu     = document.getElementsByClassName("inf-menu");
	week         = document.getElementsByClassName("week");

	m_event      = document.getElementsByClassName("m-event");
	m_eventfood  = document.getElementsByClassName("m-eventfood");

	allergy_mark.addEventListener("mouseover", function() { popup.style.display = "block"; });
	allergy_mark.addEventListener("mouseout", function() { popup.style.display = "none"; });

	if(next) {
		next.addEventListener("mouseover", function() { next_txt.style.visibility = "visible" });
		next.addEventListener("mouseout" , function() { next_txt.style.visibility = "hidden"; });
	}
	if(null_next) {
		null_next.addEventListener("mouseover", function() { next_txt.style.visibility = "visible" });
		null_next.addEventListener("mouseout" , function() { next_txt.style.visibility = "hidden"; });
	}

	if(prev) {
		prev.addEventListener("mouseover", function() { prev_txt.style.visibility = "visible" });
		prev.addEventListener("mouseout" , function() { prev_txt.style.visibility = "hidden"; });
	}
	if (null_prev) {
		null_prev.addEventListener("mouseover", function() { prev_txt.style.visibility = "visible"; null_ptxt.style.visibility = "visible" });
		null_prev.addEventListener("mouseout" , function() { prev_txt.style.visibility = "hidden"; null_ptxt.style.visibility = "hidden" });
	}

	if (null_next) {
		null_next.addEventListener("mouseover", function() { next_txt.style.visibility = "visible"; null_ntxt.style.visibility = "visible" });
		null_next.addEventListener("mouseout" , function() { next_txt.style.visibility = "hidden"; null_ntxt.style.visibility = "hidden" });
	}

	allergy_info.addEventListener("click", allergy);

	inf_detail.addEventListener("click", infDetailChangeHandler);

	for (var i = 0; i < m_event.length; i++) {
		m_event.item(i).addEventListener( "mouseover", function (event) {
			var m = event.target || event.srcElement;
			for (var j = 0; j < m_event.length; j++) {
				if (m_event[j] == m) {
					m_eventfood[j].style.display = "block";
				}
			};
		});
		
		m_eventfood.item(i).addEventListener("mouseover",  function (event) {
			var m = event.target || event.srcElement;
			m.style.display = "block";
		});
		m_eventfood.item(i).addEventListener("mouseout", function (event) {
			var m = event.target || event.srcElement;
			m.style.display = "none";
		});
	};
}

function infDetailChangeHandler() {
	console.log( inf_detail.checked );
	if (inf_detail.checked == true) {
	
		division.colSpan = 2;

		for(var j=0; j<4; j++) {
			day_food.item(j).rowSpan = 3;
			day_food.item(j).style.width = "71px";
			inf_menu.item(j).style.display = "table-cell";
			origin.item(j).style.display = "table-row";
			nutrition.item(j).style.display = "table-row";
		}
	}

	else {
		
		division.colSpan = 1;

		for(var k=0; k<4; k++) {
			day_food.item(k).rowSpan = 1;
			day_food.item(j).style.width = "140px";
			inf_menu.item(k).style.display = "none";
			origin.item(k).style.display = "none";
			nutrition.item(k).style.display = "none";
		}
	}
}

function allergy() {
	if(stars.item(0) == null) {}

	else if (allergy_info.checked == true) {
		for(var j=0; j<stars.length; j++) {
			stars.item(j).style.display = "inline";
		}
	}

	else if(allergy_info.checked == false) {
		for(var k=0; k<stars.length; k++) {
			stars.item(k).style.display = "none";
		}
	}
}