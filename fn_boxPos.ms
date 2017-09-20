fn unregisterAllTimeCallBacks =
(
	unRegisterTimeCallback printBoxPos
	unRegisterTimeCallback windSpeedChange
)
unregisterAllTimeCallBacks()
windStrengthArray = #()
neuron1speedUp = #()
neuron1speedDown = #()
neuron1speedStill = #()
neuron2speedUp = #()
neuron2speedDown = #()
neuron2speedStill = #()
neuron3speedUp = #()
neuron3speedDown = #()
neuron3speedStill = #()
wNeuron1 = 1
wNeuron2 = 1
wNeuron3 = 1
wNeuron11 = 1
wNeuron12 = 1
wNeuron13 = 1
wNeuron21 = 1
wNeuron22 = 1
wNeuron23 = 1
wNeuron31 = 1
wNeuron32 = 1
wNeuron33 = 1
bThen = b.pos[3]
bPrevious = b.pos[3]
windStrgAVG = 0.0
fn printBoxPos =
(
	if nvpx.IsSimulating() == false do
	(
		print "No animation running"
		--print "Animation Running"
		--print w.strength
		--print b.pos[3]
	)
	
	--return b.pos
)

fn windSpeedChange =
(
	if nvpx.IsSimulating() == true do
	(
		bNow = b.pos[3] --Should always be the position on the current frame.
		speedDir = (bNow - bPrevious)/100 --Speed and direction positive is moving away and negative is moving torwards
		bPrevious = b.pos[3] --Always should be the position on the previous frame
		distFSource = (bNow - bThen)/200   --This is the distance from the initial point.
		--bThen = b.pos[3]
		bMass = b.MassFX_Rigid_Body.mass
		gForce = g.strength
		wForce = w.strength
		MaxWind = 15
		MinWind = 3
		weightHigh = 1
		weightLow = 0.1
		maxPosDist = 1
		minPosDis = 0.01
		windStrengthAdd = 0
		averageWind = 0.0
		windStrg = 0

		--append windStrengthArray w.strength
		/*for windCount = 1 to windStrengthArray do
		(
			windStrengthAdd += windstrengthArray[windCount]
		)*/
		if sliderTime == 0 do
		(
			if windStrengthArray.count > 0 then
			(
				for d=1 to windstrengthArray.count do 
				(
					windStrg += windstrengthArray[d]
				)
				windStrgAVG = windStrg/windstrengthArray.count
			)
			else
			(
				windstrengthArray = #()
			)
			
			w.strength = windStrgAVG
			print windStrgAVG as string + "\n"
		)

		if distFSource > minPosDis and distFSource < maxPosDist do
		(
			wNeuron1 = distFSource
			if speedDir > 0.0 and speedDir < 1.0 do --This neuron is above the origin and moving away from the origin
			(
				w.strength = (MaxWind * ((speedDir * distFSource)/ wNeuron11 ))
				format"Neuron 1 end 1 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron11
			)
			if speedDir < 0.0 do --This neuron is above the origin and moving torwards the origin
			(
				w.strength = (MaxWind * ((speedDir * distFSource)/ wNeuron12))
				format"Neuron 1 end 2 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron12
			)
			if speedDir == 0 do --This neuron is above the origin and not moving
			(
				w.strength = (MaxWind * ((speedDir * distFSource)/ wNeuron13))
				format"Neuron 1 end 3 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron13
			)
			
		)
		if distFSource < -minPosDis and distFSource > -maxPosDist do
		(
			wNeuron2 = distFSource

			if speedDir < 0.0 and speedDir > -1.0 do --This neuron is bellow the origin and moving away
			(
				w.strength = (MaxWind * ((speedDir * distFSource)/ wNeuron21))
				format"Neuron 2 end 1 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron21
			)
			if speedDir > 0.0 and speedDir < 1.0 do --This neuron is bellow the origin and moving torwards the origin
			(
				w.strength = (MaxWind * ((speedDir * distFSource)/ wNeuron22))
				format"Neuron 2 end 2 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron22
			)
			if speedDir == 0 do --This neuron is bellow the origin and not moving
			(
				w.strength = (MaxWind * ((speedDir * distFSource)/ wNeuron23))
				format"Neuron 2 end 3 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron23
			)
		)
		if distFSource <= minPosDis and distFSource >= -minPosDis do
		(
			wNeuron3 = distFSource

			if speedDir > 0.0 do
			(
				w.strength = (MinWind * ((speedDir * distFSource)/ wNeuron31))
				format"Neuron 3 end 1 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron31
			)
			if speedDir < 0.0 do
			(
				w.strength = (MinWind * ((speedDir * distFSource)/ wNeuron32))
				format"Neuron 3 end 2 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron32
			)
			if speedDir == 0 do
			(
				w.strength = (MinWind * ((speedDir * distFSource)/ wNeuron33))
				format"Neuron 3 end 3 - Wind Strength:% . Distance from source:% . Speed: % . Weight: %\n" w.strength distFSource speedDir wNeuron33
			)
		)
		append windstrengthArray w.strength

	)
)
registerTimeCallback printBoxPos
registerTimeCallback windSpeedChange
--unRegisterTimeCallback printBoxPos
--unRegisterTimeCallback windSpeedChange
