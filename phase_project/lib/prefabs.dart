// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';

import 'classes/date_handling.dart';

//Text Prefabs
class TitleText extends StatelessWidget {
  TitleText({required this.content, super.key});

  String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kTitleSize,
          fontWeight: FontWeight.w300),
    );
  }
}

class HeaderText extends StatelessWidget {
  HeaderText({required this.content, super.key});

  String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kHeaderSize,
          fontWeight: FontWeight.w300),
    );
  }
}

class DefaultText extends StatelessWidget {
  DefaultText({required this.content, super.key});

  String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kTextSize,
          fontWeight: FontWeight.w300),
    );
  }
}

class DescriptionText extends StatelessWidget {
  DescriptionText({required this.content, super.key});

  String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kDescriptionSize,
          fontWeight: FontWeight.w200),
    );
  }
}

//Design Elements
class SperationBar extends StatelessWidget {
  const SperationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: kDefaultPadding, bottom: kDefaultPadding),
      child: Container(
        width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
        height: 1,
        color: kFontColor,
      ),
    );
  }
}

//Buttons
class StartButton extends StatelessWidget {
  StartButton({required this.text, required this.goToScreen, super.key});

  String text;
  Widget goToScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: HeaderText(content: text),
      ),
    );
  }
}

//Card Prefabs
class ModulCard extends StatelessWidget {
  ModulCard({
    required this.modulName,
    required this.cardCount,
    required this.phaseCount,
    required this.modulScreen,
    super.key,
  });

  Widget modulScreen;
  String modulName;
  int cardCount, phaseCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => modulScreen),
        );
      }),
      child: Container(
        height: 190,
        width: 310,
        decoration: BoxDecoration(
            border: Border.all(
              color: kFontColor,
            ),
            borderRadius:
                const BorderRadius.all(Radius.circular(kDefaultPadding / 2))),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(
                content: modulName,
              ),
              DefaultText(
                content: "Karten: $cardCount",
              ),
              DefaultText(
                content: "Phasen: $phaseCount",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  QuestionCard({
    required this.question,
    required this.cardScreen,
    required this.phaseCount,
    required this.currentPhase,
    required this.nextQueryDate,
    super.key,
  });

  Widget cardScreen;
  String question;
  int currentPhase, phaseCount;
  DateTime nextQueryDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => cardScreen),
        );
      }),
      child: Container(
        height: 190,
        width: 310,
        decoration: BoxDecoration(
            border: Border.all(
              color: kFontColor,
            ),
            borderRadius:
                const BorderRadius.all(Radius.circular(kDefaultPadding / 2))),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(
                content: question,
              ),
              DefaultText(
                content: "Phase: $currentPhase/$phaseCount",
              ),
              DefaultText(
                content: "Nächste Abfrage: ${formatedDateTime(nextQueryDate)}",
              )
            ],
          ),
        ),
      ),
    );
  }
}
