function onCountdown(event:CountdownEvent) event.cancelled = true;

FlxG.scaleMode.width = 640;
FlxG.scaleMode.height = 480;

var path = "stages/void/";
var test:FlxSprite;



function boyPlace(placeX:Float, placeY:Float){
    bf.x = placeX;
    bf.y = placeY;
}

function background(){
    test = new FlxSprite(-350,-290);
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

    bf.x = gf.x;
    bf.y = gf.y;

    //bf.screenCenter();

}

function postCreate(){
    for (i in [missesTxt, accuracyTxt, scoreTxt, healthBar,healthBarBG, iconP2, iconP1]) i.visible = false;
}