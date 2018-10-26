package jp.okawa.js.url;

import js.Browser;
import js.html.Window;
import js.jquery.Event;
import js.jquery.JQuery;

class URLParser {

	public var url      (default,null):String;
	public var source   (default,null):String;
	public var protocol (default,null):String;
	public var authority(default,null):String;
	public var userInfo (default,null):String;
	public var user     (default,null):String;
	public var password (default,null):String;
	public var host     (default,null):String;
	public var port     (default,null):String;
	public var relative (default,null):String;
	public var path     (default,null):String;
	public var directory(default,null):String;
	public var file     (default,null):String;
	public var query    (default,null):String;
	public var anchor   (default,null):String;

	public var queries  (default,null):Map<String,String>;
	public var filename (default,null):String;

	private static var KEYS:Array<String> = ['source','protocol','authority','userInfo','user','password','host','port','relative','path','directory','file','query','anchor'];

	/* =======================================================================
		New
	========================================================================== */
	public function new(url:String) {

		this.url = url;

		var r:EReg = ~/^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/;

		r.match(url);

		for (i in 0...KEYS.length) {
			Reflect.setField(this,KEYS[i],r.matched(i));
		}

		queries = getParseQueries(query);

		if (authority != null && 0 < authority.indexOf('.html')) {
			filename = authority.split('.html')[0];
		}

	}

		/* =======================================================================
			To String
		========================================================================== */
		public function toString():String {

			var s:String = 'For Url -> " + url + "\n';
			for (i in 0...KEYS.length) {
				s += KEYS[i] + ': ' + Reflect.field(this, KEYS[i]) + (i == KEYS.length - 1 ? '':'\n');
			}
			return s;

		}

		/* =======================================================================
			Get Remove Query URL
		========================================================================== */
		public function getRemoveQueryURL():String {

			if (-1 < url.indexOf('?')) {
				return url.split('?' + query)[0];
			}
			return url;

		}

		/* =======================================================================
			Parse
		========================================================================== */
		public static function parse(url:String):URLParser {

			return new URLParser(url);

		}

		/* =======================================================================
			Get Query
		========================================================================== */
		public function getQuery(key:String):String {

			if (!existsQuery(key)) return null;
			return queries.get(key);

		}

		/* =======================================================================
			Exists Query
		========================================================================== */
		public function existsQuery(key:String):Bool {

			if (queries == null) return false;
			var target:String = queries[key];
			return target != null && 0 < target.length && target != '';

		}

	/* =======================================================================
		Get Parse Queries
	========================================================================== */
	private function getParseQueries(query:String):Map<String,String> {

		if (query == null || query == '') return null;

		var map   :Map<String,String> = new Map();
		var params:Array<String> = 0 < query.indexOf('&') ? query.split('&') : [query];

		for (param in params) {
			var p:Array<String> = param.split('=');
			map[p[0]] = p[1];
		}

		return map;

	}

}
