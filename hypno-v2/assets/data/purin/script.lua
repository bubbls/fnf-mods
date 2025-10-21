function onCreate()
   setProperty('skipCountdown', true);
   triggerEvent('Turn Off Cam Follow', 'false');
end

--hi check out this eyesore of a code! i hope you have fun.
function onCreatePost()
   setProperty('camHUD.visible', false);

   characterPlayAnim('bf', 'idle-alt', true);
   
   triggerEvent('Alt Idle Animation', 'bf', '-alt');
   
   setProperty('boyfriend.danceEveryNumBeats', 16);
   
   makeAnimatedLuaSprite('picoAnim', 'purin/Full_pico_purin', getProperty('BF_X'), getProperty('BF_Y'));
   addAnimationByPrefix('picoAnim', 'turn', 'Pico Turn0', 24, false);
   addAnimationByPrefix('picoAnim', 'knife-out', 'Knife out0', 24, false);
   addAnimationByIndices('picoAnim', 'turn-reverse', 'Pico Turn0', '13,12,11,10,9,8,7,6,5,4,3,2,1,0', 24);
   addOffset('picoAnim', 'turn', 6, 18);
   addOffset('picoAnim', 'turn-reverse', 6, 18);
   addOffset('picoAnim', 'knife-out', 27, 0);
   addLuaSprite('picoAnim');
   
   makeAnimatedLuaSprite('jigglyAnim', 'purin/jigglyassets', 149, 585);
   addAnimationByPrefix('jigglyAnim', 'bleh', 'jigglyturn0', 0, false);
   addAnimationByPrefix('jigglyAnim', 'turn', 'jigglyturn0', 24, false);
   addAnimationByIndices('jigglyAnim', 'turn-reverse', 'jigglyturn0', '21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0', 24);
   addOffset('jigglyAnim', 'bleh', 17, 1);
   addOffset('jigglyAnim', 'turn', 17, 1);
   addOffset('jigglyAnim', 'turn-reverse', 17, 1);
   scaleObject('jigglyAnim', 0.45, 0.45);
   updateHitbox('jigglyAnim');
   addLuaSprite('jigglyAnim');
   
   setProperty('picoAnim.visible', false);
   setProperty('jigglyAnim.visible', false);
   setProperty('dad.visible', false);
   
   setProperty('gf.visible', false);
   
   setXY('boyfriend', 765, 367);
   setXY('dad', 40, 435);
   
   addCharacterToList('jigglypuff-stare', 'dad');
end

function onStartCountdown()
   triggerEvent('Camera Follow Pos', getMidpointX('stare'), getMidpointY('stare') - 110);

   return Function_Continue;
end

function onStepHit()
   if curStep == 55 then
      doTweenAlpha('staticFadeIn', 'static', 1, 0.6, 'quadInOut');
   elseif curStep == 64 then
      playAnim('picoAnim', 'turn', true, false);
	  
	  setProperty('picoAnim.visible', true);
	  setProperty('boyfriend.visible', false);
	  setProperty('stare.visible', true);
	  
      doTweenAlpha('staticFadeOut', 'static', 0, 0.6, 'quadInOut');
   elseif curStep == 80 then
      setProperty('camZooming', false);
      
      doTweenZoom('camGameZoomIn', 'camGame', 1, 24, 'cubeInOut');
   elseif curStep == 208 then
      doTweenAlpha('staticFadeIn', 'static', 1, 3, 'quadInOut');
      doTweenAlpha('staticHUDFadeIn', 'statichud', 1, 3, 'quadInOut');
   elseif curStep == 232 then
      setProperty('camHUD.visible', true);
   
      doTweenAlpha('staticHUDFadeOut', 'statichud', 0, 1, 'quadInOut'); 
      setProperty('static.visible', false);	 
      
	  setProperty('stare.visible', false);
      setProperty('dad.visible', true);
	  
	  cancelTween('camGameZoomIn');
	  doTweenZoom('normalZoom', 'camGame', defaultCamZoom, 0);
	  
      triggerEvent('Turn Off Cam Follow', 'true');
      triggerEvent('Camera Follow Pos', nil, nil);
	  
      setProperty('camZooming', true);
	  
      playAnim('picoAnim', 'turn-reverse', true);   
	  
	  hideStrums('boyfriend', false);
   elseif curStep == 364 then
      playAnim('picoAnim', 'knife-out', true);
	  
	  setProperty('picoAnim.visible', true);
	  setProperty('boyfriend.visible', false);
	  
      for i = 4, 7 do
	     noteTweenAlpha('note' .. i, i, 1, 0.38, 'quadInOut');
	  end
   elseif curStep == 368 then
      setProperty('boyfriend.danceEveryNumBeats', 2);
	  setProperty('picoAnim.visible', false);
	  setProperty('boyfriend.visible', true);
	  
	  triggerEvent('Alt Idle Animation', 'bf', '');
   elseif curStep == 1189 then
      setProperty('jigglyAnim.visible', true);
	  setProperty('dad.visible', false);
	  
	  playAnim('jigglyAnim', 'turn', true);
	  
	  doTweenAlpha('staticHUDFadeIn', 'statichud', 0.28, 0.8, 'cubeInOut');
	  doTweenZoom('camGameZoomInReverse', 'camGame', 2, 0.8, 'quadInOut');
	  
	  triggerEvent('Change Character', 'dad', 'jigglypuff-stare');
      setXY('dad', 17, 450);
	  setProperty('dad.visible', false);

      setXY('jigglyAnim', 24, 432);
   elseif curStep == 1200 then
      setProperty('dad.visible', true);
	  setProperty('jigglyAnim.visible', false);
   elseif curStep == 1444 then
      setProperty('dad.visible', false);
	  setProperty('jigglyAnim.visible', true);
     
      playAnim('jigglyAnim', 'turn-reverse', true);
	  
	  doTweenAlpha('staticHUDFadeIn', 'statichud', 0, 0.8, 'cubeInOut');
	  doTweenZoom('normalZoom', 'camGame', defaultCamZoom, 0);

      setXY('jigglyAnim', 24, 432);
   elseif curStep == 1456 then
      setProperty('jigglyAnim.visible', false);
	  setProperty('dad.visible', true);
   end
end

function setXY(tag, X, Y)
   setProperty(tag .. '.x', X);
   setProperty(tag .. '.y', Y);
end

--[[
function onSectionHit()
   if mustHitSection then
      setProperty('defaultCamZoom', 0.75);
   elseif not mustHitSection then
      setProperty('defaultCamZoom', 1);
   end
end
--]]

function hideStrums(character, both)
   local strums = {['boyfriend'] = 'playerStrums', ['dad'] = 'opponentStrums'}; --I'll be over using this so fucking much.
   
   if not both then
      for i = 0, 3 do
         setPropertyFromGroup(strums[character], i, 'alpha', 0);
      end
   else
      for i = 0, 3 do
	     setPropertyFromGroup('playerStrums', i, 'alpha', 0);
		 
	     setPropertyFromGroup('opponentStrums', i, 'alpha', 0);
	  end
   end
end

--[[STINKY INSTA KILL BLEHHHHHH
function noteMiss(id, direction, noteType, isSustainNote)
   if noteType == 'No Animation' then
      setHealth(0);
   end
end
--]]

function onUpdate() 
   if getProperty('jigglyAnim.animation.curAnim.finished') and getProperty('jigglyAnim.animation.curAnim.name') == 'turn' then
      triggerEvent('Change Character', 'dad', 'jigglypuff-stare');
	  
	  --debugPrint(getMidpointX('dad'), ' ' .. getMidpointY('dad'));

      setXY('dad', 17, 450);
   elseif getProperty('jigglyAnim.animation.curAnim.finished') and getProperty('jigglyAnim.animation.curAnim.name') == 'turn-reverse' then
      triggerEvent('Change Character', 'dad', 'jigglypuff');

      setXY('dad', 40, 435);
   elseif getProperty('picoAnim.animation.curAnim.finished') and getProperty('picoAnim.animation.curAnim.name') == 'turn-reverse' then   
      setProperty('picoAnim.visible', false);
	  
	  setProperty('boyfriend.visible', true);
   end
end
