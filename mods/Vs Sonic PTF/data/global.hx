import funkin.backend.utils.NativeAPI;

function update(elapsed) {
    if (FlxG.keys.justPressed.1)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();

    
}