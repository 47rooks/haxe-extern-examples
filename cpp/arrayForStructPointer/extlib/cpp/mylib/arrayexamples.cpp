#include <iostream>
#include <string>
#include "arrayexamples.h"


std::string ArrayExamples::simpleIntPointer(int* a, int size) {
		std::string rv{ "" };
	if (size > 0) {
		std::cout << "Dumping by size" << std::endl;
		for (int i = 0; i < size; ++i) {
			rv += std::to_string(a[i]);
			rv += ",";
		}
	}
	else {
		// a must have a null final entry
		// In case there is not one this test case limits
		std::cout << "Dumping by sentinel" << std::endl;

		for (int i = 0; i < 100; ++i) {
			if (a[i]) {
				rv += std::to_string(a[i]);
				rv += ",";
			}
			else {
				break;
			}
		}
	}
	if (rv.size() > 0) {
		rv = rv.substr(0, rv.size() - 1);
	}
	return rv;
}
