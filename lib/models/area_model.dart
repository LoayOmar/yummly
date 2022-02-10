class AreasModel {
  List<Meals> meals = [];
  AreasModel.fromJson(Map<String, dynamic> json) {
    json['meals'].forEach((element) {
      meals.add(Meals.fromJson(element));
    });
  }
}

class Meals {
  String? strArea;
  String? image;

  Meals.fromJson(Map<String, dynamic> json){
    strArea = json['strArea'] == 'Unknown' ? 'Other' : json['strArea'];
    if(strArea == 'American') {
      image = 'assets/images/areas/american.jpg';
    } else if(strArea == 'British') {
      image = 'assets/images/areas/british.jpg';
    } else if(strArea == 'Canadian') {
      image = 'assets/images/areas/canadian.jpg';
    } else if(strArea == 'Chinese') {
      image = 'assets/images/areas/chinese.webp';
    } else if(strArea == 'Croatian') {
      image = 'assets/images/areas/croatian.jpg';
    } else if(strArea == 'Dutch') {
      image = 'assets/images/areas/dutch.jpg';
    } else if(strArea == 'Egyptian') {
      image = 'assets/images/areas/egyptian.jpg';
    } else if(strArea == 'French') {
      image = 'assets/images/areas/french.jpg';
    } else if(strArea == 'Greek') {
      image = 'assets/images/areas/greek.jpg';
    } else if(strArea == 'Indian') {
      image = 'assets/images/areas/indian.jpg';
    } else if(strArea == 'Irish') {
      image = 'assets/images/areas/irish.jpg';
    } else if(strArea == 'Italian') {
      image = 'assets/images/areas/italian.jpg';
    } else if(strArea == 'Jamaican') {
      image = 'assets/images/areas/jamaican.jfif';
    } else if(strArea == 'Japanese') {
      image = 'assets/images/areas/japanese.jpg';
    } else if(strArea == 'Kenyan') {
      image = 'assets/images/areas/kenyan.jpg';
    } else if(strArea == 'Malaysian') {
      image = 'assets/images/areas/malaysian.jpg';
    } else if(strArea == 'Mexican') {
      image = 'assets/images/areas/mexican.jpg';
    } else if(strArea == 'Moroccan') {
      image = 'assets/images/areas/moroccan.jpg';
    } else if(strArea == 'Polish') {
      image = 'assets/images/areas/polish.webp';
    } else if(strArea == 'Portuguese') {
      image = 'assets/images/areas/portuguese.jpg';
    } else if(strArea == 'Russian') {
      image = 'assets/images/areas/russian.webp';
    } else if(strArea == 'Spanish') {
      image = 'assets/images/areas/spanish.jpg';
    } else if(strArea == 'Thai') {
      image = 'assets/images/areas/thai.jpg';
    } else if(strArea == 'Tunisian') {
      image = 'assets/images/areas/tunisian.jpg';
    } else if(strArea == 'Turkish') {
      image = 'assets/images/areas/turkish.jfif';
    } else if(strArea == 'Other') {
      image = 'assets/images/areas/unknown.jpg';
    }else if(strArea == 'Vietnamese') {
      image = 'assets/images/areas/vietnamese.webp';
    }
  }
}