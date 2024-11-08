import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CellBorderConfiguration extends Equatable {
  final BorderSide bottomBorder;
  final BorderSide topBorder;
  final BorderSide leftBorder;
  final BorderSide rightBorder;

  const CellBorderConfiguration(
      {this.bottomBorder = const BorderSide(color: Colors.grey, width: 1),
      this.topBorder = BorderSide.none,
      this.leftBorder = BorderSide.none,
      this.rightBorder = BorderSide.none});

  @override
  List<Object?> get props => [bottomBorder, leftBorder, rightBorder, topBorder];
}
