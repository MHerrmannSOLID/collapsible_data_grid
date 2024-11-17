import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecoratedCell extends StatelessWidget {
  DecoratedCell({required this.child, Color? background, super.key})
      : _background = background ?? Colors.transparent;

  final Widget child;
  final Color _background;

  Color get background => _background;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CollapsibleDataGridThemeData>(context);
    var borderConfiguration = theme.cellTheme.boderDecoration;
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
