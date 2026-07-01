import flixel.addons.display.FlxBackdrop;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;


var test240:FlxBackdrop = null;

function create(){
	test240 = new FlxBackdrop(Paths.image('game/menu/sky'));
    test240.antialiasing = false;
    test240.alpha = 1;
    test240.x = 400;
    test240.y = 50;
    test240.velocity.set(-40,-20);
    test240.scale.x = 1;
    test240.scale.y = 1;
    add(test240);

    
    var textShit = new FlxText(0, 0, FlxG.width, "STORY MODE!\nthere's nothing here yet.\n\npress ESC to go back\n to the MAIN MENU", 14, true);
	textShit.setFormat("fonts/vcr.ttf", 20, FlxColor.WHITE, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
	textShit.x = 0;
	textShit.y = 10;
	add(textShit);

}

function update(){
    if(FlxG.keys.justPressed.ESCAPE){
        FlxG.switchState(new MainMenuState());
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

}