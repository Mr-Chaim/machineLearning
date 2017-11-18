struct objClass
(
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
	fn initAll name sourObj targObj windObj=
	(
		name.initSource name sourObj 
		name.initTarget name targObj
		name.initWind   name windObj

		return true
	),
	fn updateValues name =
	(
		name.souPos = name.souObj.pos
		name.tarPos = name.tarObj.pos

		return true
	),
	fn importValues name valueClass =
	(
		--name.souPos = valueClass.souPos
		name.wndF   = valueClass.wndF
		name.wndT   = valueClass.wndT
		name.tltF   = valueClass.tltF
		name.dstF   = valueClass.dstF

		return true
	),
	fn outputWind name =
	(
		name.wndObj.pos      = name.souPos
		name.wndObj.strength = name.wndF
		name.wndObj.dir = [0,0,1]
		if name.dstF < 10000 then
		(
			name.wndObj.rotation.X_rotation = name.wndT[1]
			name.wndObj.rotation.Y_rotation = name.wndT[2]
		)
		else
		(
			name.wndObj.rotation.X_rotation = name.tltF[1]
			name.wndObj.rotation.Y_rotation = name.tltF[2]
		)
		
		return true
	),
	

	private
	
	souObj = undefined,
	tarObj = undefined,
	wndObj = undefined,
	wndF = 0,
	dstF = 0,
	tltF = [0,0,0],
	wndT = [0,0,0]
)