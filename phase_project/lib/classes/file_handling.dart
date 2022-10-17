import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> saveFile(PlatformFile file) async {
  final storage = await getApplicationDocumentsDirectory();
  final newFile = File('${storage.path}/${file.name}');

  return File(file.path!).copy(newFile.path);
}
