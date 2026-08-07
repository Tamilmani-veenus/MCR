import 'dart:convert';

List<Accounttypereponse> accounttypereponseFromJson(String str) => List<Accounttypereponse>.from(json.decode(str).map((x) => Accounttypereponse.fromJson(x)));

String accounttypereponseToJson(List<Accounttypereponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Accounttypereponse {
  Accounttypereponse({
    this.accTypeid,
    this.accType,
    this.androidAddActive,
  });

  int? accTypeid;
  String? accType;
  int? androidAddActive;

  factory Accounttypereponse.fromJson(Map<String, dynamic> json) => Accounttypereponse(
    accTypeid: json["Acc_Typeid"],
    accType: json["Acc_Type"],
    androidAddActive: json["Android_Add_active"],
  );

  Map<String, dynamic> toJson() => {
    "Acc_Typeid": accTypeid,
    "Acc_Type": accType,
    "Android_Add_active": androidAddActive,
  };
}
