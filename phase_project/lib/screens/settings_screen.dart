import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase_project/main.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../design.dart';
import '../prefabs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
            //Title Row
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
                  child: TitleText(content: "Einstellungen"),
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Center(
              child: CupertinoSwitch(
                // overrides the default green color of the track
                activeColor: kFontColor,
                // color of the round icon, which moves from right to left
                thumbColor: kHighlightColor,
                // when the switch is off
                trackColor: Colors.black12,
                // boolean variable value
                value: usingDarkMode,
                // changes the state of the switch
                onChanged: (value) => setState(
                  () {
                    usingDarkMode = value;
                    print(usingDarkMode);
                    Phoenix.rebirth(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
