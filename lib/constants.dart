import 'package:flutter/material.dart';

class Constants {
  final primaryColor = const Color(0xff6b9dfc);
  final primaryColorDarkMode = const Color(0xff205cf1);
  final secondaryColor = const Color(0xffa1c6fd);
  final tertiaryColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff1a1d26);
  final apiKey = "71710e32a98c46b8bef141649241610" ;

  final greyColor = const Color(0xffd9dadb);

  final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(
    const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
  );

  final linearGradientBlue = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xff6b9dfc), Color(0xff205cf1)],
    stops: [0.0, 1.0],
  );

  final linearGradientBlueDarkMode = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xff205cf1), Color(0xff0a1d5b)], // Darker blues
    stops: [0.0, 1.0],
  );


}
