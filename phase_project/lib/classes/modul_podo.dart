import 'package:phase_project/classes/question_podo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'modul_podo.g.dart';

@JsonSerializable(explicitToJson: true)
class Modul {
  final int id;

  String name;
  int phaseCnt;
  List<Question> content;

  Modul({
    required this.name,
    required this.content,
    required this.phaseCnt,
    required this.id,
  });

  factory Modul.fromJson(Map<String, dynamic> json) => _$ModulFromJson(json);
  Map<String, dynamic> toJson() => _$ModulToJson(this);

  /* factory Modul.fromJson(Map<String, dynamic> json) {
    var contentObjs = json['content'] as List;
    List<Question> questions =
        contentObjs.map((tagJson) => Question.fromJson(tagJson)).toList();

    return Modul(
      name: json["name"],
      content: questions,
      phaseCnt: json["phase_cnt"],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phase_cnt': phaseCnt,
        'content': content,
      }; */
}
