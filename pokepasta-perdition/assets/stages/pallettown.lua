--steven camera offsets
local xx = 42;
local yy = 62;
--bf camera
local xx2 = 10;
local yy2 = 60;
--miki camera offsets
local xx3 = 42;
local yy3 = 0;

local ofs = 4;
local followchars = true;
local mikiTurn = true;

function onCreatePost()
    setProperty('gf.alpha', 0);
    setProperty('gf.y', getCharacterX('GF')- 200);
end
function onCreate()
    makeAnimatedLuaSprite('miki', 'stages/pallet town/mysteriousentity',getCharacterX('GF')+ 100, getCharacterY('GF') + 140, "sparrow");
    addAnimationByPrefix('miki', "fly1", "spawn", 12, false);
    addAnimationByPrefix('miki', "fly2", "fly2", 12, true);
    --setScrollFactor("miki", 0.6, 0.6)
    setProperty('miki.alpha', 0);
    setProperty('miki.antialiasing', false);
    addLuaSprite('miki',false)
    setObjectOrder('miki', getObjectOrder('miki') - 7);
    playAnim('miki', 'fly1', true, false)

    makeLuaSprite("mike", 'flashbacks/phantommike', 0, 0)
    setObjectCamera("mike","hud");
    setProperty("mike.visible",false);
    scaleObject("mike",0.36,0.36)
    screenCenter("mike", 'xy')
    addLuaSprite("mike")

    makeAnimatedLuaSprite('laugh', 'stages/pallet town/ha',getCharacterX('GF')+ 60, getCharacterY('GF') + 140, "sparrow")
    addAnimationByPrefix('laugh', "laugh", "idle", 24, false);
    setProperty('laugh.antialiasing', false); 
    setObjectOrder('laugh', getObjectOrder('miki') + 7);
    addLuaSprite('laugh',false)
    setProperty('laugh.alpha', 0);

    
    if shadersEnabled == true then
        initLuaShader("vignetteGlitch");
        makeLuaSprite("temporaryShader")
        setSpriteShader("temporaryShader", "vignetteGlitch")
        runHaxeCode([[
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        ]]); 
        setShaderFloat("temporaryShader", "vignetteIntensity", 0.5) 
    end
end

local glitch = false;

function onBeatHit()

    if getProperty('dad.animation.curAnim.name') == 'laugh' then
        cancelTimer('invistimer');
        setProperty('laugh.alpha', 1);
        playAnim('laugh', 'laugh');
        runTimer('invistimer', 0.6);
    end

    if songName == 'Strangled' then
        if curBeat == 410 then
            setProperty('miki.alpha', 1);
            playAnim('miki', 'fly1', true, false)
            runTimer('mikimovin', 0.4)
        end
        if curBeat == 422 then
            doTweenY('mikiarrive','gf',defaultGirlfriendY,0.75,'backout')
            setProperty('gf.alpha', 1);
            followchars = false;
            removeLuaSprite('miki', true)
            triggerEvent('Camera Follow Pos',xx3,yy3)
        end

        if curBeat == 424 then
            if shadersEnabled == true then
                glitch = true;
            end
        end

        if curBeat == 104 then
            setProperty("mike.visible",true);
        end

        if curBeat == 106 then
            setProperty("mike.visible",false);
        end
    
        if curBeat == 418 then
            doTweenX('mikimove1','miki',getCharacterX('GF') + 140,0.75)
            doTweenY('mikimove1y','miki',getCharacterY('GF') + 80,0.75)
            playAnim('miki', 'fly2', true, false)
        end    
    end
end

function onTimerCompleted(tag)
    if tag == 'mikimovin' then
        doTweenX('mikimove1','miki',getCharacterX('GF') + 20,0.75)
        doTweenY('mikimove1y','miki',getCharacterY('GF') + 130,0.75)
    end

    if tag == 'invistimer' then
        setProperty('laugh.alpha', 0);
    end
end 

function onUpdate(elapsed)

    if shadersEnabled == true then
        if glitch == true then
            setShaderFloat("temporaryShader", "time", getSongPosition() / (stepCrochet  * 16))
            setShaderFloat("temporaryShader", "prob", 1.75)
        end
    end

    for i = 0, getProperty('notes.length')-1 do
        --Check if the note is an Instakill Note
        if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then

            if getPropertyFromGroup('notes', i, 'mustPress') then
                if getPropertyFromGroup('notes', i, 'strumTime') <= getSongPosition() then --Doesn't let Dad/Opponent notes get ignored
                    nd = getPropertyFromGroup('notes', i, 'noteData')
                    triggerEvent('dad2sing',nd,'')
                    --objectPlayAnimation('secondDad',nd,true)
                end
            end
        end
    end
	if followchars == true then
        
        if getProperty('gf.animation.curAnim.name') == 'idle' then
            mikiTurn = false;
        end

        if mustHitSection == false and not mikiTurn then
			setProperty('defaultCamZoom',4.20)
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
        elseif mustHitSection == true and not mikiTurn then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				setProperty('defaultCamZoom',3.44)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				setProperty('defaultCamZoom',3.46)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				setProperty('defaultCamZoom',3.45)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				setProperty('defaultCamZoom',3.45)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
				setProperty('defaultCamZoom',3.45)
            end
        end
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	followchars = true
	if noteType == 'Both Dads Sing' or noteType == 'GF Sing' then
		followchars = false
		triggerEvent('mikiSing',noteData,'')

	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if songName == 'Strangled' then
        if curBeat >= 442 then
            followchars = true
        end
    end
end

function onEvent( name, value1,value2)
	if name == "mikiSing" then
        mikiTurn = true
		if value1 == '0' then
            triggerEvent('Camera Follow Pos',xx3-ofs,yy3)
		end
		if value1 == '1' then
            triggerEvent('Camera Follow Pos',xx3,yy3+ofs)
		end
		if value1 == '2' then
            triggerEvent('Camera Follow Pos',xx3,yy3-ofs)
		end
		if value1 == '3' then
            triggerEvent('Camera Follow Pos',xx3+ofs,yy3)
		end
	end
end