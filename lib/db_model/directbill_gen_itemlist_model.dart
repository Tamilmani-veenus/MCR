class DirectBillGenItemListTableModel{
  int? Id;
  int? workDetId;
  String? Name;
  String? unit;
  double? qty;
  double? rate;
  double? amount;
  int? isApi ;

  DirectBillGenItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = Id != null ? Id : null;
    mapping['workDetId'] = workDetId != null ? workDetId : null;
    mapping['Name'] = Name != null ? Name : null;
    mapping['unit'] = unit != null ? unit : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['amount'] = amount != null ? amount : null;
    mapping['isApi'] = isApi;
    return mapping;
  }
}