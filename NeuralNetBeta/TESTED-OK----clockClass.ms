struct clockClass
(	
	fn create name func=
	(	
		name.theTimer = dotNetObject "System.Windows.Forms.Timer"
		name.theTimer.interval = 50
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
	theTimer = undefined
)