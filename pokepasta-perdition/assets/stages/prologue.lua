--steven camera offsets
local xx = 350;
local yy = 425;
--bf camera
local xx2 = 350;
local yy2 = 425;
local ofs = 7;
local missingAlpha = 0;
local followchars = true;
local noteAppear = false;

function onSongStart()
    for i = 0, getProperty('opponentStrums.length') - 1 do
        setPropertyFromGroup('opponentStrums', i, 'visible', false)
        setPropertyFromGroup('opponentStrums', i, 'y', 130)
        setPropertyFromGroup('opponentStrums', i, 'x', -9999)
    end

    if songName == 'Prologue' then
        for i = 0, getProperty('playerStrums.length') - 1 do
            setPropertyFromGroup('playerStrums', i, 'alpha', 0)
        end
    end
end

function onCreate()
    setProperty('cornerMark.visible', false);
    setProperty('dadGroup.visible', false);
    setProperty('skipCountdown', true);

    makeLuaSprite('pokeball', 'stages/biggerpokeball', defaultBoyfriendX + 150, defaultBoyfriendY + 125)
    setProperty('pokeball.alpha', 0);
    setProperty('pokeball.angle', getRandomInt(-75, -45));
    setProperty('pokeball.antialiasing', false);
    addLuaSprite('pokeball', false)

    makeLuaSprite("white", 'hud', 0, 0)
    makeGraphic("white", 1280, 720, 'ffffff')
    addLuaSprite("white", true)

    makeAnimatedLuaSprite('MISSINGSCREEN', 'stages/prologue/missingno', 0, 0)
    addAnimationByPrefix("MISSINGSCREEN", "static", "static", 24, true)
    playAnim("MISSINGSCREEN", "static", true, false, 0)
    scaleObject('MISSINGSCREEN', 1, 1)
    setProperty('MISSINGSCREEN.alpha', 0);
    screenCenter('MISSINGSCREEN', 'XY')
    setObjectCamera('MISSINGSCREEN', 'ui')
    setObjectOrder('MISSINGSCREEN', getObjectOrder('MISSINGSCREEN') - 2)
    setScrollFactor('MISSINGSCREEN', 0, 0);
    addLuaSprite('MISSINGSCREEN', false)

    makeAnimatedLuaSprite("missingenergy", 'stages/prologue/missingenergy', 0, 0, "sparrow")
    addAnimationByPrefix("missingenergy", "idle", "idle", 12, true)
    playAnim("missingenergy", "idle", true);
    scaleObject('missingenergy', 5, 5)
    setProperty('missingenergy.antialiasing', false)
    setProperty('missingenergy.alpha', 0);
    screenCenter('missingenergy', 'XY')
    setObjectCamera('missingenergy', 'ui')
    setScrollFactor('missingenergy', 0, 0);
    addLuaSprite('missingenergy', true)

    makeLuaSprite("s!", 'stages/prologue/idle', 0, 0)
    scaleObject('s!', 5, 5)
    setProperty('s!.antialiasing', false)
    setProperty('s!.alpha', 0);
    screenCenter('s!', 'XY')
    setObjectCamera('s!', 'ui')
    setScrollFactor('s!', 0, 0);
    addLuaSprite('s!', true)

    makeLuaText('message', 'In a world that cheated me...', 0, 0, 575)
    addLuaText('message')
    setTextSize("message", 16)
    setTextBorder("message", 2, "000000")
    screenCenter('message', 'X')
    setProperty('message.alpha', 0);
    setTextAlignment("message", 'center')

    makeLuaSprite("stare", 'stages/prologue/stare', 0, 0)
    scaleObject('stare', 5, 5)
    setProperty('stare.antialiasing', false)
    setProperty('stare.alpha', 0);
    screenCenter('stare', 'XY')
    setObjectCamera('stare', 'ui')
    setScrollFactor('stare', 0, 0);
    addLuaSprite('stare', true)

    makeLuaSprite("eye", 'stages/prologue/eye', 0, 0)
    scaleObject('eye', 5, 5)
    setProperty('eye.antialiasing', false)
    setProperty('eye.alpha', 0);
    screenCenter('eye', 'XY')
    setObjectCamera('eye', 'ui')
    setScrollFactor('eye', 0, 0);
    addLuaSprite('eye', true)

    makeLuaSprite("close", 'stages/prologue/close', 0, 0)
    scaleObject('close', 5, 5)
    setProperty('close.antialiasing', false)
    setProperty('close.alpha', 0);
    screenCenter('close', 'XY')
    setObjectCamera('close', 'ui')
    setScrollFactor('close', 0, 0);
    addLuaSprite('close', true)


end

local canEndSong = false;

function onEndSong()
    if canEndSong then
        return Function_Continue;
    else
        setProperty('message.alpha', 1);
        setProperty('s!.alpha', 1);
        runTimer('endidle', 4.63)

        runTimer('powersec', 6)

        runTimer('endsong', 25.26);
        playSound('jumpscare/steven', 1, 'steveno')

        cameraShake('camUI', 0.001, 25)
        if shadersEnabled == true and chromaEnabled == true then
            initLuaShader("camEffects");
            makeLuaSprite("temporaryShader")
            setSpriteShader("temporaryShader", "camEffects")
            runHaxeCode([[
                game.camUI.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
            ]]);
        end
        return Function_Stop;
    end
end

function onTimerCompleted(tag)
    if tag == 'endidle' then
        setProperty('message.alpha', 0);
        setProperty('s!.alpha', 0);
        if shadersEnabled == true and chromaEnabled == true then
            setShaderFloat("temporaryShader", "distort", 2.0)
        end
        setProperty('camUI.zoom', 1.50);
    end

    if tag == 'powersec' then
        setProperty('message.alpha', 1);
        setTextString("message", "Why should I play fair.");
        screenCenter('message', 'X');
        doTweenAlpha("whitestuff", "missingenergy", 1, 0.35, 'sinein');
        setProperty('stare.alpha', 1);
        doTweenZoom('zoomout', 'camUI', 1.30, 0.35, 'sineout');
    end

    if tag == 'endsong' then
        canEndSong = true;
        endSong();
    end
end

function onCreatePost()
    setProperty('scoreTxt.visible', false);
    setProperty('centerMark.visible', false);
    setProperty('healthBar.visible', false);
    setProperty('iconP1.visible', false);
    setProperty('iconP2.visible', false);

end

function onStepHit()
    if curStep == 8 then
        doTweenAlpha('whitedisappear', 'white', 0, 3, 'sinein')
    end

    if songName == 'Prologue' then
        if curStep == 32 then
            noteAppear = true;
            noteTweenAlpha("notefade1", 4, 1, 15.0, "cubeinout")
            noteTweenAlpha("notefade2", 5, 1, 15.0, "cubeinout")
            noteTweenAlpha("notefade3", 6, 1, 15.0, "cubeinout")
            noteTweenAlpha("notefade4", 7, 1, 15.0, "cubeinout")
        end

        if curStep == 352 then
            followchars = false;
            triggerEvent('Camera Follow Pos', 350, 125);
        end

        if curStep == 360 then
            setProperty('pokeball.alpha', 1);
            doTweenY('throwpokeball', 'pokeball', defaultBoyfriendY - 175, 1, 'cubeout')
            doTweenAngle('spinball', 'pokeball', getRandomInt(90, 180), 1, 'sinein')
            playSound('pokeballthrow', 1, 'missingthrow')
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'throwpokeball' then
        setProperty('camGame.visible', false)
        setProperty('MISSINGSCREEN.alpha', 1);
        doTweenAlpha('missingappear', 'MISSINGSCREEN', 0, 4, 'cubeout')
        for i = 0, getProperty('playerStrums.length') - 1 do
            setPropertyFromGroup('playerStrums', i, 'visible', false)
        end
        playSound('jumpscare/missingno', 1, 'scream')
    end

    if tag == 'zoomout' then
        doTweenZoom('zoomslow1', 'camUI', 1.20, 5.59, 'sineout')
    end

    if tag == 'zoomslow1' then
        doTweenAlpha('fadefullsteven', 'stare', 0, 1.1, 'cubeIn')
        doTweenAlpha('fadeeye', 'eye', 1, 1, 'cubeIn')
        setProperty('message.alpha', 0);
        doTweenZoom('zoomslow2', 'camUI', 1.10, 5.54, 'sineout')
    end

    if tag == 'zoomslow2' then
        doTweenAlpha('fadeouteye', 'eye', 0, 1.1, 'cubeIn')
        doTweenAlpha('fadeclose', 'close', 1, 1, 'cubeIn')
        doTweenZoom('zoomslow3', 'camUI', 1.0, 5.07, 'sineout')
    end

    if tag == 'zoomslow3' then
        setProperty('missingenergy.alpha', 0);
        setProperty('close.alpha', 0);
        --removeSpriteShader('temporaryShader');
    end
end

function onUpdate()

    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos', xx - ofs, yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos', xx + ofs, yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos', xx, yy - ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos', xx, yy + ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos', xx, yy)
            end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos', xx2 - ofs, yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos', xx2 + ofs, yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos', xx2, yy2 - ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos', xx2, yy2 + ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos', xx2, yy2)
            end
        end
    end
end
