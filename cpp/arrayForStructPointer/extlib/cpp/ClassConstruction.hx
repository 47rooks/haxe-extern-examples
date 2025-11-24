package;

/**
 * This module demonstrates different ways of modelling a C++ extern class
 * in Haxe. Individual comments indicate specific peculiarities. You will note
 * that the Haxe class can be called anything and yet refer to the particular
 * C++ class. It does this using the `@:native` metadata. This allows me
 * to create all the cases in one file. It is well worth examining the 
 * generated output C++ from the test code in `TestClassConstruction.cpp`
 * to see the impact of this and the `@:structAccess` metadata.
 */
@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
		<lib name="../../extlib/cpp/mylib/x64/Debug/mylib.a" if="linux"/>
		<lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib" if="windows"/>
	</target>
')
@:native("BasicTypes")
extern class ClassConstruction {
	/**
	 * Factory function mapped to the native constructor.
	 * This constructor allocates the object in stack memory and
	 * returns the object itself.
	 * 
	 * @return a ClassConstruction instance
	 */
	@:native("BasicTypes")
	public static function create(i:Int, b:Bool):ClassConstruction;

	/**
	 * Get an Int by value.
	 * @return Int
	 */
	public function getInt():Int;
}

@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
		<lib name="../../extlib/cpp/mylib/x64/Debug/mylib.a" if="linux"/>
		<lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib" if="windows"/>
	</target>
')
@:native("BasicTypes")
extern class ClassConstructionPtrOfType {
	/**
	 * Factory function mapped to the native constructor.
	 * This constructor allocates the class memory in the heap and returns
	 * a pointer to the object.
	 * 
	 * @return an cpp.Pointer to a ClassConstructionPtrOfType instance
	 */
	@:native("new BasicTypes")
	public static function create(i:Int, b:Bool):cpp.Pointer<ClassConstructionPtrOfType>;

	/**
	 * Get an Int by value.
	 * @return Int
	 */
	public function getInt():Int;
}

@:unreflective
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
		<lib name="../../extlib/cpp/mylib/x64/Debug/mylib.a" if="linux"/>
		<lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib" if="windows"/>
	</target>
')
@:native("BasicTypes *")
extern class ClassConstructionPtrOfPtrToType {
	/**
	 * Factory function mapped to the native constructor.
	 * This constructor allocates the class memory in the heap and returns
	 * a cpp.Pointer of a pointer to the object.
	 * 
	 * @return an cpp.Pointer of a pointer to a ClassConstructionPtrOfPtrToType
	 * instance
	 */
	@:native("new BasicTypes")
	public static function create(i:Int, b:Bool):cpp.Pointer<ClassConstructionPtrOfPtrToType>;

	/**
	 * Get an Int by value.
	 * @return Int
	 */
	public function getInt():Int;
}

@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
		<lib name="../../extlib/cpp/mylib/x64/Debug/mylib.a" if="linux"/>
		<lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib" if="windows"/>
	</target>
')
@:native("BasicTypes")
extern class ClassConstructionRefOfType {
	/**
	 * Factory function mapped to the native constructor.
	 * This constructor allocates the object in stack memory and
	 * returns the object itself.
	 * 
	 * @return a cpp.Reference of ClassConstructionRefOfType instance
	 */
	@:native("BasicTypes")
	public static function create(i:Int, b:Bool):cpp.Reference<ClassConstructionRefOfType>;

	/**
	 * Get an Int by value.
	 * @return Int
	 */
	public function getInt():Int;
}
