import 'dart:convert';

List<SiteDropdownResponse> siteDropdownResponseFromJson(String str) => List<SiteDropdownResponse>.from(json.decode(str).map((x) => SiteDropdownResponse.fromJson(x)));

String siteDropdownResponseToJson(List<SiteDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiteDropdownResponse {
  SiteDropdownResponse({
    this.siteId,
    this.siteName,
  });

  int? siteId;
  String? siteName;

  factory SiteDropdownResponse.fromJson(Map<String, dynamic> json) => SiteDropdownResponse(
    siteId: json["SiteId"],
    siteName: json["SiteName"],
  );

  Map<String, dynamic> toJson() => {
    "SiteId": siteId,
    "SiteName": siteName,
  };
}
