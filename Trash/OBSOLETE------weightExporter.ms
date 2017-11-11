--Weight Exporter


weightNamesXYZ = #("Distance ","Speed ","Acel ","Wind ")
weightNames = #(weightNamesXYZ,weightNamesXYZ,weightNamesXYZ)
weightAxis = #("X","Y","Z")
weightDataSet = (maxFilePath + "weightDataset.csv")

if (doesFileExist weightDataSet) == false do
(
	createDataset = createfile weightDataSet
	close createDataset
)

createDataset = openFile weightDataSet mode:"a"


fn weightCounter weights axisN typeN=
(
	arr=#()
	for a=1 to weights[axisN][typeN].count do
	(
		weightStr = ("Weight " + (a as string))
		append arr weightStr
	)
	arr
)

fn createWeightsLine dataSetFile=
(
	arr = weightCounter weights axisN typeN
	for a = 1 to arr.count do 
	(
		format ",%" arr[a] to:createDataset
	)
)

fn weightExporter weightDataSet weightNames weightAxis weights=
(

	for a=1 to weights.count do 
	(
		format "\nAxis: % --------------------\n" weightNames[a] to:createDataset
		createWeightsLine dataSetFile
		--format ",Weight 1,Weight 2,Weight 3,Weight 4,Weight 5,Weight 6,Weight 7,Weight 8,Weight 9,Weight 10,Weight 11,Weight 12,Weight 13,Weight 14,Weight 15,Weight 16,Weight 17,Weight 18,Weight 19,Weight 20" to:createDataset
		for a1=1 to weights[a].count do
		(
			format "\nWeight Type : % \n" weightNamesXYZ[a1] to:createDataset
			for a2=1 to weights[a][a1].count do
			(
				format "Node %" a2 to:createDataset
				for a3=1 to weights[a][a1][a2].count do
				(
					singularWeight =  weights[a][a1][a2][a3]
					format ",%" singularWeight to:createDataset
				)
				format "\n"  to:createDataset
			)
		)
	)
	close createDataset
)

fn weightsFunction weights n var= (return weights[n][var])