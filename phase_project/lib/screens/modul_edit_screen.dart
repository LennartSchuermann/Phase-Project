import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';

import '../prefabs.dart';

class ModulEditScreen extends StatefulWidget {
  const ModulEditScreen({super.key});

  @override
  State<ModulEditScreen> createState() => _ModulEditScreenState();
}

class _ModulEditScreenState extends State<ModulEditScreen> {
  TextEditingController titleTextController = TextEditingController();
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
                  content: "Bearbeiten | Modul Name",
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: titleTextController,
              textInputType: TextInputType.text,
              hintTxt: "Titel",
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
