import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';

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
