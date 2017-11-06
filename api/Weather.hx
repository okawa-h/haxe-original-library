package jp.okawa.api;
 
import haxe.Http;
import haxe.Json;
import jp.Jsonp;

class Weather {

	/* =======================================================================
		New
	========================================================================== */
	public function new():Void {

	}

	/* =======================================================================
		ajax
	========================================================================== */
	public static function contact(areaId,callback = null):Void {

		var http = new Jsonp("http://weather.livedoor.com/forecast/webservice/json/v1" + "?city=" + areaId);
		http.onData = function(data) {
		  trace(data);
		}
		http.request("jp.okawa.api.Weather.success()");

        // var request : Http = new Http("http://weather.livedoor.com/forecast/webservice/json/v1");

        // request.setParameter("city",areaId);
        // request.setParameter("callback","Weather.auccess");

        // request.onData = (callback != null) ? callback : onSuccess;
        // request.request( false );

	}

	/* =======================================================================
		On Success
	========================================================================== */
	private static function success(data:Dynamic):Void {

		trace(Json.parse(data));

	}

	/* =======================================================================
		On Success
	========================================================================== */
	private static function onSuccess(data:Dynamic):Void {

		trace(Json.parse(data));

	}

}