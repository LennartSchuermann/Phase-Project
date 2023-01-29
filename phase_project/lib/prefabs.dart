// ignore_for_file: must_be_immutable

import 'logic/date_handling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phase_project/design.dart';

//Text Prefabs
class TitleText extends StatelessWidget {
  TitleText({required this.content, super.key});

  String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kTitleSize,
          fontWeight: FontWeight.w400),
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kHeaderSize,
          fontWeight: FontWeight.w400),
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kTextSize,
          fontWeight: FontWeight.w400),
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: kFontColor,
          fontFamily: "Inter",
          fontSize: kDescriptionSize,
          fontWeight: FontWeight.w400),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goToScreen),
        );
      },
      child: Container(
        height: 60,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(color: kHighlightColor),
          color: kHighlightColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(kDefaultPadding / 2),
          ),
        ),
        child: Center(
          child: HeaderText(
            content: text,
          ),
        ),
      ),
    );
  }
}

class QueryActionButton extends StatelessWidget {
  QueryActionButton({required this.text, required this.color, super.key});

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
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
              color: currentPhase < phaseCount ? kFontColor : kRightColor,
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
                content: currentPhase < phaseCount
                    ? "Nächste Abfrage: ${formatedDateTime(nextQueryDate)}"
                    : "Fertig!",
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Text Input
class TextInputField extends StatelessWidget {
  TextInputField({
    required this.controller,
    required this.textInputType,
    required this.hintTxt,
    Key? key,
  }) : super(key: key);

  TextEditingController controller;
  TextInputType textInputType;
  String hintTxt;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: textInputType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      controller: controller,
      keyboardType: textInputType,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hoverColor: kFontColor,
        fillColor: kBackgroundColor,
        focusColor: kHighlightColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kFontColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintTxt,
        hintStyle: TextStyle(
          color: kFontColor.withOpacity(0.75),
          fontFamily: 'Inter',
          fontSize: kTextSize,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: TextStyle(
        color: kFontColor,
        fontFamily: 'Inter',
        fontSize: kTextSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

//Loading Page
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText(content: kAppName),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            CircularProgressIndicator(
              color: kFontColor,
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            DescriptionText(content: "$kAppVersion | $kAppCaption")
          ],
        ),
      ),
    );
  }
}
