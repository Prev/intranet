$(document).ready(function() {
	var className = $(this).attr('class');
	$('.stay-manage-deadline-time input[type=text], .stay-manage-goingout-time').keyup(function(){
		$(this).val($(this).val().replace(/[^0-9\.]/,''));
		if($(this).attr('class') == 'stay-manage-deadline-time-hour'){
			if($('.stay-manage-deadline-time-hour').val() > 23)
				$('.stay-manage-deadline-time-hour').val(23);
		}else if($(this).attr('class') == 'stay-manage-deadline-time-min'){
			if($('.stay-manage-deadline-time-min').val() > 59)
				$('.stay-manage-deadline-time-min').val(59);
		}else if($(this).attr('name') == 'goingout_start_time_hour'){
			if($(this).val() > 23)
				$(this).val(23);
		}else if($(this).attr('name') == 'goingout_start_time_min'){
			if($(this).val() > 59)
				$(this).val(59);
		}else if($(this).attr('name') == 'goingout_end_time_hour'){
			if($(this).val() > 23)
				$(this).val(23);
		}else if($(this).attr('name') == 'goingout_end_time_min'){
			if($(this).val() > 59)
				$(this).val(59);
		}
	});

	$('.stay-manage-goingout-time').attr('disabled', 'disabled');
	$('.stay-manage-goingout-time').addClass('disabled');
	
	$('input[name=allow_goingout]').change(function()
	{
		if(document.stay_manage_data.allow_goingout.checked)
        {
            $('.stay-manage-goingout-time').removeAttr('disabled');
            $('.stay-manage-goingout-time').removeClass('disabled');
        }
        else
        {
        	$('.stay-manage-goingout-time').val('');
        	$('.stay-manage-goingout-time').attr('disabled', 'disabled');
        	$('.stay-manage-goingout-time').addClass('disabled');
        }
	});
	
	$('input[name=popup_notice_check]').change(function()
	{
		if(document.stay_manage_data.popup_notice_check.checked)
        {
	        $('textarea[name=popup_notice_text]').removeAttr('disabled');
	        $('textarea[name=popup_notice_text]').removeClass('disabled');
	    }
        else
        {
        	$('textarea[name=popup_notice_text]').val('');
        	$('textarea[name=popup_notice_text]').attr('disabled', 'disabled');
        	$('textarea[name=popup_notice_text]').addClass('disabled');
        }
	});
	
	if(page == 2){
		$("#stay-manage *").on("keydown change", function(){
			$("#stay-manage-btn-save-changes").attr("disabled",false).attr("class","stay-manage-btn-save-changes-able");
		});
	}

	autoFormPopup = document.getElementById("auto-form-popup");
});
function showAutoFormHelp() {
	autoFormPopup.style.visibility = "visible";
}

function hideAutoFormHelp() {
	autoFormPopup.style.visibility = "hidden";
}

function registerStayInfo(){
	var form = document.stay_manage_data;
	
	if(form.stay_deadlines_grade1.value == '' && form.stay_deadlines_grade2.value == '' && form.stay_deadlines_grade3.value == ''){
		openPopup("잔류 마감일이 설정되지 않았습니다.", "모든 학년의 잔류 마감일이 설정되지 않았습니다.<br />" +
		"적어도 한 학년은 잔류 마감일을 설정하여야 합니다.");
		return;			
	}
	
	var stayDate = new Date(form.date.value)
	    , deadlineGrade1 = new Date(form.stay_deadlines_grade1.value)
	    , deadlineGrade2 = new Date(form.stay_deadlines_grade2.value)
	    , deadlineGrade3 = new Date(form.stay_deadlines_grade3.value);
	
	if(isNaN(stayDate.getTime()) || (isNaN(deadlineGrade1.getTime()) && isNaN(deadlineGrade2.getTime()) && isNaN(deadlineGrade3.getTime()))){
		openPopup("잔류 마감일의 형식에 오류가 있습니다", "잔류 마감일의 형식에 오류가 있습니다.<br />" +
		"잔류 마감일을 다시 한번 확인 해 주세요.");
		return;
	}
	
	if(form.stay_title.value == ''){
		openPopup("잔류 제목이 설정되지 않았습니다.", "잔류 제목을 입력하지 않으셨습니다.<br />" +
		"잔류 제목을 입력해 주세요.");
		return;
	}else if(form.stay_title.value.length > 8){
		openPopup("잔류 제목이 너무 깁니다.", "입력하신 잔류 제목은 너무 깁니다.<br />" +
		"잔류 제목은 4~5자가 적당하며, 최대 8자까지 입력할 수 있습니다.");
		return;
	}
		
	openConfirmPopup("잔류 일정을 등록 하시겠습니까?",
	  "<ul>" + 
	  "<li><span>잔류명</span>"+(form.stay_title.value ? form.stay_title.value : '제목없음')+"</li>" +
	  "<li><span>잔류일</span>"+stayDate.getFullYear() + "년 " + " " + (stayDate.getMonth() + 1) + "월 " + (stayDate.getDate()) + "일(" + dayLists[stayDate.getDay()] + ")</li>" +
	  "<li><span>잔류 마감일</span>" + 
	  (isNaN(deadlineGrade1.getTime()) ? '' : "1학년 "+deadlineGrade1.getFullYear() + "년 " + " " + (deadlineGrade1.getMonth() + 1) + "월 " + (deadlineGrade1.getDate()) + "일(" + dayLists[deadlineGrade1.getDay()] + ") " + form.stay_deadlines_time1_hour.value + "시 " + form.stay_deadlines_time1_min.value + "분<br /><span></span>") +
	  (isNaN(deadlineGrade2.getTime()) ? '' : "2학년 "+deadlineGrade2.getFullYear() + "년 " + " " + (deadlineGrade2.getMonth() + 1) + "월 " + (deadlineGrade2.getDate()) + "일(" + dayLists[deadlineGrade2.getDay()] + ") " + form.stay_deadlines_time2_hour.value + "시 " + form.stay_deadlines_time2_min.value + "분<br /><span></span>") + 
	  (isNaN(deadlineGrade3.getTime()) ? '' : "3학년 "+deadlineGrade3.getFullYear() + "년 " + " " + (deadlineGrade3.getMonth() + 1) + "월 " + (deadlineGrade3.getDate()) + "일(" + dayLists[deadlineGrade3.getDay()] + ") " + " " + form.stay_deadlines_time3_hour.value + "시 " + form.stay_deadlines_time3_min.value + "분</li>") + 
	  "<li><span>급신 신청</span>조식 "+ form.allowlevel_breakfast[form.allowlevel_breakfast.selectedIndex].text +", 중식 "+ form.allowlevel_lunch[form.allowlevel_lunch.selectedIndex].text + ", 석식" + form.allowlevel_dinner[form.allowlevel_dinner.selectedIndex].text + ", 간식 "+ form.allowlevel_snack[form.allowlevel_snack.selectedIndex].text + "</li>" +
	  "<li><span>외출 신청</span>"+ (form.allow_goingout.checked ? ("허용, 외출 시간 " + form.goingout_start_time_hour.value + ":" + form.goingout_start_time_min.value + "~" + form.goingout_end_time_hour.value + ":" + form.goingout_end_time_min.value + "으로 제한") : "불가") +"</li>" +
	  "<li><span>기숙사 숙박 신청</span>"+ (form.allow_sleep.checked ?  "허용" : "불가") +"</li>" +
	  "<li><span>팝업 공지</span>"+ (form.popup_notice_check.checked ?  "예" : "아니오") +"</li>" +
	  "<li><span>임시 마감</span>"+ (form.temp_disabled.checked ?  "예" : "아니오") +"</li>" +
	  "</ul>",
	  "<div>등록된 잔류 일정은 ‘잔류 관리’ 메뉴에서 수정할 수 있습니다.</div>",
	  function () { document.forms.stay_manage_data.submit(); },
	  function () { closeConfirmPopup(); return false; }
	);
}

function deleteStayInfo(){
	var tmp = new Date(date);
	
	openConfirmPopup("잔류 일정을 삭제 하시겠습니까?",
		tmp.getFullYear() + "년 " + (tmp.getMonth() + 1) +"월 " + tmp.getDate() +"일(" + dayLists[tmp.getDay()] + ") 잔류 일정을 정말 삭제하시겠습니까?<br />" +
		"잔류 일정을 삭제하면 데이터를 다시 복구할 수 없습니다.","",
		function () { location.href=deleteStayInfoURL + '&date=' + date },
		function () { closeConfirmPopup(); return false; }
	);	
}
function updateStayInfo(){
	var form = document.stay_manage_data;

	if(form.stay_title.value == ''){
		openPopup("잔류 제목이 설정되지 않았습니다.", "잔류 제목을 입력하지 않으셨습니다.<br />" +
		"잔류 제목을 입력해 주세요.");
		return;
	}else if(form.stay_title.value.length > 8){
		openPopup("잔류 제목이 너무 깁니다.", "입력하신 잔류 제목은 너무 깁니다.<br />" +
		"잔류 제목은 4~5자가 적당하며, 최대 8자까지 입력할 수 있습니다.");
		return;
	}
	
	if(form.stay_deadlines_grade1.value == '' && form.stay_deadlines_grade2.value == '' && form.stay_deadlines_grade3.value == ''){
		openPopup("잔류 마감일이 설정되지 않았습니다.", "모든 학년의 잔류 마감일이 설정되지 않았습니다.<br />" +
		"적어도 한 학년은 잔류 마감일을 설정하여야 합니다.");
		return;			
	}
	
	if(form.stay_deadlines_grade1.value == '' && form.stay_deadlines_grade2.value == '' && form.stay_deadlines_grade3.value == ''){
		openPopup("잔류 마감일이 설정되지 않았습니다.", "모든 학년의 잔류 마감일이 설정되지 않았습니다.<br />" +
		"적어도 한 학년은 잔류 마감일을 설정하여야 합니다.");
		return;			
	}
	if(form.temp_disabled.checked){
		openConfirmPopup("잔류 신청을 임시 마감하시겠습니까?",
			"<div>‘잔류 신청을 임시 마감합니다’에 체크가 되어 있습니다.<br />" +
			"정말 잔류 신청을 임시로 마감하시겠습니까?</div>",
			"<div>임시 마감 해제는 가장 늦은 잔류 마감일 전까지 가능합니다.</div>",
			function () {updateStayInfoPopup(); return;},
			function () {closeConfirmPopup(); return;}
		);			
	}else
		updateStayInfoPopup();	
	
}
function updateStayInfoPopup(){
	var form = document.stay_manage_data;
	var stayDate;
	var deadlineGrade1,deadlineGrade2,deadlineGrade3;
	stayDate = new Date(form.date.value);
	deadlineGrade1 = new Date(form.stay_deadlines_grade1.value);
	deadlineGrade2 = new Date(form.stay_deadlines_grade2.value);
	deadlineGrade3 = new Date(form.stay_deadlines_grade3.value);
	
	openConfirmPopup("잔류 일정을 수정 하시겠습니까?",
	  "<ul>" + 
	  "<li><span>잔류명</span>"+(form.stay_title.value ? form.stay_title.value : '제목없음')+"</li>" +
	  "<li><span>잔류일</span>"+stayDate.getFullYear() + "년 " + " " + (stayDate.getMonth() + 1) + "월 " + (stayDate.getDate()) + "일(" + dayLists[stayDate.getDay()] + ") "+"</li>" +
	  "<li><span>잔류 마감일</span>" +
	  (isNaN(deadlineGrade1.getTime()) ? '' : "1학년 "+deadlineGrade1.getFullYear() + "년 " + " " + (deadlineGrade1.getMonth() + 1) + "월 " + (deadlineGrade1.getDate()) + "일(" + dayLists[deadlineGrade1.getDay()] + ") " + form.stay_deadlines_time1_hour.value + "시 " + form.stay_deadlines_time1_min.value + "분<br /><span></span>") +
	  (isNaN(deadlineGrade2.getTime()) ? '' : "2학년 "+deadlineGrade2.getFullYear() + "년 " + " " + (deadlineGrade2.getMonth() + 1) + "월 " + (deadlineGrade2.getDate()) + "일(" + dayLists[deadlineGrade2.getDay()] + ") " + form.stay_deadlines_time2_hour.value + "시 " + form.stay_deadlines_time2_min.value + "분<br /><span></span>") + 
	  (isNaN(deadlineGrade3.getTime()) ? '' : "3학년 "+deadlineGrade3.getFullYear() + "년 " + " " + (deadlineGrade3.getMonth() + 1) + "월 " + (deadlineGrade3.getDate()) + "일(" + dayLists[deadlineGrade3.getDay()] + ") " + " " + form.stay_deadlines_time3_hour.value + "시 " + form.stay_deadlines_time3_min.value + "분</li>") + 
	  "<li><span>외출 신청</span>"+ (form.allow_goingout.checked ? ("허용, 외출 시간 " + form.goingout_start_time_hour.value + ":" + form.goingout_start_time_min.value + "~" + form.goingout_end_time_hour.value + ":" + form.goingout_end_time_min.value + "으로 제한") : "불가") +"</li>" +
	  "<li><span>기숙사 숙박 신청</span>"+ (form.allow_sleep.checked ?  "허용" : "불가") +"</li>" +
	  "</ul>",
	  "<div>등록된 잔류 일정은 ‘잔류 관리’ 메뉴에서 수정할 수 있습니다.</div>",
	  function () { document.forms.stay_manage_data.submit(); },
	  function () { closeConfirmPopup(); return false; }
	);
}

function closeStayInfo(){
	var form = document.stay_manage_data;

	deadlineGrade1 = new Date(form.stay_deadlines_grade1.value);
	deadlineGrade2 = new Date(form.stay_deadlines_grade2.value);
	deadlineGrade3 = new Date(form.stay_deadlines_grade3.value);

	openConfirmPopup("정말 잔류 신청을 즉시 마감 하시겠습니까?",
		"<ul>" + 
		"<li><span>잔류명</span>"+(form.stay_title.value ? form.stay_title.value : '제목없음')+"</li>" +
		"<li><span>잔류일</span>"+form.date.value+"</li>" +
		"<li><span>잔류 마감일</span>"+
		(isNaN(deadlineGrade1.getTime()) ? '' : "1학년 "+deadlineGrade1.getFullYear() + "년 " + " " + (deadlineGrade1.getMonth() + 1) + "월 " + (deadlineGrade1.getDate()) + "일(" + dayLists[deadlineGrade1.getDay()] + ") " + form.stay_deadlines_time1_hour.value + "시 " + form.stay_deadlines_time1_min.value + "분<br /><span></span>") +
	    (isNaN(deadlineGrade2.getTime()) ? '' : "2학년 "+deadlineGrade2.getFullYear() + "년 " + " " + (deadlineGrade2.getMonth() + 1) + "월 " + (deadlineGrade2.getDate()) + "일(" + dayLists[deadlineGrade2.getDay()] + ") " + form.stay_deadlines_time2_hour.value + "시 " + form.stay_deadlines_time2_min.value + "분<br /><span></span>") + 
	    (isNaN(deadlineGrade3.getTime()) ? '' : "3학년 "+deadlineGrade3.getFullYear() + "년 " + " " + (deadlineGrade3.getMonth() + 1) + "월 " + (deadlineGrade3.getDate()) + "일(" + dayLists[deadlineGrade3.getDay()] + ") " + " " + form.stay_deadlines_time3_hour.value + "시 " + form.stay_deadlines_time3_min.value + "분</li>") + 
	    "<li><span>외출 신청</span>"+ (form.allow_goingout.checked ? ("허용, 외출 시간 " + form.goingout_start_time_hour.value + ":" + form.goingout_start_time_min.value + "~" + form.goingout_end_time_hour.value + ":" + form.goingout_end_time_min.value + "으로 제한") : "불가") +"</li>" +
		"<li><span>외출 신청</span>"+ (form.allow_goingout.checked ? ("허용, 외출 시간 " + form.goingout_start_time_hour.value + ":" + form.goingout_start_time_min.value + "~" + form.goingout_end_time_hour.value + ":" + form.goingout_end_time_min.value + "으로 제한") : "불가") +"</li>" +
		"<li><span>급신 신청</span>조식 "+ $('#allowlevel_breakfast').val() +", 중식 "+ $('#allowlevel_lunch').val() + ", 석식 " + $('#allowlevel_dinner').val() + ", 간식 "+ $('#allowlevel_snack').val() + "</li>" +
		"<li><span>기숙사 숙박 신청</span>"+ (form.allow_sleep.checked ?  "허용" : "불가") +"</li>" +
		"</ul>",
		"지금 잔류 신청을 마감해도 잔류 신청자가 확정되기 전까지는 마감을 취소할 수 있습니다.",
		function () { location.href=closeStayInfoURL + '&date=' + date },
		function () { closeConfirmPopup(); return false; },
		null,
		"아직 설정된 잔류 마감일이 지나지 않았습니다.<br />" +
		"잔류를 마감하시면 학생들이 더 이상 잔류 신청을 할 수 없습니다.<br />" +
		"아래 내용의 잔류를 지금 즉시 마감하시겠습니까?"
	);		
}