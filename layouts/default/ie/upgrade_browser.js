var browserUpgrade;
var browserUpgradeTimer;
var browserUpgradeSize = -107;

window.addEventListener("load", function() {
	browserUpgrade = document.createElement("div");
	browserUpgrade.id = "browser-upgrade";
	browserUpgrade.innerHTML = '<div id="browser-upgrade-img">' +
				'<span class="hidden">접속 중이신 웹 브라우저는 지원되지 않습니다.<br>정상적인 서비스 이용을 위해 다음 브라우저 중 하나를 설치하시기 바랍니다.</span>' +
			'</div>' +
			'<ul id="browser-upgrade-selector">' +
				'<a href="http://google.com/chrome"><li id="browser-upgrade-chrome"></li></a>' +
				'<a href="http://www.mozilla.or.kr/ko/"><li id="browser-upgrade-firefox"></li></a>' +
				'<a href="http://windows.microsoft.com/ko-KR/internet-explorer/downloads/ie-8"><li id="browser-upgrade-ie"></li></a>' +
				'<a href="http://www.apple.com/kr/safari/"><li id="browser-upgrade-safari"></li></a>' +
				'<a href="http://www.opera.com/browser/"><li id="browser-upgrade-opera"></li></a>' +
				'<li id="browser-upgrade-close" onclick="closeBrowserUpgrade()"></li>' +
			'</ul>';

	browserUpgrade.style.top = browserUpgradeSize + "px";
	document.body.insertBefore(browserUpgrade, document.getElementById("header"));

	browserUpgradeTimer = setInterval(browserUpgrade_slide, 20);	
});

function browserUpgrade_slide() {
	browserUpgradeSize += 3;
	browserUpgrade.style.top = browserUpgradeSize + "px";
	
	if (browserUpgradeSize >= 10)
		clearInterval(browserUpgradeTimer);
}

function closeBrowserUpgrade() {
	browserUpgrade.style.display = "none";
}