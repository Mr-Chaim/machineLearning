struct objClass
(
	souObj = undefined,
	tarObj = undefined,
	wndObj = undefined,

	souPos = [0,0,0],
	tarPos = [0,0,0],

	fn initSource name objName= 
	(
		name.souObj = objName
		name.souPos = objName.pos

		return true
	),
	fn initTarget name objName=
	(
		name.tarObj = objName
		name.tarPos = objName.pos

		return true
	),
	fn initWind name objName= 
	(
		if classof objName == Wind then
		(
			name.wndObj = objName
		)
		else (format "Error, no Wind object on %, Obj is : %" objName (classof objName))
		return true
	),
	fn updateValue name =
	(
		name.souPos = name.souObj.pos
		name.tarPos = name.tarObj.pos

		return true
	),
	fn initAll name sourObj targObj windObj=
	(
		name.initSource name sourObj 
		name.initTarget name targObj
		name.initWind   name windObj
	),
	fn outputWind name valueClass =
	(
		name.wndObj.pos      = valueClass.souPos
		name.wndObj.strength = valueClass.wndFinalF
		
		name.wndObj.rotate.X_rotation = valueClass.wndFinalT[1]
		name.wndObj.rotate.Y_rotation = valueClass.wndFinalT[2]
		name.wndObj.rotate.Z_rotation = valueClass.wndFinalT[3]
		
		return true
	),
	fn testWind test = 
	(
		const       = constClass()
		maxDistance = const.maxDistance
		maxTilt     = const.maxTilt
		maxWind     = const.maxWindForce
		rGen        = mathClass.randomGenFn

		test.tiltFinal = [(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt),(rGen -maxTilt maxTilt)]
		test.windForce = rGen 0 maxWind

	),

	private

	wndFinalF = 0,
	wndFinalT = [0,0,0]

)
fn testCurrentObjFn obj1 obj2 objWind= 
(
	objClassTest = objClass()

	const       = constClass()
	maxTilt     = const.maxTilt
	maxWind     = const.maxWindForce
	maxDistance = const.maxDistance

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