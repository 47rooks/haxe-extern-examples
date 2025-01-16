package;

import cpp.Callable;

/**
 * CallbackExamples is a set of examples of how you can pass a Haxe function to C++ and later call it from C++. Of course this is not actually what happens. What happens is that you model an extern interface that accepts a function of some shape and this transpiles to C++. You then invoke that code passing in a Callable or Function so that when that transpiles to C++ it produces code compatible with the external C++ code. Then later the C++ library can invoke the callback. 
 */
@:structAccess
@:include("./mylib/callbackexamples.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
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
}
