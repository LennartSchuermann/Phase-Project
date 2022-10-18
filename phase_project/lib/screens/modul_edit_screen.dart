// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';

import '../classes/modul_podo.dart';
import '../prefabs.dart';

class ModulEditScreen extends StatefulWidget {
  ModulEditScreen({required this.edit, required this.modul, super.key});

  Modul modul;
  bool edit;

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
                Flexible(
                  child: TitleText(
                    content: widget.edit
                        ? "Bearbeiten | ${widget.modul.name}"
                        : "Erstellen | ${widget.modul.name}",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: titleTextController,
              textInputType: TextInputType.text,
              hintTxt: "Titel (${widget.modul.name})",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: phaseTextController,
              textInputType: TextInputType.number,
              hintTxt: "Anzahl Phasen (${widget.modul.phaseCnt})",
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
