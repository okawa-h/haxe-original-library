package jp.okawa.js.urlTools;

import js.Browser;

class Query {

	private var _paramsMap : Map<String,String>;

	/* =======================================================================
		Constractor
	========================================================================== */
	public function new():Void {

		_paramsMap = new Map();
		var search : String = Browser.location.search;
		if (search.indexOf('#') == -1) {
			_paramsMap['init'] = 'init';
			return;
		}
		var url    : String = search.substring(1);
		var params : Array<String> = (url.indexOf('&') > 0) ? url.split('&') : [url];
		
		for (i in 0 ... params.length) {
			var elm : Array<String> = params[i].split('=');
			_paramsMap[StringTools.urlDecode(elm[0])] = StringTools.urlDecode(elm[1]);
		}

	}

	/* =======================================================================
		Exists
	========================================================================== */
	public function exists(key:String):Bool {

		return _paramsMap.exists(key);

	}

	/* =======================================================================
		Get
	========================================================================== */
	public function get(key:String):String {

		return _paramsMap.get(key);

	}

}