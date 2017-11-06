package jp.okawa.api;
 
import haxe.Http;
import haxe.Json;

class YahooWeather {

	/* =======================================================================
		ajax
	========================================================================== */
	public static function contact(callback = null):Void {

		var request = new Http("../../../php/ajax.php");

		request.setParameter("url","http://rss.weather.yahoo.co.jp/rss/days/4610.xml");

        request.onData = (callback != null) ? callback : onSuccess;
        request.request( false );

	}

	/* =======================================================================
		On Success
	========================================================================== */
	private static function onSuccess(data:Dynamic):Void {

		trace(Json.parse(data));

	}

}