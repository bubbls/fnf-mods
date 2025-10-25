package states.stages;

import states.stages.objects.*;
import flixel.addons.display.FlxTiledSprite;
import objects.Character;
import shaders.PinCushion;
import openfl.filters.ShaderFilter;
import openfl.display.Shader;
class CinnabarSystem extends BaseStage
{
    var glitchcity:FlxTiledSprite;
    var bg:BGSprite;
    var intendedColor:Int;
	var colorTween:FlxTween;
	override function create()
	{
        glitchcity = new FlxTiledSprite(Paths.image('stages/glitched/overdrivebg'), 1500, 1750, true, true);
        glitchcity.screenCenter(Y);
        glitchcity.x = -350;
        glitchcity.scrollFactor.set(0.90, 0.90);
        glitchcity.antialiasing = false;
        add(glitchcity);

		/*
        bg = new BGSprite('gradientStatic',-820,-445, 0, 0, ['pixel'], true);
		bg.antialiasing = false;
        bg.scale.set(10,10);
		add(bg);*/


		var spotlight:BGSprite = new BGSprite('stages/glitched/spotlight', 368, 447, 0.95, 0.95);
		spotlight.antialiasing = false;
		add(spotlight);
	}
    var colorLerp:Float = 12;
	override function update(elapsed:Float)
	{
        super.update(elapsed);
        var fakeElapsed:Float = CoolUtil.clamp(elapsed, 0, 1);
        if (fakeElapsed > 0) {
            glitchcity.scrollX += fakeElapsed / (0.05 / 60);

        }
	}

	override function sectionHit()
	{
        if(!PlayState.SONG.notes[curSection].mustHitSection){
            glitchcity.color = FlxColor.fromRGB(PlayState.opponentColors[0],PlayState.opponentColors[1],PlayState.opponentColors[2]);
        }else{
            glitchcity.color = FlxColor.fromRGB(PlayState.playerColors[0],PlayState.playerColors[1],PlayState.playerColors[2]);
        }
    }

	override function stepHit()
	{
		/*
		if (curStep == 1424){
            FlxTween.tween(bg, {alpha: 0}, 0.75, {ease: FlxEase.sineOut});
        }*/
	}

	override function eventPushed(event:objects.Note.EventNote)
	{
		switch(event.event)
		{
			case "Unleash RED":

		}
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Unleash RED":
				if(flValue1 == null) flValue1 = 0;
				var val:Int = Math.round(flValue1);
				switch(val)
				{

				}
		}
	}
}