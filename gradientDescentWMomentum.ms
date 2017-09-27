allSpeedsArray =#()
w.strength  = 1
maxAcceleration = 100/10
gForce1 = random 0.1 1.0
gForce2 = random 0.1 1.0
maxSpeed = 5
topSpeed = 200
windForce = w.strength
counter = 0
counter2 = 0
bPast = b.pos[3]
initBpast = bPast
windAcel = 0
speedNow = b.pos[3]-bPast
bMass = b.MassFX_Rigid_Body.mass
steps = 5
sumationArr1=0
sumationArr2=0
allSpeedsArray1 = #()
allSpeedsArray2 = #()
fn unregisterAllTimeCallBacks =
(
	unRegisterTimeCallback printBoxPos
	unRegisterTimeCallback windSpeedChange
	unregisterTimeCallback maxSpeedFinder
)
unregisterAllTimeCallBacks()

fn maxSpeedFinder = 
(
	if nvpx.IsSimulating() == true do
	(
		counter +=1
		if counter == 1 do
		(
			windAbsolute = (windForce/maxSpeed)
			acel = ((speedNow-(b.pos[3]-bPast)))/maxAcceleration
			speedNow = (b.pos[3]-bPast)/topSpeed
			bPast = b.pos[3]
			if acel > maxAcceleration do (acel = maxAcceleration)
			if acel < -maxAcceleration do (acel = -maxAcceleration)
			if acel == 0.0 then (windAcel = maxAcceleration)
			else  (windAcel = (acel/windAbsolute))
			--print w.strength
			/*if (b.pos[3]/bDummy.pos[3]) > 0.99 and (b.pos[3]/bDummy.pos[3]) > 1.01 do
				(
					format "Calibrated, the force is: %\n" windForce
					windEquilibrium = windForce
					--global windForce = windForce
				)*/
			if (b.pos[3]/bDummy.pos[3]) < 1.0 then 
			(
				--if acel == 0.0 do (windAcel = maxAcceleration)
				aUnder =abs (bDummy.pos[3]-(bDummy.pos[3]-b.pos[3]))/bDummy.pos[3]
				windAcel = (((speedNow)+(windAbsolute+acel))/aUnder)*maxSpeed
				if acel == 0.0 do (windAcel = maxAcceleration)
				if windAcel < 0 do (windAcel = -WindAcel)
				windForce = windAcel
				append allSpeedsArray1 aUnder
				format "1.Bpos: %. Dpos: %. Wstr: % , wAcel: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" b.pos[3] bDummy.pos[3] windAbsolute (windAcel/maxSpeed) aUnder (acel) speedNow gforce1
				if windForce > maxSpeed do
				(
					windForce = maxSpeed
				)
				if windForce < -maxSpeed do
				(
					windForce = -maxSpeed
				)
				
			)
			else (windForce = 0.0)
			if (b.pos[3]/bDummy.pos[3]) > 1.0 do
			(
				--if acel == 0.0 do (windAcel = -maxAcceleration)
				aOver = abs (bDummy.pos[3]-(b.pos[3]-bDummy.pos[3]))/bDummy.pos[3]
				windAcel = (((speedNow)+(windAbsolute+acel))/aOver)*maxSpeed
				if acel == 0.0 do (windAcel = -maxAcceleration)
				--if windAcel < 0.0 do (windAcel = -WindAcel)
				windForce = windAcel
				append allSpeedsArray2 aOver
				format "2.Bpos: %. Dpos: %. Wstr: % , wAcel: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" b.pos[3] bDummy.pos[3] windAbsolute (windAcel/maxSpeed) aOver (acel) speedNow gforce2
			 	if windForce > maxSpeed do
				(
					windForce = maxSpeed
				)
				if windForce < -maxSpeed do
				(
					windForce = -maxSpeed
				) 
				
			) 
			

			w.strength = windForce


			counter2 +=1
			
		 	if counter2 == steps do
			(
				if allSpeedsArray1.count > 1 do
				(
					for arr1 = 1 to allSpeedsArray1.count do
					(
						sumationArr1 += allSpeedsArray1[arr1]
						

					)
					gforce1 = gforce1*(sumationArr1/allSpeedsArray1.count)
					allSpeedsArray1 = #()
					sumationArr1 = 0
				)
				if allSpeedsArray2.count > 1 do
				(
					for arr2 = 1 to allSpeedsArray2.count do
					(
						
						sumationArr2 += allSpeedsArray2[arr2]

					)
					gforce2 = gforce2*(sumationArr2/allSpeedsArray2.count)
					allSpeedsArray2 = #()
					sumationArr2 = 0
				)
				--windForce = sumationArr/allSpeedsArray.count
				
				
				
			
				
				
				counter2 = 0
			)
			 
			counter = 0
		)	
		
	)
)
registerTimeCallback maxSpeedFinder