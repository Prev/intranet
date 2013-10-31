// JavaScript Documentvar selectedSeat = null;
var seatBalloon;
var seatBalloonText;
var selectedSeat;
var selectedSeatClass;
var clsName;
window.addEventListener("load", function () {
	seatBalloon = document.getElementById("seat-balloon");
	seatBalloonText = document.getElementById("seat-balloon-text");
});
function seatSelectHandler(target){
	if (!date) return;
	if($('#disapply_seat').is(":checked"))
		return;

	if(selectedSeat != null){
		selectedSeat.className = selectedSeatClass;	
		if(selectedSeat == target){
			target.className = selectedSeatClass;
			seatName= isDefaultSeat(selectedSeatClass) ? '' : selectedSeatClass;
			selectedSeatClass = null;
			selectedSeat = null;
			return;
		}
	}
	
	if(target == null) return;
	clsName = target.className;
	selectedSeatClass = target.className;
	selectedSeat = target;
	seatName=getSeatNum(target.id);
	
	if(isDefaultSeat(target.className) && seatName != clickedStudentSeat){
		if(!confirm("선택한 좌석을 강제로 설정하시겠습니까? 해당 좌석을 신청한 기존 학생은 좌석이 미신청 상태로 변경됩니다."))
			return;

		if($("#disapply_seat").is(':checked'))
			$("#disapply_seat").attr("checked", true);
	}
	else if(!isDefaultSeat(target.className))
		$('#disapply_seat').attr("checked", false)

	target.className = "seat_sel-" + getSeatNum(clsName);
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

function isDefaultSeat(target){
	if(target.indexOf("seat_default-"))
		return true;
}
function enableSeat() {
	var ics = document.getElementById("input-cb-seat");
	ics.checked = false;
	toggleSeat(ics);
}

function disabledSeat() {
	var ics = document.getElementById("input-cb-seat");
	ics.checked = true;
	toggleSeat(ics);
}

function toggleSeat(target) {
	if ($(target).is(':checked')) {
		for (var i=1; i<=18; i++) {
			var ss = document.getElementsByClassName("seat_sel-"+i);
			for (var j=0; j<ss.length; j++)
				ss[j].className = 'seat_disabled-'+i;
			
			var ds = document.getElementsByClassName('seat_default-'+i), ds2 = [];
			for (var j=0; j<ds.length; j++)
				ds2.push(ds.item(j));
			for (var j=0; j<ds2.length; j++)	
				ds2[j].className = 'seat_disabled-'+i;

		}
		selectedSeat = null;
	}
	else {
		for (var i=1; i<=18; i++) {
			var ds2 = [];
			var ds = document.getElementsByClassName('seat_disabled-'+i);
			for (var j=0; j<ds.length; j++)
				ds2.push(ds.item(j));
			for (var j=0; j<ds2.length; j++)	
				ds2[j].className = 'seat_default-'+i;
			
		}
	}
}
