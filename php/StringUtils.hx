package jp.okawa.php;

import haxe.crypto.Md5;
import haxe.crypto.Sha1;
import php.Web;
 
class StringUtils {

	/* =======================================================================
		Get Uniq Id
	========================================================================== */
	public static function getUniqId():String {

		var ip   : String = Web.getClientIP();
		var date : String = DateTools.format(Date.now(), "%Y%m%d%H%M%S");
		return Md5.encode(Md5.encode(ip) + Sha1.encode(date));

	}

}