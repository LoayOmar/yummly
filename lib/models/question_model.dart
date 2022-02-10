class QuestionModel {
  String? answer;
  String? image;
  String? type;

  QuestionModel.fromJson(Map<String, dynamic> json){
    answer = json['answer'];
    image = json['image'];
    type = json['type'];
  }
}