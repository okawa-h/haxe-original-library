package jp.okawa.js.modalwindow;

/** 
 * Requires JQuery, Minimum required HTML.
 */

import js.Browser;
import js.html.Image;
import js.html.VideoElement;
import js.jquery.JQuery;
import js.jquery.Event;

class Modalwindow {

	/** 
     * Window
     * @type {JQuery} 
     */
	private static var _jWindow : JQuery;

	/** 
     * Frame
     * @type {JQuery} 
     */
	private static var _jParent : JQuery;

	/** 
     * Content
     * @type {JQuery} 
     */
	private static var _jContent : JQuery;

	/** 
     * Background
     * @type {JQuery} 
     */
	private static var _jBackground : JQuery;

	/** 
     * Frame
     * @type {JQuery} 
     */
	private static var _jFrame : JQuery;

	/** 
     * Modalcontent length
     * @type {Int} 
     */
	private static var _length : Int = 0;

	/**
	 * This is an instance of this class
	 * @return
	 */
	public function new(jContent:JQuery,?jTrigger:JQuery):Void {

		var jAddContent : JQuery = jContent.children().clone();
		_length++;
		if (_length <= 1) init();

		/**
		 * On show
		 * @return
		 */
		function onShow():Void {

			jContent.trigger('onModalwindowShow',[jAddContent]);

		}

		/**
		 * Run
		 * @return
		 */
		function run():Void {

			setContent(jAddContent);
			show(onShow);

		}

		if (jTrigger == null) {
			run();
			return;
		}

		jTrigger.on({ 'click':run });

	}

	/**
	 * This is an initialize
	 * @return
	 */
	private static function init():Void {

		_jWindow     = new JQuery(Browser.window);
		_jParent     = new JQuery(getHtml());
		_jContent    = _jParent.find('.content');
		_jBackground = _jParent.find('.background');
		_jFrame      = _jParent.find('.frame');

		new JQuery('body').append(_jParent);
		_jWindow.on({ 'resize':onResize });
		_jParent.on({ 'click':onClick });

	}

	/**
	 * Show
	 * @return
	 */
	private static function show(onShow:Void->Void):Void {

		_jParent.show();
		_jFrame.css('opacity',0);

		loadContent(function() {
			setPosition();
			fade(0,0.8,function() {
				onShow();
			});
			_jFrame.animate({ opacity:1 },200);
		});

	}

	/**
	 * Hide
	 * @return
	 */
	private static function hide():Void {

		_jFrame.animate({ opacity:0 },200);
		fade(0.8,0,function() {
			_jContent.empty();
			_jParent.hide();
		});

	}

	/**
	 * Fade animate
	 * @param  {Float} start
	 * @param  {Float} end
	 * ?@param  {Void->Void} complete function
	 * @return
	 */
	private static function fade(start:Float,end:Float,?onComplete:Void->Void):Void {

		var animater : JQuery = new JQuery({ x:start });

		/**
		 * Complete animate
		 * @return
		 */
		function done() {

			if (onComplete != null) onComplete();

		}

		/**
		 * Animate step
		 * @param {Float} Value
		 * @return
		 */
		function step(val:Float) {

			_jBackground.css({ 'background-color':'rgba(0,0,0,' + val + ')' });

		}

		animater.animate({ x:end },{
			duration: 200,
			step    : step,
			done    : done
		});

	}

	/**
	 * Click action
	 * @param  {Event}
	 * @return
	 */
	private static function onClick(event:Event):Void {

		var value : String = new JQuery(event.target).data('js');
		switch (value) {
			case 'close':
				hide();
		}

	}

	/**
	 * Resize action
	 * @param  {Event}
	 * @return
	 */
	private static function onResize(event:Event):Void {

		setPosition();

	}

	/**
	 * Set content html
	 * @param  {JQuery}
	 * @return
	 */
	private static function setContent(jContent:JQuery):Void {

		_jContent.empty().html('<div class="frame-inner"></div>');
		_jContent.find('.frame-inner').append(jContent);

	}

	/**
	 * Content load image
	 * @param  {Void->Void} loaded function
	 * @return
	 */
	private static function loadContent(onLoaded:Void->Void):Void {

		var jTargets : JQuery = _jContent.find('img,video');
		var counter  : Int    = 0;
		var length   : Int    = jTargets.length;

		if (length <= 0) onLoaded();

		/**
		 * Load image
		 * @return
		 */
		function loadImage(jTarget:JQuery):Void {

			var image : Image = new Image();
			image.onload = function() {
				counter++;
				if (length <= counter) onLoaded();
			}
			image.src = jTarget.prop('src');

		}

		/**
		 * Load video
		 * @return
		 */
		function loadVideo(jTarget:JQuery):Void {

			// var video  : VideoElement = cast jTarget.clone().get(0);
			// video.oncanplay = function() {
			// 	video.remove();
				counter++;
				if (length <= counter) onLoaded();
			// }

		}

		for (i in 0 ... length) {

			var jTarget : JQuery = jTargets.eq(i);
			var tag     : String = jTarget.prop('tagName');

			switch (tag) {
				case 'IMG'  :loadImage(jTarget);
				case 'VIDEO':loadVideo(jTarget);
			}


		}

	}

	/**
	 * Set Position
	 * @return
	 */
	private static function setPosition():Void {

		var winW : Float = _jWindow.innerWidth();
		var winH : Float = _jWindow.innerHeight();
		var top  : Float = (winH - _jFrame.height()) * .5;
		var left : Float = (winW - _jFrame.width())  * .5;

		if (top  < 0) top  = 0;
		if (left < 0) left = 0;
		_jFrame.css({ top:top,left:left });

	}

	/**
	 * Get base html
	 * @return {String}
	 */
	private static function getHtml():String {

		return 
			'<div data-js="modalwindow">
				<div class="background" data-js="close">
					<div class="frame">
						<section class="content"></section>
						<div class="control"><button data-js="close">close</button></div>
					</div>
				</div>
			</div>';

	}
	
}