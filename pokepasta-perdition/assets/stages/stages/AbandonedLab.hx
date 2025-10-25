package states.stages;

import states.stages.objects.*;
import objects.Character;

class PalletTown extends BaseStage
{
	override function create()
	{
		var backLab:BGSprite = new BGSprite('stages/lab/lab back', -77, -133, 0.94, 0.96);
		backLab.antialiasing = false;
		add(backLab);

        var frontLab:BGSprite = new BGSprite('stages/lab/lab front', -71, 0, 0.98, 0.98);
		frontLab.antialiasing = false;
		add(frontLab);
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