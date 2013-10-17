var selectingSongId;
var selectedForm;

function confirmSelectSong(songId, form) {
	selectingSongId = songId;
	selectedForm = form;

	openConfirmPopup("기숙사를 선택 해 주세요","<div style='margin-bottom:7px; font-size:13px'>선택한 곡을 <select id='dormitory-type'><option value='1'>본관</option><option value='2'>학봉관</option></select> 기상송으로 선정합니다.</div><div>선정시 해당 곡은 내일의 기상송으로 선택되며 오전 7시가 지나면 '오늘의 기상송으로 표시됩니다.</div>", "오전 7시 이전까지 선정을 철회하고 다시 선정 할 수 있습니다", selectSong, closeConfirmPopup);
}

function selectSong() {
	var dormitoryType = document.getElementById("dormitory-type").value;
	
	selectedForm.dormitory_type.value = dormitoryType;
	selectedForm.song_id.value = selectingSongId;
	selectedForm.submit();
}


function cancelSelectedSong(dormitoryType, form) {
	form.dormitory_type.value = dormitoryType;
	form.submit();
}