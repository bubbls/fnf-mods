local xx;
local yy;
local xx2 = 290;
local yy2 = 450;
local xx3 = 1600;
local yy3 = 450;
local ofs = 3;
local followchars = true;
local instakillOnMiss = false

function onCreate()
    if dadName == 'gr-overdriven' then
        xx = 355;
        yy = 410;
    else
        xx = 335;
        yy = 440;
    end
    setProperty('skipCountdown',true)

    makeAnimatedLuaSprite('glitchWarn','stages/glitched/glitchy warning',140, 100)
    addAnimationByPrefix('glitchWarn','warning','dont miss message',30,false);
    addLuaSprite('glitchWarn',true)
    scaleObject('glitchWarn', 4.0, 4.0);
    screenCenter("glitchWarn", 'xy')
    setProperty('glitchWarn.antialiasing',false)
    setObjectCamera('glitchWarn','hud');
    setProperty('glitchWarn.alpha', 0.0001)
    objectPlayAnimation('glitchWarn', 'warning', true)

    makeAnimatedLuaSprite('glitchswap','stages/glitched/swap warning',140, 100)
    addAnimationByPrefix('glitchswap','warning','swap',30,false);
    addLuaSprite('glitchswap',true)
    scaleObject('glitchswap', 4.0, 4.0);
    screenCenter("glitchswap", 'xy')
    setProperty('glitchswap.antialiasing',false)
    setObjectCamera('glitchswap','hud');
    setProperty('glitchswap.alpha', 0.0001)
    objectPlayAnimation('glitchswap', 'warning', true)

end




function onBeatHit()

-- 2nd phase transformation
    if curBeat == 324 then
        doTweenAlpha('uiAlphaShitz', 'camHUD', 0, 1.0, 'quadInOut')
        followchars = false;
    end

    if curBeat == 340 then
        doTweenZoom('screenZoom', 'camGame', 2.99, 4.0, 'quadIn');
        end
    if curBeat == 352 then
        setProperty('defaultCamZoom',3.03)
    end

    if curBeat == 356 then
        doTweenAlpha('uiAlphaShitz', 'camHUD', 1, 1.0, 'quadInOut')
        followchars = true;
    end

    if curBeat == 560 then
        setProperty('camGame.visible',false)
        setProperty('camHUD.visible',false)
    end
end

function onStepHit()
	if curStep % camSpeed == 0 then
		triggerEvent('Add Camera Zoom',0.015*camInt,-0.04*camInt)
	end

    if curStep == 1942 then
        triggerEvent("Screen Shake", '28,0.0015')
    end
end

function onEvent( name, value1,value2)
	if name == 'Camera Zoom Speed' then
		camSpeed = value1
		camInt = value2
	end

    if name == 'Glitchy Insta Kill' then
        triggerEvent("Screen Shake", '0.5,0.0015')
        if value1 == 'on' then
            if value2 == 'insta' then
                setProperty('instakillOnMiss', true)
                setProperty('glitchWarn.alpha', 1)
                objectPlayAnimation('glitchWarn', 'warning', true)
            elseif value2 == 'swap' then
                setProperty('glitchswap.alpha', 1.0)
                objectPlayAnimation('glitchswap', 'warning', true)
                runTimer('disappearswaptxt', 0.65)
                for i = 0, 3 do
                    if downscroll == true then
                        setPropertyFromGroup('playerStrums',i,'y',50)
                        setPropertyFromGroup("playerStrums",i,"direction",-90)
    
                    elseif downscroll == false then
                        setPropertyFromGroup('playerStrums',i,'y',570)
                        setPropertyFromGroup("playerStrums",i,"direction",-90)
                    end
                end
            end
            setProperty('healthBar.alpha', 0.0001);
            setProperty('healthBarBG.alpha', 0.0001);
            setProperty('iconP1.alpha', 0.0001);
            setProperty('iconP2.alpha', 0.0001);
            setProperty('scoreTxt.alpha', 0.0001);
        end
        if value1 == 'off' then
            if value2 == 'insta' then
                setProperty('glitchWarn.alpha', 0.0001)
                setProperty('instakillOnMiss', false)
                
            end 
            if value2 == 'swap' then
                for i = 0, 3 do
                    if downscroll == true then
                        setPropertyFromGroup('playerStrums',i,'y',570)
                        setPropertyFromGroup("playerStrums",i,"direction",90)
                        elseif downscroll == false then
                        setPropertyFromGroup('playerStrums',i,'y',50)
                        setPropertyFromGroup("playerStrums",i,"direction",90)
                    end

                end
                cancelTimer('disappearswaptxt')
                setProperty('glitchswap.alpha', 0.0001)
            end
            setProperty('healthBar.alpha', 1.0);
            setProperty('healthBarBG.alpha', 1.0);
            setProperty('iconP1.alpha', 1.0);
            setProperty('iconP2.alpha', 1.0);
            setProperty('scoreTxt.alpha', 1.0);
        end

	end

end

function onTimerCompleted(tag)
    if tag == 'disappearswaptxt' then
        setProperty('glitchswap.alpha', 0.0001)
    end
end

function onCreatePost()

    for i = 0, getProperty('opponentStrums.length')-1 do
		--setPropertyFromGroup('opponentStrums',i,'visible',false)
		setPropertyFromGroup('opponentStrums',i,'y',130)
		setPropertyFromGroup('opponentStrums',i,'x',-9999)
	end
end

function onUpdate()
	setProperty('gf.visible',false);
    if dadName == 'gr-overdriven' or dadName == 'gr-beyond' then
        xx = 355;
        yy = 400;
    else
        xx = 335;
        yy = 440;
    end
	if followchars == true then
        if mustHitSection == false then
			setProperty('defaultCamZoom',3.6)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
			setProperty('defaultCamZoom',3.25)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos',365,390)
    end
end


