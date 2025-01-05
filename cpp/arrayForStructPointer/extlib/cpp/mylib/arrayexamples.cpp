#include <iostream>
#include <string>
#include "arrayexamples.h"

std::string ArrayExamples::simpleIntPointer(int *a, int size)
{
	std::string rv{ "" };
	if (size > 0)
	{
		std::cout << "Dumping by size" << std::endl;
		for (int i = 0; i < size; ++i)
		{
			rv.append(std::to_string(a[i]));
			rv.append(",");
		}
	}
	else
	{
		// a must have a null final entry
		// In case there is not one this test case limits
		std::cout << "Dumping by sentinel" << std::endl;

		for (int i = 0; i < 100; ++i)
		{
			if (a[i])
			{
				rv.append(std::to_string(a[i]));
				rv.append(",");
			}
			else
			{
				break;
			}
		}
	}
	if (rv.size() > 0)
	{
		rv = rv.substr(0, rv.size() - 1);
	}
	std::cout << "About to return:" << rv << std::endl;
	return rv;
}

std::string ArrayExamples::appendToString(std::string& in) {
	return in.append("SUFFIX");
}

std::string& ArrayExamples::getMyStr() {
	return myStr;
}

// std::string* ArrayExamples::simpleIntPointer(int* a, int size) {
//	std::string* rv;
//	rv = new std::string("");
//	if (size > 0) {
//		std::cout << "Dumping by size" << std::endl;
//		for (int i = 0; i < size; ++i) {
//			rv->append(std::to_string(a[i]));
//			rv->append(",");
//		}
//	}
//	else {
//		// a must have a null final entry
//		// In case there is not one this test case limits
//		std::cout << "Dumping by sentinel" << std::endl;
//
//		for (int i = 0; i < 100; ++i) {
//			if (a[i]) {
//				rv->append(std::to_string(a[i]));
//				rv->append(",");
//			}
//			else {
//				break;
//			}
//		}
//	}
//	if (rv->size() > 0) {
//		rv = new std::string(rv->substr(0, rv->size() - 1));
//	}
//	return rv;
// }

// const char* ArrayExamples::simpleIntPointer2(int* a, int size) {
//	auto rv = simpleIntPointer(a, size);
//	const char* rv_str = rv.c_str();
//	std::cout << "simpleIntPointer2 about to return =" << rv_str << std::endl;
//	return rv_str;
// }

//String ArrayExamples::simpleIntPointer2(int* a, int size)
//{
//	std::string rv{ "" };
//	if (size > 0)
//	{
//		std::cout << "Dumping by size" << std::endl;
//		for (int i = 0; i < size; ++i)
//		{
//			rv.append(std::to_string(a[i]));
//			rv.append(",");
//		}
//	}
//	else
//	{
//		// a must have a null final entry
//		// In case there is not one this test case limits
//		std::cout << "Dumping by sentinel" << std::endl;
//
//		for (int i = 0; i < 100; ++i)
//		{
//			if (a[i])
//			{
//				rv.append(std::to_string(a[i]));
//				rv.append(",");
//			}
//			else
//			{
//				break;
//			}
//		}
//	}
//	if (rv.size() > 0)
//	{
//		rv = rv.substr(0, rv.size() - 1);
//	}
//	std::cout << "About to return:" << rv << std::endl;
//	return String::create(rv.c_str(), rv.size());
//	//return "hello from rv";
//}
