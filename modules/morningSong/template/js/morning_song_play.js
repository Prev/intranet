var musicDirUrl = getUrl() + "/files/attach/musics/";
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
		audio = new Audio(musicDirUrl + musicLists[index]);
		audio.loop = true;
	}
	
	nowPlayingButton = document.getElementById("play-button-" + index);
	nowPlayingButton.className += " playing";

	audio.play();
	lastPlayingIndex = index;
}