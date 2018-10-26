package jp.okawa.utils;

class ArrayTools {

	/* =======================================================================
		Shuffle
	========================================================================== */
	public static function shuffle(it:Array<Dynamic>):Array<Dynamic> {

		return it.sort(function(a:Dynamic,b:Dynamic):Int {
			return Math.floor(Math.random()-0.5);
		});

	}

	/* =======================================================================
		Get Random
	========================================================================== */
	public static function getRandom(it:Array<Dynamic>):Dynamic {

		return it[Math.floor(Math.random() * it.length)];

	}

	/* =======================================================================
		Exists Params Value
	========================================================================== */
	public static function existsParamValue(array:Array<Dynamic>,paramName:String,target:Dynamic):Bool {
		
		for (info in array) {
			if (Reflect.hasField(info,paramName)) continue;
			if (Reflect.getProperty(info,paramName) == target) return true;
		}
		return false;

	}

}