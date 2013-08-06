var inputId, inputPw, inputRepw, emailHost;
var inputIdWarning, inputPwWarning, inputRepwWarning
var checkIdTimeout;
var FILTERED_ID = ["admin", "administrator", "root", "webmaster", "master", "tester"];

window.onload = function () {
	inputId = document.getElementById("input-id");
	inputPw = document.getElementById("input-pw");
	inputRepw = document.getElementById("input-repw");
	emailHost = document.getElementById("email-host");
	
	inputIdWarning = document.getElementById("input-id-warning");
	inputPwWarning = document.getElementById("input-pw-warning");
	inputRepwWarning = document.getElementById("input-repw-warning");
	
	inputId.onkeyup = function () {
		for (var i=0; i<FILTERED_ID.length; i++) {
			if (inputId.value.indexOf(FILTERED_ID[i]) != -1) {
				inputIdWarning.style.color = "#d02626"
				inputIdWarning.innerHTML = '사용 할 수 없는 아이디입니다.';
				return;
			}
		}
		if (inputId.value.match(/[^a-z0-9_-]+/g)) {
			inputIdWarning.style.color = "#d02626"
			inputIdWarning.innerHTML = '사용 할 수 없는 아이디입니다.';
		}else if (inputId.value.length < 6) {
			inputIdWarning.style.color = "#d02626"
			inputIdWarning.innerHTML = '아이디가 너무 짧습니다.';
		}else if (inputId.value.length > 20) {
			inputIdWarning.style.color = "#d02626"
			inputIdWarning.innerHTML = '아이디가 너무 깁니다.';
		}else {
			inputIdWarning.style.color = "#F90"
			inputIdWarning.innerHTML = '중복확인중입니다.';
			
			clearTimeout(checkIdTimeout);
			checkIdTimeout = setTimeout(checkId, 500);
		}
	}
	
	inputPw.onkeyup= function () {
		var strength = checkPasswordStrength(inputId.value, inputPw.value);
		switch (strength) {
			case "short" :
				inputPwWarning.style.color = "#d02626"
				inputPwWarning.innerHTML = '비밀번호가 너무 짧습니다.';
				break;
			
			case "same" :
			case "bad" :
				inputPwWarning.style.color = "#d02626"
				inputPwWarning.innerHTML = '보안 강도: 취약 (다른 비밀번호를 입력하세요)';
				break;
			
			case "good" :
				inputPwWarning.style.color = "#F90"
				inputPwWarning.innerHTML = '보안 강도: 보통';
				break;
			
			case "strong" :
				inputPwWarning.style.color = "#390"
				inputPwWarning.innerHTML = '보안 강도: 강력';
				break;
			
			case "very strong" :
				inputPwWarning.style.color = "#390"
				inputPwWarning.innerHTML = '보안 강도: 매우 강력';
				break;
			
		}
	}
	
	inputRepw.onkeyup= function () {
		if (inputPw.value != inputRepw.value) {
			inputRepwWarning.innerHTML = "비밀번호가 다릅니다.";
			inputRepw.style.marginTop = "0px";
		}else {
			inputRepwWarning.innerHTML = "";
			inputRepw.style.marginTop = "7px";
		}
	}
}

function checkId() {
	$.get('../ajax/check_user_id.php?user_id='+inputId.value, function (result) {
		if (inputId.value.match(/[^a-z0-9_-]+/g)) {
			inputIdWarning.style.color = "#d02626"
			inputIdWarning.innerHTML = '사용 할 수 없는 아이디입니다.';
		}else if (result == 'true') {
			inputIdWarning.style.color = "#390"
			inputIdWarning.innerHTML = '사용 가능한 아이디 입니다.';
		}else {
			inputIdWarning.style.color = "#d02626"
			inputIdWarning.innerHTML = '이미 사용중인 아이디 입니다.';
		}
	});
}

function emailSelectHandler(target) {
	if (target.value == "custom") {
		emailHost.value = "";
		emailHost.className = "";
		emailHost.disabled = false;
	}else {
		emailHost.value = target.value;
		emailHost.className = "disabled";
		emailHost.disabled = true;
	}
}

function checkSubmit(form) {
	if (inputId.value.match(/[^a-z0-9_-]+/g)) {
		alert("사용 할 수 없는 아이디입니다.");
		return false;
	}else if (inputId.value.length < 6) {
		alert("아이디가 너무 짧습니다.");
		return false;
	}else if (inputId.value.length > 20) {
		alert("아이디가 너무 깁니다.");
		return false;
	}else if (inputIdWarning.innerHTML == '이미 사용중인 아이디 입니다.') {
		alert("이미 사용중인 아이디 입니다.");
		return false;
	}
	var strength = checkPasswordStrength(inputId.value, inputPw.value);
	if (strength == "short" || strength == "same" || strength == "bad") {
		alert("사용 할 수 없는 비밀번호입니다.");
		return false;
	}
	if (inputPw.value != inputRepw.value) {
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		return false;
	}
	if (form.email_id.value == '') {
		alert("이메일을 빠짐없이 입력 해 주세요");
		return false;
	}
	emailHost.disabled = false;
	return true;
}

function checkPasswordStrength(userId,password){
	var score=0;
	if(password.length<6) return"short";
	if(password.toLowerCase()==userId.toLowerCase() ) return"same";
	score+=password.length*4;
	score+=(checkRepetition(1,password).length-password.length)*1;
	score+=(checkRepetition(2,password).length-password.length)*1;
	score+=(checkRepetition(3,password).length-password.length)*1;
	score+=(checkRepetition(4,password).length-password.length)*1;
	if(password.match(/(.*[0-9].*[0-9].*[0-9])/)){score+=5}
	if(password.match(/(.*[!,@,#,$,%,^,&,*,?,_,~].*[!,@,#,$,%,^,&,*,?,_,~])/)){score+=5}
	if(password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)){score+=10}
	if(password.match(/([a-zA-Z])/)&&password.match(/([0-9])/)){score+=15}
	if(password.match(/([!,@,#,$,%,^,&,*,?,_,~])/)&&password.match(/([0-9])/)){score+=15}
	if(password.match(/([!,@,#,$,%,^,&,*,?,_,~])/)&&password.match(/([a-zA-Z])/)){score+=15}
	if(password.match(/^\w+$/)||password.match(/^\d+$/)){score-=10}if(score<0){score=0}
	if(score>100){score=100}
	if(score<32)return"bad";
	else if(score<52)return"good";
	else if(score<85)return"strong";
	else return"very strong"
}

function checkRepetition(pLen,str){
	var res="";
	for(var i=0;i<str.length;i++){
		
		var repeated=true;

		for(var j=0;j<pLen&&(j+i+pLen)<str.length;j++){
			repeated=repeated&&(str.charAt(j+i)==str.charAt(j+i+pLen))
		}

	if(j<pLen){repeated=false}
	if(repeated){
		i+=pLen-1;
		repeated=false
	}
	else{res+=str.charAt(i)}}return res
}