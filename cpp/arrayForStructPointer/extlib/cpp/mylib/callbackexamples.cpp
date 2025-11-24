
#include "callbackexamples.h"
#include <iostream>

int CallbackExamples::invoke(int p1, int p2)
{
	return m_fn(p1, p2);
}
