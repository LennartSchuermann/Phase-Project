import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/prefabs.dart';
import 'package:phase_project/screens/modul_edit_screen.dart';
import 'package:phase_project/screens/question_edit_screen.dart';

class ModulScreen extends StatefulWidget {
  const ModulScreen({super.key});

  @override
  State<ModulScreen> createState() => _ModulScreenState();
}

class _ModulScreenState extends State<ModulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                TitleText(
                  content: "Modul Name",
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            HeaderText(content: "Heute fällig:"),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            Row(
              children: [
                StartButton(
                  text: "Start",
                  goToScreen: const ModulScreen(),
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
                          for (int i = 0; i < 5; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: kDefaultPadding / 4),
                              child: QuestionCard(
                                question: "Frage",
                                cardScreen: QuestionEditScreen(
                                  edit: true,
                                ),
                                currentPhase: 2,
                                phaseCount: 5,
                                nextQueryDate: DateTime.now(),
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
                      for (int i = 0; i < 5; i++)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding / 4),
                          child: QuestionCard(
                            question: "Frage",
                            cardScreen: QuestionEditScreen(
                              edit: true,
                            ),
                            currentPhase: 2,
                            phaseCount: 5,
                            nextQueryDate: DateTime.now(),
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
