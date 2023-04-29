import 'package:bubble/config/themes/themes.dart';
import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient commonGradient = LinearGradient(
    colors: [
      Palette.white,
      Palette.lightBlue,
    ],
    stops: [0.1, 1.0],
    begin: Alignment(-1.0, -1.0),
    end: Alignment(1.0, 1.0),
  );
}
