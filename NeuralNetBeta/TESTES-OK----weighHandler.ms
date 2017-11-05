-- Weight handler


--vClass = valueStoreClass()
--

struct weightClass
(

	public

	deltaW =#([1,2,3],[1,2,3],[1,2,3]),
	speedW =#([1,2,3],[1,2,3],[1,2,3]),
	acelW =#([1,2,3],[1,2,3],[1,2,3]),
	tiltW =#([1,2,3],[1,2,3],[1,2,3]),

	deltaCurW = [0,0,0],
	speedCurW = [0,0,0],
	acelCurW = [0,0,0],
	tiltCurW = [0,0,0],

	wForce = #(),

	fn init name= 

	(
		for a=1 to 3 do 
		(
			name.deltaW[a] = compClass.arrayCreaFn 20
			name.speedW[a] = compClass.arrayCreaFn 20
			name.acelW[a] = compClass.arrayCreaFn 20
			name.tiltW[a] = compClass.arrayCreaFn 20
		)

		name.wForce = compClass.arrayCreaFn 20

		return true
	),


	fn updateWeight name=
	(
		deltaFoo = [0,0,0]
		speedFoo = [0,0,0]
		acelFoo = [0,0,0]
		tiltFoo = [0,0,0]

		for a=1 to 3 do 
		(
			deltaFoo[1] = compClass.absFn name.deltaPredVal[a] const.maxDistance
			deltaFoo[2] = compClass.absFn name.deltaPastVal[a] const.maxDistance
			deltaFoo[3] = compClass.absFn name.deltaActVal[a] const.maxDistance

			speedFoo[1] = compClass.absFn name.speedPredVal[a] const.maxSpeed
			speedFoo[2] = compClass.absFn name.speedPastVal[a] const.maxSpeed
			speedFoo[3] = compClass.absFn name.speedActVal[a] const.maxSpeed

			acelFoo[1] = compClass.absFn name.acelPredVal[a] const.maxacel
			acelFoo[2] = compClass.absFn name.acelPastVal[a] const.maxacel
			acelFoo[3] = compClass.absFn name.acelActVal[a] const.maxacel

			tiltFoo[1] = compClass.absFn name.tiltPredVal[a] const.maxTilt
			tiltFoo[2] = compClass.absFn name.tiltPastVal[a] const.maxTilt
			tiltFoo[3] = compClass.absFn name.tiltActVal[a] const.maxTilt
			

			deltaPos = compClass.constrainFn deltaFoo[2]
			speedPos = compClass.constrainFn speedFoo[2]
			acelPos = compClass.constrainFn acelFoo[2]
			tiltPos = compClass.constrainFn tiltFoo[2]

			name.deltaW[a][deltaPos] = compClass.sigmFn (name.deltaW[a][deltaPos] - ( deltaFoo[3] - deltaFoo[1]))
			name.speedW[a][speedPos] = compClass.sigmFn (name.speedW[a][speedPos] - ( speedFoo[3] - speedFoo[1]))
			name.acelW[a][acelPos] = compClass.sigmFn (name.acelW[a][acelPos] - ( acelFoo[3] - acelFoo[1]))
			name.tiltW[a][tiltPos] = compClass.sigmFn (name.tiltW[a][tiltPos] - ( tiltFoo[3] - tiltFoo[1]))

		)
		return true
	),

	fn catchCurrent name= 
	(


		for a=1 to 3 do 
		(
			deltaFoo = compClass.absFn name.deltaActVal[a] const.maxDistance
			speedFoo = compClass.absFn name.speedActVal[a] const.maxSpeed
			acelFoo = compClass.absFn name.acelActVal[a] const.maxacel
			tiltFoo = compClass.absFn name.tiltActVal[a] const.maxTilt
			

			deltaPos = compClass.constrainFn deltaFoo
			speedPos = compClass.constrainFn speedFoo
			acelPos = compClass.constrainFn acelFoo
			tiltPos = compClass.constrainFn tiltFoo

			name.deltaCurW[a] = name.deltaW[a][deltaPos]
			name.speedCurW[a] = name.speedW[a][speedPos]
			name.acelCurW[a] = name.acelW[a][acelPos]
			name.tiltCurW[a] = name.tiltW[a][tiltPos]
		)

		return true
	),

	fn testValues test= 
	(


		for a=1 to 3 do
		(

			test.deltaPredVal[a] = compClass.randomGenFn -const.maxDistance const.maxDistance
			test.deltaPastVal[a] = compClass.randomGenFn -const.maxDistance const.maxDistance
			test.deltaActVal[a] = compClass.randomGenFn -const.maxDistance const.maxDistance

			test.speedPredVal[a] = compClass.randomGenFn -const.maxSpeed const.maxSpeed
			test.speedPastVal[a] = compClass.randomGenFn -const.maxSpeed const.maxSpeed
			test.speedActVal[a] = compClass.randomGenFn -const.maxSpeed const.maxSpeed

			test.acelPredVal[a] = compClass.randomGenFn -const.maxAcel const.maxAcel
			test.acelPastVal[a] = compClass.randomGenFn -const.maxAcel const.maxAcel
			test.acelActVal[a] = compClass.randomGenFn -const.maxAcel const.maxAcel

			test.tiltPredVal[a] = compClass.randomGenFn -const.maxTilt const.maxTilt
			test.tiltPastVal[a] = compClass.randomGenFn -const.maxTilt const.maxTilt
			test.tiltActVal[a] = compClass.randomGenFn -const.maxTilt const.maxTilt
		)

		return true
	),

	fn updateObj name vClass = 
	(

		name.deltaPredVal = vClass.deltaPredVal
		name.deltaPastVal = vClass.deltaPastVal
		name.deltaActVal = vClass.deltaActVal

		name.speedPredVal = vClass.speedPredVal
		name.speedPastVal = vClass.speedPastVal
		name.speedActVal = vClass.speedActVal

		name.acelPredVal = vClass.acelPredVal
		name.acelPastVal = vClass.acelPastVal
		name.acelActVal = vClass.acelActVal

		name.tiltPredVal = vClass.tiltPredVal
		name.tiltPastVal = vClass.tiltPastVal
		name.tiltActVal = vClass.tiltActVal
		
		return true
	),


	private

	deltaPredVal = [0,0,0],
	deltaPastVal = [0,0,0],
	deltaActVal = [0,0,0],
	speedPredVal = [0,0,0],
	speedPastVal = [0,0,0],
	speedActVal = [0,0,0],
	acelPredVal = [0,0,0],
	acelPastVal = [0,0,0],
	acelActVal = [0,0,0],
	tiltPredVal = [0,0,0],
	tiltPastVal = [0,0,0],
	tiltActVal = [0,0,0]



)
fn testWeightClassFn =

(
	const = constClass()
	compClass = compFnClass()
	testWeightClass = weightClass()
	testWeightClass.init testWeightClass
	testWeightClass.testValues testWeightClass
	testWeightClass.updateWeight testWeightClass
	testWeightClass.catchCurrent testWeightClass

	print testWeightClass.deltaCurW
	print testWeightClass.speedCurW
	print testWeightClass.acelCurW
	print testWeightClass.tiltCurW
)