#include "stdafx.h"


_constantValues::_constantValues()
{
	_maxD = 100.0;
	_maxT = 90.0;
	_maxM = 15.0;
	_maxW = 10.0;

	initStandardValues();
}

_constantValues::_constantValues(float var1, float var2, float var3, float var4)
{
	_maxD = var1;
	_maxT = var2;
	_maxM = var3;
	_maxW = var4;
	manualInitValues();
}

