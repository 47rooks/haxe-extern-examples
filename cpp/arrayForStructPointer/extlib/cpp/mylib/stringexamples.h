#pragma once
#include <iostream>
#include <string>

class __declspec(dllexport)  StringExamples
{
private:
	char *m_cp;
public:
	StringExamples(const char* s)  {
		m_cp = (char *)malloc(1000);
		int copylen = strlen(s) < 1000 ? strlen(s) : 999;
		memcpy(m_cp, s, copylen);
		m_cp[copylen] = '\0';

		std::cout << "StringExamples(C++): " << m_cp << std::endl;
	}

	~StringExamples() {
		std::cout << "StringExamples(C++): destructor" << std::endl;
		if (m_cp) {
			free(m_cp);
			m_cp = NULL;
		}
	}

	const char* get_string();

	void set_string(const char* s);
};