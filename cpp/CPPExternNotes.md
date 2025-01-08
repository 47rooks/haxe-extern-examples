# CPP Extern Notes

- [CPP Extern Notes](#cpp-extern-notes)
  - [Introduction](#introduction)
  - [Patterns](#patterns)
    - [Constructor - Stack allocated, object, struct access](#constructor---stack-allocated-object-struct-access)
    - [Constructor - Heap allocated, pointer to object, struct access](#constructor---heap-allocated-pointer-to-object-struct-access)
    - [Constructor - Heap allocated, pointer of type pointer to object, pointer access](#constructor---heap-allocated-pointer-of-type-pointer-to-object-pointer-access)
    - [Constructor - Stack allocated, object reference, struct access](#constructor---stack-allocated-object-reference-struct-access)


In general the plan is to have an extern project here for a kind of native
type. The library will cover as much of the functionality of the type as
is necessary to demonstate the principles and experiment with any difficult
cases. These examples are not intended to be exhaustive.

## Introduction

Essentially externs in Haxe provide a way to tell the compiler what code to generate in the transpiler output and how to present the extern on the Haxe level. It really is impossible I think to fully understand extern syntax and "modelling choices" as I'll call them without understanding the target language, and what Haxe statements translate to when transpiled. In the examples that follow some familiarity with C++ is assumed as the explanations would be much longer without that basis.

## Patterns

Ways of modelling an extern class. There are four ways I know of currently
to extern a C++ class. They differ in where the memory is allocated and how
the class fields must be accessed from Haxe. The basic template is
```
@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
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
	public static function create():ClassConstruction;
```
This modelling is based on a similar example from a 10 year old talk by Hugh Sanderson. See the general README for a link to that.

Note the following points
   * `@:unreflective` means it will not participate in dynamic access. There is no constructor or cast for Dynamic in these examples.
   * @:structAccess will generate C++ code which uses `.field` access rather than `->field`. This is significant in that it is possible to generate invalid C++ code if it is used incorrectly. It should be used where the class `@:native` is not a `class *` style, and it must not be present where `@:native("Class *")` is used.
   * @:buildXml is to pull in the DLL into the compile link line.
   * @:include tells the compiler to add this include into the generated code for this class.
   * @:native tells the compiler to emit the quoted string in place of the class name. This appears to be a literal string replacement. In this case this becomes the type of the variable to which the newly created instance will be assigned. As such it must match the type of the return of the `create()` function.
   * The `create()` is a factory function. Why not just use `new` ? Well `new` is a Haxe keyword and it will cause the compile to emit the standard Haxe `new` code which is not what is wanted here. So instead we create a factory function, a static function that returns an instance of the object.  This function returns an instance of the class `ClassConstruction` (in Haxe), emitted as `BasicTypes` in C++ due to the `@:native`.

The code that this generates for a simple unit test using this extern is as follows.

Haxe code
```
	function testClassConstruction():Void {
		var bt = ClassConstruction.create();
		Assert.equals(10, bt.getInt());
	}
```
C++ code
```
void TestClassConstruction_obj::testClassConstruction(){
            	HX_STACKFRAME(&_hx_pos_e1cf47fe4bf5c573_9_testClassConstruction)
HXLINE(  10)		 BasicTypes bt = BasicTypes();
HXLINE(  11)		int _hx_tmp = bt.getInt();
HXDLIN(  11)		::utest::Assert_obj::equals(10,_hx_tmp,null(),::hx::SourceInfo(HX_("src/TestClassConstruction.hx",52,c3,f6,e0),11,HX_("TestClassConstruction",97,81,b8,d3),HX_("testClassConstruction",b7,51,25,09)));
            	}
```

As you can see above every string ClassConstruction in Haxe lines 10 and 11 has been converted to BasicTypes. Further the `bt.getInt()` shows struct access at work. If things are going wrong in the modelling of your extern be prepared to look into the generated `.cpp` file.

Most of these elements are retained regardless of the model of externing you choose. The four choices I know off are listed now.

### Constructor - Stack allocated, object, struct access

```
@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
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
	public static function create():ClassConstruction;
```

This is useful for a local that will not be retained beyond the scope it is created in. There is no need to destroy (in fact you cannot) as the class will just get cleaned up when the scope is exited.

### Constructor - Heap allocated, pointer to object, struct access
```
@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
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
	public static function create():cpp.Pointer<ClassConstructionPtrOfType>;
```

The memory for this is allocated on the heap and a pointer is returned. This is likely the most common use for any long lived object that must persist beyond the enclosing scope.

cpp generated from a simple test

```
void TestClassConstruction_obj::testClassConstructionPtrOfType(){
            	HX_STACKFRAME(&_hx_pos_e1cf47fe4bf5c573_14_testClassConstructionPtrOfType)
HXLINE(  15)		::cpp::Pointer<  BasicTypes > bt = (new BasicTypes());
HXLINE(  16)		int _hx_tmp = bt->get_value().getInt();
HXDLIN(  16)		::utest::Assert_obj::equals(10,_hx_tmp,null(),::hx::SourceInfo(HX_("src/TestClassConstruction.hx",52,c3,f6,e0),16,HX_("TestClassConstruction",97,81,b8,d3),HX_("testClassConstructionPtrOfType",48,73,32,13)));
HXLINE(  17)		bt->destroy();
            	}
```

Here it is worth pointing out that the HXLINE 16 translation here `bt->get_value().getInt();` is again structAccess. The `bt->get_value()` is the `cpp.Pointer` dereference but the actual `BasicTypes` access to the `getInt()` method is via the `.` operator, structure access.

### Constructor - Heap allocated, pointer of type pointer to object, pointer access
```
@:unreflective
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
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
	public static function create():cpp.Pointer<ClassConstructionPtrOfPtrToType>;
```

This seems pretty useless to me. It changes the C++ field access to use the `->` pointer access in place of the `.` field access. This is essentially invisible at the Haxe level. To demonstrate, this is the C++ code from a test to access the `getInt()` method.
```
HXLINE(  29)		int _hx_tmp = bt->get_value()->getInt();
```

### Constructor - Stack allocated, object reference, struct access
```
@:unreflective
@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
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
	public static function create():cpp.Reference<ClassConstructionRefOfType>;
```
This seems appealing but it really offers no benefit over the first case above and is stack allocated which limits its usefulness.