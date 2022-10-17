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

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json["question"],
      answer: json["answer"],
      imgPath: json["img_path"],
      phase: json["phase"],
      nextQuery: json["date"],
    );
  }

  /* Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      }; */
}
