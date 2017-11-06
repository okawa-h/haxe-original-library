package jp.okawa.js;
 
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Image;
import js.html.Uint8ClampedArray;

class ImageTools {

	/* =======================================================================
		Get Pixel Data
	========================================================================== */
	public static function getPixelData(image:Image):Uint8ClampedArray {

		var canvas : CanvasElement = Browser.document.createCanvasElement();
		canvas.width  = image.width;
		canvas.height = image.height;
		var ctx : CanvasRenderingContext2D = canvas.getContext('2d');
		ctx.drawImage(image,0,0);
		return ctx.getImageData(0,0,canvas.width,canvas.height).data;

	}

}