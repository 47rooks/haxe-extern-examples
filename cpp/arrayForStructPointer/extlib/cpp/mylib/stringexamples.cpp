#include "stringexamples.h"

const char * StringExamples::get_string()
{
	std::cout << "StringExamples::get_string():(C++): " << m_cp << std::endl;
	return m_cp;
}

void StringExamples::set_string(const char* s)
{
	int copylen = strlen(s) < 1000 ? strlen(s) : 999;
	memcpy(m_cp, s, copylen);
	m_cp[copylen] = '\0';
}