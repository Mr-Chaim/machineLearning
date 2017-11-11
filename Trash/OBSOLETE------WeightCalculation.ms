--Weight Calculation


struct weightClass
(

	public

	deltaW = [0,0,0],
	speedW = [0,0,0],
	acelW = [0,0,0],
	tiltW = [0,0,0],

	deltaCurW = [0,0,0],
	speedCurW = [0,0,0],
	acelCurW = [0,0,0],
	tiltCurW = [0,0,0],



	fn init = 

	(
		for a=1 to 3 do 
		(
			deltaW[a] = arrayCreaFn 20
			speedW[a] = arrayCreaFn 20
			acelW[a] = arrayCreaFn 20
			tiltW[a] = arrayCreaFn 20
		)

		wForce = arrayCreaFn 20
	),


	fn update valueStoreClass=
	(
		updateObj valueStoreClass

		for a=1 to 3 do 
		(
			deltaFoo = [0,0,0]
			speedFoo = [0,0,0]
			AcelFoo = [0,0,0]
			tiltFoo = [0,0,0]

			deltaFoo[1] = absFn deltaPredVal[a] maxDistance
			deltaFoo[2] = absFn deltaPastVal[a] maxDistance
			deltaFoo[3] = absFn deltaActVal[a] maxDistance

			speedFoo[1] = absFn speedPredVal[a] maxSpeed
			speedFoo[2] = absFn speedPastVal[a] maxSpeed
			speedFoo[3] = absFn speedActVal[a] maxSpeed

			AcelFoo[1] = absFn AcelPredVal[a] maxAcel
			AcelFoo[2] = absFn AcelPastVal[a] maxAcel
			AcelFoo[3] = absFn AcelActVal[a] maxAcel

			tiltFoo[1] = absFn tiltPredVal[a] maxTilt
			tiltFoo[2] = absFn tiltPastVal[a] maxTilt
			tiltFoo[3] = absFn tiltActVal[a] maxTilt
			

			deltaPos = constrainFn deltaFoo[2]
			speedPos = constrainFn speedFoo[2]
			acelPos = constrainFn AcelFoo[2]
			tiltPos = constrainFn tiltFoo[2]

			deltaW[a][deltaPos] = sigmFn (deltaW[a][deltaPos] - ( deltaFoo[3] - deltaFoo[1]))
			speedW[a][speedPos] = sigmFn (speedW[a][speedPos] - ( speedFoo[3] - speedFoo[1]))
			acelW[a][acelPos] = sigmFn (acelW[a][acelPos] - ( AcelFoo[3] - AcelFoo[1]))
			tiltW[a][tiltPos] = sigmFn (tiltW[a][tiltPos] - ( tiltFoo[3] - tiltFoo[1]))
		)
		return
	),

	fn catch = 
	(
		for a=1 to 3 do 
		(
			deltaFoo = absFn deltaActVal[a] maxDistance
			speedFoo = absFn speedActVal[a] maxSpeed
			AcelFoo = absFn AcelActVal[a] maxAcel
			tiltFoo = absFn tiltActVal[a] maxTilt
			

			deltaPos = constrainFn deltaFoo
			speedPos = constrainFn speedFoo
			acelPos = constrainFn AcelFoo
			tiltPos = constrainFn tiltFoo

			deltaCurW[a] = deltaW[a][deltaPos]
			speedCurW[a] = speedW[a][speedPos]
			acelCurW[a] = acelW[a][acelPos]
			tiltCurW[a] = tiltW[a][tiltPos]


		)
		return
	),

	private

	absFn = compFnClass.absFn,
	constrainFn = compFnClass.constrainFn,
	sigmFn = compFnClass.sigmFn,
	arrayCreaFn = compFnClass.arrayCreaFn,
	
	maxDistance = constClass.maxDistance,
	maxAcel = constClass.maxAcel,
	maxSpeed = constClass.maxSpeed,
	maxTilt = constClass.maxTilt,

	fn updateObj valueStoreClass = 
	(

		deltaPredVal = valueStoreClass.deltaPredVal
		deltaPastVal = valueStoreClass.deltaPastVal
		deltaActVal = valueStoreClass.deltaActVal

		speedPredVal = valueStoreClass.speedPredVal
		speedPastVal = valueStoreClass.speedPastVal
		speedActVal = valueStoreClass.speedActVal

		AcelPredVal = valueStoreClass.AcelPredVal
		AcelPastVa = valueStoreClass.AcelPastVa
		AcelActVal = valueStoreClass.AcelActVal

		tiltPredVal = valueStoreClass.tiltPredVal
		tiltPastVal = valueStoreClass.tiltPastVal
		tiltActVal = valueStoreClass.tiltActVal
	)
)