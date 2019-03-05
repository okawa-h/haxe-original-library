package js.miniMasonry;

typedef Parameters = {
	?baseWidth:Int,
	container:String,
	?gutter:Int,
	?minify:Bool
}

@:native('MiniMasonry')
extern class MiniMasonry {

	public function new(parameters:Parameters);
	public function layout():Void;

}
