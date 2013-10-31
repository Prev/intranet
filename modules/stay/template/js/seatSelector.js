var selectedSeat = null;
function seatSelectHandler(target){
	if (!date) return;
	
	var clsName = target.className;
	target.className = "seat_sel-" + getSeatNum(clsName);
	
	if (target == selectedSeat) {
		target.className = "seat_default-" + getSeatNum(clsName);
		selectedSeat = null;
		return;
	}
	
	if (selectedSeat != null){
		clsName = selectedSeat.className;
		selectedSeat.className = "seat_default-" + getSeatNum(clsName);		
	}
	selectedSeat = target;
	enableSeat();
}

function seatOverHandler(target, studentNumberAndName) {
	if (!date) return;
	if (!seatBalloon || !seatBalloonText) return;
	
	seatBalloon.style.display = "block";
	if (target.offsetLeft) {
		seatBalloonText.innerHTML = studentNumberAndName;
		seatBalloon.style.left = (target.offsetLeft - (seatBalloon.offsetWidth - target.offsetWidth) / 2) + "px";
		seatBalloon.style.top = (target.offsetTop - seatBalloon.offsetHeight - 5) + "px";
	}
}

function seatOutHandler(target) {
	seatBalloon.style.display = "none";
}

function getSeatNum(seat){
	var tmp = seat.split('-');
	return tmp[tmp.length - 1];
}