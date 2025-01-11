#include "basictypes.h"

int BasicTypes::getInt() {
	return 10;
}

int* BasicTypes::getIntPtr() {
	int x{ 11 };
	return &x;
}

int& BasicTypes::getIntRef() {
	int x{ 12 };
	return x;
}

bool BasicTypes::getBool() {
	return false;
}

bool* BasicTypes::getBoolPtr() {
	bool b{ false };
	return &b;
}

bool& BasicTypes::getBoolRef() {
	bool b{ true };
	return b;
}

int BasicTypes::sum(int a, int b) {
	return a + b;
}

void BasicTypes::sumOutParam(int a, int b, int* out) {
	*out = a + b;
}

// FIXME Move to StringTypes when we do strings
//const char* BasicTypes::concat(const char* a, const char* b) {
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