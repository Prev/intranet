var mainBuildingSong;
var subBuildingSong;
var todayTitle;
var todayDateTime;
var prevBtn;
var nextBtn;
var yoil = ["일","월","화","수","목","금","토"];

window.addEventListener("load", function() {
	todayDateTime = selectedDate.getTime();
	mainBuildingSong = document.getElementById("main-building-song");
	subBuildingSong = document.getElementById("sub-building-song");
	todayTitle = document.getElementById("today-title");

	prevBtn = document.getElementById("prev-button");
	nextBtn = document.getElementById("next-button");

	if (getHash()) {
		var date = getHash();
		date = date.split("-");
		
		if (date.length == 3)
			selectedDate = new Date(date[0], date[1]-1, date[2]);
	}
	hashChangeHandler();
});

function openUploadPopup() {
	if (uploadable)
		openUploadPopup2();
	else
		openConfirmPopup("기상송 업로드 실패", "이미 신청된 내역이 있습니다. 신청한 기상송을 바꾸시겠습니까?", "", function () {
			closeConfirmPopup();
			openUploadPopup2();
		}, closeConfirmPopup);
}

function openUploadPopup2() {
	window.open(getUrl('morningSong', 'dispRequestSongPopup'), 'post', 'width=576, height=380, top=100, left=100');
}

function getHash() {
	if (location.hash == "#" || location.hash == "")
		return selectedDate.getFullYear() + "-" + (selectedDate.getMonth()+1) + "-" + selectedDate.getDate();
	if (location.hash.substr(0, 1) == "#")
		return location.hash.substr(1);
	else
		return location.hash;
}

function hashChangeHandler() {
	rawOutput = (jQuery.browser.msie && parseInt(jQuery.browser.version) <= 9);
	
	if (todayDateTime - 1000*60*60*24*6 >= selectedDate.getTime())
		prevBtn.style.visibility = "hidden";

	if (todayDateTime == selectedDate.getTime())
		nextBtn.style.visibility = "hidden";

	if (todayDateTime < selectedDate.getTime()) {
		alert("잘못된 값입니다");
		return;
	}

	if (lastPlayingIndex === 0 || lastPlayingIndex === 1) {
		lastPlayingIndex = null;
		audio.pause();

		if (nowPlayingButton)
			nowPlayingButton.className = nowPlayingButton.className.split(" playing").join("");
	}

	$.get(getUrl("morningSong", "getSelectedSongJson", "date="+getHash()+(rawOutput ? "&print_raw=1" : "")), function (data) {
		todayTitle.innerHTML = '<span id="date">' + selectedDate.getFullYear() + "." + (selectedDate.getMonth()+1) + "." + selectedDate.getDate() + "("+yoil[selectedDate.getDay()]+')</span><span id="hot-pink">' + (todayDateTime == selectedDate.getTime() ? "오늘의 기상송" : "기상송") + "</span>";
		
		if (data.bon) {
			mainBuildingSong.innerHTML = data.bon.song_name;
			musicLists[0] = data.bon.songUrl;
		}else {
			mainBuildingSong.innerHTML = "선정된 곡이 없습니다.";
			musicLists[0] = null;
		}

		if (data.hak) {
			subBuildingSong.innerHTML = data.hak.song_name;
			musicLists[1] = data.hak.songUrl;
		}else {
			subBuildingSong.innerHTML = "선정된 곡이 없습니다.";
			musicLists[1] = null;
		}
	});
}

if (document.all && (!document.documentMode || (document.documentMode && document.documentMode < 8))) {
	(function () {	
		var oldHref = location.href;
		setInterval(function() {
			var newHref = location.href;
			if (oldHref !== newHref) {
				hashChangeHandler();
				oldHref = newHref;
			}
		}, 50);
	})();
	// IE7 이하 hashchange 핸들링 수동 interval 처리
}
window.addEventListener("hashchange", hashChangeHandler);


function viewPrevSong() {
	selectedDate.setDate( selectedDate.getDate() - 1 );
	location.hash = "#" + selectedDate.getFullYear() + "-" + (selectedDate.getMonth()+1) + "-" + selectedDate.getDate();

	if (todayDateTime - 1000*60*60*24*6 >= selectedDate.getTime())
		prevBtn.style.visibility = "hidden";

	nextBtn.style.visibility = "visible";
}


function viewNextSong() {
	selectedDate.setDate( selectedDate.getDate() + 1 );
	location.hash = "#" + selectedDate.getFullYear() + "-" + (selectedDate.getMonth()+1) + "-" + selectedDate.getDate();

	if (todayDateTime <= selectedDate.getTime())
		nextBtn.style.visibility = "hidden";

	prevBtn.style.visibility = "visible";
}