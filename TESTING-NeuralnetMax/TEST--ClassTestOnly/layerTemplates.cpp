#include <string>
#include "stdafx.h"
#include <vector>
#include <string>
#include <memory>
#include "mathLibrary.h"
#include "layerConstructor.h"


class distancelayer : public layerFactory
{
public:
	virtual ~distancelayer() {};

	virtual void setLayerName()
	{
		m_layer->setLayerName("Name");
	}

	virtual void setLayerType()
	{
		m_layer->setLayerType("Distance");
	}

	float maxValue = 0.0;
	int numberNodes = 1;
	int exitNodes = 1;
	float currentValue = 0.0;
	float pastValue = 0.0;
	float pastprediction = 0.0;
	float weight = 0.0;
	float pastweight = 0.0;
	int weightPosition[2] = { 1,1 };
	int pastweightPosition[2] = { 1,1 };
	float ousideVal = 0.0;
	float outsideMax = 0.0;
	vector<vector<float>> weightArray;

	void initWeights()
	{
		weightArray = mathLibrary::arrayGenFn(numberNodes, exitNodes);
	}
};
class anglelayer
{
	string layerName;
	string type;
	float maxValue;
	int numberNodes = 1;
	int exitNodes = 1;
	float currentValue[3];
	float pastValue[3];
	float prediction[3];
	float pastprediction[3];
	float weight[3];
	float pastweight[3];
	int weightPosition[3][2];
	int pastweightPosition[3][2];
	vector<vector<vector<float>>> weightArray;

	void initWeights()
	{
		
		for (int a = 0; a < 3; a++)
		{
			weightArray[a] = mathLibrary::arrayGenFn(numberNodes, exitNodes);
		}
	}
};
class movementlayer
{
	string layerName;
	string type;
	float maxValue;
	int numberNodes = 1;
	int exitNodes = 1;
	float currentValue;
	float pastValue;
	float pastprediction;
	float weight;
	float pastweight;
	int weightPosition[2];
	int pastweightPosition[2];
	float ousideVal;
	float outsideMax;
	vector<vector<float>> weightArray;

	void initWeights()
	{
		weightArray = mathLibrary::arrayGenFn(numberNodes, exitNodes);
	}
};
class windlayer
{
	string layerName;
	string type;
	float maxValue;
	int numberNodes = 1;
	int exitNodes = 1;
	float currentValue;
	float pastValue;
	float pastprediction;
	float weight;
	float pastweight;
	int weightPosition[2];
	int pastweightPosition[2];
	float ousideVal;
	float outsideMax;

	void initWeights()
	{
		vector<vector<float>> weightArray = mathLibrary::arrayGenFn(numberNodes, exitNodes);
	}
};
class objectlayer
{
	string type = "Object";
	float currentValue[3];
	float pastValue[3];
	float pastprediction[3];

};

