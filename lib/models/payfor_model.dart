import 'dart:convert';

List<Payforreponse> payforreponseFromJson(String str) => List<Payforreponse>.from(json.decode(str).map((x) => Payforreponse.fromJson(x)));

String payforreponseToJson(List<Payforreponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payforreponse {
  Payforreponse({
    this.acPayForId,
    this.acPayForName,
  });

  String? acPayForId;
  String? acPayForName;

  factory Payforreponse.fromJson(Map<String, dynamic> json) => Payforreponse(
    acPayForId: json["Ac_PayForId"],
    acPayForName: json["Ac_PayForName"],
  );

  Map<String, dynamic> toJson() => {
    "Ac_PayForId": acPayForId,
    "Ac_PayForName": acPayForName,
  };
}
