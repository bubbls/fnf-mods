function onUpdate()
	if not middlescroll then
		if curBeat <= 0 then
			setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)

			setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)

			setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)

			setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)


			setPropertyFromGroup('opponentStrums', 0, 'x', -1000)

			setPropertyFromGroup('opponentStrums', 1, 'x', -1000)

			setPropertyFromGroup('opponentStrums', 2, 'x', -1000)

			setPropertyFromGroup('opponentStrums', 3, 'x', -1000)

			setPropertyFromGroup('opponentStrums', 0, 'alpha', 0)

			setPropertyFromGroup('opponentStrums', 1, 'alpha', 0)
		
			setPropertyFromGroup('opponentStrums', 2, 'alpha', 0)
		
			setPropertyFromGroup('opponentStrums', 3, 'alpha', 0)
		end
	end
end
