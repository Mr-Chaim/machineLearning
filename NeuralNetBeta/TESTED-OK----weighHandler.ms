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
			name.deltaW[a] = mathClass.arrayCreaFn 20
			name.speedW[a] = mathClass.arrayCreaFn 20
			name.acelW[a] = mathClass.arrayCreaFn 20
			name.tiltW[a] = mathClass.arrayCreaFn 20
		)

		name.wForce = mathClass.arrayCreaFn 20

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
			deltaFoo[1] = mathClass.absFn name.deltaPredVal[a] const.maxDistance
			deltaFoo[2] = mathClass.absFn name.deltaPastVal[a] const.maxDistance
			deltaFoo[3] = mathClass.absFn name.deltaActVal[a] const.maxDistance

			speedFoo[1] = mathClass.absFn name.speedPredVal[a] const.maxSpeed
			speedFoo[2] = mathClass.absFn name.speedPastVal[a] const.maxSpeed
			speedFoo[3] = mathClass.absFn name.speedActVal[a] const.maxSpeed

			acelFoo[1] = mathClass.absFn name.acelPredVal[a] const.maxacel
			acelFoo[2] = mathClass.absFn name.acelPastVal[a] const.maxacel
			acelFoo[3] = mathClass.absFn name.acelActVal[a] const.maxacel

			tiltFoo[1] = mathClass.absFn name.tiltPredVal[a] const.maxTilt
			tiltFoo[2] = mathClass.absFn name.tiltPastVal[a] const.maxTilt
			tiltFoo[3] = mathClass.absFn name.tiltActVal[a] const.maxTilt
			

			deltaPos = mathClass.constrainFn deltaFoo[2]
			speedPos = mathClass.constrainFn speedFoo[2]
			acelPos = mathClass.constrainFn acelFoo[2]
			tiltPos = mathClass.constrainFn tiltFoo[2]

			name.deltaW[a][deltaPos] = mathClass.sigmFn (name.deltaW[a][deltaPos] - ( deltaFoo[3] - deltaFoo[1]))
			name.speedW[a][speedPos] = mathClass.sigmFn (name.speedW[a][speedPos] - ( speedFoo[3] - speedFoo[1]))
			name.acelW[a][acelPos] = mathClass.sigmFn (name.acelW[a][acelPos] - ( acelFoo[3] - acelFoo[1]))
			name.tiltW[a][tiltPos] = mathClass.sigmFn (name.tiltW[a][tiltPos] - ( tiltFoo[3] - tiltFoo[1]))
		)
		return true
	),

	fn catchCurrent name= 
	(
		for a=1 to 3 do 
		(
			deltaFoo = mathClass.absFn name.deltaActVal[a] const.maxDistance
			speedFoo = mathClass.absFn name.speedActVal[a] const.maxSpeed
			acelFoo = mathClass.absFn name.acelActVal[a] const.maxacel
			tiltFoo = mathClass.absFn name.tiltActVal[a] const.maxTilt
			

			deltaPos = mathClass.constrainFn deltaFoo
			speedPos = mathClass.constrainFn speedFoo
			acelPos = mathClass.constrainFn acelFoo
			tiltPos = mathClass.constrainFn tiltFoo

			name.deltaCurW[a] = name.deltaW[a][deltaPos]
			name.speedCurW[a] = name.speedW[a][speedPos]
			name.acelCurW[a] = name.acelW[a][acelPos]
			name.tiltCurW[a] = name.tiltW[a][tiltPos]
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


	fn testValues test= 
	(


		for a=1 to 3 do
		(
			test.deltaPredVal[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance
			test.deltaPastVal[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance
			test.deltaActVal[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance

			test.speedPredVal[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed
			test.speedPastVal[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed
			test.speedActVal[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed

			test.acelPredVal[a] = mathClass.randomGenFn -const.maxAcel const.maxAcel
			test.acelPastVal[a] = mathClass.randomGenFn -const.maxAcel const.maxAcel
			test.acelActVal[a] = mathClass.randomGenFn -const.maxAcel const.maxAcel

			test.tiltPredVal[a] = mathClass.randomGenFn -const.maxTilt const.maxTilt
			test.tiltPastVal[a] = mathClass.randomGenFn -const.maxTilt const.maxTilt
			test.tiltActVal[a] = mathClass.randomGenFn -const.maxTilt const.maxTilt
		)

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
	mathClass = mathClass()
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