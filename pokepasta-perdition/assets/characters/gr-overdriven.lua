
local canFloat = false;

function onUpdate()
    songPos = getSongPosition()
	local currentBeat = (songPos/5000)*(curBpm/60)
	if canFloat == true then
		doTweenY('float', 'dadGroup', -135 - 30*math.sin((currentBeat+12*12)*math.pi), 2)
	end
end

function onEvent( name, value1,value2)
    if name == 'Unleash RED' then
		canFloat = true;
	end
end
