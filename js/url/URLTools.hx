package jp.okawa.js.url;

import js.Browser;

class URLTools {

	/* =======================================================================
		Is Inside URL 
	========================================================================== */
	public static function isInsideURL(url:String):Bool {

		var reg:EReg = new EReg('^(https?:)?//' + Browser.document.domain,'i');
		return reg.match(url) || url.charAt(0) == '/';

	}

}