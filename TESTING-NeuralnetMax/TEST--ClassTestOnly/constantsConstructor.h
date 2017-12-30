#pragma once
#include <string>
#include "stdafx.h"

class constantConstrctor
{
public:
	void setMaxAbsoluteDistance(const float& mAbs)
	{
		_maxAbs = mAbs;
	}
	void setMaxWind(const float& mW)
	{
		_maxWind = mW;
	}
	void setMaxDirection(const float& mD)
	{
		_maxDst = mD;
	}
	void setMaxSpeed(const float& mS)
	{
		_maxSpd = mS;
	}
	void setMaxAceleration(const float& mA)
	{
		_maxAcl = mA;
	}
	void setMaxTilt(const float& mT)
	{
		_maxTlt = mT;
	}
	void setMaxWindTilt(const float& mWT)
	{
		_maxWndTlt = mWT;
	}

	void show() const
	{
		cout << "Layer Name   : " << _maxWind << endl;
		cout << "Layer Type   : " << _maxDst << endl;
		cout << "Input Nodes  : " << _maxSpd << endl;
		cout << "Output Nodes : " << _maxAcl << endl;
		cout << "Output Nodes : " << _maxTlt << endl;
		cout << "Output Nodes : " << _maxWndTlt << endl;
		cout << "Output Nodes : " << _maxAbs << endl;
	}
private:
	float _maxWind;
	float _maxDst;
	float _maxSpd;
	float _maxAcl;
	float _maxTlt;
	float _maxWndTlt;
	float _maxAbs;
	float _maxWndT;

	~constants();
};

