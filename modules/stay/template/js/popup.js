var popupBox, popupInterval, popupInterval2;
var cPopupBox, cPopupInterval, cPopupInterval2;
var prefixes = ["webkit", "o", "moz"];

function getPrefixedCSS(css) {
	var arr = [];
	for (var i=0; i<prefixes.length; i++) {
		var css2 = (prefixes[i] == "") ? css : css.substr(0, 1).toUpperCase() + css.substr(1, css.length - 1);
		arr[i] = prefixes[i] + css2;
	}
	return arr;
}

function openPopup(title, content, bottomText, callBack) {
	popupBox = document.getElementById("popup-box");
	var popupBg = document.getElementById("popup-layout-bg");
	
	document.body.style.overflow = "hidden";
	popupBg.style.visibility = "visible";
	
	popupBox.style.visibility = "visible";
	
	if (title) document.getElementById("popup-title").innerHTML = String(title);	
	if (content) document.getElementById("popup-content").innerHTML = String(content);
	if (bottomText) document.getElementById("popup-bottom-text").innerHTML = String(bottomText);
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++)
		popupBox.style[prefixedCSS[i]] = "scale(0, 0)";
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = popupBox.style[prefixedCSS[i]];
		if (transform) {
			popupBox.style.opacity = 0;
			break;
		}
	}
	popupInterval = setInterval(function () {
		var prefixedCSS = getPrefixedCSS("transform");
		for (var i=0; i<prefixedCSS.length; i++) {
			var transform = popupBox.style[prefixedCSS[i]];
			if (!transform) continue;
			
			var scales = transform.split(" ").join("").split("(")[1].split(")")[0].split(",");
			var scaleX = parseFloat(scales[0]) + (1 - parseFloat(scales[0])) * 0.7;
			var scaleY = parseFloat(scales[1]) + (1 - parseFloat(scales[1])) * 0.7;
			
			if (scaleX > 0.95 || scaleY > 0.95) {
				popupBox.style[prefixedCSS[i]] = "scale(1,1)";
				popupBox.style.opacity = 1;
				clearInterval(popupInterval);
			}else {
				popupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				popupBox.style.opacity = scaleX;
			}
		}
	}, 30);
	
	var inHeight = window.innerHeight || window.offsetHeight;
	if (popupBox.offsetHeight + 200 > inHeight) {
		var popupBoxContent = document.getElementById("popup-content");
		popupBoxContent.style.maxHeight = inHeight - 200 + "px";
		popupBoxContent.style.overflowY = "auto";
		popupBoxContent.style.overflowX = "hidden";
	}
	
	popupBox.style.marginLeft = (-1 * popupBox.offsetWidth / 2) + "px";
	if (popupBox.offsetHeight < 300)
		popupBox.style.marginTop = ((-1 * popupBox.offsetHeight / 2) - 50) + "px";
	else
		popupBox.style.marginTop = (-1 * popupBox.offsetHeight / 2) + "px";
	
	window.addEventListener("keydown", keyClosePopupHandler);
	
	if (callBack) {
		document.getElementById("ok-button").onclick = callBack;
		document.getElementById("close-button").onclick = callBack;
	}else {
		document.getElementById("ok-button").onclick = closePopup;
		document.getElementById("close-button").onclick = closePopup;
	}
}

function keyClosePopupHandler(event) {
	var keyCode = ('which' in event) ? event.which : event.keyCode;
	switch (keyCode) {
		case 13 :
		case 27 :
		closePopup();
	}
	
	window.removeEventListener("keydown", keyClosePopupHandler);
}

function closePopup() {
	document.body.style.overflow = "auto";
	document.getElementById("popup-layout-bg").style.visibility = "hidden";
	document.getElementById("popup-box").style.visibility = "hidden";
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = popupBox.style[prefixedCSS[i]];
		if (transform) {
			document.body.style.overflow = "hidden";
			document.getElementById("popup-layout-bg").style.visibility = "visible";
			document.getElementById("popup-box").style.visibility = "visible";
			break;
		}
	}
	popupInterval2 = setInterval(function () {
		var prefixedCSS = getPrefixedCSS("transform");
		for (var i=0; i<prefixedCSS.length; i++) {
			var transform = popupBox.style[prefixedCSS[i]];
			if (!transform) continue;
			
			var scales = transform.split(" ").join("").split("(")[1].split(")")[0].split(",");
			var scaleX = parseFloat(scales[0]) + (0 - parseFloat(scales[0])) * 0.5;
			var scaleY = parseFloat(scales[1]) + (0 - parseFloat(scales[1])) * 0.5;
			
			if (scaleX < 0.05 || scaleY < 0.05) {
				popupBox.style[prefixedCSS[i]] = "scale(0,0)";
				popupBox.style.opacity = 0;
				document.body.style.overflow = "auto";
				document.getElementById("popup-layout-bg").style.visibility = "hidden";
				document.getElementById("popup-box").style.visibility = "hidden";
				
				clearInterval(popupInterval2);
			}else {
				popupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				popupBox.style.opacity = scaleX;
			}
		}
	}, 30);
}

function openConfirmPopup(title, content, bottomText, onTrueCallBack, onFalseCallBack) {
	cPopupBox = document.getElementById("c-popup-box");
	var popupBg = document.getElementById("popup-layout-bg");
	
	document.body.style.overflow = "hidden";
	popupBg.style.visibility = "visible";
	
	cPopupBox.style.visibility = "visible";
	
	if (title) document.getElementById("c-popup-title").innerHTML = String(title);	
	if (content) document.getElementById("c-popup-content").innerHTML = String(content);
	if (bottomText) document.getElementById("c-popup-bottom-text").innerHTML = String(bottomText);
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++)
		cPopupBox.style[prefixedCSS[i]] = "scale(0, 0)";
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = cPopupBox.style[prefixedCSS[i]];
		if (transform) {
			cPopupBox.style.opacity = 0;
			break;
		}
	}
	cPopupInterval = setInterval(function () {
		var prefixedCSS = getPrefixedCSS("transform");
		for (var i=0; i<prefixedCSS.length; i++) {
			var transform = cPopupBox.style[prefixedCSS[i]];
			if (!transform) continue;
			
			var scales = transform.split(" ").join("").split("(")[1].split(")")[0].split(",");
			var scaleX = parseFloat(scales[0]) + (1 - parseFloat(scales[0])) * 0.7;
			var scaleY = parseFloat(scales[1]) + (1 - parseFloat(scales[1])) * 0.7;
			
			if (scaleX > 0.95 || scaleY > 0.95) {
				cPopupBox.style[prefixedCSS[i]] = "scale(1,1)";
				cPopupBox.style.opacity = 1;
				clearInterval(cPopupInterval);
			}else {
				cPopupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				cPopupBox.style.opacity = scaleX;
			}
		}
	}, 30);
	
	cPopupBox.style.marginLeft = (-1 * cPopupBox.offsetWidth / 2) + "px";
	if (cPopupBox.offsetHeight < 300)
		cPopupBox.style.marginTop = ((-1 * cPopupBox.offsetHeight / 2) - 50) + "px";
	else
		cPopupBox.style.marginTop = (-1 * cPopupBox.offsetHeight / 2) + "px";
	
	document.getElementById("c-yes-button").onclick = onTrueCallBack;
	document.getElementById("c-no-button").onclick = onFalseCallBack;
	document.getElementById("c-close-button").onclick = onFalseCallBack;
}

function closeConfirmPopup() {
	document.body.style.overflow = "auto";
	document.getElementById("popup-layout-bg").style.visibility = "hidden";
	document.getElementById("c-popup-box").style.visibility = "hidden";
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = cPopupBox.style[prefixedCSS[i]];
		if (transform) {
			document.body.style.overflow = "hidden";
			document.getElementById("popup-layout-bg").style.visibility = "visible";
			document.getElementById("c-popup-box").style.visibility = "visible";
			break;
		}
	}
	popupInterval2 = setInterval(function () {
		var prefixedCSS = getPrefixedCSS("transform");
		for (var i=0; i<prefixedCSS.length; i++) {
			var transform = cPopupBox.style[prefixedCSS[i]];
			if (!transform) continue;
			
			var scales = transform.split(" ").join("").split("(")[1].split(")")[0].split(",");
			var scaleX = parseFloat(scales[0]) + (0 - parseFloat(scales[0])) * 0.5;
			var scaleY = parseFloat(scales[1]) + (0 - parseFloat(scales[1])) * 0.5;
			
			if (scaleX < 0.05 || scaleY < 0.05) {
				cPopupBox.style[prefixedCSS[i]] = "scale(0,0)";
				cPopupBox.style.opacity = 0;
				document.body.style.overflow = "auto";
				document.getElementById("popup-layout-bg").style.visibility = "hidden";
				document.getElementById("c-popup-box").style.visibility = "hidden";
				
				clearInterval(popupInterval2);
			}else {
				cPopupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				cPopupBox.style.opacity = scaleX;
			}
		}
	}, 30);
}
function openConfirmPopup2(title, header, content, bottomText, onTrueCallBack, onFalseCallBack) {
	cPopupBox = document.getElementById("c-popup-box2");
	var popupBg = document.getElementById("popup-layout-bg");
	
	document.body.style.overflow = "hidden";
	popupBg.style.visibility = "visible";
	
	cPopupBox.style.visibility = "visible";
	
	if (title) document.getElementById("c-popup-title2").innerHTML = String(title);
	if (header) document.getElementById("c-popup-header2").innerHTML = String(header);
	if (content) document.getElementById("c-popup-content2").innerHTML = String(content);
	if (bottomText) document.getElementById("c-popup-bottom-text2").innerHTML = String(bottomText);
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++)
		cPopupBox.style[prefixedCSS[i]] = "scale(0, 0)";
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = cPopupBox.style[prefixedCSS[i]];
		if (transform) {
			cPopupBox.style.opacity = 0;
			break;
		}
	}
	cPopupInterval = setInterval(function () {
		var prefixedCSS = getPrefixedCSS("transform");
		for (var i=0; i<prefixedCSS.length; i++) {
			var transform = cPopupBox.style[prefixedCSS[i]];
			if (!transform) continue;
			
			var scales = transform.split(" ").join("").split("(")[1].split(")")[0].split(",");
			var scaleX = parseFloat(scales[0]) + (1 - parseFloat(scales[0])) * 0.7;
			var scaleY = parseFloat(scales[1]) + (1 - parseFloat(scales[1])) * 0.7;
			
			if (scaleX > 0.95 || scaleY > 0.95) {
				cPopupBox.style[prefixedCSS[i]] = "scale(1,1)";
				cPopupBox.style.opacity = 1;
				clearInterval(cPopupInterval);
			}else {
				cPopupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				cPopupBox.style.opacity = scaleX;
			}
		}
	}, 30);
	
	cPopupBox.style.marginLeft = (-1 * cPopupBox.offsetWidth / 2) + "px";
	if (cPopupBox.offsetHeight < 300)
		cPopupBox.style.marginTop = ((-1 * cPopupBox.offsetHeight / 2) - 50) + "px";
	else
		cPopupBox.style.marginTop = (-1 * cPopupBox.offsetHeight / 2) + "px";
	
	document.getElementById("c-yes-button2").onclick = onTrueCallBack;
	document.getElementById("c-no-button2").onclick = onFalseCallBack;
	document.getElementById("c-close-button2").onclick = onFalseCallBack;
}

function closeConfirmPopup2() {
	document.body.style.overflow = "auto";
	document.getElementById("popup-layout-bg").style.visibility = "hidden";
	document.getElementById("c-popup-box2").style.visibility = "hidden";
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = cPopupBox.style[prefixedCSS[i]];
		if (transform) {
			document.body.style.overflow = "hidden";
			document.getElementById("popup-layout-bg").style.visibility = "visible";
			document.getElementById("c-popup-box2").style.visibility = "visible";
			break;
		}
	}
	popupInterval2 = setInterval(function () {
		var prefixedCSS = getPrefixedCSS("transform");
		for (var i=0; i<prefixedCSS.length; i++) {
			var transform = cPopupBox.style[prefixedCSS[i]];
			if (!transform) continue;
			
			var scales = transform.split(" ").join("").split("(")[1].split(")")[0].split(",");
			var scaleX = parseFloat(scales[0]) + (0 - parseFloat(scales[0])) * 0.5;
			var scaleY = parseFloat(scales[1]) + (0 - parseFloat(scales[1])) * 0.5;
			
			if (scaleX < 0.05 || scaleY < 0.05) {
				cPopupBox.style[prefixedCSS[i]] = "scale(0,0)";
				cPopupBox.style.opacity = 0;
				document.body.style.overflow = "auto";
				document.getElementById("popup-layout-bg").style.visibility = "hidden";
				document.getElementById("c-popup-box2").style.visibility = "hidden";
				
				clearInterval(popupInterval2);
			}else {
				cPopupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				cPopupBox.style.opacity = scaleX;
			}
		}
	}, 30);
}
