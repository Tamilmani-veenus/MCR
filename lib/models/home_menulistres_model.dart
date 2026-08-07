

import 'dart:convert';

List<GetHomeMenuListResponse> getHomeMenuListResponseFromJson(String str) => List<GetHomeMenuListResponse>.from(json.decode(str).map((x) => GetHomeMenuListResponse.fromJson(x)));

String getHomeMenuListResponseToJson(List<GetHomeMenuListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHomeMenuListResponse {
  GetHomeMenuListResponse({
    this.headName,
    this.subMenu,
  });

  String? headName;
  List<SubMenu>? subMenu;

  factory GetHomeMenuListResponse.fromJson(Map<String, dynamic> json) => GetHomeMenuListResponse(
    headName: json["HeadName"],
    subMenu: List<SubMenu>.from(json["SubMenu"].map((x) => SubMenu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "HeadName": headName,
    "SubMenu": List<dynamic>.from(subMenu!.map((x) => x.toJson())),
  };
}

class SubMenu {
  SubMenu({
    this.subName,
    this.androidReport,
  });

  String? subName;
  String? androidReport;

  factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
    subName: json["SubName"],
    androidReport: json["AndroidReport"],
  );

  Map<String, dynamic> toJson() => {
    "SubName": subName,
    "AndroidReport": androidReport,
  };
}
