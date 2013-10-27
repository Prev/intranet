function selectCategory() {
	var selector = document.getElementById("category-selector");
	var boardId = document.getElementById("board-selector").value;
	var node;

	selector.innerHTML = "";

	node = document.createElement('option');
	node.value = "none";
	node.innerHTML = "말머리 선택";

	selector.appendChild(node);

	if (categorys[boardId]) {
		for (var i=0; i<categorys[boardId].length; i++) {
			node = document.createElement('option');
			node.value = categorys[boardId][i];
			node.innerHTML =categorys[boardId][i];

			if (selectedCategory && categorys[boardId][i] == selectedCategory)
				node.selected = true;

			selector.appendChild(node);
		}
	}

	if (document.forms.tx_editor_form.is_notice) {
		if (isBoardAdminPerBoards[boardId])
			document.forms.tx_editor_form.is_notice.disabled = false;
		else {
			document.forms.tx_editor_form.is_notice.disabled = true;
			document.forms.tx_editor_form.is_notice.checked = false;
		}
	}
}

selectCategory();