import 'package:json_annotation/json_annotation.dart';

part 'question_podo.g.dart';

@JsonSerializable()
class Question {
  String question;
  String answer;
  String imgPath;
  int phase;
  DateTime nextQuery;

  Question({
    required this.question,
    required this.answer,
    required this.imgPath,
    required this.phase,
    required this.nextQuery,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  /* factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json["question"],
      answer: json["answer"],
      imgPath: json["img_path"],
      phase: json["phase"],
      nextQuery: DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
        'img_path': imgPath,
        'phase': phase,
        'date': nextQuery,
      }; */
}
