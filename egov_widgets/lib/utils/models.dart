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

enum ExceptionType {
  UNAUTHORIZED,
  BADREQUEST,
  INVALIDINPUT,
  FETCHDATA,
  OTHER,
  CONNECTIONISSUE
}
