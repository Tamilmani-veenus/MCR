import 'dart:convert';

List<ProjectWiseShowListResponse> projectWiseShowListResponseFromJson(String str) => List<ProjectWiseShowListResponse>.from(json.decode(str).map((x) => ProjectWiseShowListResponse.fromJson(x)));

String projectWiseShowListResponseToJson(List<ProjectWiseShowListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectWiseShowListResponse {
  ProjectWiseShowListResponse({
    this.siteid,
    this.siteName,
    this.headerId,
    this.header,
    this.footerId,
    this.footer,
    this.unit,
    this.balQty,
    this.stockQty,
  });

  int? siteid;
  String? siteName;
  int? headerId;
  String? header;
  int? footerId;
  String? footer;
  String? unit;
  double? balQty;
  double? stockQty;

  factory ProjectWiseShowListResponse.fromJson(Map<String, dynamic> json) => ProjectWiseShowListResponse(
    siteid: json["siteid"],
    siteName: json["SiteName"],
    headerId: json["HeaderId"],
    header: json["Header"],
    footerId: json["FooterId"],
    footer: json["Footer"],
    unit: json["Unit"],
    balQty: json["Bal_Qty"].toDouble(),
    stockQty: json["Stock_Qty"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "siteid": siteid,
    "SiteName": siteName,
    "HeaderId": headerId,
    "Header": header,
    "FooterId": footerId,
    "Footer": footer,
    "Unit": unit,
    "Bal_Qty": balQty,
    "Stock_Qty": stockQty,
  };
}


