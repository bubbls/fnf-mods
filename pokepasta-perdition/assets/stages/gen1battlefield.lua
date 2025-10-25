local xx = 195;
local yy = 68;
local ofs = 0;
local followchars = true;

function onCreate()
	makeLuaSprite('barleft','',-260,-50)
	makeGraphic('barleft',400,900,'000000')
	addLuaSprite('barleft',true)
    setScrollFactor('barleft',0,0)
    setObjectCamera('barleft','ui')

	makeLuaSprite('barright','',1150,-50)
	makeGraphic('barright',400,900,'000000')
	addLuaSprite('barright',true)
    setScrollFactor('barright',0,0)
    setObjectCamera('barright','ui')
	
end

function onBeatHit()

end

function onUpdate()
	setProperty('gf.visible',false);
	setProperty('boyfriend.scale.x',2.0);
	setProperty('boyfriend.scale.y',2.0);
	if followchars == true then
        if mustHitSection == false then
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
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        end
    end
end