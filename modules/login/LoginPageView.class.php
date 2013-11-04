<?php
	
	class LoginPageView extends View {

		var $errorType;
		var $next;

		function dispLoginPage() {
			if (!is_null(User::getCurrent())) {
				redirect(getUrl());
				return;
			}

			if (isset($_GET['result']))
				switch ($_GET['result']) {
					case 'fail':
					case 'fail_sec':
						$this->errorType = $_GET['result'];
						break;
				}
			
			$this->rsaKeys = (object) array(
				'publicKey' => RSA_PUBLIC_KEY,
				'modulus' => RSA_MODULUS
			);
			$this->next = isset($_GET['next']) ? $_GET['next'] : (isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : NULL);
			self::execTemplate('login_form');
		}

/*
var form;
var rsa;
var capslockAlert;
var capslockTimeout;

window.addEventListener("load", function () {
	capslockAlert = document.getElementById("capslock-alert");
	form = document.forms.login_form;
	rsa = new RSA(rsaKeys.publicKey, null, rsaKeys.modulus);
	
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
		
		var custom_enc_id = encryptCustom(form.id.value);
		var custom_enc_pw = encryptCustom(form.pw.value);
		var enc_id = rsa.encrypt(custom_enc_id);
		var enc_pw = rsa.encrypt(custom_enc_pw);

		form.enc_id.value = enc_id;
		form.enc_pw.value = enc_pw;
		form.check_sum.value = md5(form.pw.value + custom_enc_id + "dimigo-integrated-login");
		
		form.id.disabled = true;
		form.pw.disabled = true;

		form.submit();
		return true;
		
	}catch (e) {
		alert("오류가 발생했습니다.");
		console.dir(e);
		return false;
	}
}
*/
		
	}