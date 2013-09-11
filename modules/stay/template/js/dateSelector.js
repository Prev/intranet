var timers = {"prev":null, "next":null};
var counts = {"prev":null, "next":null};
var dateContainer;

function slide(type){
	dateContainer = document.getElementById("date-container");
	
	if (type == 'prev'){
		counts.prev=0;
		if (timers.next) { clearInterval(timers.next); timers.next=null };
		if (!timers.prev) timers.prev = setInterval(slide_prev, 20)
	}else{
		counts.next=0;
		if (timers.prev) { clearInterval(timers.prev); timers.prev=null };
		if (!timers.next) timers.next = setInterval(slide_next, 20);
		
	}	
}
function slide_prev(){
	//dateContainer = document.getElementById("date-container");
	//if (!timers.prev) return;
	if (dateContainer.offsetLeft + 10 >= 0) { 
		dateContainer.style.left = 0 + "px";	
		clearInterval(timers.prev);
	}else{
		dateContainer.style.left = (dateContainer.offsetLeft + 10) + "px";
		if (counts.prev++ == 10) { clearInterval(timers.prev); timers.prev=null };
	}
}
function slide_next(){
	//dateContainer = document.getElementById("date-container");
	//console.log('d');
	//console.dir(dateContainer);
	//if (!timers.next) return;
	if ((-1 * dateContainer.offsetLeft) - 10 >= dateContainer.offsetWidth - 690) { 
		dateContainer.style.left = (-1 * (dateContainer.offsetWidth - 690)) + "px";	
		clearInterval(timers.next);
	}else {
		dateContainer.style.left = (dateContainer.offsetLeft - 10) + "px";
		if (counts.next++ == 10) { clearInterval(timers.next); timers.next=null };
	}
}

