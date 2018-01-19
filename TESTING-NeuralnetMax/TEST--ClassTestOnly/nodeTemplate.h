#pragma once
#include "stdafx.h"

class _nodeTemplate
{
public:
	float _iVal, _maxV, _currVal, _pastVal;
	int _type;
	char _dir;

	_nodeTemplate(int v_type, float var1[], float var2[], char s_direction, float maxVal);

	void update()
	{
		switch (_type)
		{
		case 1:
			updateDist();
			break;
		case 2:
			updateMov();
			break;
		case 3:
			updateTilt();
			break;
		}
		updateAbsolute();
	};


private:
	void setDirStr()
	{
		switch (m_direction)
		{
		case 0:
			_dir = 'X';
			break;
		case 1:
			_dir = 'Y';
			break;
		case 2:
			_dir = 'Z';
			break;
		}
	}
	void updateAbsolute()
	{
		_maxV = m_maxVal;
		float foo = mathLibrary::absFn(_iVal, _maxV);
		float foo2 = mathLibrary::binaryRectFn(foo, -1.0, 1.0);
		_currVal = foo2;
	}
	void updateDist()
	{
		_iVal = mathLibrary::dstFfn(m_IsourcePos, m_ItargetPos);
	}
	void updateMov()
	{
		_iVal = mathLibrary::movementFn(m_IPastVal, m_ICurrVal);
	}
	void updateTilt()
	{
		vector<float> foo = mathLibrary::tltFFn(m_IsourcePos, m_ItargetPos);
		_iVal = foo[m_direction];
	}

	float m_maxVal, m_IsourcePos[3], m_ItargetPos[3], m_IPastVal, m_ICurrVal;
	int m_direction;
};