function onCreate()
	makeAnimatedLuaSprite('static','gradientStatic',200,-255);
    setObjectOrder('static', 1)
	addAnimationByPrefix('static','idle','pixel',30,true);
	scaleObject('static',4,4);
    setProperty('static.antialiasing', false);
    setScrollFactor('static',0,0)
    addLuaSprite('static');

    if shadersEnabled == true and glitchEnabled == true then
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

function onUpdate(elapsed)
    if glitch == true then
        if shadersEnabled == true and glitchEnabled == true then
            setShaderFloat("temporaryShader", "time", getSongPosition() / (stepCrochet  * 16))
            setShaderFloat("temporaryShader", "prob", 1.75)
        end
    end
end

function onEvent(eventName,value1,value2)
    if eventName == 'Unleash RED' then
        glitch = true;
        doTweenAlpha('overdrivemode', 'static', 0, 0.75, 'sineOut')
    end
end
