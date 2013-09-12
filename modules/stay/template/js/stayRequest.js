var sideinfo_meal;
var sideinfo_goingout;
var sideinfo_dormitory;
var sideinfo_extra_caption;
var sideinfo_seat;

var aicGoingout;
var seatBalloon;
var seatBalloonText;

var beforunloadFunc;
var selectedSeat2;

var autoFormPopup;

window.addEventListener("load", function () {
	sideinfo_meal = document.getElementById("sideinfo-meal");
	sideinfo_goingout = document.getElementById("sideinfo-goingout");
	sideinfo_sleep = document.getElementById("sideinfo-sleep");
	sideinfo_extra_caption = document.getElementById("sideinfo-extra-caption");
	sideinfo_seat = document.getElementById("sideinfo-seat");
	
	aicGoingout = document.getElementById("aic-goingout");
	seatBalloon = document.getElementById("seat-balloon");
	seatBalloonText = document.getElementById("seat-balloon-text");
	
	autoFormPopup = document.getElementById("auto-form-popup");
	
	if (selectedSeat_reqName)
		selectedSeat = document.getElementById("seat-" + selectedSeat_reqName);
	
	enterFrameHandler();
	setInterval(enterFrameHandler, 50);
	
	document.forms.stay_request.onchange = function () {
		window.onbeforeunload = function() {
			return "계속하면 작성중이던 잔류 데이터가 삭제됩니다.";
		}
	}
	
	if (stayType == "update") {
		$("#stay-request-form :input").change(function() {
			var btn = document.getElementById("aside-button-request");
			btn.className = "aside-button-update-abled";
			btn.onclick = submitStayRequestForm;
		});
		$("#stay-request-form :input[type=text]").keyup(function() {
			var btn = document.getElementById("aside-button-request");
			btn.className = "aside-button-update-abled";
			btn.onclick = submitStayRequestForm;
		});
		
		selectedSeat2 = selectedSeat;
		setInterval(function () {
			if (selectedSeat2 != selectedSeat) {
				var btn = document.getElementById("aside-button-request");
				btn.className = "aside-button-update-abled";
				btn.onclick = submitStayRequestForm;
				
				selectedSeat2 = selectedSeat;
			}
		}, 50);
	}
	
	if (stayType != "update" && stayAbled_deadline && autoFormData) {
		openConfirmPopup("설정된 자동외출이 있습니다",
			"<div>선택하신 요일에는 자동외출이 설정되어 있습니다.</div>" +
			"<div>설정하신 내용을 자동으로 입력할까요?</div>",
			"단, 도서관 좌석은 직접 선택해야 합니다.",
			function () {
				var form = document.forms.stay_request;
				var i;
				
				if (!form.apply_goingout.disabled) {
					form.apply_goingout.checked = true;
					
					var goingoutForms = ["goingout_start_hour", "goingout_start_minute", "goingout_end_hour", "goingout_end_minute", "goingout_cause"]
					for (i=0; i<goingoutForms.length; i++) {
						form[goingoutForms[i]].className = form[goingoutForms[i]].className.split(" disabled").join("");
						form[goingoutForms[i]].className = form[goingoutForms[i]].className.split("disabled").join("");
						form[goingoutForms[i]].disabled = false;
					}
					var goingoutStartTime = autoFormData.goingout_start_time.split(":");
					var goingoutEndTime = autoFormData.goingout_end_time.split(":");
					
					form.goingout_start_hour.value = goingoutStartTime[0];
					form.goingout_start_minute.value = goingoutStartTime[1];
					form.goingout_end_hour.value = goingoutEndTime[0];
					form.goingout_end_minute.value = goingoutEndTime[1];
					form.goingout_cause.value = autoFormData.goingout_cause;
				}
				var mealKeywords = ["breakfast", "lunch" ,"dinner", "snack"];
				for (i=0; i<mealKeywords.length; i++) {
					if (!form["apply_" + mealKeywords[i]].disabled && autoFormData.meals.indexOf(mealKeywords[i]) != -1) {
						form["apply_" + mealKeywords[i]].checked = true;
					}
				}
				form.extra_caption.value = autoFormData.extra_caption;
				
				closeConfirmPopup();
			},
			function () { closeConfirmPopup(); }
		);
	}
});


function disabledCheckboxes() {
	var form = document.forms.stay_request;
	
	for (var i=0; i<form.length; i++) {
		if (!form[i].disabled) form[i].disabled = true;
		if (form[i].className.indexOf('disabled') == -1) form[i].className += " disabled";
	}
}

function toggleGoingout(target) {
	if (target.disabled)
		return;
	if (target.checked) {
		var c = document.getElementById("stay-request-goingout-cause");
		var d = document.getElementsByClassName("stay-request-goingout-time");
		for (var i=0; i<d.length; i++) {
			d.item(i).className = "stay-request-goingout-time";
			d.item(i).disabled = false;
		}
		c.className = "";
		c.disabled = false;
	}else {
		var c = document.getElementById("stay-request-goingout-cause");
		var d = document.getElementsByClassName("stay-request-goingout-time");
		for (var i=0; i<d.length; i++) {
			d.item(i).className = "stay-request-goingout-time disabled";
			d.item(i).disabled = true;
		}
		c.className = "disabled";
		c.disabled = true;
	}
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
	if (target.checked) {
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
	}else {
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


function getValueOrQuestionMark(value) {
	if (value)
		return value;
	else
		return "?";
}

function goingoutTextBlurHandler(target) {
	var str = String(target.value);
	if (str.length == 1)
		target.value = "0" + str;
}

function enterFrameHandler() {
	var form = document.forms.stay_request;
	var appliedMeals = [];
	
	if (form.apply_breakfast.checked) appliedMeals.push("조식");
	if (form.apply_lunch.checked) appliedMeals.push("중식");
	if (form.apply_dinner.checked) appliedMeals.push("석식");
	if (form.apply_snack.checked) appliedMeals.push("간식");
	sideinfo_meal.innerHTML = appliedMeals.join(",");
	
	if (Number(form.goingout_start_hour.value) != form.goingout_start_hour.value) form.goingout_start_hour.value = "";
	if (Number(form.goingout_start_minute.value) != form.goingout_start_minute.value) form.goingout_start_minute.value = "";
	if (Number(form.goingout_end_hour.value) != form.goingout_end_hour.value) form.goingout_end_hour.value = "";
	if (Number(form.goingout_end_minute.value) != form.goingout_end_minute.value) form.goingout_end_minute.value = "";
	
	
	if (form.apply_goingout.checked) {
		if (sideinfo_goingout.innerHTML !=  "<div>" + getValueOrQuestionMark(form.goingout_start_hour.value) + ":" + getValueOrQuestionMark(form.goingout_start_minute.value) + "~" + getValueOrQuestionMark(form.goingout_end_hour.value) + ":" + getValueOrQuestionMark(form.goingout_end_minute.value) + "</div>" + "<div>" + form.goingout_cause.value + "</div>") {
			sideinfo_goingout.innerHTML =  "<div>" + getValueOrQuestionMark(form.goingout_start_hour.value) + ":" + getValueOrQuestionMark(form.goingout_start_minute.value) + "~" +
			getValueOrQuestionMark(form.goingout_end_hour.value) + ":" + getValueOrQuestionMark(form.goingout_end_minute.value) + "</div>" +
			"<div>" + form.goingout_cause.value + "</div>";
		}
	}else
		sideinfo_goingout.innerHTML = "미신청";
	
	if (form.apply_goingout.checked && form.goingout_cause.value)
		aicGoingout.style.padding = "34px 8px";
	else
		aicGoingout.style.padding = "";
	
	sideinfo_sleep.innerHTML = (form.apply_sleep.checked) ? "신청" : "미신청";
	sideinfo_extra_caption.innerHTML = (form.extra_caption.value) ? form.extra_caption.value : "없음";
	
	if (!form.disapply_seat.checked && selectedSeat)
		sideinfo_seat.innerHTML = selectedSeat.id.split("-")[1];
	else if (form.disapply_seat.checked)
		sideinfo_seat.innerHTML = "신청 안함";
	else
		sideinfo_seat.innerHTML = "좌석을 선택해 주세요";
}

function submitStayRequestForm() {
	var form = document.forms.stay_request;
	var numberTexts = [form.goingout_start_hour, form.goingout_start_minute, form.goingout_end_hour, form.goingout_end_minute];
	
	if (!stayAbled_deadline) {
		var week = new Array('일', '월', '화', '수', '목', '금', '토');
		var deadlineTempArr = deadline.split(" ");
		var deadlineArr = [deadlineTempArr[0].split("-"), deadlineTempArr[1].split(":")];
		var deadlineObj = new Date(deadlineArr[0][0], deadlineArr[0][1]-1, deadlineArr[0][2], deadlineArr[1][0], deadlineArr[1][1], deadlineArr[1][2]);
		openPopup("잔류 신청이 이미 마감되었습니다",
			"<div>잔류 신청이 마감되어 신청할 수 없습니다.</div>" +
			"<div>담당 교사에게 문의해주세요.</div>",
			"이 잔류 신청은 "+deadlineObj.getFullYear()+"년 "+(deadlineObj.getMonth()+1)+"월 "+deadlineObj.getDate()+"일("+week[deadlineObj.getDay()]+") "+deadlineObj.getHours()+":"+set0(deadlineObj.getMinutes())+"에 마감되었습니다.");
		return;
	}
	
	if (form.apply_goingout.checked) {
		for (var i=0; i<numberTexts.length; i++) {
			if (numberTexts[i].value == '') {
				openPopup("외출 신청이 올바르지 않습니다", "외출 시간을 빠짐없이 입력하세요.", "");
				return;
			}else if (Number(numberTexts[i].value) != numberTexts[i].value) {
				openPopup("외출 신청이 올바르지 않습니다", "외출 시간에는 숫자가 입력되어야 합니다.", "");
				return;
			}else if (i%2 == 0 && (Number(numberTexts[i].value) < 0 || Number(numberTexts[i].value) > 23)){
				openPopup("외출 신청이 올바르지 않습니다", "'시간' 정보에는 0부터 23 사이의 숫자가 입력되어야 합니다.", "");
				return;
			}else if (i%2 == 1 && (Number(numberTexts[i].value) < 0 || Number(numberTexts[i].value) > 59)){
				openPopup("외출 신청이 올바르지 않습니다", "'분' 정보에는 0부터 59 사이의 숫자가 입력되어야 합니다.", "");
				return;
			}
		}
		if (Number(numberTexts[0].value) * 60 + Number(numberTexts[1].value) >= Number(numberTexts[2].value) * 60 + Number(numberTexts[3].value)) {
			openPopup("외출 신청이 올바르지 않습니다", "외출 시작시간은 외출 끝시간보다 늦을 수 없습니다.", "");
			return;
		}else if (form.goingout_cause.value == '') {
			openPopup("외출 신청이 올바르지 않습니다", "외출 사유를 입력해 주십시오.", "");
			return;
		}
	}
	if (!form.disapply_seat.checked && !selectedSeat) {
		openPopup("좌석을 선택하지 않으셨습니다", "도서관 좌석은 반드시 선택해야 합니다. 좌석 선택을 원하지 않으면 '별도의 좌석을 신청하지 않고 잔류를 신청합니다.' 에 체크하세요.", "");
		return;
	}
	if (!form.disapply_seat.checked)
		form.seat_data.value = selectedSeat.id.split("-")[1];
	else
		form.seat_data.value = null;
	
	
	beforunloadFunc = window.onbeforeunload;
	window.onbeforeunload = null;
	
	if (form.goingout_start_hour.value != "" && form.goingout_start_minute.value != "" && form.goingout_end_hour.value != "" && form.goingout_end_minute.value != "") {
		if ((Number(form.goingout_start_hour.value) * 60 + Number(form.goingout_start_minute.value) < Number(outgoingAllowedTime[0]) * 60 + Number(outgoingAllowedTime[1])) || (Number(form.goingout_end_hour.value) * 60 + Number(form.goingout_end_minute.value) > Number(outgoingAllowedTime[2]) * 60 + Number(outgoingAllowedTime[3]))) {
			openConfirmPopup(
				"외출을 신청할 수 없는 시간입니다",
				"신청하신 시간은 외출이 허용된 시간이 아닙니다.<br>그래도 외출을 신청하시겠습니까?",
				"오늘은 " + outgoingAllowedTime[0] + ":" + outgoingAllowedTime[1] + "부터 " + outgoingAllowedTime[2] + ":" + outgoingAllowedTime[3] + "까지 외출이 가능합니다.",
				openPopupAndSubmitStay,
				function () { window.onbeforeunload = beforunloadFunc; closeConfirmPopup(); }
			);
			return;
		}
	}
	openPopupAndSubmitStay();
}

function openPopupAndSubmitStay() {
	var form = document.forms.stay_request;
	
	//form.submit();
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var deadlineTempArr = deadline.split(" ");
	var deadlineArr = [deadlineTempArr[0].split("-"), deadlineTempArr[1].split(":")];
	var deadlineObj = new Date(deadlineArr[0][0], deadlineArr[0][1]-1, deadlineArr[0][2], deadlineArr[1][0], deadlineArr[1][1], deadlineArr[1][2]);
	
	var dateTempArr = deadline.split(" ");
	var dateArr = [dateTempArr[0].split("-"), dateTempArr[1].split(":")];
	var dateObj = new Date(dateArr[0][0], dateArr[0][1]-1, dateArr[0][2], dateArr[1][0], dateArr[1][1], dateArr[1][2]);
	
	openConfirmPopup("정말 잔류를 "+(stayType == "update" ? "수정" : "신청")+"하시겠습니까?",
		"<ul>" + 
		"<li><span>잔류 신청일</span>"+dateObj.getFullYear()+"년 "+(dateObj.getMonth()+1)+"월 "+dateObj.getDate()+"일("+week[dateObj.getDay()]+")</li>" +
		"<li><span>급식 신청</span>"+sideinfo_meal.innerHTML+"</li>" + 
		"<li><span>외출 신청</span>"+((form.apply_goingout.checked) ? form.goingout_start_hour.value + ":" + form.goingout_start_minute.value + "~" + form.goingout_end_hour.value + ":" + form.goingout_end_minute.value + " (" + form.goingout_cause.value + ")" : '미신청') + "</li>" +
		"<li><span>기숙사 숙박 신청</span>"+sideinfo_sleep.innerHTML+"</li>" + 
		"<li><span>기타 특이사항</span>"+sideinfo_extra_caption.innerHTML+"</li>" + 
		"<li><span>좌석 신청</span>"+sideinfo_seat.innerHTML+"</li>" + 
		"</ul>",
		"<div>- 이 잔류 신청은 "+deadlineObj.getFullYear()+"년 "+(deadlineObj.getMonth()+1)+"월 "+deadlineObj.getDate()+"일("+week[deadlineObj.getDay()]+") "+deadlineObj.getHours()+":"+set0(deadlineObj.getMinutes())+"에 마감됩니다.</div>" +
		"<div>- 잔류 신청 마감 전까지 '잔류 신청/수정/취소' 메뉴에서 잔류 내역을 수정하거나 취소할 수 있습니다.</div>",
		function () { for (var i=0; i<form.length; i++) { form[i].disabled = false;}; document.forms.stay_request.submit(); },
		function () { window.onbeforeunload = beforunloadFunc; closeConfirmPopup(); }
	);
}

function cancleStay() {
	if (!stayAbled_deadline) {
		var week = new Array('일', '월', '화', '수', '목', '금', '토');
		var deadlineObj = new Date(deadlineArr[0][0], deadlineArr[0][1]-1, deadlineArr[0][2], deadlineArr[1][0], deadlineArr[1][1], deadlineArr[1][2]);
		openPopup("잔류 신청이 이미 마감되었습니다",
			"<div>잔류 신청이 마감되어 신청할 수 없습니다.</div>" +
			"<div>담당 교사에게 문의해주세요.</div>",
			"이 잔류 신청은 "+deadlineObj.getFullYear()+"년 "+(deadlineObj.getMonth()+1)+"월 "+deadlineObj.getDate()+"일("+week[deadlineObj.getDay()]+") "+deadlineObj.getHours()+":"+set0(deadlineObj.getMinutes())+"에 마감되었습니다.");
		return;
	}
	
	beforunloadFunc = window.onbeforeunload;
	window.onbeforeunload = null;
	
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var deadlineTempArr = deadline.split(" ");
	var deadlineArr = [deadlineTempArr[0].split("-"), deadlineTempArr[1].split(":")];
	var deadlineObj = new Date(deadlineArr[0][0], deadlineArr[0][1]-1, deadlineArr[0][2], deadlineArr[1][0], deadlineArr[1][1], deadlineArr[1][2]);
	
	var dateTempArr = deadline.split(" ");
	var dateArr = [dateTempArr[0].split("-"), dateTempArr[1].split(":")];
	var dateObj = new Date(dateArr[0][0], dateArr[0][1]-1, dateArr[0][2], dateArr[1][0], dateArr[1][1], dateArr[1][2]);
	
	if (continuousDates) {
		openConfirmPopup("연속된 잔류 신청이 있습니다",
			"잔류신청이 연속되어 있습니다.<br>연속된 모든 잔류를 한꺼번에 취소할까요?",
			"이 잔류 신청은 "+deadlineObj.getFullYear()+"년 "+(deadlineObj.getMonth()+1)+"월 "+deadlineObj.getDate()+"일("+week[deadlineObj.getDay()]+") "+(deadlineObj.getHours())+":"+(set0(deadlineObj.getMinutes()))+"에 마감되며, 마감 이전에는 언제든지 다시 신청할 수 있습니다.",
			function () { location.href = cancelStayURL + '&continuous_dates=true&date=' + document.forms.stay_request.date.value + "," + continuousDates.join(","); },
			openGetClosePopup
		);
	}else
		openGetClosePopup();
}

function openGetStartPopup() {
	openPopup("잔류신청 튜토리얼 영상", '<iframe width="640" height="360" src="//www.youtube.com/embed/w3cZBFXTXkw" frameborder="0" allowfullscreen></iframe>', " ", function () { document.getElementById("popup-content").innerHTML = ""; closePopup(); }, {"width":"auto"});
}

function openGetClosePopup(dateObj, deadlineObj, week) {
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var deadlineTempArr = deadline.split(" ");
	var deadlineArr = [deadlineTempArr[0].split("-"), deadlineTempArr[1].split(":")];
	var deadlineObj = new Date(deadlineArr[0][0], deadlineArr[0][1]-1, deadlineArr[0][2], deadlineArr[1][0], deadlineArr[1][1], deadlineArr[1][2]);
	
	var dateTempArr = deadline.split(" ");
	var dateArr = [dateTempArr[0].split("-"), dateTempArr[1].split(":")];
	var dateObj = new Date(dateArr[0][0], dateArr[0][1]-1, dateArr[0][2], dateArr[1][0], dateArr[1][1], dateArr[1][2]);
	var stayDate = new Date(date);
	
	openConfirmPopup("잔류 신청을 취소하시겠습니까?",
		"<div>"+stayDate.getFullYear()+"년 "+(stayDate.getMonth()+1)+"월 "+stayDate.getDate()+"일("+week[stayDate.getDay()]+") 잔류 신청을 취소하시겠습니까?</div>" +
		"<div>취소 후 잔류 재신청은 마감 시간 전까지 가능합니다.</div>",
		"이 잔류 신청은 "+deadlineObj.getFullYear()+"년 "+(deadlineObj.getMonth()+1)+"월 "+deadlineObj.getDate()+"일("+week[deadlineObj.getDay()]+") "+(deadlineObj.getHours())+":"+(set0(deadlineObj.getMinutes()))+"에 마감됩니다.",
		function () { location.href = cancelStayURL + '&date=' + document.forms.stay_request.date.value; },
		function () { window.onbeforeunload = beforunloadFunc; closeConfirmPopup(); }
	);
}

function showAutoFormHelp() {
	autoFormPopup.style.visibility = "visible";
}

function hideAutoFormHelp() {
	autoFormPopup.style.visibility = "hidden";
}

function set0(str, length) {
	str = String(str);
	if (!length) length =  2;
	for (var i=0; i<length - str.length; i++)
		str = "0" + str;
	return str;
}