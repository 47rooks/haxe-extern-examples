package;

import cpp.Reference;
import cpp.StdString;

/**
 * An example wrapper class for a C++ library.
 * 
 * @:include points to the library header file.
 * @:buildXml defines the location of the library to be linked with
 * @:native defines the native name to be used for the class. Specifically in
 * this case a pointer to the class. My understanding of why this is done is
 * that Haxe cannot call the extern cannot constructor and must instead use a
 * `create()` factory function. This will then return a reference to the class
 * instance (pointer). This is why is defines the name as `ArrayExamples *`.
 * Related to the last point above is the `@:native("new ArrayExamples")` for
 * the `create()` factory function.
 */
@:include("./mylib/arrayexamples.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
	</target>
')
@:native("ArrayExamples *")
extern class ArrayExamples {
	/**
	 * Factory function mapped to the native constructor.
	 * @return an ArrayExamples instance
	 */
	@:native("new ArrayExamples")
	public static function create():ArrayExamples;

	/**
	 * Call a c++ function to convert an array of Ints into a comma delimited
	 * string.
	 * @param a the array if Ints
	 * @param size the number of elements in the array. If 0 then `a` must
	 * end with a 0 element.
	 * @return StdString the command delimited string 
	 */
	@:native("simpleIntPointer")
	public function simpleIntPointer(a:cpp.RawPointer<Int>, size:Int):cpp.StdString;

	@:native("appendToString")
	public function appendToString(inStr:Reference<StdString>):cpp.StdString;

	@:native("simpleIntPointer2")
	public function simpleIntPointer2(a:cpp.RawPointer<Int>, size:Int):String;

	@:native("getMyStr")
	public function getMyStr():String;
	/**
	 * Call a c++ function to convert an array of Ints into a comma delimited
	 * string.
	 * @param a the array if Ints
	 * @param size the number of elements in the array. If 0 then `a` must
	 * end with a 0 element.
	 * @return String the command delimited string 
	 */
	// @:native("simpleIntPointer2")
	// public function simpleIntPointer2(a:cpp.RawPointer<Int>, size:Int):String;
}
