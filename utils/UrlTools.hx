package jp.okawa.utils;

import haxe.extern.EitherType;
 
class NumberTools {

	/* =======================================================================
		Insert Comma Delimiter
	========================================================================== */
	public static function insertCommaDelimiter(number:EitherType<String,EitherType<Int,Float>>):String {

		if (Type.typeof(number) == Type.ValueType.TInt) {
			number = new String(number);
		}
		if (Type.typeof(number) == Type.ValueType.TFloat) {
			number = new String(number);
		}

		var reg : EReg = ~/(\d)(?=(?:\d{3}){2,}(?:\.|$))|(\d)(\d{3}(?:\.\d*)?$)/g;
		return reg.replace(number,"$1$2,$3");

	}

	/* =======================================================================
		Remove Comma Delimiter
	========================================================================== */
	public static function removeCommaDelimiter(numberString:String):String {

		return ~/,/g.replace(numberString,'');

	}

	/* =======================================================================
		Get Random Integer
	========================================================================== */
	public static function getRandomRange(min:Float,max:Float):Float {

		return Math.random() * ( max - min ) + min;

	}


}