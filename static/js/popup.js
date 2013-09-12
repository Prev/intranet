var popupBox, popupInterval, popupInterval2;
var cPopupBox, cPopupInterval, cPopupInterval2;
var prefixes = ["webkit", "o", "moz"];
var popupLayoutBg;

function getPrefixedCSS(css) {
	var arr = [];
	for (var i=0; i<prefixes.length; i++) {
		var css2 = (prefixes[i] == "") ? css : css.substr(0, 1).toUpperCase() + css.substr(1, css.length - 1);
		arr[i] = prefixes[i] + css2;
	}
	return arr;
}

function showPopupLayoutBg() {
	if (!popupLayoutBg) {
		popupLayoutBg = document.createElement("div");
		popupLayoutBg.id = "popup-layout-bg";

		document.body.appendChild(popupLayoutBg);
	}

	popupLayoutBg.style.visibility = "visible";
	document.body.style.overflow = "hidden";
}

function hidePopupLayoutBg() {
	if (popupLayoutBg)
		popupLayoutBg.style.visibility = "hidden";

	document.body.style.overflow = "auto";
}

function openPopup(title, content, bottomText, callBack, styles) {
	if (popupBox)
		document.body.removeChild(popupBox);

	popupBox = document.createElement("div");
	popupBox.id = "popup-box";
	popupBox.className = "popup-box";
	popupBox.innerHTML = 
	'<div id="popup-title-bar" class="popup-title-bar">' +
		'<div id="popup-title" class="popup-title">'+(title ? title : '')+'</div>' +
		'<button id="close-button" class="close-button">X</button>' +
	'</div>' +
	'<div id="popup-content" class="popup-content">'+(content ? content : '')+'</div>' +
	'<div id="popup-bottom-bar" class="popup-bottom-bar">' +
		'<div id="popup-bottom-text" class="popup-bottom-text">'+(bottomText ? bottomText : '')+'</div>' +
		'<button id="ok-button">확인</button>' +
	'</div>';
	popupBox.style.visibility = "visible";

	if (styles) {
		for (var i in styles) {
			popupBox.style[i] = styles[i];
		}
	}
	document.body.appendChild(popupBox);

	showPopupLayoutBg();
	
	
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
	
	var inHeight = window.innerHeight || document.documentElement.clientHeight;
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
	
	if (callBack) {
		document.getElementById("ok-button").onclick = callBack;
		document.getElementById("close-button").onclick = callBack;
	}else {
		document.getElementById("ok-button").onclick = closePopup;
		document.getElementById("close-button").onclick = closePopup;
	}

	window.addEventListener("keydown", keyClosePopupHandler);
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
	if (!popupBox) return;

	hidePopupLayoutBg();
	popupBox.style.visibility = "hidden";
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = popupBox.style[prefixedCSS[i]];
		if (transform) {
			showPopupLayoutBg();
			popupBox.style.visibility = "visible";
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
				hidePopupLayoutBg();
				popupBox.style.visibility = "hidden";
				
				clearInterval(popupInterval2);
			}else {
				popupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				popupBox.style.opacity = scaleX;
			}
		}
	}, 30);
}

function openConfirmPopup(title, content, bottomText, onTrueCallBack, onFalseCallBack, styles, header) {
	if (cPopupBox)
		document.body.removeChild(cPopupBox);

	cPopupBox = document.createElement("div");
	cPopupBox.id = "c-popup-box";
	cPopupBox.className = "popup-box";
	cPopupBox.innerHTML = 
	'<div id="c-popup-title-bar" class="popup-title-bar">' +
		'<div id="c-popup-title" class="popup-title">'+(title ? title : '')+'</div>' +
		'<button id="c-close-button" class="close-button">X</button>' +
	'</div>' +
	(header ? '<div id="c-popup-header" class="popup-bottom-bar">'+header+'</div>' : '') +
	'<div id="c-popup-content" class="popup-content">'+(content ? content : '')+'</div>' +
	'<div id="c-popup-bottom-bar" class="popup-bottom-bar">' +
		'<div id="c-popup-bottom-text" class="popup-bottom-text">'+(bottomText ? bottomText : '')+'</div>' +
		'<div class="popup-btn-container">' +
			'<button id="c-yes-button">예</button>' +
			'<button id="c-no-button">아니요</button>' +
		'</div>' +
	'</div>';
	
	cPopupBox.style.visibility = "visible";
	
	if (styles) {
		for (var i in styles) {
			popupBox.style[i] = styles[i];
		}
	}

	document.body.appendChild(cPopupBox);

	showPopupLayoutBg();

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
	if (!cPopupBox) return;

	hidePopupLayoutBg();
	cPopupBox.style.visibility = "hidden";
	
	var prefixedCSS = getPrefixedCSS("transform");
	for (var i=0; i<prefixedCSS.length; i++) {
		var transform = cPopupBox.style[prefixedCSS[i]];
		if (transform) {
			showPopupLayoutBg();
			cPopupBox.style.visibility = "visible";
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
				hidePopupLayoutBg();
				cPopupBox.style.visibility = "hidden";
				
				clearInterval(popupInterval2);
			}else {
				cPopupBox.style[prefixedCSS[i]] = "scale("+scaleX+","+scaleY+")";
				cPopupBox.style.opacity = scaleX;
			}
		}
	}, 30);
}