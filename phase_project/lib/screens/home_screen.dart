import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/prefabs.dart';
import 'package:phase_project/screens/modul_edit_screen.dart';
import 'package:phase_project/screens/modul_screen.dart';

import '../classes/modul_podo.dart';
import '../logic/file_handling.dart';
import '../logic/query_handling.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);

    return FutureBuilder<dynamic>(
      future: readSaveFile(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Modul> moduls = getModuls(snapshot.data);
          List<Modul> modulsToQuery = getModulsToQuery(moduls);
          return Scaffold(
            backgroundColor: kBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TitleText(
                          content: kAppName,
                        ),
                      ),
                      DescriptionText(content: "$kAppVersion | $kAppCaption")
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  modulsToQuery.isNotEmpty
                      ? HeaderText(content: "Heute fällig:")
                      : const SizedBox(),
                  SizedBox(
                    height: modulsToQuery.isNotEmpty ? kDefaultPadding / 2 : 0,
                  ),
                  //Today
                  modulsToQuery.isNotEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (kDefaultPadding * 2),
                          height: 220,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: ShaderMask(
                              shaderCallback: (Rect rect) {
                                return const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.transparent,
                                    kBackgroundColor,
                                  ],
                                  stops: [
                                    0.9,
                                    1.0
                                  ], // 10% purple, 80% transparent, 10% purple
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstOut,
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (int i = 0; i < modulsToQuery.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: kDefaultPadding / 4),
                                      child: GestureDetector(
                                        //Alert Dialog
                                        onLongPress: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    backgroundColor:
                                                        kBackgroundColor,
                                                    title: HeaderText(
                                                      content:
                                                          'Lösche "${moduls[i].name}"?',
                                                    ),
                                                    content: DefaultText(
                                                      content:
                                                          'Wiederherstellen ist nicht möglich!',
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: DefaultText(
                                                          content: 'Zurück',
                                                        ),
                                                      ),
                                                      //DELETE DISH
                                                      TextButton(
                                                        onPressed: () async {
                                                          //Delete Modul
                                                          await editData(
                                                              moduls[i], true);

                                                          // ignore: use_build_context_synchronously
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const HomeScreen(),
                                                            ),
                                                          );
                                                        },
                                                        child: DefaultText(
                                                          content: 'Löschen',
                                                        ),
                                                      ),
                                                    ],
                                                  ));
                                        },
                                        child: ModulCard(
                                          modulName: moduls[i].name,
                                          cardCount: moduls[i].content.length,
                                          phaseCount: moduls[i].phaseCnt,
                                          modulScreen: ModulScreen(
                                            currentModul: moduls[i],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  modulsToQuery.isNotEmpty
                      ? const SperationBar()
                      : const SizedBox(),
                  HeaderText(content: "Alle Fächer:"),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  //All
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        (kDefaultPadding * 2),
                    height: 220,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect rect) {
                          return const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.transparent,
                              kBackgroundColor,
                            ],
                            stops: [
                              0.9,
                              1.0
                            ], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < moduls.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: kDefaultPadding / 4),
                                child: GestureDetector(
                                  //Alert Dialog
                                  onLongPress: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              backgroundColor: kBackgroundColor,
                                              title: HeaderText(
                                                content:
                                                    'Lösche "${moduls[i].name}"?',
                                              ),
                                              content: DefaultText(
                                                content:
                                                    'Wiederherstellen ist nicht möglich!',
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: DefaultText(
                                                    content: 'Zurück',
                                                  ),
                                                ),
                                                //DELETE DISH
                                                TextButton(
                                                  onPressed: () async {
                                                    //Delete Modul
                                                    await editData(
                                                        moduls[i], true);

                                                    // ignore: use_build_context_synchronously
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: DefaultText(
                                                    content: 'Löschen',
                                                  ),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: ModulCard(
                                    modulName: moduls[i].name,
                                    cardCount: moduls[i].content.length,
                                    phaseCount: moduls[i].phaseCnt,
                                    modulScreen: ModulScreen(
                                      currentModul: moduls[i],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModulEditScreen(
                      modul: Modul(
                        id: 0,
                        content: List.empty(),
                        name: "null",
                        phaseCnt: 0,
                      ),
                      edit: false,
                    ),
                  ),
                );
              },
              backgroundColor: kBackgroundColor,
              foregroundColor: kFontColor,
              child: Stack(
                children: [
                  const Center(child: Icon(CupertinoIcons.add, size: 30.0)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kFontColor,
                        width: 1.1,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const LoadingPage();
        }
      },
    );
  }
}

void rebuildAllChildren(BuildContext context) {
  print("Updating...");
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
