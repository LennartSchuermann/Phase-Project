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
  final Directory dir = await getDir(dataPath);

  final saveFile = File('${dir.path}\\save.json');
  if (!await saveFile.exists()) {
    await saveFile.create(recursive: true);
  }

  //TODO add template json??

  return dir;
}

//Read
Future<dynamic> readSaveFile() async {
  final Directory dir = await getDir(dataPath);

  final saveFile = File('${dir.path}\\save.json');

  var data = json.decode(await saveFile.readAsString());

  return data;
}

List<Modul> getModuls(var jsonData) {
  var rest = jsonData as List;

  List<Modul> modulList =
      rest.map<Modul>((json) => Modul.fromJson(json)).toList();

  printContent(modulList);

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

//Print Content
void printContent(List<Modul> moduls) {
  for (Modul modul in moduls) {
    print(modul.name);
    for (Question question in modul.content) {
      print("\t -${question.question}");
    }
  }
}
