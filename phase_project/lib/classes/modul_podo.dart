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
    return Modul(
        name: json["name"],
        content: Question.fromJson(json["content"]) as List<Question>,
        phaseCnt: json["phase_cnt"]);
  }
}
