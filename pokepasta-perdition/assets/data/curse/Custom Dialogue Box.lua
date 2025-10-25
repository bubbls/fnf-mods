--[[

- Custom Dialogue Script made by Super_Hugo

- Credit me if you use the script!



INSTRUCTIONS:

Just use the comments that I added in each variable lol

And for the 'dialogue' and 'characters' variables use/change the examples that I added

--]]

----------------------------------------------------OPTIONS----------------------------------------------------


---DIALOGUE TYPE AND STUFF---
local daDialogueType = ''					--'end' for a dialogue at the end of the song, anything else for normal dialogue

canSkip = true				--if the dialogue can be skipped with the skip key
skipKey = 'ESCAPE'		--the key that will be used if the dialogue can be skipped

doCutscene = true			--(only for normal textboxes) [if you want a video at the start of the dialogue disable this and add a video in the first page]

onlyOneTime = false			--make it so the dialogue only appears one time in the song even if you restart the song (only for normal textboxes)
onlyForStoryMode = false

BG = true			--if the textbox has a background

noAntialiasing = false		--change this if your textbox and characters are pixelated

textboxOpen = 'anim'			--change how the textbox appears at the start. 'fade' for fade in, 'anim' for animation, anything else for no animation

stopAtPunctuation = true		--make the text wait a little bit if a there's a punctuation mark



---TEXT---
txtPos = {100, 425, 1100}		--{x, y, textWidth}
textColor = ''
textBorderColor = '000000'
textBorderSize = 0

textHasShadow = false		--if you want the text to have a shadow (looks cooler)
shadowColor = '000000'
shadowDistanceX = 3
shadowDistanceY = 3

defaultTextFont = 'PKMN RBYGSC.ttf'
defaultTextSize = 32



---DIALOGUE SOUND---
clickSound = 'click'

music = 'breakfast'			--'' for no music (you can play music from the 'music' or 'sounds' folders) [you can also change these by using these variables in a dialogue]
musicLoops = true
musicVolume = 0.6

talkVolume = 0
clickVolume = 0.5



---add all your files here---		(they need to be in 'data/YOUR SONG/dialogue' folder) [make that folder if you don't have it]
characterFiles = {'carmine', 'redwood', 'empty'}		--add your character file names here

dialogueBoxes = {'normal', 'normal'}		--add the dialogue boxes here

dialogueName = {'dialogue'}		--add the dialogue name here (only one dialogue)



----------------------------------------------------CODE & STUFF----------------------------------------------------

--Don't edit anything from this point on

local finished = {start = false, _end = false}
local page = 1
local completeTxt = ''
local cutText = ''
local txtNum = 0

local inDialogue = false
local inVideo = false

local autoTimerThing = 0
local openAnimFinished = false
local currentMusic = ''

local characters = {}
local dialogueBox = {}
local dialogue = {}

function createTextboxStuff()

	makeLuaSprite('cursebg','dialogue/dialoguebg', 0,0);
	setObjectCamera('cursebg', 'other')
	setProperty('cursebg.scale.x', 3.5);
	setProperty('cursebg.scale.y', 3.5);
	setProperty('cursebg.alpha', 0.5)
	setProperty('cursebg.antialiasing', false)
	addLuaSprite('cursebg', true)

	makeLuaSprite('doofBG', '', -500, -300);
	luaSpriteMakeGraphic('doofBG', getPropertyFromClass('flixel.FlxG', 'width') * 2, getPropertyFromClass('flixel.FlxG', 'height') * 2, '000000')
	setProperty('doofBG.alpha', 0)
	setObjectCamera('doofBG', 'other')
	addLuaSprite('doofBG', true)


	for i = 1, #characters do

		makeAnimatedLuaSprite('portrait'..i, characters[i]["image"], characters[i]["position"][1], characters[i]["position"][2]);
		for ii = 1, #characters[i]["animations"] do
			addAnimationByPrefix('portrait'..i, characters[i]["animations"][ii]["name"], characters[i]["animations"][ii]["anim"], characters[i]["animations"][ii]["fps"], characters[i]["animations"][ii]["loops"])
		end
		setObjectCamera('portrait'..i, 'other')
		
		if not (characters[i]["scaleX"] == nil) then 
			setProperty('portrait'..i..'.scale.x', characters[i]["scaleX"])
			setProperty('portrait'..i..'.scale.y', characters[i]["scaleY"])
		else
			setProperty('portrait'..i..'.scale.x', characters[i]["scale"])
			setProperty('portrait'..i..'.scale.y', characters[i]["scale"])
		end
		
		updateHitbox('portrait'..i)
		setProperty('portrait'..i..'.alpha', 0)
		setProperty('portrait'..i..'.antialiasing', false)
		setProperty('portrait'..i..'.flipX', characters[i]["animations"][1]["flipX"])
		
		addLuaSprite('portrait'..i, true)

		if characters[i]["image"] == nil then
			setProperty('portrait'..i..'.visible', false)
		end

		objectPlayAnimation('portrait'..i, characters[i]["animations"][1]["name"], true)
		
		setProperty('portrait'..i..'.offset.x', characters[i]["animations"][1]["offsets"][1])
		setProperty('portrait'..i..'.offset.y', characters[i]["animations"][1]["offsets"][2])

	end


	for i = 1, #dialogueBox do
	
		if not (dialogueBox[i] == nil or dialogueBox[i] == {}) then

			dialogueBox[i]["hasAnims"] = false
			
			if not (dialogueBox[i]["animations"] == nil) and #dialogueBox[i]["animations"] > 0 then
				makeAnimatedLuaSprite('doof'..i, dialogueBox[i]["image"], dialogueBox[i]["position"][1], dialogueBox[i]["position"][2])
				dialogueBox[i]["hasAnims"] = true
			else
				makeLuaSprite('doof'..i, dialogueBox[i]["image"], dialogueBox[i]["position"][1], dialogueBox[i]["position"][2])
			end
			
			if dialogueBox[i]["hasAnims"] == true then
			
				for ii = 1, #dialogueBox[i]["animations"] do
					addAnimationByPrefix('doof'..i, dialogueBox[i]["animations"][ii]["name"], dialogueBox[i]["animations"][ii]["anim"], dialogueBox[i]["animations"][ii]["fps"], dialogueBox[i]["animations"][ii]["loops"])
				end
				
			end
			
			setObjectCamera('doof'..i, 'other')
			
			if not (dialogueBox[i]["scaleX"] == nil) then 
				setProperty('doof'..i..'.scale.x', dialogueBox[i]["scaleX"])
				setProperty('doof'..i..'.scale.y', dialogueBox[i]["scaleY"])
			else
				setProperty('doof'..i..'.scale.x', dialogueBox[i]["scale"])
				setProperty('doof'..i..'.scale.y', dialogueBox[i]["scale"])
			end

			updateHitbox('doof'..i)
			setProperty('doof'..i..'.alpha', 0)
			setProperty('doof'..i..'.antialiasing', not dialogueBox[i]["no_antialiasing"])
			addLuaSprite('doof'..i, true)
			
			if dialogueBox[i]["hasAnims"] == true then
			
				setProperty('doof'..i..'.offset.x', dialogueBox[i]["animations"][1]["offsets"][1])
				setProperty('doof'..i..'.offset.y', dialogueBox[i]["animations"][1]["offsets"][2])

				if dialogue[page].textbox == dialogueBox[i]["name"] then
					objectPlayAnimation('doof'..i, 'open', true)
				end
				
			end

			if dialogueBox[i]["image"] == nil then
				setProperty('doof'..i..'.visible', false)
				setProperty('doof'..i..'.active', false)
			end
		
		end
	
	end



	if textHasShadow == true then
		makeLuaText('doofTxtShadow', '', txtPos[3], txtPos[1] + shadowDistanceX, txtPos[2] + shadowDistanceY)

		setObjectCamera('doofTxtShadow', 'other')
		setTextAlignment('doofTxtShadow', 'left')
		setProperty('doofTxtShadow.borderSize', textBorderSize)

		setProperty('doofTxtShadow.borderColor', getColorFromHex(shadowColor))
		if textBorderSize <= 0 then setProperty('doofTxtShadow.borderColor', null) end
		setProperty('doofTxtShadow.color', getColorFromHex(shadowColor))

		addLuaText('doofTxtShadow', true)
	end

	makeLuaText('doofTxt', '', txtPos[3], txtPos[1], txtPos[2])

	setObjectCamera('doofTxt', 'other')
	setTextAlignment('doofTxt', 'left')
	setProperty('doofTxt.borderSize', textBorderSize)

	setProperty('doofTxt.borderColor', getColorFromHex(textBorderColor))
	if textBorderSize <= 0 then setProperty('doofTxt.borderColor', null) end
	setProperty('doofTxt.color', getColorFromHex(textColor))

	setProperty('doofTxt.alpha', 0)
	addLuaText('doofTxt', true)

end


if string.find(daDialogueType:lower(), 'end') then

	function onEndSong()
	
		if inVideo == true then
		
			inVideo = false
			
			if inDialogue == true then
				nextPage()
			end
			
			return Function_Stop
			
		end

		if string.find(daDialogueType:lower(), 'end') then

			if finished._end == false then
			
				if inDialogue == false then
					local a = dialogueAppear('end')
					if a == 'error' then return Function_Continue end
				end
				
				return Function_Stop
				
			end
		
		end

		return Function_Continue
		
	end

else

	function onStartCountdown()
	
		if inVideo == true then
		
			inVideo = false
			
			if inDialogue == true then
				nextPage()
			end
			
			return Function_Stop
			
		end

		if not (string.find(daDialogueType:lower(), 'end')) then
		
			if finished.start == false then

				if inDialogue == false then
					local a = dialogueAppear('start')
					if a == 'error' then return Function_Continue end
				end
				
				return Function_Stop
				
			end
		
		end
		
		setProperty('inCutscene', false)

		return Function_Continue
			
	end

end


function dialogueAppear(type)

	characters = {}
	dialogueBox = {}
	dialogue = {}

	setupFiles()
	
	--if there was an error with the dialogue then don't continue
	if (dialogue == nil or dialogue == {}) then 
		setProperty('inCutscene', true)
		setProperty('canPause', true)
		--debugPrint('<DIALOGUE> There was an error loading the dialogue.')
		return 'error'
	end
	
	
	--start stuff
	createTextboxStuff()

	if (onlyOneTime == true and getPropertyFromClass('PlayState', 'seenCutscene') == true) or (onlyForStoryMode == true and getPropertyFromClass('PlayState', 'isStoryMode') == false) then
		finished.start = true
		setProperty('canPause', true)
		return 'error'
	end

	if type == 'start' then
	
		if (onlyForStoryMode == true and getPropertyFromClass('PlayState', 'isStoryMode') == true) or onlyForStoryMode == false then

			if (onlyOneTime == true and getPropertyFromClass('PlayState', 'seenCutscene') == false) or onlyOneTime == false then

				setProperty('canPause', false)
				--setProperty('inCutscene', true)

				--music stuff
				if not (dialogue[page].music == nil or dialogue[page].music == '') then
				
					if tonumber(dialogue[page].musicVolume) == nil then dialogue[page].musicVolume = musicVolume end
					if dialogue[page].musicLoops == nil then dialogue[page].musicLoops = musicLoops end
				
					playMusic(dialogue[page].music, dialogue[page].musicVolume, dialogue[page].musicLoops)
					currentMusic = dialogue[page].music

					if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
						playSound(dialogue[page].music, musicVolume, 'dialogueMusic')
					end

				else
				
					playMusic(music, musicVolume, musicLoops)
					currentMusic = music

					if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
						playSound(music, musicVolume, 'dialogueMusic')
					end
					
				end


				if doCutscene == true then

					makeLuaSprite('black', '', -500, -300);
					luaSpriteMakeGraphic('black', getPropertyFromClass('flixel.FlxG', 'width') * 2, getPropertyFromClass('flixel.FlxG', 'height') * 2, '000000')
					setObjectCamera('black', 'other')
					addLuaSprite('black', true)

					doTweenAlpha('blackAlpha', 'black', 0, 2)

				else
					textboxAppear()
					updateDialogueBox()
				end

			end
		
		end
		
	else
	
		textboxAppear()
	
		--music stuff
		if not (dialogue[page].music == nil or dialogue[page].music == '') then
		
			if tonumber(dialogue[page].musicVolume) == nil then dialogue[page].musicVolume = musicVolume end
			if dialogue[page].musicLoops == nil then dialogue[page].musicLoops = musicLoops end
		
			playMusic(dialogue[page].music, dialogue[page].musicVolume, dialogue[page].musicLoops)
			currentMusic = dialogue[page].music

			if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
				playSound(dialogue[page].music, dialogue[page].musicVolume, 'dialogueMusic')
			end

		else
		
			playMusic(music, musicVolume, musicLoops)
			currentMusic = music

			if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
				playSound(music, musicVolume, 'dialogueMusic')
			end
			
		end
		
		updateDialogueBox()
		
	end
	
	setProperty('inCutscene', true)
	
	inDialogue = true
	
end


function onUpdate()

	if inDialogue == true then

		if dialogue[page].lock == nil or dialogue[page].lock == '' then dialogue[page].lock = false end

		if getProperty('doofTxt.alpha') == 1 and inVideo == false then

			if not (dialogue[page].auto == true) then
			
				if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
					
					if completeTxt == dialogue[page].text then
						nextPage()
					elseif dialogue[page].lock == false then
						cancelTimer('txtWait')
						cancelTimer('talkWait')
						completeTxt = dialogue[page].text
					end

				end

				if dialogue[page].lock == false and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not (page == #dialogue + 1) then
					cancelTimer('txtWait')
					cancelTimer('talkWait')
					completeTxt = dialogue[page].text
				end
			
			else

				if completeTxt == dialogue[page].text then
				
					autoTimerThing = autoTimerThing + 1
				
					if autoTimerThing > dialogue[page].autoEndTimer then
				
						if page == #dialogue then
							endDialogue()
						else
						
							if dialogue[page].repeats == true and dialogue[page].repeatLoops > 0 then
								dialogue[page].repeatLoops = dialogue[page].repeatLoops - 1
							end
						
							if not (dialogue[page].repeats == true) or dialogue[page].repeatLoops == 0 then
								page = page + 1
							end
							
							playSound(clickSound, clickVolume)
							updateDialogueBox()
							
						end
						
						autoTimerThing = 0
					
					end
						
				end
			
			end


			if page == #dialogue + 1 or (canSkip == true and dialogue[page].lock == false and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..skipKey:upper())) then
				endDialogue()
			end


			setTextString('doofTxt', completeTxt)
			if textHasShadow == true then setTextString('doofTxtShadow', completeTxt) end


			for i = 1, #characters do
			
				for ii = 1, #characters[i]["animations"] do
				
					if dialogue[page].character == 'all' then
			
						if characters[i]["animations"][ii]["name"] == dialogue[page].anim then
				
							if characters[i]["animations"][ii]["loops"] == true then
								playPortraitAnimation(characters[i]["name"], dialogue[page].anim)
							end
				
						end
					
					elseif characters[i]["name"] == dialogue[page].character then 
					
						if characters[i]["animations"][ii]["name"] == dialogue[page].anim then
				
							if characters[i]["animations"][ii]["loops"] == true then
								playPortraitAnimation(characters[i]["name"], dialogue[page].anim)
							end
				
						end
						
					end
					
				end

			end
			
			
			for i = 1, #dialogueBox do
			
				if not (dialogueBox[i] == nil or dialogueBox[i] == {}) and dialogue[page].textbox == dialogueBox[i]["name"] then
				
					for ii = 1, #dialogueBox[i]['animations'] do
				
						if dialogueBox[i]["animations"][ii]["name"] == dialogue[page].textboxAnim then
						
							if dialogueBox[i]["hasAnims"] == true and dialogueBox[i]["animations"][ii]["loops"] == true and getProperty('doof'..i..'.animation.curAnim.finished') == true then
							
								if not (dialogue[page].textboxAnim == nil or dialogue[page].textboxAnim == '') then
									objectPlayAnimation('doof'..i, dialogue[page].textboxAnim, false)
								else
									objectPlayAnimation('doof'..i, 'open', false)
								end
								
							end
							
							setProperty('doof'..i..'.flipX', dialogueBox[i]["animations"][ii]["flipX"])
							setProperty('doof'..i..'.antialiasing', not dialogueBox[i]["animations"][ii]["no_antialiasing"])
							
							setProperty('doof'..i..'.offset.x', dialogueBox[i]["animations"][ii]["offsets"][1])
							setProperty('doof'..i..'.offset.y', dialogueBox[i]["animations"][ii]["offsets"][2])
							
						end
						
					end
					
				end
				
			end

		end
	
	end

end


function nextPage()

	inVideo = false

	if page == #dialogue then
		endDialogue()
	else
	
		if dialogue[page].repeats == true and dialogue[page].repeatLoops > 0 then
			dialogue[page].repeatLoops = dialogue[page].repeatLoops - 1
		end
	
		if not (dialogue[page].repeats == true) or dialogue[page].repeatLoops == 0 then
			page = page + 1
		end
		
		playSound(clickSound, clickVolume)
		updateDialogueBox()
		
	end
				
end


function onTimerCompleted(tag)

	if tag == 'txtWait' then

		txtNum = txtNum + 1
		cutText = string.sub(dialogue[page].text, txtNum, txtNum)
		completeTxt = completeTxt..cutText
		
		local speed = dialogue[page].textSpeed
		
		if speed == nil then speed = 0.03 end

		if txtNum < string.len(dialogue[page].text) then

			if stopAtPunctuation == true then

				if (cutText == '?' or cutText == '.') then
					runTimer('txtWait', speed + 0.2)
				elseif (cutText == ',') then
					runTimer('txtWait', speed + 0.1)
				else
					runTimer('txtWait', speed)
				end

			else
				runTimer('txtWait', speed)
			end

		end

	end

	if tag == 'talkWait' then

		if stopAtPunctuation == true then

			if not (cutText == ' ' or cutText == ',' or cutText == '?' or cutText == '!' or cutText == '.') then

				if not (dialogue[page].talkSound == nil or dialogue[page].talkSound == '') then
					playSound(dialogue[page].talkSound, talkVolume)
				end

			end

		else

			if not (dialogue[page].talkSound == null or dialogue[page].talkSound == '') then
				playSound(dialogue[page].talkSound, talkVolume)
			end

		end

		if txtNum < string.len(dialogue[page].text) then
		
			local speed = dialogue[page].talkSpeed
		
			if speed == nil then speed = 0.05 end
		
			runTimer('talkWait', speed)
			
		end

	end

end


function onTweenCompleted(tag)

	if tag == 'blackAlpha' then
		textboxAppear()
		updateDialogueBox()
	end

	if tag == 'doofAlpha' or tag == 'doofAlphaEnd' then

		--remove everything as we don't need it anymore
		removeLuaSprite('doofBG', true)
		
		for i = 1, #dialogueBox do
			removeLuaSprite('doof'..i, true)
		end

		for i = 1, #characters do
			removeLuaSprite('portrait'..i, true)
		end

		if textHasShadow == true then
			removeLuaSprite('doofTxtShadow', true)
		end
		removeLuaSprite('doofTxt', true)
		removeLuaSprite('black', true)
		
		stopSound('startSound')

		setProperty('canPause', true)
		setPropertyFromClass('PlayState', 'seenCutscene', true)
		
	end
		
	if tag == 'doofAlpha' and not (string.find(daDialogueType:lower(), 'end')) then
		startCountdown()
		removeLuaScript(scriptName)
	end
	
	if tag == 'doofAlphaEnd' and string.find(daDialogueType:lower(), 'end') then
		endSong(false)
		removeLuaScript(scriptName)
	end
	
	if tag == 'doofAlpha1' then
		openAnimFinished = true
	end

end


function updateDialogueBox()

	--dialogue box alpha and anims
	if openAnimFinished == true then
	
		for i = 1, #dialogueBox do
		
			if not (dialogueBox[i] == nil or dialogueBox[i] == {}) then 
				
				if dialogue[page].textbox == dialogueBox[i]["name"] then
				
					if dialogueBox[i]["hasAnims"] == true and not (getProperty('doof'..i..'.animation.curAnim.name') == 'open') then
						objectPlayAnimation('doof'..i, dialogue[page].textboxAnim, true)
					end
					
					setProperty('doof'..i..'.alpha', dialogueBox[i]["alpha"])
					
				else
					setProperty('doof'..i..'.alpha', 0)
				end
			
			end
					
		end
	
	end
	

	--character alpha and anims
	if dialogue[page].character == 'all' then

		for i = 1, #characters do
			setProperty('portrait'..i..'.alpha', characters[i]["alpha"])
			playPortraitAnimation(characters[i]["name"], dialogue[page].anim)
		end

	else

		for i = 1, #characters do

			if characters[i]["name"] == dialogue[page].character then
				setProperty('portrait'..i..'.alpha', characters[i]["alpha"])
				playPortraitAnimation(characters[i]["name"], dialogue[page].anim)

			else
				setProperty('portrait'..i..'.alpha', characters[i]["inactive_alpha"])
			end

		end

	end
	
	
	--font
	if dialogue[page].font == '' or dialogue[page].font == nil then
	
		if tonumber(defaultTextFont == nil) then defaultTextFont = 'vcr.ttf' end
		
		setTextFont('doofTxt', defaultTextFont)
		if textHasShadow == true then setTextFont('doofTxtShadow',  defaultTextFont) end
		
	else
		setTextFont('doofTxt', dialogue[page].font)
		if textHasShadow == true then setTextFont('doofTxtShadow', dialogue[page].font) end
	end
	
	
	--size
	if tonumber(dialogue[page].textSize == nil) then
	
		if tonumber(defaultTextSize == nil) then defaultTextSize = 40 end
		
		setTextSize('doofTxt', defaultTextSize)
		if textHasShadow == true then setTextSize('doofTxtShadow', defaultTextSize) end
		
	else
		setTextSize('doofTxt', dialogue[page].textSize)
		if textHasShadow == true then setTextSize('doofTxtShadow', dialogue[page].textSize) end
	end
	
	
	--text color
	if dialogue[page].textColor == '' or dialogue[page].textColor == nil then
		setProperty('doofTxt.color', getColorFromHex('000000'))
	else
		setProperty('doofTxt.color', getColorFromHex(dialogue[page].textColor))
	end
	
	
	--set variables
	cutText = ''
	completeTxt = ''
	txtNum = 0

	runTimer('txtWait', 0.01)
	runTimer('talkWait', 0.01)
	
	
	--start sound
	if not (dialogue[page].startSound == nil or dialogue[page].startSound == '') then
		playSound(dialogue[page].startSound, 1, 'startSound')
	end
	
	
	--background
	if BG == true then
	
		if not (dialogue[page].bgImage == nil or dialogue[page].bgImage == '') then
		
			loadGraphic('doofBG', dialogue[page].bgImage)
			
			setProperty('doofBG.alpha', 1)
			
			if not (dialogue[page].bgPos == nil or dialogue[page].bgPos == {}) then
				setProperty('doofBG.x', dialogue[page].bgPos[1])
				setProperty('doofBG.y', dialogue[page].bgPos[2])
			end
			
			if not (dialogue[page].bgScale == nil or dialogue[page].bgScale == '') then
				setProperty('doofBG.scale.x', dialogue[page].bgScale)
				setProperty('doofBG.scale.y', dialogue[page].bgScale)
			end
			
		else
		
			removeLuaSprite('doofBG', true)
			
			makeLuaSprite('doofBG', '', -500, -300);
			luaSpriteMakeGraphic('doofBG', getPropertyFromClass('flixel.FlxG', 'width') * 2, getPropertyFromClass('flixel.FlxG', 'height') * 2, '000000')
			setProperty('doofBG.alpha', 0)
			setObjectCamera('doofBG', 'other')
			addLuaSprite('doofBG', true)
			
			setObjectOrder('doofBG', 0)
	
			setProperty('doofBG.alpha', 0.5)
			
		end
		
	end


	--video stuff
	if not (dialogue[page].video == nil or dialogue[page].video == '') then
	
		--if the video doesn't start check if the name is correct
		startVideo(dialogue[page].video)
		
		
		--no need for text because you are watching a video
		cancelTimer('txtWait')
		cancelTimer('talkWait')
		
		cutText = ''
		completeTxt = ''
		txtNum = 0
		dialogue[page].text = ''
		
		
		--make other stuff invisible
		for i = 1, #characters do
			setProperty('portrait'..i..'.alpha', 0)
		end
		
		for i = 1, #dialogueBox do
		
			if not (dialogueBox[i] == nil or dialogueBox[i] == {}) then 
				
				if dialogue[page].textbox == dialogueBox[i]["name"] then
					setProperty('doof'..i..'.alpha', 0)
				end
			
			end
					
		end
		
		setProperty('doofBG.alpha', 0)
		inVideo = true
		
	end
	
	
	--different music stuff
	if not (page == 1) then
	
		stopSound('dialogueMusic')
	
		if not (dialogue[page].music == nil or dialogue[page].music == '') then
		
			--debugPrint(currentMusic)
		
			if tonumber(dialogue[page].musicVolume) == nil then dialogue[page].musicVolume = musicVolume end
			if dialogue[page].musicLoops == nil then dialogue[page].musicLoops = musicLoops end
		
			if not (currentMusic == dialogue[page].music) then
				playMusic(dialogue[page].music, dialogue[page].musicVolume, dialogue[page].musicLoops)
				currentMusic = dialogue[page].music
			else
				setPropertyFromClass('flixel.FlxG', 'sound.music.volume', dialogue[page].musicVolume)
				setPropertyFromClass('flixel.FlxG', 'sound.music.looped', dialogue[page].musicLoops)
			end

			if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
				playSound(dialogue[page].music, dialogue[page].musicVolume, 'dialogueMusic')
			end

		else
		
			--debugPrint(currentMusic)
		
			if not (currentMusic == music) then
				playMusic(music, musicVolume, musicLoops)
				currentMusic = music
			else
				setPropertyFromClass('flixel.FlxG', 'sound.music.volume', musicVolume)
				setPropertyFromClass('flixel.FlxG', 'sound.music.looped', musicLoops)
			end

			if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
				playSound(music, musicVolume, 'dialogueMusic')
			end
			
		end
	
	end

end


function playPortraitAnimation(character, anim)

	for i = 1, #characters do

		if characters[i]["name"] == character then
		
			objectPlayAnimation('portrait'..i, anim, false)
			
			for ii = 1, #characters[i]["animations"] do
			
				if characters[i]["animations"][ii]["name"] == anim then
				
					setProperty('portrait'..i..'.flipX', characters[i]["animations"][ii]["flipX"])
					
					setProperty('portrait'..i..'.offset.x', characters[i]["animations"][ii]["offsets"][1])
					setProperty('portrait'..i..'.offset.y', characters[i]["animations"][ii]["offsets"][2])
					
				end
				
			end
			
		end

	end

end


function textboxAppear()

	local _error = true

	for i = 1, #dialogueBox do
	
		if not (dialogueBox[i] == nil or dialogueBox[i] == {}) then

			if dialogue[page].textbox == dialogueBox[i]["name"] then
			
				_error = false

				if dialogueBox[i]["hasAnims"] == true and (textboxOpen == 'anim' or textboxOpen == 'animation') then
					setProperty('doof'..i..'.alpha', dialogueBox[i]["alpha"])
					setProperty('doofTxt.alpha', 1)
					objectPlayAnimation('doof'..i, 'open', true)
					openAnimFinished = true

				elseif textboxOpen == 'fade' then
					if dialogueBox[i]["alpha"] > 0 then doTweenAlpha('doofAlpha1', 'doof'..i, dialogueBox[i]["alpha"], 0.5) end
					doTweenAlpha('doofTxtAlpha1', 'doofTxt', 1, 0.5)
					if dialogueBox[i]["hasAnims"] == true then objectPlayAnimation('doof'..i, dialogue[page].textboxAnim, true) end

				else
					setProperty('doof'..i..'.alpha', dialogueBox[i]["alpha"])
					setProperty('doofTxt.alpha', 1)
					openAnimFinished = true
				end
				
			else
				setProperty('doof'..i..'.alpha', 0)
			end

		end
	
	end
	
	if _error then
		setProperty('doofTxt.alpha', 1)
		openAnimFinished = true
	end

	if BG == true then
	
		if not (dialogue[page].bgImage == nil or dialogue[page].bgImage == '') then
			setProperty('doofBG.alpha', 1)
		else
			setProperty('doofBG.alpha', 0.5)
		end
		
	end

end


function endDialogue()

	inDialogue = false

	--just in case
	cancelTimer('txtWait')
	cancelTimer('talkWait')

	doTweenAlpha('doofBGAlpha', 'doofBG', 0, 1)
	doTweenAlpha('bgalpha', 'cursebg', 0, 1)

	doTweenAlpha('doofTxtAlpha', 'doofTxt', 0, 1)
	if textHasShadow == true then
		doTweenAlpha('doofTxtShadowAlpha', 'doofTxtShadow', 0, 1)
	end
	
	local _error = true
	
	if #dialogueBox > 0 then
	
		for i = 1, #dialogueBox do
		
			if not (dialogueBox[i] == nil or dialogueBox[i] == {}) then
				
				if dialogue[page].textbox == dialogueBox[i]["name"] then
				
					_error = false
				
					if string.find(daDialogueType:lower(), 'end') then
						doTweenAlpha('doofAlphaEnd', 'doof'..i, 0, 1)
						finished._end = true
					else
						doTweenAlpha('doofAlpha', 'doof'..i, 0, 1)
						finished.start = true
					end
					
				end

			end
			
		end
		
	end
	
	if _error then
	
		if string.find(daDialogueType:lower(), 'end') then
			cancelTween('doofTxtAlpha')
			doTweenAlpha('doofAlphaEnd', 'doofTxt', 0, 1)
			finished._end = true
		else
			cancelTween('doofTxtAlpha')
			doTweenAlpha('doofAlpha', 'doofTxt', 0, 1)
			finished.start = true
		end
		
	end

	for i = 1, #characters do
		doTweenAlpha('portrait'..i..'Alpha', 'portrait'..i, 0, 1)
	end

	if getPropertyFromClass('flixel.FlxG', 'sound.music.playing') == false then
		soundFadeOut('dialogueMusic', 1, 0)
	else
		soundFadeOut('', 1, 0)
	end

end


function onSoundFinished(tag)

	if tag == 'dialogueMusic' then

		if not (dialogue[page].music == nil or dialogue[page].music == '') then
		
			if dialogue[page].musicLoops == true then
				if tonumber(dialogue[page].musicVolume) == nil then dialogue[page].musicVolume = musicVolume end
				playSound(dialogue[page].music, dialogue[page].musicVolume, 'dialogueMusic')
			end
			
		elseif musicLoops == true then
			playSound(music, musicVolume, 'dialogueMusic')
		end
		
	end

end


--new stuff here
function setupFiles()

	local path = ''
	local json = {}

	--convert the json files to a table and the add it to the characterData variable
	if #characterFiles > 0 then

		for i = 1, #characterFiles do
		
			path = 'data/'..getPropertyFromClass('PlayState', 'SONG.song')..'/dialogue/'..characterFiles[i]..'.json'
			json = jsonToTable(path)
			
			if not (json == nil) then
			
				--add some useful extra data
				json.jsonName = characterFiles[i]
				json.jsonPath = path
				
				characters[#characters + 1] = json

			end
			
		end
		
	else
		debugPrint('<DIALOGUE> No characters specified.')
	end
	
	if #dialogueBoxes > 0 then
	
		for i = 1, #dialogueBoxes do
		
			path = 'data/'..getPropertyFromClass('PlayState', 'SONG.song')..'/dialogue/'..dialogueBoxes[i]..'.json'
			json = jsonToTable(path)
			
			if not (json == nil) then

				--add some useful extra data
				json.jsonName = dialogueBoxes[i]
				json.jsonPath = path
				
				dialogueBox[#dialogueBox + 1] = json
				
			end
			
		end
	
	else
		debugPrint('<DIALOGUE> No dialogue box specified.')
	end


	if #dialogueName > 0 then
	
		--check if dialogue exists, else throw an error
		local file = ''
		
		path = 'data/'..getPropertyFromClass('PlayState', 'SONG.song')..'/dialogue/'..dialogueName[1]..'.json'

		if not (getPropertyFromClass('Paths', 'currentModDirectory') == '') then
			file = 'mods/'..getPropertyFromClass('Paths', 'currentModDirectory')..'/'..path
		else
			file = 'assets/'..path
		end
		
		if checkFileExists(file, true) == true then

			json = jsonToTable(path, false)
			
			if not (json == nil) then
			
				--add some useful extra data
				json.jsonName = dialogueName[1]
				json.jsonPath = path
				
				dialogue = json
				
			end
			
			path = nil
			json = nil
		
		else
			debugPrint("<DIALOGUE> Dialogue file doesn't exist: "..file)
			dialogue = nil
			return
		end
	
	else
		debugPrint('<DIALOGUE> No dialogue file specified. Exiting dialogue.')
		dialogue = nil
		return
	end

end


--I made this myself yooo
function jsonToTable(jsonFile, checkFile)

	if checkFile == nil then checkFile = true end

	local path = ''

	if not (getPropertyFromClass('Paths', 'currentModDirectory') == '') then
		path = 'mods/'..getPropertyFromClass('Paths', 'currentModDirectory')..'/'..jsonFile
	else
		path = 'assets/'..jsonFile
	end

	if checkFile == false or (checkFileExists(path, true) == true) then

		local text = getTextFromFile(jsonFile)
	
		text = string.gsub(text, '":', ' =')
		text = string.gsub(text, '	"', '')
		if string.find(text, '%[') then text = string.gsub(text, '%[', '%{') end
		if string.find(text, '%]') then text = string.gsub(text, '%]', '%}') end
		
		_G["test"] = ''
		
		runStringCode([[
			_G["test"] = ]]..text..[[
		]])
		
		local tbl = _G["test"]
		
		_G["test"] = nil
		
		return tbl

	else
		debugPrint("<DIALOGUE> File doesn't exist: "..path)
		return nil
	end

end


--for turning a string into a table
function runStringCode(code)

	_function, error1 = loadstring(code, '<DIALOGUE> ', 't', _G)
	
	if error1 then 
		debugPrint(error1) 
		return 
	end
	
	
	succeed, error2 = pcall(function() _function() end)
	
	if not (succeed) then 
		debugPrint(error2) 
		return 
	end

end