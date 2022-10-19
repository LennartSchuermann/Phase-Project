import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phase_project/classes/modul_podo.dart';
import 'package:phase_project/classes/question_podo.dart';

String imgPath = 'PhaseProject\\images';
String dataPath = 'PhaseProject\\save';

Future<Directory> getDir(String path) async {
  final storage = await getApplicationDocumentsDirectory();
  final dir = Directory('${storage.path}\\$path');

  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }

  return dir;
}

//Img Data
Future<File> saveFile(PlatformFile file) async {
  final Directory dir = await getDir(imgPath);

  final newFile = File('${dir.path}\\${file.name}');
  return File(file.path!).copy(newFile.path);
}

//Safe data

//Create
Future<Directory> createSaveFile() async {
  final File saveFile = await getSaveFile();
  if (!await saveFile.exists()) {
    await saveFile.create(recursive: true);
  }

  //TODO add template json??

  return Directory(saveFile.path);
}

Future<File> getSaveFile() async {
  final Directory dir = await getDir(dataPath);
  return File('${dir.path}\\save.json');
}

//Read
Future<dynamic> readSaveFile() async {
  final Directory dir = await getDir(dataPath);

  final saveFile = File('${dir.path}\\save.json');

  var data = [];
  if (await saveFile.readAsString() != "") {
    data = json.decode(await saveFile.readAsString());
  }

  return data;
}

List<Modul> getModuls(var jsonData) {
  var rest = jsonData as List;

  List<Modul> modulList =
      rest.map<Modul>((json) => Modul.fromJson(json)).toList();

  //printContent(modulList);

  return modulList;
}

List<Question> getQuestions(Modul modul) {
  List<Question> questions = [];
  for (Question question in modul.content) {
    questions.add(question);
  }

  return questions;
}

//Edit
Future editData(Modul modul, bool remove) async {
  List<Modul> moduls = getModuls(await readSaveFile());
  Modul? oldModul = getDuplicateModul(moduls, modul.id);

  if (oldModul != null) {
    moduls.remove(oldModul);

    if (!remove) moduls.add(modul);
    await saveData(moduls, modul);
  }

  return moduls;
}

Future editQuestion(Modul modul, Question question, bool remove) async {
  Question? oldQuestion = getDuplicateQuestion(modul.content, question.id);
  if (oldQuestion != null) {
    modul.content.remove(oldQuestion);

    if (!remove) modul.content.add(question);
    await saveData(await editData(modul, false), modul);
  }
}

Modul? getDuplicateModul(List<Modul> moduls, int id) {
  for (var modul in moduls) {
    if (modul.id == id) {
      return modul;
    }
  }
  return null;
}

Question? getDuplicateQuestion(List<Question> questions, int id) {
  for (var question in questions) {
    if (question.id == id) {
      return question;
    }
  }
  return null;
}

//Add
Future addData(Modul modul) async {
  List<Modul> moduls = getModuls(await readSaveFile());
  moduls.add(modul);

  await saveData(moduls, modul);
}

Future saveData(List<Modul> moduls, Modul modul) async {
  final File saveFile = await getSaveFile();
  saveFile.writeAsStringSync(json.encode(moduls));

  print(modul.toJson());
}

//Print Content
void printContent(List<Modul> moduls) {
  for (Modul modul in moduls) {
    print(modul.name);
    for (Question question in modul.content) {
      print("\t -${question.question}");
    }
  }
}
