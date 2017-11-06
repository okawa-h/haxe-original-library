package jp.okawa.macro;

import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.io.File;
 
class Utils {

	public static function writeHead(comment:String='/*This is MIT License.*/\n'):Void {

		var fileName: String = Compiler.getOutput();
		File.saveContent(fileName, comment + File.getContent(fileName));

	}

}