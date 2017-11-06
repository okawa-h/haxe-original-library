package jp.okawa.js;

import js.jquery.JQuery;
 
class EasingTools {

	/* =======================================================================
		Add JQuery
	========================================================================== */
	public static function addJQuery():Void {

		JQuery.extend(untyped JQuery.easing,{

			def   : 'easeOutQuad',
			swing : swing,

			easeInQuad    : easeInQuad,
			easeOutQuad   : easeOutQuad,
			easeInOutQuad : easeInOutQuad,

			easeInCubic    : easeInCubic,
			easeOutCubic   : easeOutCubic,
			easeInOutCubic : easeInOutCubic,

			easeInQuart    : easeInQuart,
			easeOutQuart   : easeOutQuart,
			easeInOutQuart : easeInOutQuart,

			easeInQuint    : easeInQuint,
			easeOutQuint   : easeOutQuint,
			easeInOutQuint : easeInOutQuint,

			easeInSine    : easeInSine,
			easeOutSine   : easeOutSine,
			easeInOutSine : easeInOutSine,

			easeInExpo    : easeInExpo,
			easeOutExpo   : easeOutExpo,
			easeInOutExpo : easeInOutExpo,

			easeInCirc    : easeInCirc,
			easeOutCirc   : easeOutCirc,
			easeInOutCirc : easeInOutCirc,

			easeInElastic    : easeInElastic,
			easeOutElastic   : easeOutElastic,
			easeInOutElastic : easeInOutElastic,

			easeInBack    : easeInBack,
			easeOutBack   : easeOutBack,
			easeInOutBack : easeInOutBack,

			easeInBounce    : easeInBounce,
			easeOutBounce   : easeOutBounce,
			easeInOutBounce : easeInOutBounce

		});

	}

		/* =======================================================================
			Swing
		========================================================================== */
		private static function swing(x,t:Float,b,c,d):Float {

			return easeOutQuad(x,t,b,c,d);

		}

		/* =======================================================================
			In Quad
		========================================================================== */
		private static function easeInQuad(x,t:Float,b,c,d):Float {

			return c*(t/=d)*t + b;

		}

		/* =======================================================================
			Out Quad
		========================================================================== */
		private static function easeOutQuad(x,t:Float,b,c,d):Float {

			return -c *(t/=d)*(t-2) + b;

		}

		/* =======================================================================
			In Out Quad
		========================================================================== */
		private static function easeInOutQuad(x,t:Float,b,c,d):Float {

			if ((t/=d/2) < 1) return c/2*t*t + b;
			return -c/2 * ((--t)*(t-2) - 1) + b;

		}

		/* =======================================================================
			In Cubic
		========================================================================== */
		private static function easeInCubic(x,t:Float,b,c,d):Float {
		
			return c*(t/=d)*t*t + b;
			
		}

		/* =======================================================================
			Out Cubic
		========================================================================== */
		private static function easeOutCubic(x,t:Float,b,c,d):Float {
		
			return c * ((t/=d - 1) * t * t + 1) + b;
			
		}

		/* =======================================================================
			In Out Cubic
		========================================================================== */
		private static function easeInOutCubic(x,t:Float,b,c,d):Float {

			if ((t/=d/2) < 1) return c/2*t*t*t + b;
			return c/2*((t-=2)*t*t + 2) + b;

		}

		/* =======================================================================
			In Quart
		========================================================================== */
		private static function easeInQuart(x,t:Float,b,c,d):Float {
			
			return c * (t /= d) * t * t * t + b;
		
		}

		/* =======================================================================
			Out Quart
		========================================================================== */
		private static function easeOutQuart(x,t:Float,b,c,d):Float {
			
			return c * (t /= d) * t * t * t + b;
		
		}

		/* =======================================================================
			In Out Quart
		========================================================================== */
		private static function easeInOutQuart(x,t:Float,b,c,d):Float {

			if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
			return -c/2 * ((t-=2)*t*t*t - 2) + b;
		
		}

		/* =======================================================================
			In Quint
		========================================================================== */
		private static function easeInQuint(x,t:Float,b,c,d):Float {

			return c*(t/=d)*t*t*t*t + b;

		}

		/* =======================================================================
			Out Quint
		========================================================================== */
		private static function easeOutQuint(x,t:Float,b,c,d):Float {

			return c*((t=t/d-1)*t*t*t*t + 1) + b;

		}

		/* =======================================================================
			In Out Quint
		========================================================================== */
		private static function easeInOutQuint(x,t:Float,b,c,d):Float {

			if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
			return c/2*((t-=2)*t*t*t*t + 2) + b;

		}

		/* =======================================================================
			In Sine
		========================================================================== */
		private static function easeInSine(x,t,b,c,d):Float {

			return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;

		}

		/* =======================================================================
			Out Sine
		========================================================================== */
		private static function easeOutSine(x,t,b,c,d):Float {

			return c * Math.sin(t / d * (Math.PI / 2)) + b;

		}

		/* =======================================================================
			In Out Sine
		========================================================================== */
		private static function easeInOutSine(x,t,b,c,d):Float {

			return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;

		}

		/* =======================================================================
			In Expo
		========================================================================== */
		private static function easeInExpo(x,t,b,c,d):Float {

			return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;

		}

		/* =======================================================================
			Out Expo
		========================================================================== */
		private static function easeOutExpo(x,t,b,c,d):Float {

			return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;

		}

		/* =======================================================================
			In Out Expo
		========================================================================== */
		private static function easeInOutExpo(x,t:Float,b,c,d):Float {

			if (t == 0) return b;
			if (t == d) return b + c;
			if ((t /= d / 2) < 1) return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
			return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b;

		}

		/* =======================================================================
			In Circ
		========================================================================== */
		private static function easeInCirc(x,t:Float,b,c,d):Float {

			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;

		}

		/* =======================================================================
			Out Circ
		========================================================================== */
		private static function easeOutCirc(x,t:Float,b,c,d):Float {

			return c * Math.sqrt(1 - (t=t/d-1)*t) + b;

		}

		/* =======================================================================
			In Out Circ
		========================================================================== */
		private static function easeInOutCirc(x,t:Float,b,c,d):Float {

			if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
			return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;

		}

		/* =======================================================================
			In Elastic
		========================================================================== */
		private static function easeInElastic(x,t:Float,b,c,d):Float {

			var s=1.70158;
			var p:Float=0;
			var a=c;
			if (t==0) return b;
			if ((t/=d)==1) return b+c;
			if (p <= 0) p=d*.3;
			if (a < Math.abs(c)) { a=c; var s=p/4; }
			else var s = p/(2*Math.PI) * Math.asin (c/a);
			return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
		
		}

		/* =======================================================================
			Out Elastic
		========================================================================== */
		private static function easeOutElastic(x,t:Float,b,c,d):Float {
		
			var s = 1.70158;
			var p : Float = 0;
			var a = c;
			
			if (t == 0) return b;
			if ((t /= d) == 1) return b + c;
			if (p <= 0) p = d * .3;
			if (a < Math.abs(c)) { a = c; var s = p / 4; }
			else var s = p / (2 * Math.PI) * Math.asin (c / a);
			return a * Math.pow(2,-10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p ) + c + b;
		
		}

		/* =======================================================================
			Out Elastic
		========================================================================== */
		private static function easeInOutElastic(x,t:Float,b,c,d):Float {

			var s=1.70158;
			var p:Float=0;
			var a=c;
			if (t==0) return b;
			if ((t/=d/2)==2) return b+c;
			if (p <= 0) p=d*(.3*1.5);
			if (a < Math.abs(c)) { a=c; var s=p/4; }
			else var s = p/(2*Math.PI) * Math.asin (c/a);
			if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
			return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
		
		}

		/* =======================================================================
			In Back
		========================================================================== */
		private static function easeInBack(x,t:Float,b,c,d,s=1.70158):Float {

			return c*(t/=d)*t*((s+1)*t - s) + b;

		}

		/* =======================================================================
			Out Back
		========================================================================== */
		private static function easeOutBack(x,t:Float,b,c,d,s=1.70158):Float {

			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;

		}

		/* =======================================================================
			In Out Back
		========================================================================== */
		private static function easeInOutBack(x,t:Float,b,c,d,s=1.70158):Float {

			if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;

		}

		/* =======================================================================
			In Bounce
		========================================================================== */
		private static function easeInBounce(x,t:Float,b,c,d):Float {
		
			return c - easeOutBounce(x, d-t, 0, c, d) + b;

		}

		/* =======================================================================
			Out Bounce
		========================================================================== */
		private static function easeOutBounce(x,t:Float,b,c,d):Float {
		
			if ((t /= d) < (1 / 2.75)) return c * (7.5625 * t * t) + b;
			else if (t < (2 / 2.75)) return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
			else if (t < (2.5 / 2.75)) return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
			else return c*(7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;

		}

		/* =======================================================================
			In Out Bounce
		========================================================================== */
		private static function easeInOutBounce(x,t:Float,b,c,d):Float {

			if (t < d/2) return easeInBounce(x, t*2, 0, c, d) * .5 + b;
			return easeOutBounce(x, t*2-d, 0, c, d) * .5 + c*.5 + b;

		}

}