//a
// import funkin.backend.scripting.MultiThreadedScript; // OpenGL hates threaded loading characters lmao
import funkin.game.Character;

var charactersMap:Map<String, Character> = [
    null => null, // because fuck hscript
];
function postCreate() {
    if (gf != null) charactersMap.set(gf.curCharacter, gf);
    if (dad != null) charactersMap.set(dad.curCharacter, dad);
    if (boyfriend != null) charactersMap.set(boyfriend.curCharacter, boyfriend);
    // 0 - Precache | 1 - StrumLine To Change | 2 - Character Index | 3 - Character Name | 4 - X Offset | 5 - Y Offset
	for (event in events) {
		if (event.name != 'Change Character' || event.params[0] == false) continue;

        var newCharName = event.params[3];
        if (charactersMap.exists(newCharName)) continue;

        var strumLineIdx = Std.parseInt(event.params[1]);
        var charIndex = Std.parseInt(event.params[2]);

        var strumLine = strumLines.members[strumLineIdx];
        var characterApplying = strumLine.characters[charIndex];
        
        var newChar = precacheCharacter(characterApplying, newCharName, strumLineIdx, {x: Std.parseFloat(event.params[4]), y: Std.parseFloat(event.params[5])});
        charactersMap.set(newCharName, newChar);
    }
}

function onEvent(e) {
    var event = e.event;
    if (event.name != "Change Character") return;
    var strumLineIdx = Std.parseInt(event.params[1]);
    var charIndex = Std.parseInt(event.params[2]);
    var newCharName = event.params[3];

    var strumLine = strumLines.members[strumLineIdx];
    var characterApplying = strumLine.characters[charIndex];

    var characterSetting = precacheCharacter(characterApplying, newCharName, strumLineIdx, {x: Std.parseFloat(event.params[4]), y: Std.parseFloat(event.params[5])});

    if (characterSetting == null || characterApplying == null) return;
    if (characterApplying.curCharacter == characterSetting.curCharacter) return;

    characterApplying.exists = characterApplying.active = characterApplying.visible = false;
    characterSetting.exists = characterSetting.active = characterSetting.visible = true;
    strumLine.characters[Std.parseInt(event.params[3])] = characterSetting;

}

function precacheCharacter(characterToApply:Character, newCharName:String, strumIDX:Int, ?offset) {
    if (charactersMap.exists(newCharName)) return charactersMap.get(newCharName);
    offset ??= {x: 0, y: 0};
    var newChar = new Character(0, 0, newCharName, characterToApply.isPlayer);
    PlayState.instance.stage.applyCharStuff(newChar, newCharName, strumIDX);
    newChar.updateHitbox();
    newChar.exists = newChar.active = newChar.visible = false;
    insert(members.indexOf(characterToApply), newChar);
    // cam stage offsets
    switch (strumIDX) {
        case 0:
            newChar.cameraOffset.x += stage?.characterPoses['dad']?.camxoffset;
            newChar.cameraOffset.y += stage?.characterPoses['dad']?.camyoffset;
        case 1:
            newChar.cameraOffset.x += stage?.characterPoses['boyfriend']?.camxoffset;
            newChar.cameraOffset.y += stage?.characterPoses['boyfriend']?.camyoffset;
        case 2:
            newChar.cameraOffset.x += stage?.characterPoses['girlfriend']?.camxoffset;
            newChar.cameraOffset.y += stage?.characterPoses['girlfriend']?.camyoffset;
    }
    
    // newChar.visible = false;
    // Rodney i only took this because I wanted to see what this actually did. I still don't know what it does.
    // try {
    //     trace("newChar.cameras: " + newChar.cameras);
    //     for (c in newChar.cameras) {
    //         newChar.drawComplex(c);
    //     }
    // }
    // catch(e:Dynamic) {
    //     trace('drawComplex didn\'t work this time for some reason');
    // }
    return newChar;
}