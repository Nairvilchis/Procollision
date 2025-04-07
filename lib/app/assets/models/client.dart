import 'dart:ffi';

class Client {
  Int? clientId;
  String? name;
  String? phone;
  String? email;

  Client({this.clientId, this.name, this.phone, this.email});

  Client.fromJson(Map<String, dynamic> json) {
  
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
 
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}


/*
{
    "client_id": 1,
    "name": "",
    "phone": "",
    "email": ""
}
 */