#pragma once
#include "stdafx.h"

using namespace std;
using std::vector;

class layer {
public:
	void setLayerName(const string& name)
	{
		m_name = name;
	}
	void setLayerType(const string& type)
	{
		m_type = type;
	}
	void setNumberNodes(const int& numberNodes)
	{
		m_mNodes = numberNodes;
	}
	void setExitNodes(const int& exitNodes)
	{
		m_eNodes = exitNodes;
	}
	void show() const
	{
		cout << "Layer Name   : " << m_name << endl;
		cout << "Layer Type   : " << m_type << endl;
		cout << "Input Nodes  : " << m_mNodes << endl;
		cout << "Output Nodes : " << m_eNodes << endl;
	}
private:
	string m_name;
	string m_type;
	int m_mNodes;
	int m_eNodes;
};


class layerFactory
{
public:
	virtual ~layerFactory() {};
	layer* getLayer()
	{
		return m_layer.release();
	}
	void createNewLayer()
	{
		m_layer = make_unique<layer>();
	}
	void initType(string layerName, int typeNumber, int numberNodes, int exitNodes)
	{
		switch (typeNumber)
		{
		case 1:
		{
			type = "Distance";
			new distancelayer(layerName, numberNodes);
			break;
		}
		case 2:
		{
			string type = "Angle";
			float maxValue;
			int numberNodes;
			float currentValue[3];
			float pastValue[3];
			float prediction[3];
			float pastprediction[3];
			float weight[3];
			float pastweight[3];
			int weightPosition[3][2];
			int pastweightPosition[3][2];
			break;
		}
		case 3:
		{
			string type = "Movement";
			float maxValue;
			int numberNodes;
			float currentValue;
			float pastValue;
			float pastprediction;
			float weight;
			float pastweight;
			int weightPosition[2];
			int pastweightPosition[2];
			break;
		}
		case 4:
		{
			string type = "Wind";
			float maxValue;
			int numberNodes;
			float currentValue;
			float pastValue;
			float pastprediction;
			float weight;
			float pastweight;
			int weightPosition[2];
			int pastweightPosition[2];
			break;
		}
		case 5:
		{
			string type = "Object";
			float currentValue[3];
			float pastValue[3];
			float pastprediction[3];
			break;
		}
		}
	}
	virtual void setLayerName() = 0;
	virtual void setLayerType() = 0;
	virtual void setNumberNodes() = 0;
	virtual void setExitNodes() = 0;
protected:
	unique_ptr<layer> m_layer;
};