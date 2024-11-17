import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:flutter/material.dart';

class DecoratedCell extends StatelessWidget {
  DecoratedCell(
      {required this.child, DecoratedCellThemeData? cellTheme, super.key})
      : cellTheme = cellTheme ?? DecoratedCellThemeData();

  final Widget child;
  final DecoratedCellThemeData cellTheme;

  @override
  Widget build(BuildContext context) {
    var borderConfiguration = cellTheme.boderDecoration;
    return Container(
        decoration: BoxDecoration(
          color: cellTheme.tableBackground.mainColor,
          border: Border(
            top: borderConfiguration.topBorder,
            right: borderConfiguration.rightBorder,
            left: borderConfiguration.leftBorder,
            bottom: borderConfiguration.bottomBorder,
          ),
        ),
        child: child);
  }
}
