import 'package:phase_project/classes/question_podo.dart';

class Modul {
  String name;
  int phaseCnt;
  List<Question> content;

  Modul({
    required this.name,
    required this.content,
    required this.phaseCnt,
  });

  factory Modul.fromJson(Map<String, dynamic> json) {
    var contentObjs = json['content'] as List;
    List<Question> questions =
        contentObjs.map((tagJson) => Question.fromJson(tagJson)).toList();
    return Modul(
        name: json["name"], content: questions, phaseCnt: json["phase_cnt"]);
  }
}
