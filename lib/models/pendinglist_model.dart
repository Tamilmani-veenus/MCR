import 'dart:convert';

List<PendingListResponse> pendingListResponseFromJson(String str) => List<PendingListResponse>.from(json.decode(str).map((x) => PendingListResponse.fromJson(x)));

String pendingListResponseToJson(List<PendingListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingListResponse {
  PendingListResponse({
    this.menuId,
    this.sqno,
    this.entrytype,
    this.approvalCode,
    this.count,
  });

  int? menuId;
  int? sqno;
  String? entrytype;
  String? approvalCode;
  int? count;

  factory PendingListResponse.fromJson(Map<String, dynamic> json) => PendingListResponse(
    menuId: json["MenuId"],
    sqno: json["SQNO"],
    entrytype: json["ENTRYTYPE"],
    approvalCode: json["APPROVAL_CODE"],
    count: json["COUNT"],
  );

  Map<String, dynamic> toJson() => {
    "MenuId": menuId,
    "SQNO": sqno,
    "ENTRYTYPE": entrytype,
    "APPROVAL_CODE": approvalCode,
    "COUNT": count,
  };
}
