class SiteLocationDBModel {
  int? projectId;
  String? projectName;
  int? locid;
  String? pinStatus;
  int? radius;
  String? longitude;
  String? latitude;

  siteLocationDBModelMap(){
    var mapping = Map<String, dynamic>();
    mapping['projectId'] = projectId != null ? projectId : null;
    mapping['projectName'] = projectName != null ? projectName : null;
    mapping['locid'] = locid != null ? locid : null;
    mapping['pinStatus'] = pinStatus != null ? pinStatus : null;
    mapping['radius'] = radius != null ? radius : null;
    mapping['longitude'] = longitude != null ? longitude : null;
    mapping['latitude'] = latitude != null ? latitude : null;
    return mapping;
  }
}