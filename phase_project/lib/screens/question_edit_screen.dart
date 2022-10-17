import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design.dart';
import '../prefabs.dart';

class QuestionEditScreen extends StatefulWidget {
  const QuestionEditScreen({super.key});

  @override
  State<QuestionEditScreen> createState() => _QuestionEditScreenState();
}

class _QuestionEditScreenState extends State<QuestionEditScreen> {
  TextEditingController questionTextController = TextEditingController();
  TextEditingController answerTextController = TextEditingController();
  TextEditingController phaseTextController = TextEditingController();

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
                  content: "Bearbeiten | Frage",
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: questionTextController,
              textInputType: TextInputType.text,
              hintTxt: "Frage",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: answerTextController,
              textInputType: TextInputType.text,
              hintTxt: "Antwort",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: phaseTextController,
              textInputType: TextInputType.number,
              hintTxt: "Anzahl Phasen",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO Save data
          /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WIDGET),
          ); */
        },
        backgroundColor: kBackgroundColor,
        foregroundColor: kFontColor,
        child: Stack(children: [
          const Center(child: Icon(CupertinoIcons.check_mark, size: 30.0)),
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
