import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/screens/home_screen.dart';

import 'package:window_manager/window_manager.dart';
import 'logic/file_handling.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 832),
      center: true,
      backgroundColor: kBackgroundColor,
      skipTaskbar: false,
      title: kAppName
      //titleBarStyle: TitleBarStyle.hidden,
      );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    //await windowManager.setMaximizable(true);
    await windowManager.setResizable(false);
    //await windowManager.setBackgroundColor(kFontColor);
    await windowManager.show();
    await windowManager.focus();
  });

  await createSaveFile();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), //TODO Load json data
      debugShowCheckedModeBanner: false,
    );
  }
}
