--startingVariables
struct startVar
(
	
	z_force.strength = 7.0,
	bPos = b.pos,
	bDummyPos = bDummy.pos,
	bPast = 0,
	bPastArr = #(bPos[1],bPos[2],bPos[3]),
	spdNowAbs = #(0,0,0),
	acelNowAbs = #(0,0,0),
	delta = #(0,0,0),
	deltaDirAbs=0,
	wireColorVar = #(([150,10,10] as color), ([10,150,10] as color),([10,10,150] as color)),
	abX = $Box_X_Red,
	abY = $Box_Y_Green,
	abZ = $Box_Z_Blue,
	analysisBox = #(abX,abY,abZ),
	windDifArr= #(0,0,0),
	b.MassFX_Rigid_Body.mass = 50
)

