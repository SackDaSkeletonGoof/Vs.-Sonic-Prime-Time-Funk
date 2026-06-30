import flixel.addons.display.FlxBackdrop;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;

import funkin.menus.FreeplaySonglist;
import funkin.backend.system.Conductor;
import funkin.game.HealthIcon;
import funkin.savedata.FunkinSave;

var test240:FlxBackdrop = null;

var iconArray:Array<HealthIcon> = [];

var songList:FreeplaySonglist;

/*
yeah so like- this is FUNCTIONAL. but not really like- visually functional iykwim
there is no visual feedback so if you want to see what is where use F6 to open the console.
- sack

*/
//var curSelected:Int = 0;
var curSelect:Int = 0;
var canSelect:Bool = true;

var bingle:FlxSprite;



function create(){
	songList = FreeplaySonglist.get();
	songs = songList.songs;

	test240 = new FlxBackdrop(Paths.image('game/menu/sky'));
    test240.antialiasing = false;
    test240.alpha = 1;
    test240.x = 400;
    test240.y = 50;
    test240.velocity.set(-40,-20);
    test240.scale.x = 1;
    test240.scale.y = 1;
    add(test240);

    bingle = new FlxSprite().loadGraphic(Paths.image('gameicon/32'));
    bingle.antialiasing = false;
    bingle.alpha = 1;
    bingle.x = 85;
    bingle.scale.x = 1;
    bingle.scale.y = 1;


	grpSongs = new FlxTypedGroup<Alphabet>();
	add(grpSongs);

	for (i in 0...songs.length)
	{
		var songText = new FlxText(0,  (70 * i) + 60, FlxG.width, songs[i].displayName, 14, true);
		songText.setFormat("fonts/vcr.ttf", 20, FlxColor.WHITE, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].displayName, "bold");
		//songText.isMenuItem = true;
		//songText.targetY = -i;
		songText.scale.x = 1;
		songText.scale.y = 1;
		songText.x = 10;
		grpSongs.add(songText);

		var icon:HealthIcon = new HealthIcon(songs[i].icon);
		icon.sprTracker = songText;
		icon.antialiasing = false;
		icon.visible = false;
		if (Math.max(icon.width, icon.height) > 150) icon.setUnstretchedGraphicSize(150, 150);

		// using a FlxGroup is too much fuss!
		iconArray.push(icon);
		add(icon);

		// songText.x += 40;
		// DON'T PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		// songText.screenCenter(X);
	}


	changeItem(0);


	//this is the best i got so far.

    var textShit = new FlxText(0, 0, FlxG.width, "SIDE QUESTS!", 14, true);
	textShit.setFormat("fonts/vcr.ttf", 20, FlxColor.WHITE, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
	textShit.x = 80;
	textShit.y = 10;
	add(textShit);
}

function update(){
    if(FlxG.keys.justPressed.ESCAPE){
        FlxG.switchState(new MainMenuState());
    }

	trace(songList.songs[curSelect].name);

	if (controls.UP_P || controls.DOWN_P) changeItem(controls.UP_P ? -1 : 1);
    if (controls.ACCEPT) {
    CoolUtil.playMenuSFX(1);
    new FlxTimer().start(1, FlxG.switchState(new PlayState()));
	PlayState.loadSong(songList.songs[curSelect].name, "hard");
    }

	/*
    if(FlxG.keys.justPressed.ONE){
        FlxG.switchState(new PlayState());
    	PlayState.loadSong("New Friends To Play With", "hard");
    }

    if(FlxG.keys.justPressed.TWO){
        FlxG.switchState(new PlayState());
    	PlayState.loadSong("Saturn's Jam", "hard");
    }

    if(FlxG.keys.justPressed.THREE){
        FlxG.switchState(new PlayState());
    	PlayState.loadSong("Reminiscent", "hard");
    }
	*/

	//trace(songList);
}


function changeItem(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, songList.songs.length - 1);
    CoolUtil.playMenuSFX(0);
    
    grpSongs.forEach(function(item:FlxText) {
        if (item.ID == curSelect) {
            item.color = FlxColor.RED;
			trace(item.color);
			bingle.x += 20;
            add(bingle);
        } else {
            item.color = FlxColor.WHITE;
			add(bingle);
        }
    });
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

