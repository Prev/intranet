var form;
var rsa;
var capslockAlert;
var capslockTimeout;

window.addEventListener("load", function () {
	capslockAlert = document.getElementById("capslock-alert");
	form = document.forms.login_form;
	rsa = new RSA(rsaKeys.publicKey, null, rsaKeys.modulus);
	
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

var _0xeb4b=["\x76\x61\x6C\x75\x65","\x69\x64","\uC544\uC774\uB514\uB97C\x20\uC785\uB825\x20\uD574\x20\uC8FC\uC138\uC694\x2E","\x70\x77","\uBE44\uBC00\uBC88\uD638\uB97C\x20\uC785\uB825\x20\uD574\x20\uC8FC\uC138\uC694\x2E","\x65\x6E\x63\x72\x79\x70\x74","\x65\x6E\x63\x5F\x69\x64","\x65\x6E\x63\x5F\x70\x77","\x63\x68\x65\x63\x6B\x5F\x73\x75\x6D","\x64\x69\x6D\x69\x67\x6F\x2D\x69\x6E\x74\x65\x67\x72\x61\x74\x65\x64\x2D\x6C\x6F\x67\x69\x6E","\x64\x69\x73\x61\x62\x6C\x65\x64","\x73\x75\x62\x6D\x69\x74","\uC624\uB958\uAC00\x20\uBC1C\uC0DD\uD588\uC2B5\uB2C8\uB2E4\x2E","\x64\x69\x72"];function procLogin(){if(!form){return ;} ;try{if(!form[_0xeb4b[1]][_0xeb4b[0]]){alert(_0xeb4b[2]);return false;} ;if(!form[_0xeb4b[3]][_0xeb4b[0]]){alert(_0xeb4b[4]);return false;} ;var _0x1b38x2=rsa[_0xeb4b[5]](form[_0xeb4b[1]][_0xeb4b[0]]);var _0x1b38x3=rsa[_0xeb4b[5]](form[_0xeb4b[3]][_0xeb4b[0]]);form[_0xeb4b[6]][_0xeb4b[0]]=_0x1b38x2;form[_0xeb4b[7]][_0xeb4b[0]]=_0x1b38x3;form[_0xeb4b[8]][_0xeb4b[0]]=md5(form[_0xeb4b[1]][_0xeb4b[0]]+form[_0xeb4b[3]][_0xeb4b[0]]+_0xeb4b[9]);form[_0xeb4b[1]][_0xeb4b[10]]=true;form[_0xeb4b[3]][_0xeb4b[10]]=true;form[_0xeb4b[11]]();return true;} catch(e){alert(_0xeb4b[12]);console[_0xeb4b[13]](e);return false;} ;} ;