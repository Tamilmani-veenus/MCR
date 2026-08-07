// To parse this JSON data, do
//
//     final materialWiseSubHeadResponse = materialWiseSubHeadResponseFromJson(jsonString);

import 'dart:convert';

List<MaterialWiseSubHeadResponse> materialWiseSubHeadResponseFromJson(String str) => List<MaterialWiseSubHeadResponse>.from(json.decode(str).map((x) => MaterialWiseSubHeadResponse.fromJson(x)));

String materialWiseSubHeadResponseToJson(List<MaterialWiseSubHeadResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialWiseSubHeadResponse {
  MaterialWiseSubHeadResponse({
    this.materialheadid,
    this.materialHead,
  });

  int? materialheadid;
  String? materialHead;

  factory MaterialWiseSubHeadResponse.fromJson(Map<String, dynamic> json) => MaterialWiseSubHeadResponse(
    materialheadid: json["Materialheadid"],
    materialHead: json["material_head"],
  );

  Map<String, dynamic> toJson() => {
    "Materialheadid": materialheadid,
    "material_head": materialHead,
  };
}
