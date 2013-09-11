var checkBoxes = { "grade1":[], "grade2":[], "grade3":[], "extra":[] };

var seatBalloon;
var seatBalloonText;

window.addEventListener("load", function () {
	for (var i=1; i<=3; i++) {
		for (var j=1; j<=6; j++)
			checkBoxes["grade"+i][j] = document.getElementById("cb-" + i + "-" + j);
		checkBoxes["grade"+i]["all"] = document.getElementById("cb-" + i + "-all");
	}
	
	seatBalloon = document.getElementById("seat-balloon");
	seatBalloonText = document.getElementById("seat-balloon-text");
});
function cbh_a(target, grade) {
	for (var i=1; i<=6; i++)
		checkBoxes["grade"+grade][i].checked = target.checked;
}
function cbh_c(target, grade) {
	if (!target.checked) {
		checkBoxes["grade"+grade]["all"].checked = false;
	}
}

function getSeResult() {
	var form = document.forms.se_option;
	var formValues = [];
	for (var i=0; i<form.length; i++) {
		if (form[i].checked && form[i].name.indexOf('all') != 2)
			formValues.push( form[i].name );
	}
	$.get(seResultURL + '&date='+date+'&options='+formValues.join(","), function(data) {
		document.getElementById("main-content-se-result-dds").innerHTML = data;
	});
}

function openSeatPopup() {
	openPopup("도서관 좌석 현황 조회", null, "");
}

function saveToXlsFile() {
	var form = document.forms.se_option;
	var formValues = [];
	for (var i=0; i<form.length; i++) {
		if (form[i].checked && form[i].name.indexOf('all') != 2)
			formValues.push( form[i].name );
	}
	window.open(exportExcelStayDataURL + '&date='+date+'&options='+formValues.join(","));
}

function seatOverHandler_inquiry(target, studentNumberAndName) {
	if (!date) return;
	if (!seatBalloon || !seatBalloonText) return;
	
	var popupBoxContent = document.getElementById("popup-content");
	
	seatBalloon.style.display = "block";
	if (target.offsetLeft) {
		seatBalloonText.innerHTML = studentNumberAndName;
		seatBalloon.style.left = (target.offsetLeft - (seatBalloon.offsetWidth - target.offsetWidth) / 2) + "px";
		seatBalloon.style.top = (target.offsetTop - seatBalloon.offsetHeight - 5 - popupBoxContent.scrollTop) + "px";
	}
}