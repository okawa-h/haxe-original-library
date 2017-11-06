package jp.okawa.js.jquery;

import js.jquery.Event as JqEvent;
import js.html.PopStateEvent;
 
class Event extends JqEvent {
	
	/* =======================================================================
		Get Pop State Event
	========================================================================== */
	public static function getPopStateEvent(event:JqEvent):PopStateEvent {
		
		return Reflect.getProperty(event,'originalEvent');
		
	}

}