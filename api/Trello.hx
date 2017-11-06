package jp.okawa.api;
 
import haxe.Http;
import haxe.Json;

class Trello {

	private static var _USER  : String;
	private static var _KEY   : String;
	private static var _TOKEN : String;

	/* =======================================================================
		New
	========================================================================== */
	public function new(user:String,key:String,token:String):Void {

		_USER  = user;
		_KEY   = key;
		_TOKEN = token;

	}

	/* =======================================================================
		ajax
	========================================================================== */
	private static function contact(options:Map<String,String>,type:Bool = false,callback = null,custom = false):Void {

        if (custom) {

        	trace("https://trello.com/1/" + options.get("url") + "&key=" + _KEY + "&token=" + _TOKEN);

        	untyped $.ajax({

		        type     : "DELETE",
		        url      : "https://trello.com/1/" + options.get("url") + "&key=" + _KEY + "&token=" + _TOKEN ,
				dataType : 'json'

		    }).then(function(data) {

		    	if (callback == null) {

		    		onSuccess(data);

		    	} else {

		    		callback(data);

		    	}
		  
		    });
        } else {

	        options.set("key",_KEY);
	        options.set("token",_TOKEN);

	        var request : Http = new Http("https://trello.com/1/" + options.get("url"));

			for (key in options.keys()) {

				if (key == "url") continue;
				request.setParameter(key,options.get(key));

			}

	        request.onData = (callback != null) ? callback : onSuccess;
	        request.request( type );
	    }

	}

	/* =======================================================================
		On Success
	========================================================================== */
	private static function onSuccess(data:Dynamic):Void {

		trace(Json.parse(data));

	}

		/* =======================================================================
			Add Card
		========================================================================== */
		public function addCard(idList:String,name:String,callback = null):Void {

			var map : Map<String,String> = new Map();

			map.set("url","cards");
			map.set("idList",idList);
			map.set("name",name);

			contact(map,true,callback);

		}

		/* =======================================================================
			Remove Card
		========================================================================== */
		public function removeCard(idCard:String,callback = null):Void {

			var map : Map<String,String> = new Map();
			map.set("url","cards/" + idCard + "?");

			contact(map,false,callback,true);

		}

		/* =======================================================================
			Add List
		========================================================================== */
		public function addList(idBoard:String,name:String,callback = null):Void {

			var map : Map<String,String> = new Map();
			map.set("url","lists");
			map.set("idBoard",idBoard);
			map.set("name",name);
			
			contact(map,true,callback);
		}

		/* =======================================================================
			Get User All Board
		========================================================================== */
		public function getBoards(callback = null):Void {

			var map : Map<String,String> = new Map();
			map.set("url","members/" + _USER + "/boards");

			contact(map,false,callback);

		}

		/* =======================================================================
			Get Board
		========================================================================== */
		public function getBoard(idBord:String,callback = null) {

			var map : Map<String,String> = new Map();
			map.set("url","boards/" + idBord);

			contact(map,false,callback);

		}

		/* =======================================================================
			Get List
		========================================================================== */
		public function getList(idBord:String,callback = null) {

			var map : Map<String,String> = new Map();
			map.set("url","boards/" + idBord + "/lists");

			contact(map,false,callback);
		}

		/* =======================================================================
			Get All Card
		========================================================================== */
		public function getAllCard(idBord:String,callback = null) {

			var map : Map<String,String> = new Map();
			map.set("url","boards/" + idBord + "/cards");

			contact(map,false,callback);

		}

		/* =======================================================================
			Get Card Board
		========================================================================== */
		public function getListInCard(idList:String,callback = null) {

			var map : Map<String,String> = new Map();
			map.set("url","lists/" + idList + "/cards?");

			contact(map,false,callback);
		}


}