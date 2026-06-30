function onNoteCreation(e:NoteCreationEvent) {
    e.noteSprite = 'game/notes/arrows';
    e.noteScale = 1;
	trace("should work");
}

function onStrumCreation(event:StrumCreationEvent){
	event.sprite = "game/notes/arrows";
}

function onPostStrumCreation(e:StrumCreationEvent) {
    e.strum.scale.set(1, 1);
    e.strum.updateHitbox();
	e.strum.antialiasing = false;
}

function onPostNoteCreation(e) {
	e.note.antialiasing = false;
}