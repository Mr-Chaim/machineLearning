fn backPropagation = 
(
	if nvpx.IsSimulating() == true do
	(
		speedPrevious = speedDir
		bNow = b.pos[3] --Should always be the position on the current frame.
		speedDir = (bNow - bPrevious) --Speed and direction positive is moving away and negative is moving torwards
		bPrevious = b.pos[3] --Always should be the position on the previous frame
		distFSource = (bNow - bThen)/200   --This is the distance from the initial point.
		windStrengthAdd = 0

		if distFSource > minPosDis and distFSource < maxPosDist do
		(
			wNeuron1 = distFSource
			if speedDir > 0.0 and speedDir < 1.0 do --This neuron is above the origin and moving away from the origin
			(
				prevResultsArray11 = #( w.strength, speedPrevious, speedDir, distFSource)
				append wNeuron11Array prevResultsArray11
				for d = 1 in prevResultsArray11.count do
				(
					wNeuron11 = 
				)
			)
			if speedDir < 0.0 do --This neuron is above the origin and moving torwards the origin
			(
				prevResultsArray12 = #( w.strength, speedDir, distFSource)
				append wNeuron12Array prevResultsArray12
			)
			if speedDir == 0 do --This neuron is above the origin and not moving
			(
				prevResultsArray13 = #( w.strength, speedDir, distFSource)
				append wNeuron13Array prevResultsArray13
			)
			
		)
		if distFSource < -minPosDis and distFSource > -maxPosDist do
		(
			wNeuron2 = distFSource

			if speedDir < 0.0 and speedDir > -1.0 do --This neuron is bellow the origin and moving away
			(
				prevResultsArray21 = #( w.strength, speedDir, distFSource)
				append wNeuron21Array prevResultsArray21
			)
			if speedDir > 0.0 and speedDir < 1.0 do --This neuron is bellow the origin and moving torwards the origin
			(
				prevResultsArray22 = #( w.strength, speedDir, distFSource)
				append wNeuron22Array prevResultsArray22
			)
			if speedDir == 0 do --This neuron is bellow the origin and not moving
			(
				prevResultsArray23 = #( w.strength, speedDir, distFSource)
				append wNeuron23Array prevResultsArray23
			)
		)
		if distFSource <= minPosDis and distFSource >= -minPosDis do
		(
			wNeuron3 = distFSource

			if speedDir > 0.0 do
			(
				prevResultsArray31 = #( w.strength, speedDir, distFSource)
				append wNeuron31Array prevResultsArray31
			)
			if speedDir < 0.0 do
			(
				prevResultsArray32 = #( w.strength, speedDir, distFSource)
				append wNeuron32Array prevResultsArray32
			)
			if speedDir == 0 do
			(
				prevResultsArray33 = #( w.strength, speedDir, distFSource)
				append wNeuron33Array prevResultsArray33
			)
		)
	)
)