package jp.okawa.js.canvas;
 
import js.Browser;
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
		Clone Image Data
	========================================================================== */
	private static function cloneImageData(imageData:ImageData):ImageData {

		var canvas : CanvasElement = Browser.document.createCanvasElement();
		canvas.width  = imageData.width;
		canvas.height = imageData.height;
		var context : CanvasRenderingContext2D = canvas.getContext('2d');
		context.putImageData(imageData, 0, 0);
		return context.getImageData(0, 0, imageData.width, imageData.height);

	}

	/* =======================================================================
		Image Data Counter
	========================================================================== */
	private static function imageDataCounter(canvas:CanvasElement,process:Uint8ClampedArray->Int->Void):Void {

		var context   : CanvasRenderingContext2D = canvas.getContext2d();
		var imageData : ImageData = context.getImageData(0,0,canvas.width,canvas.height);
		var units     : Uint8ClampedArray = imageData.data;
		var index     : Int = 0;
		var length    : Int = Math.floor(units.length * .25);
		for (i in 0 ... length) {
			process(units,index);
			index += 4;
		}
		context.putImageData(imageData,0,0);

	}

	/* =======================================================================
		Draw Dot
	========================================================================== */
	public static function drawDot(canvas:CanvasElement,size:Int=5):Void {

		var width   : Int = canvas.width;
		var height  : Int = canvas.height;
		var context : CanvasRenderingContext2D = canvas.getContext2d();
		var imageData : ImageData = context.getImageData(0,0,width,height);
		var units     : Uint8ClampedArray = imageData.data;

		for (y in 0 ... height) {
			var counter : Int = 0;
			var flag    : Int = 1;
			for (x in 0 ... width) {

				var target : Int = (y * width + x) * 4;
				if (counter <= 0) units[target + 3] = 0;

				counter += flag;
				if (Math.abs(counter) == size) {
					counter = 0;
					flag * -1;
				}
			}

		}

		context.putImageData(imageData,0,0);

	}

	/* =======================================================================
		Draw Gray Scale
	========================================================================== */
	public static function drawGrayScale(canvas:CanvasElement):Void {

		imageDataCounter(canvas,function(units:Uint8ClampedArray,index:Int):Void {

			var r : Int = units[index];
			var g : Int = units[index + 1];
			var b : Int = units[index + 2];
			units[index] = units[index + 1] = units[index + 2] = Math.round((r+g+b)/3);

		});

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

		var width   : Int = canvas.width;
		var height  : Int = canvas.height;
		var context : CanvasRenderingContext2D = canvas.getContext2d();
		var units   : Uint8ClampedArray = context.getImageData(0,0,width,height).data;

		var y : Int = 0;
		for (i in 0 ... height) {
			if (height < y) break;
			var x : Int = 0;
			for (l in 0 ... width) {

				if (width < x) break;
				var target : Int = (y * width + x) * 4;
				var r : Int = units[target];
				var g : Int = units[target + 1];
				var b : Int = units[target + 2];
				context.fillStyle = 'rgb($r,$g,$b)';
				context.fillRect(x, y, x + size, y + size);

				x += size;
			}
			y += size;
		}

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

		var context   : CanvasRenderingContext2D = canvas.getContext2d();
		var width     : Int = canvas.width;
		var height    : Int = canvas.height;
		var data      : Uint8ClampedArray = context.getImageData(0,0,width,height).data;
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

		var edgeData : ImageData = context.createImageData(width,height);
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

		context.putImageData(edgeData,0,0);

	}

	/* =======================================================================
		Draw Sobel
	========================================================================== */
	public static function drawSobel(canvas:CanvasElement):Void {

		var context : CanvasRenderingContext2D = canvas.getContext2d();
		var width   : Int = canvas.width;
		var height  : Int = canvas.height;
		var imageData : ImageData = context.getImageData(0,0,width,height);
		var units   : Uint8ClampedArray = imageData.data;
		var cUnits  : Uint8ClampedArray = cloneImageData(imageData).data;
		var kernelX : Array<Int> = [
			-1,0,1,
			-2,0,2,
			-1,0,1
		];

		function getValue(i:Int,j:Int):Array<Int> {

			var value : Array<Int> = [0,0,0];
			var k : Int = -1;
			while (k <= 1) {
				var l : Int = -1;
				while (l <= 1) {

					var x : Int = j + l;
					var y : Int = i + k;
					if (x < 0 || width <= x || y < 0 || height <= y) {
						l++;
						continue;
					}

					var index1 : Int = (x + y * width) * 4;
					var index2 : Int = (l + 1) + (k + 1) * 3;
					value[0] += kernelX[index2] * cUnits[index1];
					value[1] += kernelX[index2] * cUnits[index1 + 1];
					value[2] += kernelX[index2] * cUnits[index1 + 2];
					l++;
				}
				k++;
			}
			return value;

		}

		for (i in 0 ... height) {
			for (j in 0 ... width) {

				var index : Int = (j + i * width) * 4;
				var value : Array<Int> = getValue(i,j);
				units[index]     = value[0];
				units[index + 1] = value[1];
				units[index + 2] = value[2];
				units[index + 3] = cUnits[index + 3];
				
			}
		}

		context.putImageData(imageData,0,0);

	}

}