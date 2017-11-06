package jp.okawa.utils;

import haxe.Http;
import haxe.Json;

typedef Params = Map<String,String>;
 
class HttpRequest {

	private var _path : String;
	
	/* =======================================================================
		Contractor
	========================================================================== */
	public function new(path:String='/api/'):Void {

		_path = path;

	}
	
		/* =======================================================================
			Get JSON
		========================================================================== */
		public function getJSON(name:String,params:Params,onLoaded:Dynamic->Void):Void {
			
			getString(name,params,function(data:String):Void {

				onLoaded(Json.parse(data));

			});
			
		}
		
		/* =======================================================================
			Get String
		========================================================================== */
		public function getString(name:String,params:Params,?onLoaded:String->Void):Void {
			
			var http : Http = new Http(_path + name);
			
			http.onData = function(data:String):Void {
				if (onLoaded != null) onLoaded(data);
			};

			if (params != null) {
				for (key in params.keys()) http.setParameter(key,params[key]);
			}
			
			http.request(true);
			
		}

}