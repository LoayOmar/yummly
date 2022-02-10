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

  Meals.fromJson(Map<String, dynamic> json){
    strCategory = json['strCategory'];
    if(strCategory == 'Beef') {
      image = 'assets/images/categories/beef.webp';
    } else if(strCategory == 'Breakfast') {
      image = 'assets/images/categories/breakfast.webp';
    } else if(strCategory == 'Chicken') {
      image = 'assets/images/categories/chicken.jpg';
    } else if(strCategory == 'Dessert') {
      image = 'assets/images/categories/dessert.webp';
    } else if(strCategory == 'Goat') {
      image = 'assets/images/categories/goat.jpg';
    } else if(strCategory == 'Lamb') {
      image = 'assets/images/categories/lamb.webp';
    } else if(strCategory == 'Miscellaneous') {
      image = 'assets/images/categories/miscellaneous.jpg';
    } else if(strCategory == 'Pasta') {
      image = 'assets/images/categories/pasta.webp';
    } else if(strCategory == 'Pork') {
      image = 'assets/images/categories/pork.jpg';
    } else if(strCategory == 'Seafood') {
      image = 'assets/images/categories/seafood.jpg';
    } else if(strCategory == 'Side') {
      image = 'assets/images/categories/side.jpg';
    } else if(strCategory == 'Starter') {
      image = 'assets/images/categories/starter.jpg';
    } else if(strCategory == 'Vegan') {
      image = 'assets/images/categories/vegan.jpg';
    } else if(strCategory == 'Vegetarian') {
      image = 'assets/images/categories/vegetarian.webp';
    }
  }
}