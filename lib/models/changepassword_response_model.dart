import 'dart:convert';

ChangedPasswordResponse changedPasswordResponseFromJson(String str) => ChangedPasswordResponse.fromJson(json.decode(str));

String changedPasswordResponseToJson(ChangedPasswordResponse data) => json.encode(data.toJson());

class ChangedPasswordResponse {
  ChangedPasswordResponse({
    this.retString,
  });

  String? retString;

  factory ChangedPasswordResponse.fromJson(Map<String, dynamic> json) => ChangedPasswordResponse(
    retString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}
