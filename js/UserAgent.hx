package jp.okawa.js;

import js.Browser;
 
class UserAgent {
	
	public static var userAgent(default,null):String = Browser.window.navigator.userAgent;

	public static function getBrowserName():String {

		var _ua        : String = "miss";
		var user       : String = userAgent.toLowerCase();
		var appVersion : String = Browser.window.navigator.appVersion.toLowerCase();
		
		if (user.indexOf('msie') != -1 || user.indexOf('trident') != -1) {

		    _ua = 'IE6or11';

		    if (appVersion.indexOf("msie 6.") != -1) {

		      _ua = 'IE6';

		    } else if (appVersion.indexOf("msie 7.") != -1) {

		      _ua = 'IE7';

		    } else if (appVersion.indexOf("msie 8.") != -1) {

		      _ua = 'IE8';

		    } else if (appVersion.indexOf("msie 9.") != -1) {

		      _ua = 'IE9';

		    }

		} else if (user.indexOf('chrome') != -1) {

			_ua = 'Chrome';//Opera

		} else if (user.indexOf('safari') != -1) {

			_ua = 'Safari';

		} else if (user.indexOf('firefox') != -1) {

			_ua = 'Firefox';

		}

		return _ua;
	}

	public static function getDevice():String {

		var _device : String = 'pc';

		if ((userAgent.indexOf('iPhone') > 0 
			&& userAgent.indexOf('iPad') == -1) 
			|| userAgent.indexOf('iPod') > 0 
			|| userAgent.indexOf('Android') > 0) {

		    _device = 'sp';

		}

		return _device;
	}

}