-- ghost camera offsets
local xx = 267;
local yy = 47;
-- old man red camera offsets
local xx2 = 178;
local yy2 = 46;

local ofs = 7;
local followchars = true;

local isSmoking = false;

function onStepHit()
    if curStep == 128 then
        cameraFlash('hud', 'ffffff',1,true);
    end
end

function onCreate()

    makeLuaSprite("blackbg", '', 0, 0)
    makeGraphic("blackbg", screenWidth, screenHeight, '000000')
    addLuaSprite("blackbg")
    setObjectCamera("blackbg",'ui')

    makeLuaSprite("screamer", 'jumpscares/ghostmine', (640 / 2), 30)
    --screenCenter("screamer", 'xy')
    addLuaSprite("screamer", false)
    setObjectCamera("screamer",'ui')
    scaleLuaSprite("screamer", 0.30, 0.30)

    setProperty('blackbg.visible', false)
    setProperty('screamer.visible', false)

end 

local canEndSong = false;

local targetAlpha = 0.45;

function onEvent(eventName)
    if eventName == 'Ghost Smoke' then
        if isSmoking == false then
            noteTweenAlpha("fade1", 4, targetAlpha, 0.5)
            noteTweenAlpha("fade2", 5, targetAlpha, 0.5)
            noteTweenAlpha("fade3", 6, targetAlpha, 0.5)
            noteTweenAlpha("fade4", 7, targetAlpha, 0.5)
            isSmoking = true;
        else
            isSmoking = false;
            noteTweenAlpha("fadeout1", 4, 1, 1)
            noteTweenAlpha("fadeout2", 5, 1, 1)
            noteTweenAlpha("fadeout3", 6, 1, 1)
            noteTweenAlpha("fadeout4", 7, 1, 1)
        end
    end
end 

function onEndSong()

    playSound('jumpscare/redwood', 1, 'screaming')
    setProperty('camGame.visible', false)
    setProperty('camHUD.visible', false)
    runTimer('jump',14.25)
    setProperty('camUI.zoom', 1.10)

    if canEndSong then
        return Function_Continue;
    else
        return Function_Stop;
    end
end

function onTimerCompleted(tag)
    if tag == 'jump' then
        runTimer('endsong', 6.19)

        doTweenZoom('zoomin', 'camUI', 1.5, 1, 'cubeinout')

        cameraShake('ui', 0.002, 5.7)
        setProperty('blackbg.visible', true)
        setProperty('screamer.visible', true)
    end

    if tag == 'endsong' then
        canEndSong = true
        endSong()
    end
end

function lerp(a,b,t) return a * (1-t) + b * t end

function onUpdate()
	setScrollFactor('boyfriend', 1.2, 1.2);

	if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',3.1)

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
            setProperty('defaultCamZoom',3.3)

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
    end
end