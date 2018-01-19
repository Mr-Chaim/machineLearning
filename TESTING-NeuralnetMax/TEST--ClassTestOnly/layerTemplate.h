#pragma once
#include "stdafx.h"

class _layerTemplate
{
public:
	int _nNods, _eNods, _currWPos, _pstWPos;
	float _iVal, _curV, _maxV, _pstV, _pstPrd, _currW, _pstW, _outVal, _outMax;

	vector<vector<float>> _wArr;

	_layerTemplate(float m_maxV, int m_nNods, int m_eNods, float m_outVal, float m_outMax);


	void initWeights()
	{
		_wArr = mathLibrary::arrayGenFn(_nNods, _eNods);
	}
	void updtCurrentVal()
	{

	}
	void updtPastVal()
	{

	}
	void updtPred()
	{

	}
private:
	int m_nNods, m_eNods, m_currWPos, m_pstWPos;
	float m_iVal, m_curV, m_pstV, m_pstPrd, m_currW, m_pstW, m_outVal, m_outMax, m_maxV;
};

_layerTemplate::_layerTemplate(float f_maxV, int f_nNods, int f_eNods, float f_outVal, float f_outMax)
{
	m_maxV = f_maxV;
	m_nNods = f_nNods;
	m_eNods = f_eNods;
	m_outVal = f_outVal;
	m_outMax = f_outMax;
}