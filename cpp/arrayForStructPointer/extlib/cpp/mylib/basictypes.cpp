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