/*
{
    "insurer_id": "",
    "insurer": "",
    "adjusters": [
        {
            "name": "name",
            "phone": ""
        }
    ]
}


 */


import 'dart:ffi';

class Insurer {
	Int? insurerId;
	String? insurer;
	List<Adjusters>? adjusters;

	Insurer({this.insurerId, this.insurer, this.adjusters});

	Insurer.fromJson(Map<String, dynamic> json) {
		insurerId = json['insurer_id'];
		insurer = json['insurer'];
		if (json['adjusters'] != null) {
			adjusters = <Adjusters>[];
			json['adjusters'].forEach((v) { adjusters!.add(Adjusters.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['insurer_id'] = insurerId;
		data['insurer'] = insurer;
		if (adjusters != null) {
      data['adjusters'] = adjusters!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Adjusters {
	String? name;
	String? phone;

	Adjusters({this.name, this.phone});

	Adjusters.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		phone = json['phone'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		data['phone'] = phone;
		return data;
	}
}