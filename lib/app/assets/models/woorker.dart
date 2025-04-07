/*
{
  
    "id":2558,
    "name":"nair",
    "cellphonenumber":"9999999999",
    "workstation":"admin",
    "password":"vilchis",
    "user":"nair",
    "startdate":"",
    "workpermits":{
        "admin":true,
        "appraiser":true,
        "advice":true,
        "warehouseman":true
        
     }
}

*/
class Woorker {
  
    int? id;
    String? name;
    String? cellphonenumber;
    String? workstation;
    String? password;
    String? user;
    String? startdate;
    Workpermits? workpermits;
    

    Woorker({
    
        this.id,
        this.name,
        this.cellphonenumber,
        this.workstation,
        this.password,
        this.user,
        this.startdate,
        this.workpermits});
  
    Woorker.fromJson(Map<String, dynamic> json) {
     
      id = json['id'];
      name = json['name'];
      cellphonenumber = json['cellphonenumber'];
      workstation = json['workstation'];
      password = json['password'];
      user = json['user'];
      startdate = json['startdate'][0];
      workpermits = json['workpermits'] != null
          ? Workpermits.fromJson(json['workpermits'])
          : null;
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
     
      data['id'] = id;
      data['name'] = name;
      data['cellphonenumber'] = cellphonenumber;
      data['workstation'] = workstation;
      data['password'] = password;
      data['user'] = user;
      data['startdate'] = startdate;
      if (workpermits != null) {
        data['workpermits'] = workpermits!.toJson();
      }
      return data;
    }
  }
  
  class Workpermits {
    bool? admin;
    bool? appraiser;
    bool? advice;
    bool? warehouseman;
  
    Workpermits({this.admin, this.appraiser, this.advice, this.warehouseman});
  
    Workpermits.fromJson(Map<String, dynamic> json) {
      admin = json['admin'];
      appraiser = json['appraiser'];
      advice = json['advice'];
      warehouseman = json['warehouseman'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['admin'] = admin;
      data['appraiser'] = appraiser;
      data['advice'] = advice;
      data['warehouseman'] = warehouseman;
      return data;
    }
  }