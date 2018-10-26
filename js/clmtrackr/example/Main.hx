package ;

import js.Browser.document;
import js.Browser.window;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.FileReader;
import js.html.Image;
import js.html.InputEvent;
import js.html.InputElement;
import clm.tracker.ClmTracker;

class Main {

	private static var _log      :Element;
	private static var _board    :Element;
	private static var _image    :CanvasElement;
	private static var _wireframe:CanvasElement;
	private static var _input    :InputElement;

	private static var _ctrack:ClmTracker;
	private static var _requestAnimation:Int;

	public static function main():Void {

		window.addEventListener('DOMContentLoaded',init);

	}

	private static function init():Void {

		_log = document.getElementById('log');

		setup();

		_ctrack = new ClmTracker();
		loadImage('files/img/image.png');

		_input = cast document.querySelector('[data-js="inputimage"]');
		_input.addEventListener('change',onInputImage);

	}

	private static function onInputImage(event:InputEvent) {

		window.cancelAnimationFrame(_requestAnimation);

		document.removeEventListener(clmtrackrConverged, onClmtrackrConverged);
		document.removeEventListener(clmtrackrLost, onClmtrackrLost);

		_ctrack.stop();
		clearCanvas(_image);
		clearCanvas(_wireframe);

		var reader:FileReader = new FileReader();
		reader.onload = function() {

			loadImage(reader.result);

		}
		reader.readAsDataURL(_input.files.item(0));

	}

	private static function setup():Void {

		_image     = document.createCanvasElement();
		_wireframe = document.createCanvasElement();
		_board     = document.getElementById('board');

		_board.appendChild(_image);
		_board.appendChild(_wireframe);

	}

	private static function loop(?timeStamp:Float):Void {

		_requestAnimation = window.requestAnimationFrame(loop);
		clearCanvas(_wireframe);

		if (_ctrack.getCurrentPosition()) {

			_ctrack.draw(_wireframe);

		}

	}

	private static function getMaxMin(array:Array<Float>):{max:Float,min:Float} {

		var min:Float = array[0];
		var max:Float = array[0];
		for (target in array) {
			min = Math.min(min,target);
			max = Math.max(max,target);
		}

		return { max:max,min:min };

	}

	private static function loadImage(src:String):Void {

		log('Analyze...');
		var image:Image = new Image();
		image.onload = function() {

			draw(image);

		}

		image.src = src;

	}

	private static function draw(image:Image):Void {

		var width :Int = _image.width  = _wireframe.width  = image.width;
		var height:Int = _image.height = _wireframe.height = image.height;

		_board.style.width  = width  + 'px';
		_board.style.height = height + 'px';
		_image.getContext2d().drawImage(image, 0, 0, width,height);

		loop();

		document.addEventListener(clmtrackrConverged, onClmtrackrConverged);
		document.addEventListener(clmtrackrLost,onClmtrackrLost);

		_ctrack.reset();
		_ctrack.init(untyped pModel);
		_ctrack.start(_image);

	}

	private static function clearCanvas(canvas:CanvasElement) {

		canvas.getContext2d().clearRect(0, 0, canvas.width, canvas.height);

	}

	private static function onClmtrackrConverged() {

		document.removeEventListener(clmtrackrConverged, onClmtrackrConverged);
		document.removeEventListener(clmtrackrLost, onClmtrackrLost);

		log('Success');
		window.cancelAnimationFrame(_requestAnimation);

	}

	private static function onClmtrackrLost() {

		document.removeEventListener(clmtrackrConverged, onClmtrackrConverged);
		document.removeEventListener(clmtrackrLost, onClmtrackrLost);

		log('Not found');
		window.cancelAnimationFrame(_requestAnimation);
		_ctrack.stop();

	}

	private static function log(message:String):Void {

		_log.textContent = message;

	}

}
