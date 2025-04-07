/*
{ "budget_id":"", "concepts":[{ "concept" "repairOrChange":"", "parts_id":11 }], }


 */
class Budget {
  String? budgetId;
  List<Concepts>? concepts;

  Budget({this.budgetId, this.concepts});

  Budget.fromJson(Map<String, dynamic> json) {
    budgetId = json['budget_id'];
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach((v) {
        concepts!.add(Concepts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budget_id'] = budgetId;
    if (concepts != null) {
      data['concepts'] = concepts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Concepts {
  String? concept;
  String? repairOrChange;
  int? partsId;

  Concepts({this.concept, this.repairOrChange, this.partsId});

  Concepts.fromJson(Map<String, dynamic> json) {
    concept = json['concept'];
    repairOrChange = json['repairOrChange'];
    partsId = json['parts_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['concept'] = concept;
    data['repairOrChange'] = repairOrChange;
    data['parts_id'] = partsId;
    return data;
  }
}
