package states.stages;

import states.stages.objects.*;
import objects.Character;

class PalletTown extends BaseStage
{
	var fblood:BGSprite;
	override function create()
	{
		var bg:FlxSprite = new FlxSprite(-300,-900);
		bg.makeGraphic(4000,4000, FlxColor.WHITE);
		add(bg);

		var mt:BGSprite = new BGSprite('stages/pallet town/mountains', 160, 175, 0.6, 0.6);
		mt.antialiasing = false;
		add(mt);

		var backhouse:BGSprite = new BGSprite('stages/pallet town/bg house',  200, 90, 0.8, 0.8);
		backhouse.antialiasing = false;
		add(backhouse);	

		var land:BGSprite = new BGSprite('stages/pallet town/houses', -275,-75,1,1);
		land.antialiasing = false;
		add(land);	

		fblood = new BGSprite('stages/pallet town/blood', 86, 109, 0.4, 0.4, ['floor blood'], true);
		fblood.antialiasing = false;
		add(fblood);

		var fghouse:BGSprite = new BGSprite('stages/pallet town/front house',  170, -15,1,1);
		fghouse.antialiasing = false;
		add(fghouse);	
	}

	override function eventPushed(event:objects.Note.EventNote)
	{
		switch(event.event)
		{
			case "Dadbattle Spotlight":

		}
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Dadbattle Spotlight":
				if(flValue1 == null) flValue1 = 0;
				var val:Int = Math.round(flValue1);
				switch(val)
				{

				}
		}
	}
}