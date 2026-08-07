
import 'dart:convert';

List<MaterialSubDropdownResponse> materialSubDropdownResponseFromJson(String str) => List<MaterialSubDropdownResponse>.from(json.decode(str).map((x) => MaterialSubDropdownResponse.fromJson(x)));

String materialSubDropdownResponseToJson(List<MaterialSubDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialSubDropdownResponse {
  MaterialSubDropdownResponse({
    this.materialSubId,
    this.materialSubname,
  });

  int? materialSubId;
  String? materialSubname;

  factory MaterialSubDropdownResponse.fromJson(Map<String, dynamic> json) => MaterialSubDropdownResponse(
    materialSubId: json["MaterialSubId"],
    materialSubname: json["MaterialSubname"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialSubId": materialSubId,
    "MaterialSubname": materialSubname,
  };
}
