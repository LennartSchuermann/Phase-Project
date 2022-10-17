import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

String imgPath = 'PhaseProject\\images';
String dataPath = 'PhaseProject\\save';

Future<Directory> getDir(String path) async {
  final storage = await getApplicationDocumentsDirectory();
  final dir = Directory('${storage.path}\\$path');

  print(path);

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
Future<File> createSaveFile() async {
  final Directory dir = await getDir(dataPath);

  //TODO add template json

  final saveFile = File('${dir.path}\\save.json');
  return saveFile.create(recursive: true);
}

//Read
Future<File> readSaveFile() async {
  final Directory dir = await getDir(dataPath);

  final saveFile = File('${dir.path}\\save.json');
  print(saveFile.readAsString());
  return saveFile;
}

//Edit
