package jp.okawa.utils;
 
class MathTools {

	/* =======================================================================
		Get Random Range
	========================================================================== */
	public static function getRandomRange(min:Float,max:Float):Float {

		return Math.random() * ( max - min ) + min;

	}

	/* =======================================================================
		Round Float
	========================================================================== */
	public static function roundFloat(number:Float,n:Int):Float {

		var pow : Float = Math.pow(10,n);
		return Math.round( number * pow ) / pow;

	}

	/* =======================================================================
		Ceil Float
	========================================================================== */
	public static function ceilFloat(number:Float,n:Int):Float {

		var pow : Float = Math.pow(10,n);
		return Math.ceil( number * pow ) / pow;

	}

	/* =======================================================================
		Floor Float
	========================================================================== */
	public static function floorFloat(number:Float,n:Int):Float {

		var pow : Float = Math.pow(10,n);
		return Math.floor( number * pow ) / pow;

	}

	/* =======================================================================
		Random Int
	========================================================================== */
	public static function randomInt(min:Int,max:Int):Int {

		return min + Math.floor( Math.random() * ( max - min + 1 ) );

	}

	/* =======================================================================
		Random Float
	========================================================================== */
	public static function randomFloat(min:Float,max:Float):Float {

		return min + Math.random() * ( max - min );

	}

	/* =======================================================================
		Random Float Spread
	========================================================================== */
	public static function randomFloatSpread(range:Float):Float {

		return range * ( .5 - Math.random() );

	}

	/* =======================================================================
		GCP - Greatest common divisor
	========================================================================== */
	public static function gcp(x:Int,y:Int):Int {

		var r : Int;
		while (y > 0) {
			r = x % y;
			x = y;
			y = r;
		}
		return x;

	}

	/* =======================================================================
		Prime Factorization
	========================================================================== */
	public static function primeFactorization(n:Int):Array<{ num:Int,r:Int }> {

		var s : Int = Math.floor(Math.sqrt(n));
		var r : Int = 0;
		var result : Array<{ num:Int,r:Int }> = new Array();

		for (i in 2 ... s) {

			if ((n % i) == 0) {

				r = 0;

				do {

					r++;
					n = Math.floor(n / i);

				} while ((n % i) == 0);

				result.push({ num:i,r:r });

			}
			
		}

		if (n > s) {
			result.push({num:n, r:1});
		}

		return result;

	}


}