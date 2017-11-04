/*





			OBSOLETE!!!!!!!!!




*/

fn orientationOBJtARGET movingOjb tarObj= 
(
	alphaX = ((tarObj.pos[1]) - (movingOjb.pos[1]))
	alphaY = ((tarObj.pos[2]) - (movingOjb.pos[2]))
	alphaZ = ((tarObj.pos[3]) - (movingOjb.pos[3]))


	hipXZ = sqrt((alphax*alphax)+(alphaZ*alphaZ))

	hipYZ = sqrt((alphaY*alphaY)+(alphaZ*alphaZ))


	sinhipXZ = alphaX/hipXZ
	coshipXZ = alphaZ/hipXZ
	anglehipXZ = acos coshipXZ
	
	
	sinhipYZ = alphaY/hipYZ
	coshipYZ = alphaZ/hipYZ
	anglehipYZ = acos coshipYZ

	if alphaX < 0.0 do
	(
		anglehipXZ = -anglehipXZ
	)

	if alphaY < 0.0 do 
	(
		anglehipYZ = -anglehipYZ
	)

	
	arr = #(anglehipYZ,anglehipXZ)
	

	arr
)

fn rotateObj objectRotated arr=
(
	objectRotated.dir = [0,0,1]
	rotate objectRotated (angleaxis -anglehipYZ [1,0,0])
	rotate objectRotated (angleaxis anglehipXZ [0,1,0])
)
