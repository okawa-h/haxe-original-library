package jp.okawa.utils;

class ArrayTools {

	/* =======================================================================
		Get Random
	========================================================================== */
	public static function getRandom(it:Array<Dynamic>):Dynamic {

		return it[Math.floor(Math.random() * it.length)];

	}

	/* =======================================================================
		Shuffle
	========================================================================== */
	public static function shuffle(it:Array<Dynamic>):Array<Dynamic> {

		return it.sort(function(a:Dynamic,b:Dynamic):Int {
			return Math.floor(Math.random()-0.5);
		});

	}

}