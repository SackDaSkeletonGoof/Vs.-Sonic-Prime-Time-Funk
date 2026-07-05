import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import openfl.ui.Mouse;
import flixel.effects.FlxFlicker;
import funkin.backend.utils.ShaderResizeFix;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxTiledSprite;


import lime.app.Application;
import lime.graphics.Image;


var bingle:FlxSprite;
var test240:FlxBackdrop = null;
var sex:FlxSprite;

var pixel:CustomShader;
/*
I DID IT. ALL BY MYSELF [kinda] I AM SMART - Sack
*/
//var hoveringOption:Array<String> = [0,0];
var menuOptions:FlxTypedGroup<FlxSprite>;
var optionList:Array<Array> = ["SM","SQ","options","cred"];

var curSelect:Int = 0;

function create(){

    CoolUtil.playMenuSong();

    bingle = new FlxSprite().loadGraphic(Paths.image('gameicon/32'));
    bingle.antialiasing = false;
    bingle.alpha = 1;
    bingle.x = 85;
    bingle.scale.x = 1;
    bingle.scale.y = 1;

    test240 = new FlxBackdrop(Paths.image('game/menu/sky'));
    test240.antialiasing = false;
    test240.alpha = 1;
    test240.x = 400;
    test240.y = 50;
    test240.velocity.set(-40,-20);
    test240.scale.x = 1;
    test240.scale.y = 1;
    add(test240);

    sex = new FlxSprite().loadGraphic(Paths.image('game/menu/menu'));
    sex.antialiasing = false;
    sex.alpha = 1;
    sex.x = 89;
    sex.y = 16;
    sex.scale.x = 1;
    sex.scale.y = 1;
    add(sex);

    var xPo = 120;

    add(menuOptions = new FlxTypedGroup());
    for (i => optionList in optionList) {
        var menuItem:FlxSprite;
        //menuItem.ID = i;
        menuOptions.add(menuItem = new FlxSprite(0 , 0).loadGraphic(Paths.image('game/menu/' + optionList)));
        menuItem.scale.set(1,1);
        menuItem.x = xPo;
        menuItem.y = 64 + ((menuItem.ID = i) * 30);
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
    new FlxTimer().start(1, function() selectItem());
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
            bingle.y = 52 + curSelect * 30;
            add(bingle);
        } else {
            item.color = FlxColor.WHITE;
            add(bingle);
        }
    });
}

function selectItem() {
    switch(optionList[curSelect]) {
        case 'SM': FlxG.switchState(new StoryMenuState());
        case 'SQ': FlxG.switchState(new FreeplayState());
        case 'options': FlxG.switchState(new OptionsMenu());
        case 'cred': FlxG.switchState(new CreditsMain());
    }
}

function postCreate(){
    FlxG.camera.pixelPerfectRender = true;
    FlxG.resizeWindow(960, 720);
    FlxG.width = 640;
    FlxG.height = 480;
    FlxG.scaleMode.width = 320;
    FlxG.scaleMode.height = 240;
    
    window.x = 450;
    window.y = 150;

    /*
    *pixel = new CustomShader("pixel");
    *pixel.blockSize = 1;
    pixel.res = [FlxG.width, FlxG.height];
    
    FlxG.game.addShader(pixel);
    */
}

function destroy() {
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
}