struct objClass
(
	source = undefined,
	target = undefined,
	windObj = undefined,
	
	sourcePos = [0,0,0],
	targetPos = [0,0,0],
	windPos = [0,0,0],

	sourceTilt = [0,0,0],
	targetTilt = [0,0,0],
	windTilt = [0,0,0],

	windForce = 0,

	fn initSource name objName= 
	(
		name.source = objName
		name.sourcePos = objName.pos
		name.sourceTilt = objName.dir
		return true
	),

	fn initTarget name objName=
	(
		name.target = objName
		name.targetPos = objName.pos
		name.targetTilt = objName.dir
		return true
	),

	fn initWind name objName= 
	(
		if classof objName == Wind then
		(
			name.windObj = objName

			name.windPos = objName.pos
			name.windTilt = objName.dir
			name.windForce = objName.strength
		)
		else (format "Error, no Wind object on %, Obj is : %" objName (classof objName))
		return true
	),

	fn updateValue name =
	(
		name.sourcePos = name.source.pos
		name.targetPos = name.target.pos
		name.windPos = name.windObj.pos

		name.sourceTilt = name.source.dir
		name.targetTilt = name.target.dir
		name.windTilt = name.windObj.dir

		name.windForce = name.windObj.strength

		return true
	),

	fn initAll name source target windObj=
	(
		name.initSource name source 
		name.initTarget name target
		name.initWind name windObj
	),

	fn updateWind name windClass =
	(
		name.windObj.pos = name.sourcePos
		name.windObj.dir[1] = windClass.tiltFinal[1]
		name.windObj.dir[2] = windClass.tiltFinal[2]
		name.windObj.dir[3] = windClass.tiltFinal[3]
		name.windObj.strength = windClass.windForce
	),
	fn updateWindTestMode name windClass =
	(
		name.windObj.pos = [0,0,0]
		name.windObj.dir[1] = windClass.tiltFinal[1]
		name.windObj.dir[2] = windClass.tiltFinal[2]
		name.windObj.dir[3] = windClass.tiltFinal[3]
		name.windObj.strength = windClass.windForce
	),
	fn testWind test = 
	(
		const = constClass()
		maxDistance = const.maxDistance
		maxTilt = const.maxTilt
		maxWind = const.maxWindForce
		rGen = mathClass.randomGenFn

		test.tiltFinal = [(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt)]
		test.windForce = rGen 0 maxWind

	),

	private
	tiltFinal = [0,0,0]

)
fn testCurrentObjFn obj1 obj2 objWind= 
(
	objClassTest = objClass()

	const = constClass()
	maxDistance = const.maxDistance
	maxTilt = const.maxTilt
	maxWind = const.maxWindForce

	rGen = mathClass.randomGenFn

	obj1.pos = [(rGen 0 maxDistance),(rGen 0 maxDistance),(rGen 0 maxDistance)]
	obj2.pos = [(rGen 0 maxDistance),(rGen 0 maxDistance),(rGen 0 maxDistance)]

	obj1.dir = [(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt)]
	obj2.dir = [(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt)]

	

	objClassTest.initSource objClassTest obj1
	objClassTest.initTarget objClassTest obj2
	objClassTest.initWind objClassTest objWind
	objClassTest.testWind objClassTest
	objClassTest.updateWind objClassTest objClassTest


	objClassTest.updateValue objClassTest

	print objClassTest.source.name
	print objClassTest.target.name
	print objClassTest.windObj.name


	print objClassTest.sourcePos
	print objClassTest.targetPos
	print objClassTest.windPos

	print objClassTest.sourceTilt
	print objClassTest.targetTilt
	print objClassTest.windTilt

	print objClassTest.windForce

	return true
)