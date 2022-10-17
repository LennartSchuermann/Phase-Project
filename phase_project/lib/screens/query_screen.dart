import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/screens/question_edit_screen.dart';

import '../design.dart';
import '../prefabs.dart';

class QueryScreen extends StatefulWidget {
  const QueryScreen({super.key});

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
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
                  content: "Abfrage | Modul Name",
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
              child: Column(
                children: [
                  HeaderText(content: "FRAGE"),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Container(
                    height: 450,
                    width: 900,
                    color: kHighlightColor,
                    child: Center(child: DefaultText(content: "bild")),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QueryActionButton(
                        text: "Falsch",
                        color: kFalseColor,
                      ),
                      QueryActionButton(
                        text: "Richtig",
                        color: kRightColor,
                      ),
                    ],
                  ),
                ],
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
              builder: (context) => QuestionEditScreen(
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
    );
  }
}
