import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

class DecoratedCell extends StatelessWidget {
  DecoratedCell(
      {required this.child,
      CellBorderConfiguration? borderConfiguration,
      Color? background,
      super.key})
      : _background = background ?? Colors.white,
        _borderConfiguration =
            borderConfiguration ?? const CellBorderConfiguration();

  final Widget child;
  final CellBorderConfiguration _borderConfiguration;
  final Color _background;

  Color get background => _background;
  CellBorderConfiguration get borderConfiguration => _borderConfiguration;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: background,
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
