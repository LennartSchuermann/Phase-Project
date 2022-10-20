//get Moduls for Today
import 'package:phase_project/classes/question_podo.dart';

import '../classes/modul_podo.dart';

List<int> pause = [0, 1, 2, 4, 7, 10, 40, 100, 240]; //max: 9 phases

DateTime getNextQueryDate(int currentPhase) {
  DateTime newDate =
      DateTime.now().add(Duration(days: pause[currentPhase - 1]));
  return newDate;
}

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
    if (question.nextQuery.compareTo(DateTime.now()) <= 0 &&
        currentModul.phaseCnt > question.phase) {
      questions.add(question);
    }
  }
  return questions;
}
