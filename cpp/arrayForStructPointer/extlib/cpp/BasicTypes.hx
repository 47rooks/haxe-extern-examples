package;

@:structAccess
@:include("./mylib/basictypes.h")
@:buildXml('
    <target  id="haxe">
    <lib name="..\\..\\extlib\\cpp\\mylib\\x64\\Debug\\mylib.lib"/>
	</target>
')
// @:native("BasicTypes *")
@:native("BasicTypes")
extern class BasicTypes {
	/**
	 * Factory function mapped to the native constructor.
	 * @return an BasicTypes instance
	 */
	// @:native("new BasicTypes")
	@:native("BasicTypes")
	public static function create():BasicTypes;

	/**
	 * Get an Int by value.
	 * @return Int
	 */
	public function getInt():Int;

	/**
	 * Get an pointer to an Int.
	 * Note, it is necessary to use a RawPointer here because we are
	 * returning a basic type. A `cpp.Pointer` would be used with a structure
	 * or class. The value pointed to by the raw pointer is extracted using
	 * array index 0, `getIntPtr()[0]`.
	 * @return cpp.RawPointer<Int>
	 */
	public function getIntPtr():cpp.RawPointer<Int>;

	/**
	 * Get a Ref to a Int.
	 * Note, a Reference is simply a typedef to the type, so the value is
	 * extracted through a simple cast to the type.
	 * @return cpp.Reference<Int>
	 */
	public function getIntRef():cpp.Reference<Int>;

	/**
	 * Get a Bool by value.
	 * @return Bool
	 */
	public function getBool():Bool;

	/**
	 * Get an pointer to an Bool.
	 * @return cpp.RawPointer<Bool>
	 */
	public function getBoolPtr():cpp.RawPointer<Bool>;

	/**
	 * Get a Ref to a Bool.
	 * @return cpp.Reference<Bool>
	 */
	public function getBoolRef():cpp.Reference<Bool>;
}