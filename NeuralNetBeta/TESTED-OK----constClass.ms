--BasicVariables
struct constClass
(
	maxWindForce = 0,
	maxDistance  = 0,
	maxSpeed     = 0,
	maxAcel      = 0,
	maxTilt      = 0,
	maxAbs       = 0,
	maxWndT      = 0,
	currentMaxD  = 0,
	CurrentMaxS  = 0,
	CurrentMaxA  = 0,

	fn init name =
	(
		name.maxWindForce = 10.0
		name.maxAbs       = 25.0
		name.maxDistance  = 21.0
		name.maxSpeed     = 5.0
		name.maxAcel      = 20.0
		name.maxTilt      = 35
		name.maxWndT      = 35
		
		return true
	)
)