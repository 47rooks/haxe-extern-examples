package;

import cpp.NativeString;
import utest.Assert;

/**
 * This is just a regular extern definition for the code in the meta.
 */
@:structAccess
@:native("HCExample")
extern class HCExample {
	@:native("new HCExample")
	public static function create(s:cpp.ConstPointer<cpp.Char>):cpp.Pointer<HCExample>;

	@:native("get_string")
	public function getString():cpp.ConstPointer<cpp.Char>;
}

/**
 * This headerCode ends up in the TestHeaderCodeExamples.h verbatim.
 * There is no syntax checking or parsing on this string except to ensure the
 * string does not break the Haxe file - ie. it has to be a regular Haxe string.
 */
@:headerCode('
#include <string>
#include <iostream>

class HCExample
{
private:
	std::string *m_string;
public:
	HCExample(const char* s): m_string {new std::string(s)} {
		std::cout << "HCExample(hc++): " << *m_string << std::endl;
	}
    
    const char *get_string() {
        return m_string->c_str();
    }
};
')
/**
 * This code is transpiled to cpp as normal by the Haxe compiler.
 */
class TestHeaderCodeExamples extends utest.Test {
	function testStringLifeCycle():Void {
		var ns = NativeString.c_str("Hello");
		var hc = HCExample.create(ns);
		var s = NativeString.fromPointer(hc.value.getString());
		trace(s);
		Assert.equals("Hello", s);
	}
}
