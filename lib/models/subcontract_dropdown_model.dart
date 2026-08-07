import 'dart:convert';

List<SubcontractorDropdownList> subcontractorDropdownListFromJson(String str) => List<SubcontractorDropdownList>.from(json.decode(str).map((x) => SubcontractorDropdownList.fromJson(x)));

String subcontractorDropdownListToJson(List<SubcontractorDropdownList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubcontractorDropdownList {
  SubcontractorDropdownList({
    this.subContId,
    this.subContName,
  });

  int? subContId;
  String? subContName;

  factory SubcontractorDropdownList.fromJson(Map<String, dynamic> json) => SubcontractorDropdownList(
    subContId: json["SubContId"],
    subContName: json["SubContName"],
  );

  Map<String, dynamic> toJson() => {
    "SubContId": subContId,
    "SubContName": subContName,
  };
}





List<GetLabourDetails> getLabourDetailsFromJson(String str) => List<GetLabourDetails>.from(json.decode(str).map((x) => GetLabourDetails.fromJson(x)));

String getLabourDetailsToJson(List<GetLabourDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetLabourDetails {
  int? labourId;
  String? labourName;

  GetLabourDetails({
    this.labourId,
    this.labourName,
  });

  factory GetLabourDetails.fromJson(Map<String, dynamic> json) => GetLabourDetails(
    labourId: json["LabourId"],
    labourName: json["LabourName"],
  );

  Map<String, dynamic> toJson() => {
    "LabourId": labourId,
    "LabourName": labourName,
  };
}
