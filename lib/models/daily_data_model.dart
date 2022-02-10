class DailyDataModel {
  int? id;
  String? title;
  String? preparationMinutes;
  String? cookingMinutes;
  String? readyInMinutes;
  String? servings;
  String? sourceUrl;
  String? image;
  String? spoonacularSourceUrl;
  List<ExtendedIngredients> extendedIngredients = [];
  List<AnalyzedInstructions> analyzedInstructions = [];

  DailyDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    preparationMinutes = json['preparationMinutes'].toString();
    cookingMinutes = json['cookingMinutes'].toString();
    readyInMinutes = json['readyInMinutes'].toString();
    servings = json['servings'].toString();
    sourceUrl = json['sourceUrl'];
    image = json['image'];
    spoonacularSourceUrl = json['spoonacularSourceUrl'];
    json['extendedIngredients'].forEach((element) {
      extendedIngredients.add(ExtendedIngredients.fromJson(element));
    });
    json['analyzedInstructions'].forEach((element) {
      analyzedInstructions.add(AnalyzedInstructions.fromJson(element));
    });
  }
}

class ExtendedIngredients {
  String? original;

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    original = json['original'];
  }
}

class AnalyzedInstructions {
  String? name;
  List<Steps> steps = [];

  AnalyzedInstructions.fromJson(Map<String, dynamic> json){
    name = json['name'];
    json['steps'].forEach((element) {
      steps.add(Steps.fromJson(element));
    });
  }
}

class Steps {
  String? step;

  Steps.fromJson(Map<String, dynamic> json) {
    step = json['step'];
  }
}