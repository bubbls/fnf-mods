function onStepHit()
	if curStep % camSpeed == 0 then
		triggerEvent('Add Camera Zoom',0.015*camInt,0.03*camInt)
	end
end

function onEvent( name, value1,value2)
	if name == 'Camera Zoom Speed' then
		camSpeed = value1
		camInt = value2
	end
end

function onBeatHit()
	if curBeat>421 then
		if curBeat % 2 == 0 then
			triggerEvent("MissingNo Glitch", 'Glitching', 'on')
		end
	end
end