// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/screens/home_screen.dart';
import 'package:phase_project/screens/modul_screen.dart';

import '../classes/modul_podo.dart';
import '../logic/file_handling.dart';
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
            //Titel Row
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
                        : "Erstellen | Neues Fach",
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
              hintTxt: widget.edit ? "Titel (${widget.modul.name})" : "Titel",
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            TextInputField(
              controller: phaseTextController,
              textInputType: TextInputType.number,
              hintTxt: widget.edit
                  ? "Anzahl Phasen (${widget.modul.phaseCnt})"
                  : "Anzahl Phasen (min. 1; max. 9)",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool finished = false;

          if (widget.edit) {
            //edit modul;
            Modul editedModul = widget.modul;

            if (titleTextController.text != "") {
              editedModul.name = titleTextController.text;
            }

            if (phaseTextController.text != "") {
              editedModul.phaseCnt = int.parse(phaseTextController.text);
            }

            print("Editing:");
            await editData(editedModul, false);
            finished = true;
          } else {
            //add modul
            Modul modulToAdd;

            if (titleTextController.text != "" &&
                phaseTextController.text != "" &&
                int.parse(phaseTextController.text) > 0 &&
                int.parse(phaseTextController.text) < 10) {
              modulToAdd = Modul(
                id: DateTime.now().millisecondsSinceEpoch,
                name: titleTextController.text,
                phaseCnt: int.parse(phaseTextController.text),
                content: [],
              );

              print("Adding:");
              await addData(modulToAdd);
              finished = true;
            }
          }

          if (finished) {
            if (!widget.edit) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModulScreen(
                    currentModul: widget.modul,
                  ),
                ),
              );
            }
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
