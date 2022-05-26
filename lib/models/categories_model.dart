class CategoriesModel {
  List<Meals> meals = [];
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    json['meals'].forEach((element) {
      meals.add(Meals.fromJson(element));
    });
  }
}

class Meals {
  String? strCategory;
  String? image;
  Map<String, String> categoryImage = {
    'Beef' : 'assets/images/categories/beef.webp',
    'Breakfast' : 'assets/images/categories/breakfast.webp',
    'Chicken' : 'assets/images/categories/chicken.jpg',
    'Dessert' : 'assets/images/categories/dessert.webp',
    'Goat' : 'assets/images/categories/goat.jpg',
    'Lamb' : 'assets/images/categories/lamb.webp',
    'Miscellaneous' : 'assets/images/categories/miscellaneous.jpg',
    'Pasta' : 'assets/images/categories/pasta.webp',
    'Pork' : 'assets/images/categories/pork.jpg',
    'Seafood' : 'assets/images/categories/seafood.jpg',
    'Side' : 'assets/images/categories/side.jpg',
    'Starter' : 'assets/images/categories/starter.jpg',
    'Vegan' : 'assets/images/categories/vegan.jpg',
    'Vegetarian' : 'assets/images/categories/vegetarian.webp',
  };

  Meals.fromJson(Map<String, dynamic> json){
    strCategory = json['strCategory'];
    image = categoryImage[json['strCategory']];
  }
}