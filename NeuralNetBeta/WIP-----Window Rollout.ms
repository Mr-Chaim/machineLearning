fn mainTest = (testClass.updateValue testClass)
fn tiltResult = (testClass.localPs1.tilt as string)
fn DeltaResult = (testClass.localPs1.Delta as string)
fn SpeedResult = (testClass.localsS1.spdNow as string)
fn AcelResult = (testClass.localaS1.acel as string)
fn windDResult = (testClass.localSim1.windObj.dir as string)
fn windDResult = (testClass.localSim1.windObj.strength as string)
struct clockClass
(
	functionName = undefined,
	fn create name=
	(	
		theTimer = dotNetObject "System.Windows.Forms.Timer"
		theTimer.interval = 100
		dotnet.addEventHandler theTimer "tick" name
	),
	fn start =
	(
		theTimer.start()
		return true
	),
	fn stop =
	(
		theTimer.stop()
		return True
	),
	fn reload name=
	(
		name()
		functionName = name
	),
	theTimer = undefined
)
a=tiltResult
rollout ResultTest "Result Test" width:864 height:696
(
	
	label lSpeed "Speed" pos:[24,256] width:56 height:24 align:#left
	label lTilt "Tilt" pos:[24,192] width:56 height:24 align:#left
	label lDelta "Delta" pos:[24,224] width:56 height:24 align:#left
	label lAcel "Acel" pos:[24,288] width:56 height:24 align:#left
	label lEAngle "End Angle" pos:[24,320] width:56 height:24 align:#left
	label lWForce "Wind Force" pos:[24,352] width:56 height:24 align:#left
	
	label RSpeed "Speed" pos:[200,256] width:200 height:24 align:#left
	label RTilt "tilt" pos:[200,192] width:200 height:24 align:#left
	label RDelta "Delta" pos:[200,224] width:200 height:24 align:#left
	label RAcel "Acel" pos:[200,288] width:200 height:24 align:#left
	label REAngle "End Angle" pos:[200,320] width:200 height:24 align:#left
	label RWForce "Wind Force" pos:[200,352] width:200 height:24 align:#left

	on Result Test open  do
	(
		
		maintTestTimer = clockClass()
		maintTestTimer.create mainTest

	)
	on Result Test close  do
	(
	
	)

	button startButton "Start" pos:[328,616] width:88 height:27 align:#left
	button stopButton "Stop" pos:[464,616] width:88 height:27 align:#left
	on startButton pressed do
	(
		fn captionChangeFn = 
		(



			a1 = (testClass.localPs1.tilt as string)
			a2 = (testClass.localPs1.Delta as string)
			a3 = (testClass.localsS1.spdNow as string)
			a4 = (testClass.localaS1.acel as string)
			a5 = (testClass.localSim1.windObj.dir as string)
			a6 = (testClass.localSim1.windObj.strength as string)

			createDialog label RSpeed "Speed" pos:[200,256] width:56 height:24 align:#left
			--label RTilt "tilt" pos:[200,192] width:56 height:24 align:#left
			--label RDelta "Delta" pos:[200,224] width:56 height:24 align:#left
			--label RAcel "Acel" pos:[200,288] width:56 height:24 align:#left
			--label REAngle "End Angle" pos:[200,320] width:56 height:24 align:#left
			--label RWForce "Wind Force" pos:[200,352] width:56 height:24 align:#left


			RSpeed.caption = a3
			RTilt.caption = a1
			RDelta.caption = a2
			RAcel.caption = a4
			REAngle.caption = a5
			RWForce.caption = a6

		)
		capChange = clockClass()
		capChange.create captionChangeFn
		maintTestTimer.start()
		capChange.start()
	)
	
	on stopButton pressed do
	(
		maintTestTimer.stop()
		capChange.stop()
	)
/*	maintTestTimer = undefined
	tiltTimer = undefined
	deltaTimer = undefined
	SpeedTimer = undefined
	acelTimer = undefined
	WindTimer = undefined
*/
)

createDialog ResultTest
rollout labels
(
	label RSpeed "Speed" pos:[200,256] width:200 height:24 align:#left
	label RTilt "tilt" pos:[200,192] width:200 height:24 align:#left
	label RDelta "Delta" pos:[200,224] width:200 height:24 align:#left
	label RAcel "Acel" pos:[200,288] width:200 height:24 align:#left
	label REAngle "End Angle" pos:[200,320] width:200 height:24 align:#left
	label RWForce "Wind Force" pos:[200,352] width:200 height:24 align:#left

	a1 = (testClass.localPs1.tilt as string)
	a2 = (testClass.localPs1.Delta as string)
	a3 = (testClass.localsS1.spdNow as string)
	a4 = (testClass.localaS1.acel as string)
	a5 = (testClass.localSim1.windObj.dir as string)
	a6 = (testClass.localSim1.windObj.strength as string)
	RSpeed.caption = a3
	RTilt.caption = a1
	RDelta.caption = a2
	RAcel.caption = a4
	REAngle.caption = a5
	RWForce.caption = a6

)
createDialog labels
fn DialogCreation =
(
	createDialog
)
