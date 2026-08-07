
import 'dart:convert';

List<AccountNamereponse> accountNamereponseFromJson(String str) => List<AccountNamereponse>.from(json.decode(str).map((x) => AccountNamereponse.fromJson(x)));

String accountNamereponseToJson(List<AccountNamereponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountNamereponse {
  AccountNamereponse({
    this.accNameid,
    this.accName,
  });

  int? accNameid;
  String? accName;

  factory AccountNamereponse.fromJson(Map<String, dynamic> json) => AccountNamereponse(
    accNameid: json["Acc_Nameid"],
    accName: json["Acc_Name"],
  );

  Map<String, dynamic> toJson() => {
    "Acc_Nameid": accNameid,
    "Acc_Name": accName,
  };
}
