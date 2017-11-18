--BasicVariables
struct constClass
(
	maxWindForce = 0,
	maxDistance  = 0,
	maxSpeed     = 0,
	maxAcel      = 0,
	maxTilt      = 0,
	maxAbs       = 0,

	fn init name =
	(
		name.maxAbs = 500
		name.maxWindForce = 50.0
		name.maxDistance  = 20.0
		name.maxSpeed     = 10.0
		name.maxAcel      = 3.0
		name.maxTilt      = 35
		
		return true
	)
)