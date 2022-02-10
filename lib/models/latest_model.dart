class LatestModel {
  List<Meals> meals = [];
  LatestModel.fromJson(Map<String, dynamic> json) {
    json['meals'].forEach((element) {
      meals.add(Meals.fromJson(element));
    });
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meals.fromJson(Map<String, dynamic> json){
    strMeal = json['strMeal'];
    idMeal = json['idMeal'];
    strMealThumb = json['strMealThumb'];
  }
}