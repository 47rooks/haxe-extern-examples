#pragma once
#include <iostream>
#include <string>

class __declspec(dllexport) StringExamples
{
private:
	char *m_cp;
	std::string *m_string;

public:
	StringExamples(const char *s)
	{
		m_string = new std::string(s);
		m_cp = (char *)malloc(1000);
		if (m_cp)
		{
			size_t copylen = strlen(s) < 1000 ? strlen(s) : 999;
			memcpy(m_cp, s, copylen);
			m_cp[copylen] = '\0';
		}

		std::cout << "StringExamples(C++): " << m_cp << std::endl;
	}

	~StringExamples()
	{
		std::cout << "StringExamples(C++): destructor" << std::endl;
		if (m_cp)
		{
			free(m_cp);
			m_cp = NULL;
		}
	}

	const char *get_string();

	void set_string(const char *s);
};

// FIXME Move to StringTypes.
// const char* concat(const char* a, const char* b);
// std::string concat(const char* a, const char* b);