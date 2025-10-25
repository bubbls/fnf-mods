

-- now for the visual shit 
function onCreate()

end

function onBeatHit()
	if curBeat == 2 then
		--noteTweenAlpha('0', 4, playerStrums0, 5*crochet/1000,'quadInOut')
		--noteTweenAlpha('1', 5, playerStrums0, 5*crochet/1000,'quadInOut')
		--noteTweenAlpha('2', 6, playerStrums0, 5*crochet/1000,'quadInOut')
		--noteTweenAlpha('3', 7, playerStrums0, 5*crochet/1000,'quadInOut')
	end

end


function onSongStart()
    for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums',i,'visible',false)
		setPropertyFromGroup('opponentStrums',i,'y',130)
		setPropertyFromGroup('opponentStrums',i,'x',-9999)
	end
end

function onCreatePost()


--makes the Players notes middle scroll
	for i = 0, getProperty('playerStrums.length')-1 do
		setPropertyFromGroup('playerStrums',i,'x',410)
	end
	for i = 1, getProperty('playerStrums.length')-1 do
		setPropertyFromGroup('playerStrums',i,'x',530)
	end
	for i = 2, getProperty('playerStrums.length')-1 do
		setPropertyFromGroup('playerStrums',i,'x',650)
	end
	for i = 3, getProperty('playerStrums.length')-1 do
		setPropertyFromGroup('playerStrums',i,'x',770)
	end

end