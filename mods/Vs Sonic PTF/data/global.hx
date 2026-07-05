import funkin.backend.assets.ModsFolder;
import lime.graphics.Image;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.system.Main;
import openfl.system.Capabilities;
import lime.app.Application;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

function new(){
    window.title = "SONIC PC";  
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('gameicon/64'))));
}

static var initialized:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "menus/mainstate",
    FreeplayState => "menus/sidequest",
    StoryMenuState => "menus/sm",
    CreditsMain => "menus/credits",
    OptionsMenu => "menus/options",
];

function preStateSwitch() {

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

function destroy() {
    window.x -= 160;
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
}