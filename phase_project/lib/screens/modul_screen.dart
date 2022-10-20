// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/classes/question_podo.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/logic/query_handling.dart';
import 'package:phase_project/prefabs.dart';
import 'package:phase_project/screens/home_screen.dart';
import 'package:phase_project/screens/modul_edit_screen.dart';
import 'package:phase_project/screens/query_screen.dart';
import 'package:phase_project/screens/question_edit_screen.dart';

import '../classes/modul_podo.dart';
import '../logic/file_handling.dart';

class ModulScreen extends StatefulWidget {
  ModulScreen({required this.currentModul, super.key});

  Modul currentModul;

  @override
  State<ModulScreen> createState() => _ModulScreenState();
}

class _ModulScreenState extends State<ModulScreen> {
  @override
  Widget build(BuildContext context) {
    Modul cModul = widget.currentModul;
    List<Question> questionsToQuery = getQuestionsToQuery(cModul);
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
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  iconSize: kHeaderSize,
                  enableFeedback: false,
                  icon: const Icon(
                    CupertinoIcons.chevron_back,
                    color: kFontColor,
                  ),
                ),
                Flexible(
                  child: TitleText(
                    content: cModul.name,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            questionsToQuery.isNotEmpty
                ? HeaderText(content: "Heute fällig:")
                : const SizedBox(),
            SizedBox(
              height: questionsToQuery.isNotEmpty ? kDefaultPadding / 2 : 0,
            ),
            //Today & Start
            questionsToQuery.isNotEmpty
                ? Row(
                    children: [
                      StartButton(
                        text: "Start",
                        goToScreen: QueryScreen(
                          modul: widget.currentModul,
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            (kDefaultPadding * 2) -
                            (250 + kDefaultPadding),
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
                                for (int i = 0; i < cModul.content.length; i++)
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
                                                        'Lösche "${cModul.content[i].question}"?',
                                                  ),
                                                  content: DefaultText(
                                                    content:
                                                        'Wiederherstellen ist nicht möglich!',
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: DefaultText(
                                                        content: 'Zurück',
                                                      ),
                                                    ),
                                                    //DELETE DISH
                                                    TextButton(
                                                      onPressed: () async {
                                                        //Delete Modul
                                                        await editQuestion(
                                                            cModul,
                                                            cModul.content[i],
                                                            true);

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
                                      child: QuestionCard(
                                        question: cModul.content[i].question,
                                        cardScreen: QuestionEditScreen(
                                          modul: cModul,
                                          question: cModul.content[i],
                                          edit: true,
                                        ),
                                        currentPhase: cModul.content[i].phase,
                                        phaseCount: cModul.phaseCnt,
                                        nextQueryDate:
                                            cModul.content[i].nextQuery,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            questionsToQuery.isNotEmpty
                ? const SperationBar()
                : const SizedBox(),
            HeaderText(content: "Alle Fragen:"),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            //All
            SizedBox(
              width: MediaQuery.of(context).size.width - (kDefaultPadding * 2),
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
                      for (int i = 0; i < cModul.content.length; i++)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding / 4),
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
                                              'Lösche "${cModul.content[i].question}"?',
                                        ),
                                        content: DefaultText(
                                          content:
                                              'Wiederherstellen ist nicht möglich!',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: DefaultText(
                                              content: 'Zurück',
                                            ),
                                          ),
                                          //DELETE DISH
                                          TextButton(
                                            onPressed: () async {
                                              //Delete Modul
                                              await editQuestion(cModul,
                                                  cModul.content[i], true);

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
                            child: QuestionCard(
                              question: cModul.content[i].question,
                              cardScreen: QuestionEditScreen(
                                modul: cModul,
                                question: cModul.content[i],
                                edit: true,
                              ),
                              currentPhase: cModul.content[i].phase,
                              phaseCount: cModul.phaseCnt,
                              nextQueryDate: cModul.content[i].nextQuery,
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
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModulEditScreen(
                        modul: widget.currentModul,
                        edit: true,
                      ),
                    ),
                  );
                },
                backgroundColor: kBackgroundColor,
                foregroundColor: kFontColor,
                child: Stack(children: [
                  const Center(child: Icon(CupertinoIcons.pen, size: 30.0)),
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
                ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionEditScreen(
                      modul: cModul,
                      question: Question(
                        id: 0,
                        question: "null",
                        answer: "null",
                        phase: 0,
                        imgPath: "",
                        nextQuery: DateTime.now(),
                      ),
                      edit: false,
                    ),
                  ),
                );
              },
              backgroundColor: kBackgroundColor,
              foregroundColor: kFontColor,
              child: Stack(children: [
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
