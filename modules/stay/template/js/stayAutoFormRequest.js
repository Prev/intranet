function checkSubmit() {
	var form = document.forms.main_form;
	var dayForms = $("#main_form input[name='day[]']");
	var dayChecked = false;
	
	for (var i=0; i<dayForms.length; i++) {
		if (dayForms[i].checked) {
			dayChecked = true;
			break;
		}
	}
	
	if (!dayChecked) {
		alert("요일를 선택하세요");
		return false;
	}
	
	var essentialForms = ["title", "goingout_start_hour", "goingout_start_minute", "goingout_end_hour", "goingout_end_minute", "goingout_cause"];
	for (i=0; i<essentialForms.length; i++) {
		if (!form[essentialForms[i]].value) {
			alert("양식을 모두 입력하세요");
			return false;
		}
	}
	
	var numberTexts = [form.goingout_start_hour, form.goingout_start_minute, form.goingout_end_hour, form.goingout_end_minute];
	for (i=0; i<numberTexts.length; i++) {
		if (numberTexts[i].value == '') {
			alert("외출 신청이 올바르지 않습니다", "외출 시간을 빠짐없이 입력하세요.", "");
			return false;
		}else if (Number(numberTexts[i].value) != numberTexts[i].value) {
			alert("외출 신청이 올바르지 않습니다", "외출 시간에는 숫자가 입력되어야 합니다.", "");
			return false;
		}else if (i%2 == 0 && (Number(numberTexts[i].value) < 0 || Number(numberTexts[i].value) > 23)){
			alert("외출 신청이 올바르지 않습니다", "'시간' 정보에는 0부터 23 사이의 숫자가 입력되어야 합니다.", "");
			return false;
		}else if (i%2 == 1 && (Number(numberTexts[i].value) < 0 || Number(numberTexts[i].value) > 59)){
			alert("외출 신청이 올바르지 않습니다", "'분' 정보에는 0부터 59 사이의 숫자가 입력되어야 합니다.", "");
			return false;
		}
	}
	
	form.submit();
}