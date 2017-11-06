package jp.okawa.utils;

import StringTools;
 
class StringUtils {

	/* =======================================================================
		Split　By　Length
	========================================================================== */
	public static function splitByLength(string:String,length:Int):Array<String> {

		var result : Array<String> = [];
		if (string.length < 1 || length < 1) return [string];

		var index : Int = 0;
		var start : Int = index;
		var end   : Int = start + length;
		while (start < string.length) {
			result[index] = string.substring(start, end);
			index++;
			start = end;
			end = start + length;
		}
		return result;

	}

	/* =======================================================================
		Remove Html Tag
	========================================================================== */
	public static function removeHtmlTag(string:String):String {

		return ~/<("[^"]*"|'[^']*'|[^'">])*>/g.replace(string,'');

	}

	/* =======================================================================
		Is Hiragana Text
	========================================================================== */
	public static function isHiraganaText(text:String):Bool {

		var charArray : Array<String> = text.split('');
		for (i in 0 ... charArray.length) {
			if (!isHiragana(charArray[i])) return false;
		}
		return true;

	}

	/* =======================================================================
		Is Hiragana
	========================================================================== */
	public static function isHiragana(char:String):Bool {

		var unicode : Int = char.charCodeAt(0);
		if ( unicode >= 0x3040 && unicode <= 0x309f ) return true;
		return false;

	}

	/* =======================================================================
		Is Katakana
	========================================================================== */
	public static function isKatakana(char:String):Bool {

		var unicode : Int = char.charCodeAt(0);
		if ( unicode >= 0x30a0 && unicode <= 0x30ff ) return true;
		return false;

	}

	/* =======================================================================
		To Consonant Marks
	========================================================================== */
	public static function toConsonantMarks(text:String):String {

		var before : Array<String> = ['が','ぎ','ぐ','げ','ご','ざ','じ','ず','ぜ','ぞ','だ','ぢ','づ','で','ど','ば','び','ぶ','べ','ぼ','ヴ','ガ','ギ','グ','ゲ','ゴ','ザ','ジ','ズ','ゼ','ゾ','ダ','ヂ','ヅ','デ','ド','バ','ビ','ブ','ベ','ボ','ぱ','ぴ','ぷ','ぺ','ぽ','パ','ピ','プ','ペ','ポ'];    
		var after : Array<String> = ['が','ぎ','ぐ','げ','ご','ざ','じ','ず','ぜ','ぞ','だ','ぢ','づ','で','ど','ば','び','ぶ','べ','ぼ','ヴ','ガ','ギ','グ','ゲ','ゴ','ザ','ジ','ズ','ゼ','ゾ','ダ','ヂ','ヅ','デ','ド','バ','ビ','ブ','ベ','ボ','は','ひ','ぷ','ぺ','ぽ','パ','ピ','プ','ペ','ポ'];
		for (i in 0 ... before.length) {
			text = new EReg(before[i],'g').replace(text,after[i]);
		}
		return text;

	}

	/* =======================================================================
		Katakana To Hiragana
	========================================================================== */
	public static function katakanaToHiragana(text:String):String {

		return ~/[\u30a1-\u30f6]/g.replace(text,untyped function(match:String):String {
			var chr : Int = match.charCodeAt(0) - 0x60;
			return String.fromCharCode(chr);
		});

	}

	/* =======================================================================
		Hiragana To Katakana
	========================================================================== */
	public static function hiraganaToKatagana(text:String):String {

		return ~/[\u3041-\u3096]/g.replace(text,untyped function(match:String):String {
			var chr : Int = match.charCodeAt(0) + 0x60;
			return String.fromCharCode(chr);
		});

	}

	/* =======================================================================
		Wrap Wrap
	========================================================================== */
	public static function wordwrap(text:String,wrap:String='\''):String {

		return wrap + text + wrap;

	}

}