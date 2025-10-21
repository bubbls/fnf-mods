trigger = 1
ongoing = false
function onCreate()
	setPropertyFromClass('GameOverSubstate', 'endSoundName', '')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', '')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'wind')
	setPropertyFromClass('GameOverSubstate', 'characterName', 'fredbear')
	makeLuaSprite('bg', 'stage/stage0/stage', 0, 0);
	setProperty('bg.antialiasing', false)
	addLuaSprite('bg', false);
	
	makeAnimatedLuaSprite('kid1', 'stage/stage0/kid', 355, 280);
	setProperty('kid1.antialiasing', false)
	addAnimationByPrefix('kid1', 'cheer', 'cheer', 30, true)
	objectPlayAnimation('kid1', 'cheer', true)
	addLuaSprite('kid1', false);
	
	makeAnimatedLuaSprite('kid2', 'stage/stage0/kid', 452, 280);
	setProperty('kid2.antialiasing', false)
	addAnimationByPrefix('kid2', 'cheer', 'cheer', 30, true)
	objectPlayAnimation('kid2', 'cheer', true)
	addLuaSprite('kid2', false);
end

function onGameOverStart()
	-- You died! Called every single frame your health is lower (or equal to) zero
	--return Function_Stop
	setScrollFactor(getPropertyFromClass('GameOverSubstate', 'boyfriend'), 0, 0)
	setPropertyFromClass('flixel.FlxG', 'camera.x', 0)
	setPropertyFromClass('flixel.FlxG', 'camera.y', 0)
	setPropertyFromClass('flixel.FlxG', 'camera.zoom', 1.2)
	setProperty('boyfriend.x', 0)
	setProperty('boyfriend.y', 0)
	setProperty('boyfriend.alpha', 0)
	doTweenAlpha('fadeIn', 'boyfriend', 1, 3, 'sineIn')
	--objectPlayAnimation('boyfriend', 'die', true)
	return Function_Continue;
end