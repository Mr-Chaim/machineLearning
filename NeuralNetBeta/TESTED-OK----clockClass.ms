struct clockClass
(
	functionName = undefined,
	
	fn create name func=
	(	
		name.theTimer = dotNetObject "System.Windows.Forms.Timer"
		name.theTimer.interval = 500
		dotnet.addEventHandler name.theTimer "tick" func
	),
	fn start name=
	(
		name.theTimer.start()
		return true
	),
	fn stop name=
	(
		name.theTimer.stop()
		return True
	),
	fn reload name func=
	(
		functionName = name
	),
	theTimer = undefined
)