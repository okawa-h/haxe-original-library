package jp.okawa.js.encoding;

import haxe.extern.EitherType;
import js.html.ArrayBuffer;
import js.html.Uint8Array;

@:enum abstract EncodingNames(String) from String to String {

	var AUTO   :String = 'AUTO';
	var UTF32  :String = 'UTF32';
	var UTF32BE:String = 'UTF32BE';
	var UTF32LE:String = 'UTF32LE';
	var UTF16  :String = 'UTF16';
	var UTF16BE:String = 'UTF16BE';
	var UTF16LE:String = 'UTF16LE';
	var BINARY :String = 'BINARY';
	var ASCII  :String = 'ASCII';
	var JIS    :String = 'JIS';
	var UTF8   :String = 'UTF8';
	var EUCJP  :String = 'EUCJP';
	var SJIS   :String = 'SJIS';
	var UNICODE:String = 'UNICODE';

}

@:enum abstract ConvertType(String) from String to String {

	var string     :String = 'string';
	var arraybuffer:String = 'arraybuffer';
	var array      :String = 'array';

}

typedef ConvertSettingObject = {
	to   :EncodingNames,
	from :EncodingNames,
	?type:ConvertType,
	?bom :EitherType<Bool,String>
}
typedef FromData    = EitherType<ArrayBuffer,EitherType<Uint8Array,EitherType<Array<Dynamic>,String>>>;
typedef ConvertData = EitherType<ArrayBuffer,EitherType<Array<Dynamic>,String>>;

@:native('Encoding')
extern class Encoding {

	@:overload(function(data:FromData,to:EitherType<EncodingNames,ConvertSettingObject>):EitherType<Array<String>,String>{})
	public static function convert(data:FromData,to:EncodingNames,?from:EncodingNames):ConvertData;

	public static function detect(data:EitherType<Array<Int>,EitherType<Uint8Array,String>>,encodings:EitherType<String,Array<String>>):EitherType<String,Bool>;

	public static function urlEncode(data:EitherType<Array<Int>,Uint8Array>):String;
	public static function urlDecode(string:String):Array<Int>;

	public static function base64Encode(data:EitherType<Array<Int>,Uint8Array>):String;
	public static function base64Decode(string:String):Array<Int>;

	public static function codeToString(data:EitherType<Array<Int>,Uint8Array>):String;
	public static function stringToCode(data:String):Array<Int>;

	public static function toHankakuCase(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toZenkakuCase(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toHiraganaCase(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toKatakanaCase(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toHankanaCase(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toZenkanaCase(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toHankakuSpace(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;
	public static function toZenkakuSpace(data:EitherType<Array<Int>,String>):EitherType<Array<Int>,String>;

}
