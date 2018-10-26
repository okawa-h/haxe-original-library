package jp.okawa.utils;
 
class DateUtils {

	/* =======================================================================
		Get Change Date
	========================================================================== */
	public static function getDeltaDay(target:Date,delta:Int):Date {
		
		return DateTools.delta(target,DateTools.days(delta));

	}

	/* =======================================================================
		Get Delta Month
	========================================================================== */
	public static function getDeltaMonth(target:Date,delta:Int):Date {
		
		var days : Int = DateTools.getMonthDays(target);
		return DateTools.delta(target,DateTools.days(delta) * days);

	}

	/* =======================================================================
		Get Shift Month
	========================================================================== */
	public static function getShiftMonth(date:Date,distance:Int):Date {
        
        var isUp    :Bool  = 0 < distance;
		var count   :Int   = isUp ? 1 : -1;
		var baseDate:Int   = date.getDate();
		var shift   :Float = 0;

		for (i in 0 ... Math.round(Math.abs(distance))) {

			var nowMax :Int = DateTools.getMonthDays(date);
			var nowDate:Int = date.getDate();

			var next     :{year:Int,month:Int} = getNextYearMonth(date.getFullYear(),date.getMonth(),isUp);
			var nextMax  :Int = getMonthDays(next.year,next.month);
			var clearDate:Int = nowMax - nowDate;
			var nextDate :Int = baseDate;

			if (isUp) {

				if (nextMax < nextDate) nextDate = nextMax;

			} else {

				clearDate = nowDate;
				nextDate  = nextMax - baseDate;
				if (nextDate < 0) nextDate = 0;

			}

			date = DateTools.delta(date,DateTools.days(clearDate + nextDate) * count);

		}

		return date;

	}

	/* =======================================================================
		Get Month Days
	========================================================================== */
	public static function getMonthDays(year:Int,month:Int):Int {

		return DateTools.getMonthDays(new Date(year,month,1,1,1,1));

	}

	/* =======================================================================
		Get Next Year Month Date
	========================================================================== */
	public static function getNextYearMonth(year:Int,month:Int,isUp:Bool=true):{year:Int,month:Int} {

		month = isUp ? month + 1 : month - 1;

		if (11 < month) {
			month = 0;
			year++;
		}

		if (month < 0) {
			month = 11;
			year--;
		}

		return { year:year,month:month };

	}

}