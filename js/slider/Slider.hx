package jp.okawa.js.slider;

/** 
 * Requires JQuery, Minimum required HTML.
 * <section>
 * <ul data-js="slider">
 * <li data-js="slide"></li>
 * <li data-js="slide"></li>
 * </ul>
 * </section>
 */

import haxe.Timer;
import js.Browser;
import js.jquery.JQuery;
import js.jquery.Event;

typedef Setting = {
	?duration : Int,
	?easing   : String
}

class Slider {

	/** 
     * Frame
     * @type {JQuery} 
     */
	private var _jParent : JQuery;

	/** 
     * Moving board
     * @type {JQuery} 
     */
	private var _jSlider : JQuery;

	/** 
     * Slides
     * @type {JQuery} 
     */
	private var _jSlides : JQuery;

	/** 
     * Slide navi
     * @type {JQuery} 
     */
	private var _jNavi : JQuery;

	/** 
     * Slide controller
     * @type {JQuery} 
     */
	private var _jController : JQuery;

	/** 
     * Current index
     * @type {Int} 
     */
	private var _index : Int;

	/** 
     * Slider catch
     * @type {Bool} 
     */
	private var _isCatch : Bool;

	/** 
     * Slideshow timer manager
     * @type {Timer} 
     */
	private var _timer : Timer;

	/** 
     * Slideshow timer
     * @type {Int} 
     */
	private var _timems : Int;

	/** 
     * Moving slider speed
     * @type {Int} 
     */
	public var DURATION : Int = 350;

	/** 
     * Moving slider easing
     * @type {String} 
     */
	public var EASING : String = null;

	/** 
     * On slider Moved
     * @type {Int} -> {Void}
     */
	public var onMoved : Int->JQuery->Void;

	/**
	 * This is an instance of this class
	 * @param  {JQuery} JQuery Target
	 * @param  {Int} set duration
	 * @param  {String} set easing
	 * @return
	 */
	public function new(jParent:JQuery,?setting:Setting,isSwipe:Bool=false):Void {

		_jParent = jParent;
		_jSlider = _jParent.find('[data-js="slider"]');
		_jSlides = _jParent.find('[data-js="slide"]');
		_index   = 0;
		_isCatch = false;

		if (setting == null) setting = {};
		if (Reflect.hasField(setting,'duration')) DURATION = setting.duration;
		if (Reflect.hasField(setting,'easing')  ) EASING = setting.easing;

		initNavi();
		initController();
		if (isSwipe) initSwipe();
		setCurrent(_index);

	}

		/**
		 * Call within the resize event
		 * @param  {Int} index
		 * @return
		 */
		public function jump(index:Int):Void {

			if (_jSlider.is(':animated')) return;
			_index = index;
			move();

		}

		/**
		 * Call within the resize event
		 * @return
		 */
		public function onResize():Void {

			var x : Float = _jSlides.outerWidth() * _index;
			setSliderX(-x);

		}

		/**
		 * Run slideshow
		 * @param  {Int} ms 
		 * @return {Slider} this
		 */
		public function run(timems:Int=2000):Slider {

			stop();
			if (_isCatch) return this;
			_timems = timems;
			_timer  = new Timer(timems);
			_timer.run = function() {

				var index : Int = _index + 1;
				if ( index < 0 || _jSlides.length <= index ) index = 0;
				jump(index);

			}

			return this;

		}

		/**
		 * Stop slideshow
		 * @return {Slider} this
		 */
		public function stop():Slider {

			if (_timer != null) _timer.stop();
			return this;

		}

	/**
	 * It moves based on frame size and index
	 * @return
	 */
	private function move():Void {

		var distance : Float  = _jSlides.outerWidth() * _index;
		var animater : JQuery = new JQuery({ x:getSliderX() });

		stop();
		setCurrent(_index);

		/**
		 * Complete animate
		 * @return
		 */
		function done() {

			if (_timer  != null) run(_timems);
			if (onMoved != null) onMoved(_index,_jSlides.eq(_index));

		}

		/**
		 * Animate step
		 * @param {Float} Value
		 * @return
		 */
		function step(val:Float) {

			if (_isCatch) {
				animater.stop();
				done();
				return;
			}
			setSliderX(val);

		}

		animater.animate({ x:-distance },{
			duration: DURATION,
			easing  : EASING,
			step    : step,
			done    : done
		});

	}

	/**
	 * Get value from transform:translateX
	 * @return {Float} value
	 */
	private function getSliderX():Float {

		var value : String = _jSlider.css('transform');
		return (value == 'none' || value == null) ? 0 : Std.parseFloat(value.split(',')[4]);

	}

	/**
	 * Set value for transform:translateX
	 * @return
	 */
	private function setSliderX(value:Float):Void {

		_jSlider.css({ transform:'translateX(${value}px)' });

	}

	/**
	 * Set current slide
	 * @param  {Int} index 
	 * @return
	 */
	private function setCurrent(index:Int):Void {

		_jNavi.find('li').removeClass('current').eq(index).addClass('current');
		_jSlides.removeClass('current').eq(index).addClass('current');

		_jController.removeClass('unusable');
		if ( index <= 0 ) _jController.filter('.left').addClass('unusable');
		if ( _jSlides.length - 1 <= index ) _jController.filter('.right').addClass('unusable');

	}

	/**
	 * Initialize slide navigater
	 * @return
	 */
	private function initNavi():Void {

		/**
		 * It moves based on the index of Navi
		 * @param  {Event} JQuery Event 
		 * @return
		 */
		function onClick(event:Event):Void {

			var index : Int = new JQuery(event.currentTarget).data('index');
			jump(index);

		}

		/**
		 * Get html
		 * @param
		 * @return {String}
		 */
		function getHtml():String {

			var html = '<ul data-js="navi">';
			for (i in 0 ... _jSlides.length) {
				var jTarget : JQuery = _jSlides.eq(i).find('[data-navititle]');
				var title   : String = (0 < jTarget.length) ? '<p>' + jTarget.data('navititle') + '</p>' : '';

				html += '<li data-index="$i">$title</li>';
			}
			return html + '</ul>';

		}

		_jNavi = new JQuery(getHtml());
		_jParent.append(_jNavi);
		_jNavi.on('click','li',onClick);

	}

	/**
	 * Initialize slide controller
	 * @return
	 */
	private function initController():Void {

		/**
		 * @param {Event} JQuery Event
		 * @return
		 */
		function onClick(event:Event):Void {

			var jTarget   : JQuery = new JQuery(event.currentTarget);
			var direction : Int    = (jTarget.hasClass('left')) ? -1 : 1;
			var index     : Int    = _index + direction;

			if ( index < 0 || _jSlides.length <= index ) return;
			jump(index);

		}

		_jParent.append('
				<button class="left" data-js="controller">&nbsp;</button>
				<button class="right" data-js="controller">&nbsp;</button>');
		_jController = _jParent.find('[data-js="controller"]');
		_jController.on('click',onClick);

	}

	/**
	 * Initialize slide swipe
	 * @return
	 */
	private function initSwipe():Void {

		_isCatch = false;
		var basepoint : Float = 0;
		var touchPoint: Float = 0;
		var movePoint : Float = 0;

		/**
		 * Touching inside the slider
		 * @param  {Event} JQuery event
		 * @return {Bool}
		 */
		function isTouchSlider(event:Event):Bool {

			var jTarget : JQuery = new JQuery(event.target);
			return (0 < _jSlider.find(jTarget).length);

		}

		/**
		 * Event slide touchstart
		 * event.which is type (3 is right click)
		 * @param  {Event} JQuery event
		 * @return
		 */
		function onTouchstart(event:Event):Void {

			if (!isTouchSlider(event) || event.which == 3) return;
			stop();
			_isCatch   = true;
			basepoint  = getSliderX();
			touchPoint = event.pageX;
			movePoint  = touchPoint;

		}

		/**
		 * Event slide touchmove
		 * @param  {Event} JQuery event
		 * @return
		 */
		function onTouchmove(event:Event):Void {

			if (!_isCatch) return;
			movePoint = event.pageX;
			var x : Float = basepoint - (touchPoint - movePoint);
			setSliderX(x);

			/**
			 * Scroll event cancel
			 */
			event.preventDefault();

		}

		/**
		 * Event slide touchend
		 * @param  {Event} JQuery event
		 * @return
		 */
		function onTouchend(event:Event):Void {

			if (!_isCatch) return;
			_isCatch = false;

			var distance     : Float = touchPoint - movePoint;
			var movedPersent : Float = Math.abs(distance) / _jSlides.outerWidth();
			var stepCount    : Int   = 0;

			/**
			 * If less than 20% of the width of the slide
			 */
			if (0.2 < movedPersent) {

				/**
				 * Calculate step count
				 */
				var ratio : Int = Math.floor(movedPersent);
				stepCount =  (ratio < 1) ? 1 : ratio;
				stepCount *= (0 < distance) ? 1 : -1;

			}

			var index : Int = _index + stepCount;
			if ( index < 0 ) index = 0;
			if ( _jSlides.length <= index ) index = _jSlides.length - 1;

			jump(index);

		}

		new JQuery(Browser.document).on({

			'touchstart mousedown' : onTouchstart,
			'touchmove mousemove'  : onTouchmove,
			'touchend mouseup'     : onTouchend

		});

	}
	
}