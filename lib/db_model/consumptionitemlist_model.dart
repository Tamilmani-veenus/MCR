class ConsumptionItemlist{
  int? materialid;
  String? material;
  String? scale;
  double? Stockqty;
  double? Usageqty;

  ConsumItemlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['materialid'] = materialid != null ? materialid : null;
      mapping['material'] = material != null ? material : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['stockqty'] = Stockqty != null ? Stockqty : null;
    mapping['usageqty'] = Usageqty != null ? Usageqty : null;
    return mapping;
  }
}