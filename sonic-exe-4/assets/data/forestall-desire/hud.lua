function onCreatePost() 

noteTweenX('bfTween1', 4, 90, 0.01, 'linear'); noteTweenX('bfTween2', 5, 205, 0.01, 'linear'); 
noteTweenX('bfTween3', 6, 315, 0.01, 'linear'); 
noteTweenX('bfTween4', 7, 425, 0.01, 'linear'); 
noteTweenX('dadTween1', 0, 730, 0.01, 'linear'); 
noteTweenX('dadTween2', 1, 845, 0.01, 'linear'); 
noteTweenX('dadTween3', 2, 955, 0.01, 'linear'); 
noteTweenX('dadTween4', 3, 1065, 0.01, 'linear');

end

function onUpdatePost()

    P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') *        getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

    P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)

    setProperty('iconP1.x',P1Mult - 110)

    setProperty('iconP1.origin.x',240)

    setProperty('iconP1.flipX',true)

    setProperty('iconP2.x',P2Mult + 110)

    setProperty('iconP2.origin.x',-100)

    setProperty('iconP2.flipX',true)

    setProperty('healthBar.flipX',true)

end