var checkBoxes = { "grade1":[], "grade2":[], "grade3":[], "extra":[] };
var seatName = null;
var clickedStudentSeat = null;
var dayLists;

$(document).ready(function() {
	dayLists = new Array('일','월','화','수','목','금','토');
	
	for (var i=1; i<=3; i++) {
		for (var j=1; j<=6; j++)
			checkBoxes["grade"+i][j] = document.getElementById("cb-" + i + "-" + j);
		checkBoxes["grade"+i]["all"] = document.getElementById("cb-" + i + "-all");
	}
	
	$('#goingout_start_hour,#goingout_start_min,#goingout_end_hour,#goingout_end_min').keyup(function(){
		$(this).val($(this).val().replace(/[^0-9\.]/,''));
	});
	$('#main-content-seat-top-right input[type=text]').attr("disabled",true);
	$('#apply_goingout').click(function(){	
		if($(this).is(':checked')){
			$('#main-content-seat-top-right input[type=text]').attr("disabled",false)
			$('.apply_goingout_disable').attr('class','apply_goingout_able');	
		}else{
			$('#main-content-seat-top-right input[type=text]').attr("disabled",true);
			$('.apply_goingout_able').attr('class','apply_goingout_disable');
		}
	});

	seatBalloon = document.getElementById("seat-balloon");
	seatBalloonText = document.getElementById("seat-balloon-text");

});

function getSeResult() {
	var form = document.forms.se_option;
	var formValues = [];
	for (var i=0; i<form.length; i++) {
		if (form[i].checked && form[i].name.indexOf('all') != 2)
			formValues.push( form[i].name );
	}
	$.get(seResultURL + '&date='+date+'&options='+formValues.join(",")+'&callType=3', function(data) {
		document.getElementById("main-content-se-result-dds").innerHTML = data;
	});
}


function cbh_a(target, grade) {
	for (var i=1; i<=6; i++)
		checkBoxes["grade"+grade][i].checked = target.checked;
}
function cbh_c(target, grade) {
	if (!target.checked) {
		checkBoxes["grade"+grade]["all"].checked = false;
	}
}
function getStudent(target, student_number){
	var childNodes = target.getElementsByTagName("li");
	
	setStudentInfo(childNodes[0].innerHTML);	
	childNodes[2].innerHTML == 'X' ? $('#apply_breakfast').prop("checked", false)  :  $('#apply_breakfast').prop("checked", true)
	childNodes[3].innerHTML == 'X' ? $('#apply_lunch').prop("checked", false)  :  $('#apply_lunch').prop("checked", true)
	childNodes[4].innerHTML == 'X' ? $('#apply_dinner').prop("checked", false)  :  $('#apply_dinner').prop("checked", true)
	childNodes[5].innerHTML == 'X' ? $('#apply_snack').prop("checked", false)  :  $('#apply_snack').prop("checked", true)	
	childNodes[6].innerHTML == 'X' ? $('#apply_sleep').prop("checked", false)  :  $('#apply_sleep').prop("checked", true)	
	
	if(childNodes[8].innerHTML!='미신청'){
		$('#main-content-seat-top-right input[type=text]').attr("disabled",false);
		$('.apply_goingout_disable').attr('class','apply_goingout_able');
		$('#goingout_cause').val(childNodes[14].innerHTML);		

		$('#goingout_start_hour option[value='+childNodes[10].innerHTML+']').attr('selected','selected');
		$('#goingout_start_min option[value='+childNodes[11].innerHTML+']').attr('selected','selected');
		$('#goingout_end_hour option[value='+childNodes[12].innerHTML+']').attr('selected','selected');
		$('#goingout_end_min option[value='+childNodes[13].innerHTML+']').attr('selected','selected');

		$('#goingout_cause').prop("disabled", false)
		$('#apply_goingout').prop("checked", true);

	}
	else{
		$('#main-content-seat-top-right input[type=text]').attr("disabled",true);
		$('.apply_goingout_able').attr('class','apply_goingout_disable');
		$('#goingout_start_hour option[value=00]').attr('selected','selected');
		$('#goingout_start_min option[value=00]').attr('selected','selected');
		$('#goingout_end_hour option[value=00]').attr('selected','selected');
		$('#goingout_end_min option[value=00]').attr('selected','selected');

		$('#goingout_cause').prop("disabled", true)
		$('#goingout_cause').val('');			
		
		$('#apply_goingout').prop('checked',false);
	}
	
	if(childNodes[9].innerHTML!='없음')
		$('#stay-request-etc-text').val(childNodes[9].innerHTML);
	else
		$('#stay-request-etc-text').val('');
		

	if(childNodes[7].innerHTML != '미신청'){
		$('#disapply_seat').prop('checked',false);
		seatName = childNodes[7].innerHTML;
		clickedStudentSeat = seatName;
		seatSelectHandler($('#seat-'+childNodes[7].innerHTML)[0]);
	}else{
		$('#disapply_seat').prop("checked", true);
		seatName = '';
		seatSelectHandler(null);
	}
	toggleSeat(document.getElementById('disapply_seat'));
	
	
}

function changeChoose(){
	var checkboxes = new Array('apply_breakfast','apply_lunch','apply_dinner','apply_snack','apply_sleep','apply_goingout');
	var textboxes = new Array('stay-request-etc-text','goingout_cause');
	var selects = new Array('goingout_start_hour','goingout_start_min','goingout_end_hour','goingout_end_min');
	for(var i in checkboxes)
		$('#'+checkboxes[i]).prop('checked',false);
	for(var i in textboxes)
		$('#'+textboxes[i]).val('');
	for(var i in selects)
		$('#'+selects[i]+' option[value=00]').attr('selected','selected');

	$('#disapply_seat').prop('checked',true);
	$('#goingout_cause').prop("disabled", true)
	toggleSeat(document.getElementById('disapply_seat'));
}

function setStudentInfo(data){
	$('#main-content-seat-choose-grade option[value='+data.substr(0, 1)+']').attr('selected','selected');
	$('#main-content-seat-choose-class option[value='+data.substr(1, 1)+']').attr('selected','selected');
	$('#main-content-seat-choose-number option[value='+parseInt(data.substr(2, 2))+']').attr('selected','selected');
}

function disapplySeat(){
	if($('#disapply_seat').attr('checked') == 'checked')
		seatSelectHandler(null);	
	
}
function saveStayData(){
	var form = document.seat_option;

	openConfirmPopup("정말로 해당 학생의 잔류 내용을 변경 하시겠습니까?",
	  "<ul>" + 
	  "<li><span>학년</span>"+form.grade[form.grade.selectedIndex].text+"</li>" +
	  "<li><span>반</span>"+form.class[form.class.selectedIndex].text+"</li>" +
	  "<li><span>번호</span>"+form.number[form.number.selectedIndex].text+"</li>" + 
	  "<li><span>급신 신청</span>조식 "+ (form.apply_breakfast.checked ? '신청' : '취소') +", 중식 "+(form.apply_lunch.checked ? '신청' : '취소') + ", 석식 " + (form.apply_dinner.checked ? '신청' : '취소') + ", 간식 "+ (form.apply_snack.checked ? '신청' : '취소') + "</li>" +
	  "<li><span>기숙사 숙박</span>"+ (form.apply_sleep.checked ?  "신청" : "미신청") +"</li>" +
	  "<li><span>기타 특이사항</span>"+ form.extra_caption.value +"</li>" +
	  "<li><span>외출 신청</span>"+ (form.apply_goingout.checked ? ("외출 시간 " + form.goingout_start_hour[form.goingout_start_hour.selectedIndex].text + ":" + form.goingout_start_min[form.goingout_start_min.selectedIndex].text + "~" + form.goingout_end_hour[form.goingout_end_hour.selectedIndex].text + ":" + form.goingout_end_min[form.goingout_end_min.selectedIndex].text + "으로 제한") : "미신청") +"</li>" +
	  "<li><span>외출 사유</span>"+ form.goingout_cause.value +"</li>" +
	  "<li><span>도서관 좌석</span>" + (seatName && !$('#disapply_seat').prop('checked') ? seatName : '미신청') + "</li>" +
	  "</ul>",
	  "",
	  function () {
		var form = document.forms.seat_option;
		var formValues = [];
		
		if(!$('#disapply_seat').prop('checked') && seatName == null){
			alert("좌석을 선택하지 않았습니다.");	
			return;
		}
		if($('#apply_goingout').attr('checked')){
			if(parseInt($('#goingout_start_hour').val() * 60 + $('#goingout_start_min').val()) > parseInt($('#goingout_end_hour').val() * 60 + $('#goingout_end_min').val())){
				alert('외출시간이 잘못되었습니다.');
				return;	
			}else if(!$('#goingout_cause').val()){
				alert('외출사유가 없습니다.');
				return;		
			}
		}
		for (var i=0; i<form.length; i++) {
			if(form[i].type == 'checkbox'){
				formValues.push(form[i].name+'='+(form[i].checked ? 1 : 0));
				
				if(form[i].name == 'disapply_seat' && seatName != ''){
					formValues.push('library_seat='+seatName);
				}
			}
			else if(form[i].type == 'submit')
				continue;
			else
				formValues.push(form[i].name+'='+encodeURIComponent(form[i].value));
		}

		$.post(saveStayDataURL + '&date=' + date+'&'+formValues.join("&"), function(resCode) {
			
			resCode = parseInt(resCode);
			switch(resCode){
			case SUCC_UPDATE_STAY_DATA:
				alert("[잔류수정 성공]\n해당 학생의 잔류 정보가 수정되었습니다.");
				break;
			case SUCC_ADD_STAY_DATA:
				alert("[잔류추가 성공]\n해당 학생의 잔류가 추가되었습니다.");
				break;
			case ERR_NO_STUDENT:
				alert("[잔류추가/수정 실패]\n존재하지 않는 학생입니다.");
				break;
			case ERR_NO_STAY_DATE:
				alert("[잔류추가/수정 실패]\n잔류가 불가능한 날입니다.(잔류 정보가 존재하지 않습니다.)");
				break;
			case ERR_FAIL_UPDATE_STAY_DATA:
				alert("[잔류수정 실패]\n잔류 수정중 오류가 발생했습니다.");
				break;
			case ERR_FAIL_ADD_STAY_DATA:
				alert("[잔류추가 실패]\n잔류 수정중 오류가 발생했습니다.");
				break;
			case ERR_GOINGOUT_START_TIME_IS_FASTER_THAN_END_TIME:
				alert("[외출시간 에러]\n외출 시작 시간이 외출 종료 시간보다 늦은 시간입니다.")
				break;
			}

			// 잔류 정보 업데이를 실패하던 말던간에 업데이트가 되어야 하는 내용이므로 업데이트한다.
			getSeResult();

			$.post(getStaySeatsURL + '&date=' + date + '&callType=3', function(seatData) {
				$("#seat_box").html(seatData);
				closeConfirmPopup();
			});
		});  
	},
	  function () { closeConfirmPopup(); return; }
	);
}
function deleteStayData(){
	var form = document.seat_option;
	var studentData = new Array(
		$('#main-content-seat-choose-grade').val(),
		$('#main-content-seat-choose-class').val(),
		$('#main-content-seat-choose-number').val()
	);
	openConfirmPopup("정말로 해당 학생의 잔류 정보를 삭제하시겠습니까?",
	  "<ul>" + 
	  "<li><span>학년</span>"+studentData[0]+"학년</li>" +
	  "<li><span>반</span>"+studentData[1]+"반</li>" +
	  "<li><span>번호</span>"+studentData[2]+"번</li>" + 
	  "<li><span>도서관 좌석</span>" + (seatName ? seatName : '미신청') + "</li>" +
	  "</ul>",
	  "",
	  function () {
		$.post(deleteStayDataURL + '&date=' + date+'&grade='+studentData[0]+'&class='+studentData[1]+'&number='+studentData[2], function(resCode) {
			
			resCode = parseInt(resCode);
			switch(resCode){
			case SUCC_DELETE_STAY_DATA:
				alert("[잔류삭제 성공]\n해당 학생의 잔류 정보가 삭제되었습니다.");
				break;
			case ERR_NO_STUDENT:
				alert("[잔류삭제 실패]\n존재하지 않는 학생입니다.");
				break;
			case ERR_NO_STAY_DATE:
				alert("[잔류삭제 실패]\n잔류가 불가능한 날입니다.(잔류 정보가 존재하지 않습니다.)");
				break;
			case ERR_NO_STAY_STUDENT:
				alert("[잔류삭제 실패]\n해당 학생의 잔류 정보가 존재하지 않습니다.");
				break;
			case ERR_FAIL_DELETE_STAY_DATA:
				alert("[잔류삭제 실패]\n잔류정보 삭제중 오류가 발생했습니다.");
				break;
			}
			getSeResult();

			$.post(getStaySeatsURL + '&date=' + date + '&callType=3', function(seatData) {
				$("#seat_box").html(seatData);
				closeConfirmPopup();
			});
		});  
		},
	  function () { closeConfirmPopup(); return; }
	);
}
function cancelCloseStayInfo(){
	var stayDate = new Date(date);
	
	openConfirmPopup("잔류 마감을 취소하시겠습니까?",
	  "<div>"+stayDate.getFullYear() + "년 " + " " + (stayDate.getMonth() + 1) + "월 " + (stayDate.getDate()) + "일(" + dayLists[stayDate.getDay()]+") 잔류 마감을 정말 취소하시겠습니까?</div>",
	  "<div>잔류 마감을 취소하면 모든 학년의 잔류 신청 마감일이 오늘로 변경되고, 잔류 신청 접수가 재개됩니다.</div>",
	  function () { window.location.href= cancelCloseStayInfoURL + '&date=' + date; },
	  function () { closeConfirmPopup(); return; }
	);
}
function confirmStayInfo(){
	var stayDate = new Date(date);
	
	openConfirmPopup("잔류 신청자를 확정하시겠습니까?",
	  "<div>"+stayDate.getFullYear() + "년 " + " " + (stayDate.getMonth() + 1) + "월 " + (stayDate.getDate()) + "일(" + dayLists[stayDate.getDay()]+") 잔류 신청자를 정말 확정하시겠습니까?<br />" +
	  "내용에 오류가 없는지 다시 한 번 확인해 보시기 바랍니다.</div>",
	  "<div>잔류자를 확정하면 급식실로 잔류 확정 알림과 함께 잔류자 명단이 전송되고, 잔류 학생 부모님께는 자녀 잔류 알림이 전송됩니다.<br />" +
	  "확정 이후, 잔류 신청 내역 수정은 가능하지만 급식 신청 내역은 변경할 수 없게 됩니다.</div>",
	  function () { window.location.href= confirmStayInfoURL + '&date='+date },
	  function () { closeConfirmPopup(); return; }
	);
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