import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColumnConfiguration {
  factory ColumnConfiguration.textColumn(
          {required String headerText,
          TextStyle? headerStyle,
          double weight = 1.0,
          CellBorderConfiguration? borderConfiguration}) =>
      ColumnConfiguration(
          header: Text(
            headerText,
            style: headerStyle,
          ),
          weight: weight,
          borderConfiguration: borderConfiguration);

  ColumnConfiguration(
      {required this.header,
      this.weight = 1.0,
      CellBorderConfiguration? borderConfiguration})
      : _borderConfiguration = borderConfiguration ?? CellBorderConfiguration();

  final CellBorderConfiguration _borderConfiguration;
  final Widget header;
  final double weight;

  CellBorderConfiguration get borderConfiguration => _borderConfiguration;
}
