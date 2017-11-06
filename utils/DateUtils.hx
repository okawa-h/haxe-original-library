package jp.okawa.utils;
 
class DateUtils {

	/* =======================================================================
		Get Change Date
	========================================================================== */
	public static function getDeltaDay(target:Date,delta:Int):Date {
		
		return DateTools.delta(target,DateTools.days(delta));

	}

	/* =======================================================================
		Get Change Date
	========================================================================== */
	public static function getDeltaMonth(target:Date,delta:Int):Date {
		
		var days : Int = DateTools.getMonthDays(target);
		return DateTools.delta(target,DateTools.days(delta) * days);

	}

}