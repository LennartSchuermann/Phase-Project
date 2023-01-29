import 'package:flutter/cupertino.dart';

const String kAppName = "Phase Project";
const String kAppCaption = "Working Build | Lennart S. ©";
const String kAppVersion = "v0.5";

bool usingDarkMode = false;

const kFalseColor = Color(0xffE74C3C);
const kRightColor = Color(0xff0be881);
Color kHighlightColor =
    usingDarkMode ? const Color(0xff006EE6) : const Color(0xff309C85);

Color kBackgroundColor =
    usingDarkMode ? const Color(0xff101010) : const Color(0xffFFFFFF);
Color kFontColor = usingDarkMode
    ? const Color(0xffFFFFFF)
    : const Color.fromARGB(255, 0, 0, 0);

const kTitleSize = 32.0;
const kHeaderSize = 24.0;
const kTextSize = 18.0;
const kDescriptionSize = 10.0;

const kDefaultPadding = 40.0;
