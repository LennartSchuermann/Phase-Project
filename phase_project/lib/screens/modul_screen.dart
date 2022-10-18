// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/classes/question_podo.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/prefabs.dart';
import 'package:phase_project/screens/modul_edit_screen.dart';
import 'package:phase_project/screens/query_screen.dart';
import 'package:phase_project/screens/question_edit_screen.dart';

import '../classes/modul_podo.dart';

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
            HeaderText(content: "Heute fällig:"),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            //Today & Start
            Row(
              children: [
                StartButton(
                  text: "Start",
                  goToScreen: const QueryScreen(),
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
                              child: QuestionCard(
                                question: cModul.content[i].question,
                                cardScreen: QuestionEditScreen(
                                  question: cModul.content[i],
                                  edit: true,
                                ),
                                currentPhase: cModul.content[i].phase,
                                phaseCount: cModul.phaseCnt,
                                nextQueryDate: cModul.content[i].nextQuery,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SperationBar(),
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
                          child: QuestionCard(
                            question: cModul.content[i].question,
                            cardScreen: QuestionEditScreen(
                              question: cModul.content[i],
                              edit: true,
                            ),
                            currentPhase: cModul.content[i].phase,
                            phaseCount: cModul.phaseCnt,
                            nextQueryDate: cModul.content[i].nextQuery,
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
                            question: Question(
                                question: "null",
                                answer: "null",
                                phase: 0,
                                imgPath: "",
                                nextQuery:
                                    DateTime.now()), //TODO Change new question
                            edit: false,
                          )),
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
