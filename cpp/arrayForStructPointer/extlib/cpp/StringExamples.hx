package;

import cpp.Char;
import cpp.ConstCharStar;
import cpp.ConstStar;
import cpp.RawConstPointer;

/**
 * StringExamples is a set of examples of how you can pass a Haxe function to C++ and later call it from C++. Of course this is not actually what happens. What happens is that you model an extern interface that accepts a function of some shape and this transpiles to C++. You then invoke that code passing in a Callable or Function so that when that transpiles to C++ it produces code compatible with the external C++ code. Then later the C++ library can invoke the callback.
 */
@:structAccess
@:include("./mylib/stringexamples.h")
@:buildXml('
     <target  id="haxe">
     <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
     </target>
 ')
@:native("StringExamples")
extern class StringExamples {
	/**
	 * Factory function mapped to the native constructor.
	 * @return an BasicTypes instance
	 */
	@:native("new StringExamples")
	public static function create(s:cpp.ConstPointer<cpp.Char>):cpp.Pointer<StringExamples>;

	@:native("get_string")
	public function getString():cpp.ConstPointer<cpp.Char>;

	@:native("set_string")
	public function setString(s:cpp.ConstPointer<cpp.Char>):Void;
}
