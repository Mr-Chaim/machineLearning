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
		name.windObj = objName

		name.windPos = objName.pos
		name.windTilt = objName.dir
		name.windForce = objName.strength
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
	)

)
fn testCurrentObjFn obj1 obj2 objWind= 
(

	objClassTest = objClass()

	rGen = compFnClass.randomGenFn

	obj1.pos = [(rGen 0 100),(rGen 0 100),(rGen 0 100)]
	obj2.pos = [(rGen 0 100),(rGen 0 100),(rGen 0 100)]
	objWind.pos = [(rGen 0 100),(rGen 0 100),(rGen 0 100)]

	obj1.dir = [(rGen -180 180),(rGen -180 180),(rGen -180 180)]
	obj2.dir = [(rGen -180 180),(rGen -180 180),(rGen -180 180)]
	objWind.dir = [(rGen -180 180),(rGen -180 180),(rGen -180 180)]

	objWind.strength = rGen 0 100

	objClassTest.initSource objClassTest obj1
	objClassTest.initTarget objClassTest obj2
	objClassTest.initWind objClassTest objWind



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
--testCurrentObjFn $Box001 $Box002 $wind001