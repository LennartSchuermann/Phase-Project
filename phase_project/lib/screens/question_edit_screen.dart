// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/classes/question_podo.dart';
import 'package:phase_project/screens/home_screen.dart';

import '../classes/modul_podo.dart';
import '../design.dart';
import '../logic/file_handling.dart';
import '../prefabs.dart';

class QuestionEditScreen extends StatefulWidget {
  QuestionEditScreen(
      {required this.edit,
      required this.modul,
      required this.question,
      super.key});

  Modul modul;
  Question question;
  bool edit;

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
            //Title
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
                    content: widget.edit
                        ? "Bearbeiten | ${widget.question.question}"
                        : "Erstellen | Neue Frage",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: questionTextController,
              textInputType: TextInputType.text,
              hintTxt: "Frage (${widget.question.question})",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: answerTextController,
              textInputType: TextInputType.text,
              hintTxt: "Antwort (${widget.question.answer})",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            widget.question.imgPath != ""
                ? Container(
                    color: kHighlightColor,
                    width: 500,
                    height: 320,
                    child: Image.file(
                        fit: BoxFit.fill, File(widget.question.imgPath)))
                : const SizedBox(),
            const SizedBox(
              height: kDefaultPadding,
            ),
            GestureDetector(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null) return;

                //Open single file:
                final file = result.files.first;
                await saveFile(file);
              },
              child: Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: kHighlightColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(kDefaultPadding / 2),
                  ),
                ),
                child: Center(
                  child: HeaderText(content: "Bild hinzufügen..."),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //TODO Save data
          bool finished = false;

          if (widget.edit) {
            //edit modul;
            print("Editing:");
          } else {
            //add modul
            Modul modulToAddQuestion;

            if (questionTextController.text != "" &&
                phaseTextController.text != "") {
              //modulToAddQuestion.content.add(Question(question: question, answer: answer, imgPath: imgPath, phase: phase, nextQuery: nextQuery))

              print("Adding Question:");
              //addData(modulToAdd);

              finished = true;
            }
          }

          if (finished) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
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
