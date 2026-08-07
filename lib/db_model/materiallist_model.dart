class Materiallist{
  int? materialid;
  String? material;
  String? scale;
  double? qty;
  double? balqty;
  String? remarks;
  String? desc;


  Materiallistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['materialid'] = materialid != null ? materialid : null;
    mapping['material'] = material != null ? material : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['balqty'] = balqty != null ? balqty : null;
    mapping['remarks'] = remarks != null ? remarks : null;
    mapping['desc'] = desc != null ? desc : null;
    return mapping;
  }
}