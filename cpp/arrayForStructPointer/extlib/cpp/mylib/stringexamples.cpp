#include "stringexamples.h"

const char *StringExamples::get_string()
{
	std::cout << "StringExamples::get_string():(C++): " << m_cp << std::endl;
	return m_cp;
}

void StringExamples::set_string(const char *s)
{
	size_t copylen = strlen(s) < 1000 ? strlen(s) : 999;
	memcpy(m_cp, s, copylen);
	m_cp[copylen] = '\0';
}

// FIXME Move to StringTypes when we do strings
// const char* BasicTypes::concat(const char* a, const char* b) {
////std::string BasicTypes::concat(const char* a, const char* b) {
//		//char buf[100];
//	std::string rv = new std::string(10);
//		std::string{ a };
//	rv = rv.append(b);
//	/*nt len_a = strlen(a);
//	int len_b = strlen(b);
//
//	if (len_a + len_b > 99) {
//		strcpy_s(buf, "TOO BIG");
//		return buf;
//	}
//
//	strcpy_s(buf, a);
//	strcat_s(buf, b);*/
//	return rv.c_str();
//}