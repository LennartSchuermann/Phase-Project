import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> saveFile(PlatformFile file) async {
  final storage = await getApplicationDocumentsDirectory();
  final dir = Directory('${storage.path}\\PhaseProject\\images');

  if (!await dir.exists()) {
    dir.create();
    print(dir.path);
  }

  final newFile = File('${dir.path}\\${file.name}');
  return File(file.path!).copy(newFile.path);
}
