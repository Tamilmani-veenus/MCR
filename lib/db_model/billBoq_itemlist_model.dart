class BillGenBoqItemListTableModel{
  String? Name;
  int? workDetId;
  String? unit;
  double? qty;
  double? rate;
  double? amount;
  double? balbillqty;
  double? CurBillQty;
  double? appQty;
  int? level3ItemId;
  int? headItemid;
  int? subItemid;

  BillGenBoqItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['workDetId'] = workDetId != null ? workDetId : null;
    mapping['Name'] = Name != null ? Name : null;
    mapping['unit'] = unit != null ? unit : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['amount'] = amount != null ? amount : null;
    mapping['balbillqty'] = balbillqty != null ? balbillqty : null;
    mapping['CurBillQty'] = CurBillQty != null ? CurBillQty : null;
    mapping['appQty'] = appQty != null ? appQty : null;
    mapping['level3ItemId'] = level3ItemId != null ? level3ItemId : null;
    mapping['headItemid'] = headItemid != null ? headItemid : null;
    mapping['subItemid'] = subItemid != null ? subItemid : null;

    return mapping;
  }
}