import lime.app.Application;
import lime.graphics.Image;

function onCountdown(event:CountdownEvent) event.cancelled = true;

function create(){
    bf.alpha = 1;
}

function postCreate(){
    camHUD.pixelPerfectRender = true;
    camGame.pixelPerfectRender = true;
    FlxG.resizeWindow(960, 720);
    FlxG.width = 640;
    FlxG.height = 480;
    FlxG.scaleMode.width = 320;
    FlxG.scaleMode.height = 240;
    
    window.x = 450;
    window.y = 150;
    //for (i in [missesTxt, accuracyTxt, scoreTxt, healthBar,healthBarBG, iconP2, iconP1]) i.scale = 0.5;
}