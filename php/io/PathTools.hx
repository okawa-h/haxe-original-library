package jp.okawa.php.io;

import haxe.io.Path;

class PathTools {

	/* =======================================================================
		Get File Directory
	========================================================================== */
	public static function getFileDirectory():String {

		var directory : String = untyped __php__('__FILE__').split('lib')[0];
		return Path.directory(directory);

	}

}