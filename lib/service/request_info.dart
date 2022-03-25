class RequestInfo {
  final apiId;
  final ver;
  final ts;
  final action;
  final did;
  final key;
  final msgId;
  final authToken;
  Map? userInfo;
  RequestInfo(this.apiId, this.ver, this.ts, this.action, this.did, this.key,
      this.msgId, this.authToken,
      [this.userInfo]);
  Map<String, dynamic> toJson() => {
        "apiId": apiId == null ? null : apiId,
        "ver": ver == null ? 1 : ver,
        "ts": ts == null ? null : ts,
        "action": action == null ? null : action,
        "did": did == null ? null : did,
        "key": key == null ? null : key,
        "authToken": authToken == null ? null : authToken,
        "userInfo": userInfo
      };
}
