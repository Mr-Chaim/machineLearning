--BasicVariables
struct constClass
(
	maxWindForce = 0,
	maxAcel      = 0,
	maxSpeed     = 0,
	maxDistance  = 0,
	maxTilt      = 0,

	fn init name =
	(
		name.maxWindForce = 100.0
		name.maxAcel      = 50.0
		name.maxSpeed     = 50.0
		name.maxDistance  = 5000.0
		name.maxTilt      = 180.0
		
		return true
	)
)