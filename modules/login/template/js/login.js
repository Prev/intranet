var form;
var rsa;
var capslockAlert;

window.addEventListener("load", function () {
	capslockAlert = document.getElementById("capslock-alert");
	form = document.forms.login_form;
	rsa = new RSA(rsaKeys.publicKey, null, rsaKeys.modulus);
	
	toggleSecureLogin(form.secure_login);

	form.id.focus();
});

function checkCapsLock(e) {
	kc = e.keyCode ? e.keyCode : e.which;
	sk = e.shiftKey ? e.shiftKey : ((kc == 16) ? true : false);
	if (((kc >= 65 && kc <= 90) && !sk) || ((kc >= 97 && kc <= 122) && sk))
		capslockAlert.style.visibility = 'visible';
	else
		capslockAlert.style.visibility = 'hidden';
}

function toggleSecureLogin(target) {
	if (target.checked)
		form.action = form.action.split("procLogin").join("procSecureLogin");
	else
		form.action = form.action.split("procSecureLogin").join("procLogin");
}

function procLogin() {
	try {
		if (!form.id.value) { alert("아이디를 입력 해 주세요."); return false; }
		if (!form.pw.value) { alert("비밀번호를 입력 해 주세요."); return false; }
		
		if (!form.secure_login.checked) {
			form.submit();
			return true;
			
		}else {
			var enc_id = rsa.encrypt(form.id.value);
			var enc_pw = rsa.encrypt(form.pw.value);
			
			form.enc_id.value = enc_id;
			form.enc_pw.value = enc_pw;
			form.check_sum.value = md5(form.id.value + form.pw.value);
			
			form.id.disabled = true;
			form.pw.disabled = true;

			form.submit();
			return true;
		}
	}catch (e) {
		alert("오류가 발생했습니다.");
		console.dir(e);
		return false;
	}
}