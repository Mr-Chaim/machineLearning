const = constClass()
mathClass = mathClass()

struct acelClass
(
	acel = [0,0,0],
	-- Past atributes

	acelPast = [0,0,0],

	fn updateAcel name speedClass =
	(
		for a=1 to 3 do 
		(
			name.acel[a] = mathClass.acelFn speedClass.spdPast[a] speedClass.spdNow[a]
		)
	),
	fn updatePast name= (name.acelPast = name.acel),

	fn testValue test=
	(

		spd = const.maxSpeed
		ranGen = mathClass.randomGenFn

		test.spdNow = [(ranGen -spd spd),(ranGen -spd spd),(ranGen -spd spd)]
		test.spdPast = [(ranGen -spd spd),(ranGen -spd spd),(ranGen -spd spd)]

		return true
	),
	private

	spdPast = [0,0,0],
	spdNow = [0,0,0]

)


fn testacelClassFn =
(

	const = constClass()
	mathClass = mathClass()
	testacel = acelClass()

	testacel.testValue testacel
	testacel.updateAcel testacel testacel
	testacel.updatePast testacel

	print testacel.acelPast

	testacel.testValue testacel
	testacel.updateAcel testacel testacel

	print testacel.acel

	

	return true
)