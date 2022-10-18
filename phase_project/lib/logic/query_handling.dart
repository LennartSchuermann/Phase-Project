//get Moduls for Today
import 'package:phase_project/classes/question_podo.dart';

import '../classes/modul_podo.dart';

List<Modul> getModulsToQuery(List<Modul> allModuls) {
  List<Modul> moduls = [];
  for (Modul modul in allModuls) {
    if (getQuestionsToQuery(modul).isNotEmpty) {
      moduls.add(modul);
    }
  }
  return moduls;
}

//get Questions for Today
List<Question> getQuestionsToQuery(Modul currentModul) {
  List<Question> questions = [];
  for (Question question in currentModul.content) {
    if (question.nextQuery.compareTo(DateTime.now()) <= 0) {
      questions.add(question);
    }
  }
  return questions;
}
