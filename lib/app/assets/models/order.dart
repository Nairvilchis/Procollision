/*
{
"orderId":1000 ,
"adjuster":"",
"claim":"",
"onfloor":true,
"insurerId":1,
"policy":"",
"folio":"",
"crane":true,
"deductible":"",
"series":"",
"clientId":1,
"brandModelId":1,
"year":2000,
"licenseplates":"",
"color":"",
"ThirdPartyInsured":"",
"fileURL":"",
"registrationDate":"",
"valuationDate":"",
"returnDate":"",
"deliveryDate":"",
"promiseDate":"",
"appraiserId":1,
"advisorId":1,
"sheetmetalId":1,
"mileage":"",
"painterId":1,
"budgetId":1,
"registration":"",
"process":""
}


 */
 

 class Order {
  String? orderId;
  String? adjuster;
  String? claim;
  bool? onfloor;
  int? insurerId;
  String? policy;
  String? folio;
  bool? crane;
  String? deductible;
  String? series;
  int? clientId;
  int? brandModelId;
  int? year;
  String? licenseplates;
  String? color;
  String? thirdPartyInsured;
  String? fileURL;
  String? registrationDate;
  String? valuationDate;
  String? returnDate;
  String? deliveryDate;
  String? promiseDate;
  int? appraiserId;
  int? advisorId;
  int? sheetmetalId;
  String? mileage;
  int? painterId;
  int? budgetId;
  String? registration;
  String? process;

  Order(
      {this.orderId,
      this.adjuster,
      this.claim,
      this.onfloor,
      this.insurerId,
      this.policy,
      this.folio,
      this.crane,
      this.deductible,
      this.series,
      this.clientId,
      this.brandModelId,
      this.year,
      this.licenseplates,
      this.color,
      this.thirdPartyInsured,
      this.fileURL,
      this.registrationDate,
      this.valuationDate,
      this.returnDate,
      this.deliveryDate,
      this.promiseDate,
      this.appraiserId,
      this.advisorId,
      this.sheetmetalId,
      this.mileage,
      this.painterId,
      this.budgetId,
      this.registration,
      this.process});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    adjuster = json['adjuster'];
    claim = json['claim'];
    onfloor = json['onfloor'];
    insurerId = json['insurerId'];
    policy = json['policy'];
    folio = json['folio'];
    crane = json['crane'];
    deductible = json['deductible'];
    series = json['series'];
    clientId = json['clientId'];
    brandModelId = json['brandModelId'];
    year = json['year'];
    licenseplates = json['licenseplates'];
    color = json['color'];
    thirdPartyInsured = json['ThirdPartyInsured'];
    fileURL = json['fileURL'];
    registrationDate = json['registrationDate'];
    valuationDate = json['valuationDate'];
    returnDate = json['returnDate'];
    deliveryDate = json['deliveryDate'];
    promiseDate = json['promiseDate'];
    appraiserId = json['appraiserId'];
    advisorId = json['advisorId'];
    sheetmetalId = json['sheetmetalId'];
    mileage = json['mileage'];
    painterId = json['painterId'];
    budgetId = json['budgetId'];
    registration = json['registration'];
    process = json['process'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['adjuster'] = adjuster;
    data['claim'] = claim;
    data['onfloor'] = onfloor;
    data['insurerId'] = insurerId;
    data['policy'] = policy;
    data['folio'] = folio;
    data['crane'] = crane;
    data['deductible'] = deductible;
    data['series'] = series;
    data['clientId'] = clientId;
    data['brandModelId'] = brandModelId;
    data['year'] = year;
    data['licenseplates'] = licenseplates;
    data['color'] = color;
    data['ThirdPartyInsured'] = thirdPartyInsured;
    data['fileURL'] = fileURL;
    data['registrationDate'] = registrationDate;
    data['valuationDate'] = valuationDate;
    data['returnDate'] = returnDate;
    data['deliveryDate'] = deliveryDate;
    data['promiseDate'] = promiseDate;
    data['appraiserId'] = appraiserId;
    data['advisorId'] = advisorId;
    data['sheetmetalId'] = sheetmetalId;
    data['mileage'] = mileage;
    data['painterId'] = painterId;
    data['budgetId'] = budgetId;
    data['registration'] = registration;
    data['process'] = process;
    return data;
  }
}
