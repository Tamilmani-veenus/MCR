class TransferBetItemListTableModel{
  int? id;
  int? materialId;
  String? materialName;
  String? scale;
  double? stockQty;
  double? Qty;
  double? balQty;
  int? reqDetId;
  double? rate;
  double? amount;

  TransferBetItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id != null ? id : null;
    mapping['materialId'] = materialId != null ? materialId : null;
    mapping['materialName'] = materialName != null ? materialName : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['stockQty'] = stockQty != null ? stockQty : null;
    mapping['Qty'] = Qty != null ? Qty : null;
    mapping['balQty'] = balQty != null ? balQty : null;
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['amount'] = amount != null ? amount : null;
    return mapping;
  }
}