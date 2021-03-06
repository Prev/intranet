var form;
var capslockAlert;
var capslockTimeout;

window.addEventListener("load", function () {
	capslockAlert = document.getElementById("capslock-alert");
	form = document.forms.login_form;
	
	form.id.focus();
	document.msCapsLockWarningOff = true;

	form.id.focus();
});

function checkCapsLock(e) {
	kc = e.keyCode ? e.keyCode : e.which;
	sk = e.shiftKey ? e.shiftKey : ((kc == 16) ? true : false);
	if (((kc >= 65 && kc <= 90) && !sk) || ((kc >= 97 && kc <= 122) && sk)) {
		capslockAlert.style.visibility = 'visible';
		if (!capslockTimeout)
			capslockTimeout = setTimeout(function () {
				capslockAlert.style.visibility = 'hidden';
				capslockTimeout = null;
			}, 3000);
	}
	else
		capslockAlert.style.visibility = 'hidden';
}

function encryptCustom(string) {
	string = string.split("").reverse().join("");
	return " " +  Base64.encode(string);
}

function procLogin() {
	if (!form) return;

	try {
		if (!form.id.value) { alert("아이디를 입력 해 주세요."); return false; }
		if (!form.pw.value) { alert("비밀번호를 입력 해 주세요."); return false; }

		form.submit();
		return true;
		
	}catch (e) {
		alert("오류가 발생했습니다.");
		console.dir(e);
		return false;
	}
}