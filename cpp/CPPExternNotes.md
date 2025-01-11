# CPP Extern Notes

- [CPP Extern Notes](#cpp-extern-notes)
  - [Introduction](#introduction)
  - [Patterns](#patterns)
    - [Constructors](#constructors)
      - [Constructor - Stack allocated, object, struct access](#constructor---stack-allocated-object-struct-access)
      - [Constructor - Heap allocated, pointer to object, struct access](#constructor---heap-allocated-pointer-to-object-struct-access)
      - [Constructor - Heap allocated, pointer of type pointer to object, pointer access](#constructor---heap-allocated-pointer-of-type-pointer-to-object-pointer-access)
      - [Constructor - Stack allocated, object reference, struct access](#constructor---stack-allocated-object-reference-struct-access)
    - [Function Calls with Basic Types](#function-calls-with-basic-types)
      - [Simple call with basic type returns](#simple-call-with-basic-type-returns)
      - [Simple call with basic type parameters and pointer to basic type return](#simple-call-with-basic-type-parameters-and-pointer-to-basic-type-return)
      - [Simple call with basic type parameters and return](#simple-call-with-basic-type-parameters-and-return)
      - [Simple call with basic type out parameter](#simple-call-with-basic-type-out-parameter)
    - [Invoking Haxe from C++](#invoking-haxe-from-c)
      - [A module function callback](#a-module-function-callback)


In general the plan is to have an extern project here for a kind of native
type. The library will cover as much of the functionality of the type as
is necessary to demonstate the principles and experiment with any difficult
cases. These examples are not intended to be exhaustive.

## Introduction

Essentially externs in Haxe provide a way to tell the compiler what code to generate in the transpiler output and how to present the extern on the Haxe level. It really is impossible I think to fully understand extern syntax and "modelling choices" as I'll call them without understanding the target language, and what Haxe statements translate to when transpiled. In the examples that follow some familiarity with C++ is assumed as the explanations would be much longer without that basis.

There are pairs of Haxe files, being a test class to demonstrate a collection of related features and a corresponding and similarly named `Test*.hx` which tests the functions to demonstrate how the externs are used. The extern classes themselves are part of the library under `extlib\cpp`. The thinking here is that a additional externs to different targets will be added and a generic layer abstracting away target specific types will be added above them.

## Patterns

### Constructors

These examples are in the `ClassConstruction.hx` module.

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

#### Constructor - Stack allocated, object, struct access

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

This object is created on the stack. In theory you would just use it and let it go out of scope. In this way it would act quite like a Haxe class. There is no need to destroy (in fact you cannot) as the class will just get cleaned up when the scope is exited. Returning this class instance from a function should work with standard C++ copy/move semantics but it is probably better particularly for a large object to use the following model.

#### Constructor - Heap allocated, pointer to object, struct access
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

#### Constructor - Heap allocated, pointer of type pointer to object, pointer access
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

#### Constructor - Stack allocated, object reference, struct access
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

### Function Calls with Basic Types

These examples are in the `BasicTypes.hx` and `TestBasicTypes.hx` modules.

There are a very large number of possible examples so I'll cherry pick examples I'm interested in. Feel free to request others or submit PRs.

#### Simple call with basic type returns

```
@:native("BasicTypes")
extern class BasicTypes {
...
...
...
	/**
	 * Get an Int by value.
	 * @return Int
	 */
	public function getInt():Int;
```

This just simply gets an int from C++. This extern is for the following C++
```
	int getInt();
```

Super simple and obvious and for basic types that's mostly the story.

#### Simple call with basic type parameters and pointer to basic type return

You can do pointer and reference returns even leveraging the C++ copy/move if you capture the return value in the single expression. For example, this Haxe
```
	public function getIntPtr():cpp.RawPointer<Int>;
```
externing this C++
```
	int* getIntPtr();
```
called with this Haxe
```
		var i = bt.getIntPtr()[0];
```
generates this transpile output
```
HXLINE(  27)		int i = bt.getIntPtr()[0];
```
which captures the return value from the pointer before the end of the C++ expression. If you just keep the pointer as `var i = bt.getIntPtr()` and then try to dereference `i[0]` later it will be a dangling pointer.

The same approach is demonstrated with references and with booleans. References are nice in the that they do not require the `[0]` to dereference.

#### Simple call with basic type parameters and return

Given this Haxe
```
	/**
	 * Sum two integers.
	 * @return Int
	 */
	public function sum(a:Int, b:Int):Int;
```
over this C++
```
	int sum(int a, int b);
```
and called from
```
		var v = bt.sum(16, 12);
```

So this is again a very simple case for basic types.

#### Simple call with basic type out parameter

Given this Haxe
```
	/**
	 * Sum two values and return the result via an out parameter.
	 */
	public function sumOutParam(a:Int, b:Int, out:cpp.RawPointer<Int>):Void;
```
over this C++
```
	void sumOutParam(int a, int b, int* out);
```
it requires a RawPointer as do all basic types. But here there is a small bug in the compiler (as of Haxe 4.3.6) where you would expect
```
		var rv:Int = 0;
		bt.sumOutParam(16, 12, RawPointer.addressOf(rv));
```
to work it does not. This generates invalid C++ because `rv` is optimized out. To work around this one case do either of the following
```
		var rv:AsVar<Int> = 0;
		bt.sumOutParam(16, 12, RawPointer.addressOf(rv));
```
or 
```
		var rv:Int = 0;
		bt.sumOutParam(16, 12, Pointer.addressOf(rv).raw);
```
I'd probably recommend the latter as it should be compatible with the fixed and the existing code.

### Invoking Haxe from C++

The first thing to say about this is that this is not actually what happens. What happens is that you pass a function in some way to the extern and then it's called by C++. But all of this actually happens in C++ when executed at runtime. Regardless of how it actually works though, it is convenient to think of it as being a Haxe function called from C++, and that's how it's colloquially described. And in the end there are reasons why that's not as wildly inaccurate as it might first seem.

That out of the way, there are at least three ways I can see this being done. The first example here is the registering of a module level Haxe function as a simple callback.

#### A module function callback

These examples are in

|File|Description|
|-|-|
|callbackexamples.h|The C++ library header|
|callbackexamples.cpp|The C++ implementation|
|CallbackExamples.hx|The Haxe extern model for the CallbackExamples C++ class|
|TestCallbackExamples.hx|The Haxe unit test showing how to use the extern in various cases|

Given a Haxe function at the module level
```
/**
 * `add` is a callback function that will be invoked from the C++ side of the extern.
 * In this case it simply adds the two integers and returns the result.
 * @param a 
 * @param b 
 * @return Int a + b
 */
function add(a:Int, b:Int):Int {
	return a + 2 * b;
}
```
and the following extern class model
```
extern class CallbackExamples {
	/**
	 * Factory function mapped to the native constructor.
	 * @return an BasicTypes instance
	 */
	// @:native("new BasicTypes")
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
```
we can pass the `add()` function to an instance of the `CallbackExamples` during construction. Later we can cause that callback `add()` to be run by calling `CallbackExamples.invoke()`. This may be done this way in Haxe
```
		var ce = CallbackExamples.create(Function.fromStaticFunction(add));
        var result = ce.invoke(100, 120);
```
