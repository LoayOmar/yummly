class MealModel {
  List<Meals> meals = [];
  MealModel.fromJson(Map<String, dynamic> json) {
    json['meals'].forEach((element) {
      meals.add(Meals.fromJson(element));
    });
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strTags;
  String? strYoutube;
  List ingredients = [];
  List measures = [];

  Meals.fromJson(Map<String, dynamic> json){
    strMeal = json['strMeal'];
    idMeal = json['idMeal'];
    strMealThumb = json['strMealThumb'];
    strCategory = json['strCategory'];
    strArea = json['strArea'];
    strInstructions = json['strInstructions'];
    strTags = json['strTags'];
    strYoutube = json['strYoutube'];
    for(int i=1 ; i<= 20 ; i++){
      if(json['strIngredient$i'] != null && json['strIngredient$i'] != ''){
        ingredients.add(json['strIngredient$i']);
      }
      if(json['strMeasure$i'] != null && json['strMeasure$i'] != ''){
        measures.add(json['strMeasure$i']);
      }
    }
  }
}