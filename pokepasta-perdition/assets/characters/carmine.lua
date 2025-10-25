
local canFloat = false;

function onSongStart()
	canFloat = true;
end

function onUpdate()
	if canFloat == true then
		songPos = getSongPosition()
		local currentBeat = (songPos/5000)*(curBpm/60)
		doTweenY('float', 'dadGroup', -447 - 12*math.sin((currentBeat+12*12)*math.pi),1)
	end
end
