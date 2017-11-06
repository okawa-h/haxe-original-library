package jp.okawa.js;

import js.jquery.JQuery;
 
class AdjustHeight {

	private var _jParent : JQuery;
	private var _jLists  : JQuery;

	/* =======================================================================
		Constractor
	========================================================================== */
	public function new(jParent:JQuery,?childName:String):Void {

		_jParent = jParent;
		_jLists  = (childName == null) ? _jParent.find('li') : _jParent.find(childName);
		setHeight();

	}

		/* =======================================================================
			On Resize
		========================================================================== */
		public function onResize():Void {

			setHeight();

		}

	/* =======================================================================
		Set Height
	========================================================================== */
	private function setHeight():Void {

		clear();
		var row    : Int   = getRow();
		var length : Int   = _jLists.length;
		var remain : Int   = length % row;
		var maxH   : Float = 0;

		for (i in 0 ... length) {

			var height : Float = _jLists.eq(i).height();
			if (maxH < height) maxH = height;

			if (i%row == row - 1) {
				
				for (l in 0 ... row) {
					_jLists.eq(i - l).height(maxH);
				}
				maxH = 0;

			}
		}

		if (remain == 0) return;
		for (i in 0 ... remain) {
			_jLists.eq(length - 1 - i).height(maxH);
		}

	}

	/* =======================================================================
		Get Row
	========================================================================== */
	private function getRow():Int {

		return Math.floor(_jParent.width() / _jLists.width());

	}

	/* =======================================================================
		Get Column
	========================================================================== */
	private function getColumn(row:Int):Int {

		return Math.ceil(_jLists.length / row);

	}

	/* =======================================================================
		Clear
	========================================================================== */
	private function clear():Void {

		_jLists.height('auto');

	}

}