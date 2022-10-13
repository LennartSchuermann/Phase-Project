import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/design.dart';
import 'package:phase_project/prefabs.dart';

class ModulScreen extends StatefulWidget {
  const ModulScreen({super.key});

  @override
  State<ModulScreen> createState() => _ModulScreenState();
}

class _ModulScreenState extends State<ModulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(children: [
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
            content: "Modul Name",
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddDish(
                      meal: widget.currentMeal,
                    )),
          ); */
        },
        backgroundColor: kBackgroundColor,
        foregroundColor: kFontColor,
        child: Stack(children: [
          const Center(child: Icon(CupertinoIcons.add, size: 30.0)),
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
