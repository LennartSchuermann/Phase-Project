import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/prefabs.dart';
import 'package:phase_project/screens/modul_edit_screen.dart';
import 'package:phase_project/screens/modul_screen.dart';

import '../classes/modul_podo.dart';
import '../logic/file_handling.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: readSaveFile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Modul> moduls = getModuls(snapshot.data);
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
                            content: "Phase Project",
                          ),
                        ),
                        DescriptionText(
                            content: "Design Preview Build | Lennart S. ©")
                      ],
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    HeaderText(content: "Heute fällig:"),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    //Today
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
                                  child: ModulCard(
                                    modulName: moduls[i].name,
                                    cardCount: moduls[i].content.length,
                                    phaseCount: moduls[i].phaseCnt,
                                    modulScreen: ModulScreen(
                                      currentModul: moduls[i],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SperationBar(),
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
                                  child: ModulCard(
                                    modulName: moduls[i].name,
                                    cardCount: moduls[i].content.length,
                                    phaseCount: moduls[i].phaseCnt,
                                    modulScreen: ModulScreen(
                                      currentModul: moduls[i],
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
                            content: List.empty(),
                            name: "null",
                            phaseCnt: 0), //TODO CHANGE to new modul
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
        });
  }
}
