import funkin.backend.assets.ModsFolder;
import lime.graphics.Image;
import sys.io.File;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.system.Main;
import openfl.system.Capabilities;
import lime.app.Application;

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

function new(){
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('gameicon/16'))));
}

static var initialized:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "menus/mainstate",
    //TitleState => "customStates/menus/rewritenTitle",
];

function preStateSwitch() {
    window.title = "SONIC PC";

    trace("it be doing something");
    FlxG.camera.bgColor = 0xFF000000;

	if (!initialized){
		initialized = true;
		FlxG.game._requestedState = new ModState("WarningState");
    }else 
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}