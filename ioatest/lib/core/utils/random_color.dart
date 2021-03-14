import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor {
  static Color random() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(140);
}
