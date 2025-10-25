function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if getProperty('health') > 0.1 then
		setProperty('health',getProperty('health')-0.022)
	end
end