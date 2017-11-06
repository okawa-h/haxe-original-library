package jp.okawa.utils;

class MapTools {

	/* =======================================================================
		Remove Match Character
	========================================================================== */
	public static function removeMatchCharacter(map:Map<String,String>,matchEReg:EReg):Void {

		for (key in map.keys()) {
			if (matchEReg.match(map[key])) {
				map.remove(key);
			}
		}

	}

}