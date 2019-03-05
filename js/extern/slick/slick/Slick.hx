package slick;

import haxe.extern.EitherType;
import js.jquery.JQuery;

extern class Slick implements js.jquery.Plugin {

	@:overload public function slick(method:String,?options1:Dynamic,?options2:Dynamic,?options3:Dynamic):JQuery;
	@:overload public function slick(method:String,?options1:Dynamic,?options2:Dynamic):JQuery;
	@:overload public function slick(method:String,?options:Dynamic):JQuery;
	@:overload public function slick(?options:Dynamic):JQuery;

}
