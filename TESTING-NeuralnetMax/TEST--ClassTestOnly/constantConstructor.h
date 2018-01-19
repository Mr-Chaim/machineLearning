#pragma once
#include "stdafx.h"

class _constantConstructor
{
public:
	float _maxD, _maxT, _maxM, _maxW;

	void setMaxDistance(float mAbs)
	{
		_maxD = mAbs;
	}
	void setMaxMovement(float mS)
	{
		_maxM = mS;
	}

	void setMaxTilt(float mT)
	{
		_maxT = mT;
	}
	void setMaxWind(float mW)
	{
		_maxW = mW;
	}
	void show() const
	{
		cout << "Maximum Wind : " << _maxW << endl;
		cout << "Maximum Distance : " << _maxD << endl;
		cout << "Maximum Movement : " << _maxM << endl;
		cout << "Maximum Tilt: " << _maxT << endl;
	}
};

class _constantValues : public _constantConstructor
{
public:
	float _maxD, _maxT, _maxM, _maxW;

	_constantValues();
	_constantValues(float, float, float, float);

	void initStandardValues()
	{
		setMaxDistance(_maxD);
		setMaxMovement(_maxM);
		setMaxTilt(_maxT);
		setMaxWind(_maxW);
	}
	void manualInitValues()
	{
		setMaxDistance(_maxD);
		setMaxMovement(_maxM);
		setMaxTilt(_maxT);
		setMaxWind(_maxW);
	}
};