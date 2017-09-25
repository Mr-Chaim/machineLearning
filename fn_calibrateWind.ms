allSpeedsArray =#()
w.strength  = 10
maxAcceleration = 70.45/10
gForce = -386.22
maxSpeed = 150
windForce = w.strength
counter = 0
bPast = b.pos[3]
initBpast = bPast
windAcel = 0
speedNow = b.pos[3]-bPast
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
			acel = ((speedNow-(b.pos[3]-bPast))/(maxAcceleration))
			speedNow = b.pos[3]-bPast
			bPast = b.pos[3]
			if acel > 1.0 do (acel = maxAcceleration)
			if acel < -1.0 do (acel = -maxAcceleration)
			if acel == 0 then (windAcel = maxAcceleration)
			else  (windAcel = ((windAbsolute*gForce)/(acel)))
			--print w.strength
			/*if (b.pos[3]/bDummy.pos[3]) > 0.99 and (b.pos[3]/bDummy.pos[3]) > 1.01 do
				(
					format "Calibrated, the force is: %\n" windForce
					windEquilibrium = windForce
					--global windForce = windForce
				)*/
			if (b.pos[3]/bDummy.pos[3]) < 1.0 then 
			(
				aUnder = (((bDummy.pos[3]-b.pos[3])/bDummy.pos[3]))
				
				windForce += (aUnder/(windAcel))
				format "1.Bpos: %. Dpos: %. Wstr: %, Under Dummy by %. Acc at: % Speed: %\n" b.pos[3] bDummy.pos[3] (windForce) aUnder (acel) speedNow
			)
			else
			(
				aOver = (((b.pos[3]-bDummy.pos[3])/bDummy.pos[3]))
				
				windForce -= (aOver/(abs windAcel))
				format "2.Bpos: %. Dpos: %. Wstr: %, Over Dummy by %. Acc at: % Speed: %\n" b.pos[3] bDummy.pos[3] (windForce) aOver (acel) speedNow
			)
			if windForce > maxSpeed do
			(
				windForce = maxSpeed
			)
			if windForce < -maxSpeed do
			(
				windForce = -maxSpeed
			)

			w.strength = windForce
			append allSpeedsArray windForce
			counter = 0
			if animationRange.end == sliderTime do
			(
				sumationArr = 0
				for arr = 1 to allSpeedsArray.count do
				(
					sumationArr += allSpeedsArray[arr]
				)
				windForce = sumationArr/allSpeedsArray.count
				allSpeedsArray =#()
				bPast = initBpast
				windAcel = 0
				speedNow = 0
			)
		)	
	)
)
registerTimeCallback maxSpeedFinder