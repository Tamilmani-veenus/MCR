import 'dart:convert';

List<TransferbetAlldatasApiRes> transferbetAlldatasApiResFromJson(String str) => List<TransferbetAlldatasApiRes>.from(json.decode(str).map((x) => TransferbetAlldatasApiRes.fromJson(x)));

String transferbetAlldatasApiResToJson(List<TransferbetAlldatasApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferbetAlldatasApiRes {
  TransferbetAlldatasApiRes({
    this.reqMasId,
    this.appMasId,
    this.appOrdNo,
    this.toProjectid,
    this.toProjectName,
  });

  int? reqMasId;
  int? appMasId;
  String? appOrdNo;
  int? toProjectid;
  String? toProjectName;

  factory TransferbetAlldatasApiRes.fromJson(Map<String, dynamic> json) => TransferbetAlldatasApiRes(
    reqMasId: json["Req_Mas_id"],
    appMasId: json["App_Mas_id"],
    appOrdNo: json["app_ord_no"],
    toProjectid: json["ToProjectid"],
    toProjectName: json["ToProjectName"],
  );

  Map<String, dynamic> toJson() => {
    "Req_Mas_id": reqMasId,
    "App_Mas_id": appMasId,
    "app_ord_no": appOrdNo,
    "ToProjectid": toProjectid,
    "ToProjectName": toProjectName,
  };
}
