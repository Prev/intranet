function openModifyPopup(id) {
	window.open('request.php?type=modify&id='+id, 'remotewindow', 'width=600, height=430');
}

function deleteAutoForm(id) {
	if (confirm("정말 자동외출을 삭제하시겠습니까?")) {
		location.replace("request_cgi_delete.php?id="+id);
	}
}