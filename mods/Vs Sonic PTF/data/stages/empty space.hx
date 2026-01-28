import lime.app.Application;
import lime.graphics.Image;

var path = "stages/void/";
var test:FlxSprite;
var lx:FlxSprite;
var x:FlxSprite;
var exe:FlxSprite;
var noise:FlxSprite;

var pixel:CustomShader;

function onCountdown(event:CountdownEvent) event.cancelled = true;
/*
at step 836, beat 209, mesure 52 and time of 1:09.660 the stage and character change.
shion is the new character.
the floor gets added.

thats the plan. idk how to actually code it in with out external events.
reason why i mention this: its the only way to avoid that bug where if you press F5, everything gets fucked.
*/

function create(){
    remove(dad);
    remove(gf);
    remove(boyfriend);

    test = new FlxSprite(0,0);
    test.loadGraphic(Paths.image(path + "floor"));
    test.scale.x = 1;
    test.scale.y = 1;
    test.scrollFactor.set(0, 0);
    test.antialiasing = false;
    add(test);

    lx = new FlxSprite(0,0);
    lx.loadGraphic(Paths.image(path + "Lx"));
    lx.scale.x = 1;
    lx.scale.y = 1;
    lx.scrollFactor.set(0, 0);
    lx.antialiasing = false;
    add(lx);

    x = new FlxSprite(0,0);
    x.loadGraphic(Paths.image(path + "x"));
    x.scale.x = 1;
    x.scale.y = 1;
    x.scrollFactor.set(0, 0);
    x.antialiasing = false;
    add(x);

    exe = new FlxSprite(0,0);
    exe.loadGraphic(Paths.image(path + "exe"));
    exe.scale.x = 1;
    exe.scale.y = 1;
    exe.scrollFactor.set(0, 0);
    exe.antialiasing = false;
    add(exe);

    noise = new FlxSprite(-320,-560);
    noise.frames = Paths.getFrames(path + "stat");
    noise.animation.addByIndices('noise', 'sound', [0,1,2,3,4,5,6,7,8,9,10,12,13], "", 12, true);
    noise.scale.x = 2;
    noise.scale.y = 2;
    noise.cameras = [camHUD];
    noise.scrollFactor.set(0, 0);
    noise.antialiasing = false;
    noise.animation.play('noise');
    //boyPlace(100,10);

    //bf.screenCenter();
    boyfriend.scale.x = 0.6;
    boyfriend.scale.y = 0.6;

    add(boyfriend);
    add(noise);

    x.alpha = 0;
    exe.alpha = 0;
    lx.alpha = 0;
    noise.alpha = 0;
}

function beatHit(curBeat) {
    switch (curBeat) {
        case 133:
            FlxTween.tween(exe, {alpha: 1}, 2.5, {ease: FlxEase.quadInOut});
        case 141:
            FlxTween.tween(lx, {alpha: 1}, 2.5, {ease: FlxEase.quadInOut});
        case 149:
            FlxTween.tween(x, {alpha: 1}, 2.5, {ease: FlxEase.quadInOut});
        case 205:
            noise.alpha = 1;
            x.alpha = 0;
            exe.alpha = 0;
            lx.alpha = 0;
        case 209:
            noise.alpha = 0;
            boyPlace(270,175);
            test.x = -320;
            test.y = -230;
            boyfriend.scale.x = 1;
            boyfriend.scale.y = 1;
        case 401:
            black();
    }
}

function boyPlace(placeX:Float, placeY:Float){
    bf.x = placeX;
    bf.y = placeY;
}

function black(){
    bleck = new FlxSprite();
    bleck.makeSolid(1080 * 10, 1920 * 10, 0xFF000000);
    bleck.offset.set(0, 0);
    bleck.scrollFactor.set(0, 0);
    bleck.cameras = [camHUD];
    add(bleck);
    trace("yeah its dark here"); //this is for debug purposes
}

/*
function background(xPos:Float,yPos:Float){
    test = new FlxSprite(xPos,yPos);
    test.loadGraphic(Paths.image(path + "floor"));
    test.scale.x = 1;
    test.scale.y = 1;
    test.scrollFactor.set(0, 0);
    test.antialiasing = false;
    add(test);
}
*/
function postCreate(){
    FlxG.resizeWindow(1024, 768);
    FlxG.width = 1280;
    FlxG.height = 960;
    FlxG.scaleMode.width = 640;
    FlxG.scaleMode.height = 480;
    window.x = 450;
    window.y = 150;

    pixel = new CustomShader("pixel");
    pixel.blockSize = 1.5;
    pixel.res = [FlxG.width, FlxG.height];
    camGame.addShader(pixel);
    camHUD.addShader(pixel);
    window.title = "SONIC PC";
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
