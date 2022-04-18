
import 'package:egov_widgets/utils/global_variables.dart';
import 'package:egov_widgets/utils/models.dart';

mixin HelperMethods {

   static T? enumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere((type) => type.toString().split(".").last == value);
  }

    home(){
     navigatorKey.currentState?.popUntil((route) => route.isFirst);
   }

   static String getExtension(String url){
     return url.substring(0, url.indexOf('?')).split('/').last;
   }

    List<DatePeriod> getPastMonthUntilFinancialYear(int year, {DateType? dateType}){
     var monthList = <DateTime>[];
     if(DateTime.now().year == year && DateTime.now().month >= 4){
       for(int i = 4; i <= DateTime.now().month; i++){
         monthList.add(DateTime(DateTime.now().year, i));
       }
     }else {
       var yearDetails = DateTime(year);
       for(int i = 4; i <= 12; i++){
         monthList.add(DateTime(yearDetails.year, i));
       }
       for(int i = 1; i <= (dateType == DateType.YTD ? DateTime.now().month : 3); i++){
         monthList.add(DateTime(yearDetails.year + 1, i));
       }
     }
     return monthList.map((e) => DatePeriod(DateTime(e.year, e.month, 1), DateTime(e.year, e.month + 1, 0, 23,59, 59, 999), DateType.MONTH)).toList().reversed.toList();
   }

    List<YearWithMonths> getFinancialYearList([int count = 5]){
     var yearWithMonths = <YearWithMonths>[];

     if(DateTime.now().month >= 4) {
       var year = DatePeriod(DateTime(DateTime.now().year, 4) , DateTime(DateTime.now().year + 1, 4, 0, 23,59, 59, 999), DateType.YTD);
       var monthList = getPastMonthUntilFinancialYear(DateTime.now().year);
       yearWithMonths.add(YearWithMonths(monthList, year));
     }else{
       var year = DatePeriod(DateTime( DateTime.now().year - 1, 4), DateTime.now(), DateType.YTD);
       var monthList = getPastMonthUntilFinancialYear(year.startDate.year, dateType : DateType.YTD);
       yearWithMonths.add(YearWithMonths(monthList, year));
     }

     for(int i =0; i < count-1; i++){
       var currentDate = DateTime.now();
       dynamic year = currentDate.month < 4 ? DateTime(currentDate.year - (i+1)) : DateTime(currentDate.year - i);
       year = DatePeriod(DateTime(year.year - 1, 4), DateTime(year.year, 4, 0, 23,59, 59, 999), DateType.YEAR);
       var monthList = getPastMonthUntilFinancialYear(year.startDate.year);
       yearWithMonths.add(YearWithMonths(monthList, year));
     }
     return yearWithMonths;
   }

   static List<DatePeriod> getMonthsOfFinancialYear(){
     var monthList = <DateTime>[];
     if(DateTime.now().month >= 4){
       for(int i = 4; i <= DateTime.now().month; i++){
         monthList.add(DateTime(DateTime.now().year, i));
       }
     }else {
       for(int i = 4; i <= 12; i++){
         monthList.add(DateTime(DateTime.now().year - 1, i));
       }
       for(int i = 1; i <= DateTime.now().month; i++){
         monthList.add(DateTime(DateTime.now().year, i));
       }
     }
     return monthList.map((e) => DatePeriod(DateTime(e.year, e.month, 1), DateTime(e.year, e.month + 1, 0, 23,59, 59, 999), DateType.MONTH)).toList().reversed.toList();
   }
}