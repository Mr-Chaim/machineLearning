-- Z force variables

bZpos
bDummyZpos
windAbsoluteZ
acelZ
bZpast
windacelZ
bZpos
speedNowZ
windForceZ
aOverZ
aUnderZ
z_Force.strength
--Z force function

fn windZAxis = 
(
	if nvpx.IsSimulating() == true do
	(
		
		counter +=1
		if counter == 1 do
		(
			bZpos = b.pos[3]
			bDummyZpos = bDummy.pos[3]
			windAbsoluteZ = (windForceZ/maxSpeed)
			acelZ = ((speedNowZ-(bZpos-bZpast)))/maxAcceleration
			speedNowZ = (bZpos-bZpast)/topSpeed
			bZpast = bZpos
			if acelZ > maxAcceleration do (acelZ = maxAcceleration)
			if acelZ < -maxAcceleration do (acelZ = -maxAcceleration)
			if acelZ == 0.0 then (windacelZ = maxAcceleration)
			else  (windacelZ = (acelZ/windAbsoluteZ))
			if (bZpos/bDummyZpos) < 1.0 then 
			(
				--if acelZ == 0.0 do (windacelZ = maxAcceleration)
				aUnderZ =abs (bDummyZpos-(bDummyZpos-bZpos))/bDummyZpos
				windacelZ = (((speedNowZ)+(windAbsoluteZ+acelZ))/aUnderZ)*maxSpeed
				if acelZ == 0.0 do (windacelZ = maxAcceleration)
				if windacelZ < 0 do (windacelZ = -windacelZ)
				windForceZ = windacelZ
				append allSpeedsArray1 aUnderZ
				format "1.Bpos: %. Dpos: %. Wstr: % , wacelZ: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" bZpos bDummyZpos windAbsoluteZ (windacelZ/maxSpeed) aUnderZ (acelZ) speedNowZ gforce1
				if windForceZ > maxSpeed do
				(
					windForceZ = maxSpeed
				)
				if windForceZ < -maxSpeed do
				(
					windForceZ = -maxSpeed
				)
				
			)
			else (windForceZ = 0.0)
			if (bZpos/bDummyZpos) > 1.0 do
			(
				--if acelZ == 0.0 do (windacelZ = -maxAcceleration)
				aOverZ = abs (bDummyZpos-(bZpos-bDummyZpos))/bDummyZpos
				windacelZ = (((speedNowZ)+(windAbsoluteZ+acelZ))/aOverZ)*maxSpeed
				if acelZ == 0.0 do (windacelZ = -maxAcceleration)
				--if windacelZ < 0.0 do (windacelZ = -windacelZ)
				windForceZ = windacelZ
				append allSpeedsArray2 aOverZ
				format "2.Bpos: %. Dpos: %. Wstr: % , wacelZ: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" bZpos bDummyZpos windAbsoluteZ (windacelZ/maxSpeed) aOverZ (acelZ) speedNowZ gforce2
			 	if windForceZ > maxSpeed do
				(
					windForceZ = maxSpeed
				)
				if windForceZ < -maxSpeed do
				(
					windForceZ = -maxSpeed
				) 
				
			) 
			

			z_Force.strength = windForceZ
			 
			counter = 0
		)	
		
	)
)