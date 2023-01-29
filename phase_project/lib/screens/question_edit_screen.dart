// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/classes/question_podo.dart';
import 'package:phase_project/screens/home_screen.dart';
import 'package:phase_project/screens/modul_screen.dart';

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

  String imgPath = "";

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
                  icon: Icon(
                    CupertinoIcons.chevron_back,
                    color: kFontColor,
                  ),
                ),
                Flexible(
                  child: TitleText(
                    content: widget.edit
                        ? "Bearbeiten | ${widget.modul.name} > ${widget.question.question}"
                        : "Erstellen | ${widget.modul.name} > Neue Frage",
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
              hintTxt:
                  widget.edit ? "Frage (${widget.question.question})" : "Frage",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: answerTextController,
              textInputType: TextInputType.text,
              hintTxt: widget.edit
                  ? "Antwort (${widget.question.answer})"
                  : "Antwort",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            FutureBuilder<dynamic>(
              future: File(widget.question.imgPath).exists(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData && snapshot.data) {
                  return (widget.question.imgPath != "")
                      ? Container(
                          color: kHighlightColor,
                          width: 500,
                          height: 320,
                          child: Image.file(
                            fit: BoxFit.fill,
                            File(widget.question.imgPath),
                          ),
                        )
                      : const SizedBox();
                } else {
                  return widget.question.imgPath != ""
                      ? Row(
                          children: [
                            CircularProgressIndicator(
                              color: kFontColor,
                            ),
                            const SizedBox(
                              width: kDefaultPadding,
                            ),
                            DescriptionText(
                                content:
                                    "Bild existiert möglicherweise nicht unter: ${widget.question.imgPath}")
                          ],
                        )
                      : const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            GestureDetector(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null) return;

                //Open single file:
                final file = result.files.first;

                File img = await saveFile(file);
                imgPath = img.path.toString();

                widget.question.imgPath = imgPath;
                await editQuestion(widget.modul, widget.question, false);
                setState(() {});
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
          bool finished = false;

          if (widget.edit) {
            //edit question;
            Modul editedModul = widget.modul;
            Question editedQuestion = widget.question;

            if (questionTextController.text != "") {
              editedQuestion.question = questionTextController.text;
            }

            if (answerTextController.text != "") {
              editedQuestion.answer = answerTextController.text;
            }

            if (imgPath != "") {
              editedQuestion.imgPath = imgPath;
            }

            print("Editing:");
            await editData(editedModul, false);
            finished = true;
          } else {
            //add question to modul
            if (questionTextController.text != "") {
              Question newQuestion = Question(
                id: DateTime.now().millisecondsSinceEpoch,
                question: questionTextController.text,
                answer: answerTextController.text,
                imgPath: imgPath,
                phase: 1,
                nextQuery: DateTime.now(),
              );

              widget.modul.content.add(newQuestion);

              print("Adding Question:");
              await editData(widget.modul, false);

              finished = true;
            }
          }

          if (finished) {
            //got to Modul Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        goToAfterLoading: ModulScreen(
                          currentModul: widget.modul,
                        ),
                      )),
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
