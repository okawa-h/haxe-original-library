package jp.okawa.js;

import js.jquery.JQuery;
 
class ListTools {

	/* =======================================================================
		ajust Box Height
	========================================================================== */
	public static function ajustBoxHeigh(jParent:JQuery,?childname:String):Void {

		var jList : JQuery = (childname == null) ? jParent.find('li') : jParent.find(childname);
		var row   : Int    = Math.floor(jParent.width()/jList.width());

		jList.height('auto');

		for (i in 0 ... jList.length) {

			if (i%row == row - 1) {

				var maxH : Float = 0;

				for (l in 0 ... row) {

					var jTarget : JQuery = jList.eq(i - l);
					var curH    : Float  = jTarget.height();
					if (maxH < curH) maxH = curH;

				}
				
				for (l in 0 ... row) {
					jList.eq(i - l).height(maxH);
				}

			}
		}

	}

}