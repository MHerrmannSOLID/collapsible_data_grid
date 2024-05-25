import 'package:flutter/material.dart';

class CellBorderConfiguration {
  final BorderSide bottomBorder;
  final BorderSide topBorder;
  final BorderSide leftBorder;
  final BorderSide rightBorder;

  const CellBorderConfiguration(
      {this.bottomBorder = BorderSide.none,
      this.topBorder = BorderSide.none,
      this.leftBorder = BorderSide.none,
      this.rightBorder = BorderSide.none});
}
