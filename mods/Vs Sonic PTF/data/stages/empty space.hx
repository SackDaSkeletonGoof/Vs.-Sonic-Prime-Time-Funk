import lime.app.Application;
import lime.graphics.Image;

/*
at step 836, beat 209, mesure 52 and time of 1:09.660 the stage and character change.
shion is the new character.
the floor gets added.

thats the plan. idk how to actually code it in with out external events.
reason why i mention this: its the only way to avoid that bug where if you press F5, everything gets fucked.
*/
function onCountdown(event:CountdownEvent) event.cancelled = true;


var path = "stages/void/";
var test:FlxSprite;



function boyPlace(placeX:Float, placeY:Float){
    bf.x = placeX;
    bf.y = placeY;
}

function background(){
    test = new FlxSprite(-440,-300);
    test.loadGraphic(Paths.image(path + "floor"));
    test.scale.x = 1;
    test.scale.y = 1;
    test.scrollFactor.set(0.4, 0.4);
    test.antialiasing = false;
    add(test);
}

function create(){
        
    remove(dad);
    remove(gf);

    //boyPlace(100,10);

    //bf.screenCenter();

}

function postCreate(){
    FlxG.resizeWindow(1024, 768);
    FlxG.width = 1280;
    FlxG.height = 960;
    FlxG.scaleMode.width = 640;
    FlxG.scaleMode.height = 480;
    window.x = 450;
    window.y = 150;

    for (i in [missesTxt, accuracyTxt, scoreTxt, healthBar,healthBarBG, iconP2, iconP1]) i.visible = false;
}


function destroy() {
    window.x -= 160;
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
}
