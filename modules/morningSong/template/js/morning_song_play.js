var musicDirUrl = getUrl() + "files/attach/musics/";
var nowPlayingButton;
var audio;
var lastPlayingIndex;

function togglePlayMusic(index) {
	if (nowPlayingButton)
		nowPlayingButton.className = nowPlayingButton.className.split(" playing").join("");

	if (lastPlayingIndex == index) {
		audio.pause();
		lastPlayingIndex = null;
		return;
	}

	if (audio && lastPlayingIndex != null)
		audio.pause();

	if (!musicLists[index])
		return;

	if (!audio || audio.src != musicDirUrl + musicLists[index]) {
		if (typeof Audio == "undefined") {
			alert("IE8 이하에서는 재생 기능을 지원하지 않습니다.");
			return;
		}
		audio = new Audio(musicDirUrl + musicLists[index]);
		audio.loop = true;
	}
	
	nowPlayingButton = document.getElementById("play-button-" + index);
	nowPlayingButton.className += " playing";

	audio.play();
	lastPlayingIndex = index;
}