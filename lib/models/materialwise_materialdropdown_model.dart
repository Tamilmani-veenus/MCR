import 'dart:convert';

List<MaterialWiseMaterialDropdownResponse> materialWiseMaterialDropdownResponseFromJson(String str) => List<MaterialWiseMaterialDropdownResponse>.from(json.decode(str).map((x) => MaterialWiseMaterialDropdownResponse.fromJson(x)));

String materialWiseMaterialDropdownResponseToJson(List<MaterialWiseMaterialDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialWiseMaterialDropdownResponse {
  MaterialWiseMaterialDropdownResponse({
    this.materialId,
    this.materialName,
    this.scale,
  });

  int? materialId;
  String? materialName;
  String? scale;

  factory MaterialWiseMaterialDropdownResponse.fromJson(Map<String, dynamic> json) => MaterialWiseMaterialDropdownResponse(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    scale: json["Scale"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Scale": scale,
  };
}

