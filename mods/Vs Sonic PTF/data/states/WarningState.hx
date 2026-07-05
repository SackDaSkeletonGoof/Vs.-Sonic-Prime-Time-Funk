import lime.app.Application;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;

var disclaimer:FunkinText;

var sega:FlxTimer;

var bleck:FlxSprite;

var logo:FlxSprite;

Framerate.fpsCounter.visible = true;
Framerate.memoryCounter.visible = true;
Framerate.codenameBuildField.visible = false;

function create(){
    FlxG.resizeWindow(960, 720);
    FlxG.width = 640;
    FlxG.height = 480;
    FlxG.scaleMode.width = 320;
    FlxG.scaleMode.height = 240;
    
    window.x = 450;
    window.y = 150;

    sega = new FlxTimer();
    window.title = "SONIC PC";
    bleck = new FlxSprite();
    bleck.makeSolid(1080 * 10, 1920 * 10, 0xFFFFFFFF);
    bleck.offset.set(0, 0);
    bleck.scrollFactor.set(0, 0);
    add(bleck);

    logo = new FlxSprite().loadGraphic(Paths.image('startup/sega'));
    logo.antialiasing = false;
    logo.scale.x = 0.5;
    logo.scale.y = 0.5;
    logo.alpha = 1;
    logo.screenCenter(FlxAxes.X);
    logo.screenCenter(FlxAxes.Y);
    add(logo);

    sega.start(1.0, () -> {FlxG.sound.play(Paths.sound('startUp'), 1); new FlxTimer().start(3.0, () -> FlxG.switchState(new MainMenuState()));});
}

function destroy() {
    window.x -= 160;
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
}


function postCreate(){
    titleAlphabet.y = disclaimer.y - 120;
    disclaimer.screenCenter();
    disclaimer.text = "";
}