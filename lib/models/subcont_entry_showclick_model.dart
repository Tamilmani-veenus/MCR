// To parse this JSON data, do
//
//     final subContEntryShow = subContEntryShowFromJson(jsonString);

import 'dart:convert';

List<SubContEntryShowResponse> subContEntryShowFromJson(String str) => List<SubContEntryShowResponse>.from(json.decode(str).map((x) => SubContEntryShowResponse.fromJson(x)));

String subContEntryShowToJson(List<SubContEntryShowResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubContEntryShowResponse {
  SubContEntryShowResponse({
    this.subContId,
    this.categoryId,
    this.categoryName,
    this.wages,
  });

  int? subContId;
  int? categoryId;
  String? categoryName;
  double? wages;

  factory SubContEntryShowResponse.fromJson(Map<String, dynamic> json) => SubContEntryShowResponse(
    subContId: json["SubContId"],
    categoryId: json["CategoryId"],
    categoryName: json["CategoryName"],
    wages: json["Wages"],
  );

  Map<String, dynamic> toJson() => {
    "SubContId": subContId,
    "CategoryId": categoryId,
    "CategoryName": categoryName,
    "Wages": wages,
  };
}
