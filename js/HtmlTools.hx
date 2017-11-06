package jp.okawa.js;
 
 import haxe.extern.EitherType;

class HtmlTools {

	/* =======================================================================
		Wrap Tag
	========================================================================== */
	public static function wrapTag(target:String,tag:String):String {

		return '<$tag>$target</$tag>';

	}

	/* =======================================================================
		Text To Wrap Tag
	========================================================================== */
	public static function textToWrapTag(text:EitherType<String,Int>,tag:String):String {

		var string : String = Std.string(text);
		var array  : Array<String> = string.split('');
		var html  : String = '';
		for (i in 0 ... array.length) {
			html += wrapTag(array[i],tag);
		}
		return html;

	}

}