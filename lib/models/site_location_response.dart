import 'dart:convert';

SiteLocationResponse siteLocationResponseFromJson(String str) => SiteLocationResponse.fromJson(json.decode(str));
String siteLocationResponseToJson(SiteLocationResponse data) => json.encode(data.toJson());
class SiteLocationResponse {
  SiteLocationResponse({
    List<SiteLocation>? siteLocation,}){
    _siteLocation = siteLocation;
  }

  SiteLocationResponse.fromJson(dynamic json) {
    if (json['SiteLocation'] != null) {
      _siteLocation = [];
      json['SiteLocation'].forEach((v) {
        _siteLocation?.add(SiteLocation.fromJson(v));
      });
    }
  }
  List<SiteLocation>? _siteLocation;
  SiteLocationResponse copyWith({  List<SiteLocation>? siteLocation,
  }) => SiteLocationResponse(  siteLocation: siteLocation ?? _siteLocation,
  );
  List<SiteLocation>? get siteLocation => _siteLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_siteLocation != null) {
      map['SiteLocation'] = _siteLocation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

SiteLocation siteLocationFromJson(String str) => SiteLocation.fromJson(json.decode(str));
String siteLocationToJson(SiteLocation data) => json.encode(data.toJson());
class SiteLocation {
  SiteLocation({
    num? projectId,
    num? punchID,
    String? projectName,
    String? punchStatus,
    num? locid,
    String? pinStatus,
    num? radius,
    String? longitude,
    String? latitude, }){
    _projectId = projectId;
    _punchID = punchID;
    _projectName = projectName;
    _punchStatus = punchStatus;
    _locid = locid;
    _pinStatus = pinStatus;
    _radius = radius;
    _longitude = longitude;
    _latitude = latitude;
  }

  SiteLocation.fromJson(dynamic json) {
    _projectId = json['Projectid'];
    _punchID = json['Punch_ID'];
    _projectName = json['ProjectName'];
    _punchStatus = json['punch_status'];
    _locid = json['Locid'];
    _pinStatus = json['PinStatus'];
    _radius = json['Radius'];
    _longitude = json['Longitude'];
    _latitude = json['Latitude'];
  }
  num? _projectId;
  num? _punchID;
  String? _projectName;
  String? _punchStatus;
  num? _locid;
  String? _pinStatus;
  num? _radius;
  String? _longitude;
  String? _latitude;
  SiteLocation copyWith({
    num? projectId,
    num? punchID,
    String? projectName,
    String? punchStatus,
    num? locid,
    String? pinStatus,
    num? radius,
    String? longitude,
    String? latitude,
  }) => SiteLocation(
    projectId: projectId ?? _projectId,
    punchID: punchID ?? _punchID,
    projectName: projectName ?? _projectName,
    punchStatus: punchStatus ?? _punchStatus,
    locid: locid ?? _locid,
    pinStatus: pinStatus ?? _pinStatus,
    radius: radius ?? _radius,
    longitude: longitude ?? _longitude,
    latitude: latitude ?? _latitude,
  );
  num? get projectId => _projectId;
  num? get punchID => _punchID;
  String? get projectName => _projectName;
  String? get punchStatus => _punchStatus;
  num? get locid => _locid;
  String? get pinStatus => _pinStatus;
  num? get radius => _radius;
  String? get longitude => _longitude;
  String? get latitude => _latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Projectid'] = _projectId;
    map['Punch_ID'] = _punchID;
    map['ProjectName'] = _projectName;
    map['punch_status'] = _punchStatus;
    map['Locid'] = _locid;
    map['PinStatus'] = _pinStatus;
    map['Radius'] = _radius;
    map['Longitude'] = _longitude;
    map['Latitude'] = _latitude;
    return map;
  }

}