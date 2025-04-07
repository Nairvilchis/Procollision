/* 
{
    "parts_id": 1,
    "order_id": 1,
    "sku":""
    "refaccion": "",
    "brandModel_id": 111,
    "year": 111,
    "supplier": "",
    "datePromise": "",
    "dateDispatch": "",
    "dateofReturn": "",
    "assortment": true,
    "remarks": ""
}

*/

class Parts {
  int? partsId;
  int? orderId;
  String? sku;
  String? refaccion;
  int? brandModelId;
  int? year;
  String? supplier;
  String? datePromise;
  String? dateDispatch;
  String? dateofReturn;
  bool? assortment;
  String? remarks;

  Parts(
      {this.partsId,
      this.orderId,
      this.sku,
      this.refaccion,
      this.brandModelId,
      this.year,
      this.supplier,
      this.datePromise,
      this.dateDispatch,
      this.dateofReturn,
      this.assortment,
      this.remarks});

  Parts.fromJson(Map<String, dynamic> json) {
    partsId = json['parts_id'];
    orderId = json['order_id'];
    sku = json['sku'];
    refaccion = json['refaccion'];
    brandModelId = json['brandModel_id'];
    year = json['year'];
    supplier = json['supplier'];
    datePromise = json['datePromise'];
    dateDispatch = json['dateDispatch'];
    dateofReturn = json['dateofReturn'];
    assortment = json['assortment'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parts_id'] = partsId;
    data['order_id'] = orderId;
    data['sku'] = sku;
    data['refaccion'] = refaccion;
    data['brandModel_id'] = brandModelId;
    data['year'] = year;
    data['supplier'] = supplier;
    data['datePromise'] = datePromise;
    data['dateDispatch'] = dateDispatch;
    data['dateofReturn'] = dateofReturn;
    data['assortment'] = assortment;
    data['remarks'] = remarks;
    return data;
  }
}
