#include "stdafx.h"
#include "nodeTemplate.h"

_nodeTemplate::_nodeTemplate(int v_type, float var1[], float var2[], char s_direction, float maxVal)
{
	switch (v_type)
	{
	case 1:
		m_IsourcePos[0] = var1[0];
		m_IsourcePos[1] = var1[1];
		m_IsourcePos[2] = var1[2];

		m_ItargetPos[0] = var2[0];
		m_ItargetPos[1] = var2[1];
		m_ItargetPos[2] = var2[2];
		m_maxVal = maxVal;
		_type = v_type;
		_dir = 'N';
		break;
	case 2:
		m_IPastVal = var1[0];
		m_ICurrVal = var2[0];
		m_maxVal = maxVal;
		_type = v_type;
		_dir = 'N';
		break;
	case 3:
		m_IsourcePos[0] = var1[0];
		m_IsourcePos[1] = var1[1];
		m_IsourcePos[2] = var1[2];

		m_ItargetPos[0] = var2[0];
		m_ItargetPos[1] = var2[1];
		m_ItargetPos[2] = var2[2];
		switch (s_direction)
		{
		case 'X':
			m_direction = 0;
			break;
		case 'Y':
			m_direction = 1;
			break;
		case 'Z':
			m_direction = 2;
			break;
		}
		m_maxVal = maxVal;
		_type = v_type;
		setDirStr();
		break;
	}
};
