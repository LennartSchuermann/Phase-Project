// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/classes/modul_podo.dart';
import 'package:phase_project/screens/home_screen.dart';
import 'package:phase_project/screens/question_edit_screen.dart';

import '../classes/question_podo.dart';
import '../design.dart';
import '../prefabs.dart';

class QueryScreen extends StatefulWidget {
  QueryScreen({required this.modul, super.key});

  Modul modul;

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  bool showAnswer = false;
  int currentQuestionIndex = 0;

  void nextQuestion(int questionAmount) {
    if (currentQuestionIndex + 1 >= questionAmount) {
      currentQuestionIndex = 0;
    } else {
      currentQuestionIndex++;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questions = widget.modul.content;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
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
                          content: "Abfrage | ${widget.modul.name}",
                        ),
                      ),
                    ],
                  ),
                ),
                TitleText(
                  content: "${currentQuestionIndex + 1} / ${questions.length}",
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            //Body
            SizedBox(
              width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
              child: Column(
                children: [
                  HeaderText(content: questions[currentQuestionIndex].question),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  questions[currentQuestionIndex].imgPath != ""
                      ? Container(
                          height: 350,
                          width: 900,
                          color: kHighlightColor,
                          child: Image.file(
                              fit: BoxFit.cover,
                              File(questions[currentQuestionIndex].imgPath)),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  showAnswer
                      ? DefaultText(
                          content: questions[currentQuestionIndex].answer)
                      : DefaultText(content: ""),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  DefaultText(
                      content:
                          "Phase: ${questions[currentQuestionIndex].phase}/${widget.modul.phaseCnt}"),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            nextQuestion(questions.length);
                          });
                        },
                        child: QueryActionButton(
                          text: "Falsch",
                          color: kFalseColor,
                        ),
                      ),
                      //Answer Btn
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showAnswer ? showAnswer = false : showAnswer = true;
                          });
                        },
                        child: QueryActionButton(
                          text: "Lösung",
                          color: questions[currentQuestionIndex].answer == ""
                              ? kBackgroundColor
                              : kHighlightColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          questions.remove(questions[currentQuestionIndex]);
                          //TODO increase phase & set date

                          if (questions.isEmpty) {
                            //query is done
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } else {
                            nextQuestion(questions.length);
                            setState(() {});
                          }
                        },
                        child: QueryActionButton(
                          text: "Richtig",
                          color: kRightColor,
                        ),
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
                question: questions[0],
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
