class KeyValue {
  String label;
  dynamic key;
  KeyValue(this.label, this.key);
}

class PaginationResponse {
  int offset = 0;
  int limit;
  bool isPageChange;
  PaginationResponse(this.limit, this.offset, [this.isPageChange = false]);
}

enum RequestType { GET, PUT, POST, DELETE }

enum DateType { YTD, MONTH, YEAR, LABEL }

enum ExceptionType {
  UNAUTHORIZED,
  BADREQUEST,
  INVALIDINPUT,
  FETCHDATA,
  OTHER,
  CONNECTIONISSUE
}

class YearWithMonths {
  final List<DatePeriod> monthList;
  final DatePeriod year;
  bool isExpanded = false;
  YearWithMonths(this.monthList, this.year);
}


class DatePeriod {
  final DateTime startDate;
  final DateTime endDate;
  final DateType dateType;
  final String? label;
  DatePeriod(this.startDate, this.endDate, this.dateType, [this.label]);

  @override
  bool operator ==(otherDate) {
    return (otherDate is DatePeriod)
        && otherDate.startDate == startDate
        && otherDate.endDate == endDate
        && otherDate.dateType == dateType
        && otherDate.label == label;
  }
}
