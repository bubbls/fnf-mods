function onUpdate()
	if not middlescroll then
		if curBeat == 0 then
			setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)

			setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)

			setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)

			setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)

		end
	end
end