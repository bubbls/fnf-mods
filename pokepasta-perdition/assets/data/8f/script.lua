local speed = 0

function onCreatePost()
-- I will now make the healthbar DISAPPEAR
    if getProperty('healthBar', getProperty('healthBarBG')) then
        setProperty('healthBar.visible',false)
        setProperty('healthBarBG.visible',false)
    end
-- I will now make the icons DISAPPEAR
    if getProperty('iconP1', getProperty('iconP2')) then
        setProperty('iconP1.visible',false)
        setProperty('iconP2.visible',false)
    end
-- I will now make the score DISAPPEAR (because it doesn't matter it's an instakill song)
    if getProperty('scoreTxt') then
        setProperty('scoreTxt.visible',false)
    end

-- I will now make the timer DISAPPEAR
    if getProperty('timeBar', getProperty('timeBarBG', getProperty('timeTxt'))) then
        setProperty('timeBar.visible',false)
        setProperty('timeBarBG.visible',false)
        setProperty('timeTxt.visible',false)
    end

end

function onUpdate()
    
end

function noteMiss(i,d,t,s)
    if getProperty('health') > 0.1 then
		setProperty('health',getProperty('health')-1000.0)
	end
end