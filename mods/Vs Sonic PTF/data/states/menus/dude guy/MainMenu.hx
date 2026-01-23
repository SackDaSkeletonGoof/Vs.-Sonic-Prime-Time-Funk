import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;

var options:Array<String> = ['STORY MODE', 'FREEPLAY', 'OPTIONS', 'CREDITS'];
var menuItems:FlxTypedGroup<FunkinText>;

var curSelect:Int = 0;

function create() {
    add(bg = new FunkinSprite()).makeSolid(1, 1, FlxColor.fromRGB(240, 210, 55));
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.screenCenter();

    add(grid = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, FlxColor.TRANSPARENT, FlxColor.fromRGB(158, 138, 36)))).velocity.set(25, 0);

    add(cneText = new FunkinText(5, FlxG.height / 1.06, 720, "Codename Engine v1.0.1\nPress [TAB] to Switch Mods."));

    add(itemBG = new FunkinSprite(1030, 380)).makeSolid(1, 1, FlxColor.BLACK);
    itemBG.setGraphicSize(450, 530);

    add(menuItems = new FlxTypedGroup());
    for (i => options in options) {
        menuItems.add(menuItem = new FunkinText(500, 0, 720, options, 64, true));
        menuItem.borderSize = 3.5;
        menuItem.alignment = 'right';
        /** This specific line spreads out the options downwards, idk how to explain it properly.**/
        menuItem.y = 150 + ((menuItem.ID = i) * 135);
        menuItem.alpha = 0.5;
    }
    changeItem(0);
}

function update() {
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

    if (controls.UP_P || controls.DOWN_P) changeItem(controls.UP_P ? -1 : 1);
    if (controls.BACK) {
        FlxG.switchState(new TitleState());
    }
    if (controls.ACCEPT) {
        CoolUtil.playMenuSFX(1);
        new FlxTimer().start(1.5, function() selectItem());
    }
}

function changeItem(change:Int = 0) {
    curSelect = FlxMath.wrap(curSelect + change, 0, menuItems.length - 1);
    CoolUtil.playMenuSFX(0);
    
    menuItems.forEach(function(item:FunkinText) {
        if (item.ID == curSelect) {
            item.alpha = 1;
            item.x = 480;
        } else {
            item.alpha = 0.5;
            item.x = 500;
        }
    });
}

function selectItem() {
    switch(options[curSelect]) {
        case 'STORY MODE': FlxG.switchState(new StoryMenuState());
        case 'FREEPLAY': FlxG.switchState(new FreeplayState());
        case 'OPTIONS': FlxG.switchState(new OptionsMenu());
        case 'CREDITS': FlxG.switchState(new CreditsMain());
    }
}