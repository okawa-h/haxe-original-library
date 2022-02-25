package slick;

import haxe.extern.EitherType;
import js.jquery.JQuery;

typedef Settings = {
	?accessibility: Bool,
	?adaptiveHeight: Bool,
	?autoplay: Bool,
	?autoplaySpeed: Int,
	?arrows: Bool,
	?asNavFor: String,
	?appendArrows: String,
	?appendDots: String,
	?prevArrow: EitherType<String,EitherType<JQuery,Dynamic>>,
	?nextArrow: EitherType<String,EitherType<JQuery,Dynamic>>,
	?centerMode: Bool,
	?centerPadding: String,
	?cssEase: String,
	?customPaging: Dynamic,
	?dots: Bool,
	?dotsClass: String,
	?draggable: Bool,
	?fade: Bool,
	?focusOnSelect: Bool,
	?easing: String,
	?edgeFriction: Float,
	?infinite: Bool,
	?initialSlide: Float,
	?lazyLoad: String,
	?mobileFirst: Bool,
	?pauseOnFocus: Bool,
	?pauseOnHover: Bool,
	?pauseOnDotsHover: Bool,
	?respondTo: String,
	?responsive: Array<{ breakpoint:Int,settings:Settings }>,
	?rows: Int,
	?slide: Dynamic,
	?slidesPerRow: Int,
	?slidesToShow: Int,
	?slidesToScroll: Int,
	?speed: Int,
	?swipe: Bool,
	?swipeToSlide: Bool,
	?touchMove: Bool,
	?touchThreshold: Int,
	?useCSS: Bool,
	?useTransform: Bool,
	?variableWidth: Bool,
	?vertical: Bool,
	?verticalSwiping: Bool,
	?rtl: Bool,
	?waitForAnimate: Bool,
	?zIndex: Int
}

@:enum abstract Events(String) from String to String{
	var afterChange = 'afterChange';
	var beforeChange = 'beforeChange';
	var breakpoint = 'breakpoint';
	var destroy = 'destroy';
	var edge = 'edge';
	var init = 'init';
	var reInit = 'reInit';
	var setPosition = 'setPosition';
	var swipe = 'swipe';
	var lazyLoaded = 'lazyLoaded';
	var lazyLoadError = 'lazyLoadError';
}

@:enum abstract Methods(String) from String to String{
	var slickCurrentSlide = 'slickCurrentSlide';
	var slickGoTo = 'slickGoTo';
	var slickNext = 'slickNext';
	var slickPrev = 'slickPrev';
	var slickPause = 'slickPause';
	var slickPlay = 'slickPlay';
	var slickAdd = 'slickAdd';
	var slickRemove = 'slickRemove';
	var slickFilter = 'slickFilter';
	var slickUnfilter = 'slickUnfilter';
	var slickGetOption = 'slickGetOption';
	var slickSetOption = 'slickSetOption';
	var unslick = 'unslick';
	var getSlick = 'getSlick';
}

extern class Slick implements js.jquery.Plugin {

	@:overload public function slick(method:Methods,?options1:Dynamic,?options2:Dynamic,?options3:Dynamic):JQuery;
	@:overload public function slick(method:Methods,?options1:Dynamic,?options2:Dynamic):JQuery;
	@:overload public function slick(method:Methods,?options:Dynamic):JQuery;
	@:overload public function slick(?method:Methods):JQuery;
	@:overload public function slick(?options:Settings):JQuery;

}
