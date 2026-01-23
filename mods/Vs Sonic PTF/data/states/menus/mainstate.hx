import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import openfl.ui.Mouse;
import flixel.effects.FlxFlicker;
import funkin.backend.utils.ShaderResizeFix;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;

import lime.app.Application;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;

var bingle:FlxSprite;
var sex:FlxSprite;
/*
yo, if youre reading this. please help me make this shit look low res. im gonna fucking tweak dawg

please help me if you know how to. istg
*/
//var hoveringOption:Array<String> = [0,0];
var menuOptions:FlxTypedGroup<FlxSprite>;
var optionList:Array<Array> = ["story_mode_text","freeplay_text","options_text","credits_text"];

var curSelect:Int = 0;

function create(){

    bingle = new FlxSprite().loadGraphic(Paths.image('startup/sega'));
    bingle.antialiasing = false;
    bingle.alpha = 1;
    bingle.x = 0;
    bingle.y = 0;
    bingle.scale.x = 1;
    bingle.scale.y = 1;
    add(bingle);

    sex = new FlxSprite().loadGraphic(Paths.image('testing/unused files/sex'));
    sex.antialiasing = false;
    sex.alpha = 1;
    sex.x = 300;
    sex.y = 200;
    sex.angle = 45;
    sex.scale.x = 1;
    sex.scale.y = 1;
    add(sex);

    var xPo = -650;

    trace(bingle.x + "this far in x");
    trace(bingle.y + "this far in y");

    add(menuOptions = new FlxTypedGroup());
    for (i => optionList in optionList) {
        var menuItem:FlxSprite;
        //menuItem.ID = i;
        menuOptions.add(menuItem = new FlxSprite(-650,-300).loadGraphic(Paths.image('game/' + optionList)));
        menuItem.scale.set(0.25,0.25);
        menuItem.x = xPo;
        menuItem.y = -360 + ((menuItem.ID = i) * 40);
        menuItem.alpha = 1;
        menuItem.antialiasing = false;

        
        trace(menuItem.x + "here on x");
        trace(menuItem.y + "here on y");
    }
    changeItem(0);
}

//var somethingSelected:Bool = false;

function update(){
    //idk what to do here.
    if (Options.devMode) {
        if(controls.SWITCHMOD) {
            persistentUpdate = !(persistentDraw = true);
            openSubState(new ModSwitchMenu());
        }
    
        if(FlxG.keys.justPressed.SEVEN) {
            persistentUpdate = !(persistentDraw = true);
            openSubState(new EditorPicker());
        }
    }

    if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new TitleState());
	if (FlxG.keys.justPressed.EIGHT) FlxG.switchState(new MainMenuState());
	if (FlxG.keys.justPressed.SEVEN) openSubState(new EditorPicker());

    if (controls.UP_P || controls.DOWN_P) changeItem(controls.UP_P ? -1 : 1);
    if (controls.BACK) {
    FlxG.switchState(new TitleState());
    }
    if (controls.ACCEPT) {
    CoolUtil.playMenuSFX(1);
    new FlxTimer().start(0.5, function() selectItem());
    }
	#if MOD_SUPPORT
	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = false;
		persistentDraw = true;
	}
	#end
}

function changeItem(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, menuOptions.length - 1);
    CoolUtil.playMenuSFX(0);
    
    menuOptions.forEach(function(item:FlxSprite) {
        if (item.ID == curSelect) {
            item.color = FlxColor.RED;
            //item.x = 480;
        } else {
            item.color = FlxColor.WHITE;
            //item.x = 500;
        }
    });
}

function selectItem() {
    switch(optionList[curSelect]) {
        case 'story_mode_text': FlxG.switchState(new StoryMenuState());
        case 'freeplay_text': FlxG.switchState(new FreeplayState());
        case 'options_text': FlxG.switchState(new OptionsMenu());
        case 'credits_text': FlxG.switchState(new CreditsMain());
    }
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
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
}