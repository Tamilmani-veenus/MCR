
import 'dart:convert';

List<DailyEntrysubcontRightsEntrylistRes> dailyEntrysubcontRightsEntrylistResFromJson(String str) => List<DailyEntrysubcontRightsEntrylistRes>.from(json.decode(str).map((x) => DailyEntrysubcontRightsEntrylistRes.fromJson(x)));

String dailyEntrysubcontRightsEntrylistResToJson(List<DailyEntrysubcontRightsEntrylistRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyEntrysubcontRightsEntrylistRes {
  DailyEntrysubcontRightsEntrylistRes({
    this.addMode,
    this.editMode,
    this.deleteMode,
  });

  int? addMode;
  int? editMode;
  int? deleteMode;

  factory DailyEntrysubcontRightsEntrylistRes.fromJson(Map<String, dynamic> json) => DailyEntrysubcontRightsEntrylistRes(
    addMode: json["AddMode"],
    editMode: json["EditMode"],
    deleteMode: json["DeleteMode"],
  );

  Map<String, dynamic> toJson() => {
    "AddMode": addMode,
    "EditMode": editMode,
    "DeleteMode": deleteMode,
  };
}
