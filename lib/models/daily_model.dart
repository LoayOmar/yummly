class DailyModel {
  List<Meals> meals = [];
  Nutrients? nutrients;

  DailyModel.fromJson(Map<String, dynamic> json) {
    json['meals'].forEach((element) {
      meals.add(Meals.fromJson(element));
    });

    nutrients = Nutrients.fromJson(json['nutrients']);
  }
}

class Meals {
  int? id;
  String? sourceUrl;

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceUrl = json['sourceUrl'];
  }
}

class Nutrients {
  double? calories;
  double? protein;
  double? fat;
  double? carbohydrates;

  Nutrients.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    protein = json['protein'];
    fat = json['fat'];
    carbohydrates = json['carbohydrates'];
  }
}
