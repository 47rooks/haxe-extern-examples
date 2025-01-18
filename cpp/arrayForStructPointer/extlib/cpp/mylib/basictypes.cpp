#include "basictypes.h"

int BasicTypes::getInt()
{
	return 10;
}

int *BasicTypes::getIntPtr()
{
	return &m_i;
}

int &BasicTypes::getIntRef()
{
	return m_i;
}

bool BasicTypes::getBool()
{
	return m_b;
}

bool *BasicTypes::getBoolPtr()
{
	return &m_b;
}

bool &BasicTypes::getBoolRef()
{
	return m_b;
}

int BasicTypes::sum(int a, int b)
{
	return a + b;
}

void BasicTypes::sumOutParam(int a, int b, int *out)
{
	*out = a + b;
}
