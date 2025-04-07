import 'dart:ffi';

class BrandModel {
  Int? brandModelId;
  String? brand;
  String? model;

  BrandModel({this.brandModelId, this.brand, this.model});

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandModelId = json['brandModel_id'];
    brand = json['brand'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandModel_id'] = brandModelId;
    data['brand'] = brand;
    data['model'] = model;
    return data;
  }
}
/*
{
{ "brandModel_id":"", "brand":"", "model":"" }
 */