package;

import cpp.Callable;

/**
 * This is a C++ wrapper around the C function foo().
 * It wraps a Haxe Dynamic function object into a C function pointer
 * callback with baton pointer.
 *
 * The way this works is that cb is a Haxe Dynamic function object which we
 * wrap in a heap allocated hx::Object* root pointer. The root object is added
 * as a GC root so that it remains around until needed, instead of being
 * garbage collected, which would lead to crashes. This root pointer is
 * passed as the baton to foo(). The callback function is a lambda that
 * receives the baton pointer, unwraps the Haxe Dynamic function object,
 * removes the root, deletes the heap allocated root pointer, and then
 * invokes the Haxe Dynamic function object.
 *
 * In this form there would need to be one wrapper function per C function
 * that needs to be called from Haxe with a Haxe function callback. Other
 * additions would be needed to use different callback signatures, etc. This
 * is just a simple example to illustrate the concept.
 */
@:cppNamespaceCode('
#include <iostream>
#include "../../../extlib/cpp/mylib/cfunc.h"

void foo_wrapped(Dynamic cb)
{
	auto root = new hx::Object *{cb.mPtr};

	hx::GCAddRoot(root);

	foo(root, [](void *baton)
		 {
        auto root = static_cast<hx::Object**>(baton);
        auto cb   = Dynamic(*root);

        hx::GCRemoveRoot(root);

        delete root;
		std::cout << "foo_wrapped closure:about to call cb()" << std::endl;
        cb(); });
}
')
@:headerCode('
/// @brief This is a C++ wrapper around the C function foo().
/// It accepts a Haxe Dynamic function object to pass to foo().
/// @param fn The Haxe Dynamic function object to be called back from foo().
///           The function signature is not constrained here but must match
///			  the form expected by foo().
void foo_wrapped(Dynamic cb);
')
@:keep
class CallbackExamplesHidden {
	public function new() {}
}

/**
 * CallbackExamples is a set of examples of how you can pass a Haxe function to * C++ and later call it from C++. Of course this is not actually what happens.
 * What happens is that you model an extern interface that accepts a function 
 * of some shape and this transpiles to C++. You then invoke that code passing 
 * in a Callable or Function so that when that transpiles to C++ it produces 
 * code compatible with the external C++ code. Then later the C++ library can 
 * invoke the callback. 
 */
@:structAccess
@:include("./mylib/callbackexamples.h")
@:include("CallbackExamplesHidden.h")
@:buildXml('
    <target id="haxe">
		<lib name="../../extlib/cpp/mylib/x64/Debug/mylib.a" if="linux"/>
		<lib name="../../extlib/cpp/mylib/x64/Debug/mylibc.a" if="linux"/>
		<lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib" if="windows"/>
		<lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylibc.lib" if="windows"/>
	</target>
')
@:native("CallbackExamples")
extern class CallbackExamples {
	/**
	 * Factory function mapped to the native constructor.
	 * @return an BasicTypes instance
	 */
	@:native("CallbackExamples")
	public static function create(cbk:Callable<(Int, Int) -> Int>):CallbackExamples;

	/**
	 * Call the C++ library class to invoke the callback. This is a terribly simplistic example and you would not necessarily expect such a direct invocation of the function passed to the constructor but it serves as an example.
	 * @param a 
	 * @param b 
	 * @return Int the combination of `a` and `b` as defined by `cbk` which was provided to the constructor.
	 */
	public function invoke(a:Int, b:Int):Int;

	@:native("foo_wrapped")
	static function foo_wrapped(fn:() -> Void):Void;
}
