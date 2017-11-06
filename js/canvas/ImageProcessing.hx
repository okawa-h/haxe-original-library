package jp.okawa.js.canvas;
 
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.ImageData;
import js.html.Uint8ClampedArray;

class ImageProcessing {

	/* =======================================================================
		Set Qualify
	========================================================================== */
	public static function setQualify(canvas:CanvasElement,scale:Float):Void {

		canvas.width  = Math.floor(canvas.width  * scale);
		canvas.height = Math.floor(canvas.height * scale);
		canvas.getContext2d().scale(scale,scale);

	}

	/* =======================================================================
		Image Data Counter
	========================================================================== */
	private static function imageDataCounter(canvas:CanvasElement,process:Uint8ClampedArray->Int->Void):Void {

		var ctx : CanvasRenderingContext2D = canvas.getContext2d();
		var imageData : ImageData = ctx.getImageData(0,0,canvas.width,canvas.height);
		var units     : Uint8ClampedArray = imageData.data;
		var index     : Int = 0;
		var length    : Int = Math.floor(units.length * .25);
		for (i in 0 ... length) {
			process(units,index);
			index += 4;
		}
		ctx.putImageData(imageData,0,0);

	}

	/* =======================================================================
		Draw Monochrome
	========================================================================== */
	public static function drawMonochrome(canvas:CanvasElement):Void {

		imageDataCounter(canvas,function(units:Uint8ClampedArray,index:Int):Void {

			var unity : Float = units[index]*.2126 + units[index+1]*.7152 + units[index+2]*.0722;
			units[index] = units[index+1] = units[index+2] = Math.floor(unity);

		});

	}

	/* =======================================================================
		Draw Threshold
	========================================================================== */
	public static function drawThreshold(canvas:CanvasElement,isDetail:Bool=false):Void {

		var total : Float = 0;
		imageDataCounter(canvas,function(units:Uint8ClampedArray,index:Int):Void {

			var v : Float = units[index]*.298912 + units[index+1]*.586611 + units[index+2]*.114478;

			if (isDetail) {

				if (canvas.height/index == 0) total = 0;
				total += v;
				if (total > 255) {
					total = total - 255;
					units[index] = units[index + 1] = units[index + 2] = 255;
				} else {
					units[index] = units[index + 1] = units[index + 2] = 0;
				}
				
			} else {

				if (v > 0x88) {
					units[index] = units[index + 1] = units[index + 2] = 255;
				} else {
					units[index] = units[index + 1] = units[index + 2] = 0;
				}

			}

		});

	}

	/* =======================================================================
		Draw Negative Reverse
	========================================================================== */
	public static function drawNegativeReverse(canvas:CanvasElement):Void {

		imageDataCounter(canvas,function(units:Uint8ClampedArray,index:Int):Void {

			units[index]     = 255 - units[index];
			units[index + 1] = 255 - units[index + 1];
			units[index + 2] = 255 - units[index + 2];

		});

	}

	/* =======================================================================
		Draw Mosaic
	========================================================================== */
	public static function drawMosaic(canvas:CanvasElement,size:Int=10):Void {

		imageDataCounter(canvas,function(units:Uint8ClampedArray,index:Int):Void {

			units[index]     = 255 - units[index];
			units[index + 1] = 255 - units[index + 1];
			units[index + 2] = 255 - units[index + 2];

		});

	}

	/* =======================================================================
		Draw Quantize
	========================================================================== */
	public static function drawQuantize(canvas:CanvasElement):Void {

		imageDataCounter(canvas,function(units:Uint8ClampedArray,index:Int):Void {

			var r = units[index]&0xFF;
			var g = units[index+1]&0xFF;
			var b = units[index+2]&0xFF;
			var gray  = Math.floor((r+g+b)/3);
			var quant = gray & 0xC0;
			units[index]   = quant;
			units[index+1] = quant;
			units[index+2] = quant;

		});

	}

	/* =======================================================================
		Draw Detect Edge
	========================================================================== */
	public static function drawDetectEdge(canvas:CanvasElement):Void {

		var ctx : CanvasRenderingContext2D = canvas.getContext2d();
		var width  : Int = canvas.width;
		var height : Int = canvas.height;
		var imageData : ImageData = ctx.getImageData(0,0,width,height);
		var data      : Uint8ClampedArray = imageData.data;
		var length    : Int = Math.floor(data.length * .25);
		var dataQuant : Array<Float> = [];

		var index : Int = 0;
		for (i in 0 ... length) {

			var r : Int = data[index]  &0xFF;
			var g : Int = data[index+1]&0xFF;
			var b : Int = data[index+2]&0xFF;
			var gray : Int = Math.floor((r+g+b)/3);
			index += 4;
			dataQuant.push(gray&0xC0);
			
		}

		var edgeData : ImageData = ctx.createImageData(width,height);
		for (y in 0 ... height - 1) {
			for (x in 0 ... width - 1) {

				var i : Int = y * width + x;
				var around : Float = (dataQuant[i-width]+dataQuant[i-1]+dataQuant[i+1]+dataQuant[i+width])/4;
				var c : Int = (around < dataQuant[i]) ? 0 : 255;
				edgeData.data[i*4] = c;
				edgeData.data[i*4+1] = c;
				edgeData.data[i*4+2] = c;
				edgeData.data[i*4+3] = 255;

			}
		}

		ctx.putImageData(edgeData,0,0);

	}

}