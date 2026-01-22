import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import openfl.ui.Mouse;

import lime.app.Application;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;

var bingle:FlxSprite;

var hoveringOption:Array<String> = [0,0];
var menuOptions:FlxTypeGroup<FlxSprite>;
var optionList:Array<Array> = ["story_mode_text","options_text","freeplay_text","credits_text"];

function create(){
    bingle = new FlxSprite().loadGraphic(Paths.image('startup/sega'));
    bingle.antialiasing = false;
    bingle.alpha = 1;
    bingle.x = 0;
    bingle.y = 0;
    add(bingle);

    menuOptions = new FlxTypedGroup();
    add(menuOptions);

    for (i=>option in optionList)
    {
        var menuItem:FlxSprite;
        menuItem = new FlxSprite(0,0).loadGraphic(Paths.image('game/' + option));
        menuItem.ID = i;
        menuOptions.add(menuItem);
        menuItem.scale.set(1,1);
        menuItem.alpha = 1;
        menuItem.antialiasing = false;
    }

    menuOptions.members[0].setPosition(0,10);
    menuOptions.members[1].setPosition(0,10);
    menuOptions.members[2].setPosition(0,10);
    menuOptions.members[3].setPosition(0,10);

    trace(bingle.x + "this far in x");
    trace(bingle.y + "this far in y");
}

var somethingSelected:Bool = false;

function update(){
    //idk what to do here.

    if (controls.LEFT_P){
        hoveringOption[0] = hoveringOption[0] - 1;
        changeItem();

    }
}

function changeItem() {

	if (hoveringOption[0] == 2) hoveringOption[0] = 0;
	if (hoveringOption[0] == -1) hoveringOption[0] = 1;
	if (hoveringOption[1] == 2) hoveringOption[1] = 0;
	if (hoveringOption[1] == -1) hoveringOption[1] = 1;

	FlxG.sound.play(Paths.sound('menu/scroll'));

	if (hoveringOption[0] == 0 && hoveringOption[1] == 0){
		menuOptions.members[0].loadGraphic(Paths.image('game/' + optionList[0]));
	} else { 
		menuOptions.members[0].loadGraphic(Paths.image('game/' + optionList[0]));
	}

	if (hoveringOption[0] == 0 && hoveringOption[1] == 1){
		menuOptions.members[2].loadGraphic(Paths.image('game/' + optionList[2]));
	} else { 
		menuOptions.members[2].loadGraphic(Paths.image('game/' + optionList[2]));
	}

	if (hoveringOption[0] == 1 && hoveringOption[1] == 0){
		menuOptions.members[1].loadGraphic(Paths.image('game/' + optionList[1]));	
	} else { 
		menuOptions.members[1].loadGraphic(Paths.image('game/' + optionList[1]));
	}

	if (hoveringOption[0] == 1 && hoveringOption[1] == 1){
		menuOptions.members[3].loadGraphic(Paths.image('game/' + optionList[3]));
	} else { 
		menuOptions.members[3].loadGraphic(Paths.image('game/' + optionList[3]));
	}
}

function selectItem() {
	somethingSelected = true;
	FlxG.sound.play(Paths.sound('menu/confirm'));

	if (hoveringOption[0] == 0 && hoveringOption[1] == 0) FlxFlicker.flicker(menuOptions.members[0], 1.1, 0.05, false);
	if (hoveringOption[0] == 1 && hoveringOption[1] == 0) FlxFlicker.flicker(menuOptions.members[1], 1.1, 0.05, false);
	if (hoveringOption[0] == 0 && hoveringOption[1] == 1) FlxFlicker.flicker(menuOptions.members[2], 1.1, 0.05, false);
	if (hoveringOption[0] == 1 && hoveringOption[1] == 1) FlxFlicker.flicker(menuOptions.members[3], 1.1, 0.05, false);
	
	new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (hoveringOption[0] == 0 && hoveringOption[1] == 0) FlxG.switchState(new ModState("menus/primeStory"));
			if (hoveringOption[0] == 1 && hoveringOption[1] == 0) FlxG.switchState(new OptionsMenu());
			if (hoveringOption[0] == 0 && hoveringOption[1] == 1) FlxG.switchState(new ModState("customStates/menus/rewritenFree"));
			if (hoveringOption[0] == 1 && hoveringOption[1] == 1) FlxG.switchState(new ModState("menus/credits"));
	});
}

function postCreate(){
    FlxG.resizeWindow(1024, 768);
    FlxG.width = 1280;
    FlxG.height = 960;
    FlxG.scaleMode.width = 640;
    FlxG.scaleMode.height = 480;
    window.x = 450;
    window.y = 150;
}

function destroy() {
    window.x -= 160;
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
}