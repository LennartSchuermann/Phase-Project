import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/prefabs.dart';
import 'package:phase_project/screens/modul_edit_screen.dart';
import 'package:phase_project/screens/modul_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TitleText(
                    content: "Phase Project",
                  ),
                ),
                DescriptionText(content: "Design Preview Build | Lennart S. ©")
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            HeaderText(content: "Heute fällig:"),
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
                          child: ModulCard(
                            modulName: "Test Fach",
                            cardCount: 5,
                            phaseCount: 2,
                            modulScreen: const ModulScreen(),
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
                      for (int i = 0; i < 2; i++)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding / 4),
                          child: ModulCard(
                            modulName: "Test Fach",
                            cardCount: 5,
                            phaseCount: 2,
                            modulScreen: const ModulScreen(),
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
  }
}
