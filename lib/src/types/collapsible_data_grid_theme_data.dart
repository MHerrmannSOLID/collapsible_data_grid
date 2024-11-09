import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

class CollapsibleDataGridThemeData
    extends ThemeExtension<CollapsibleDataGridThemeData> {
  static CollapsibleDataGridThemeData? of(BuildContext ctx) =>
      Theme.of(ctx).extension<CollapsibleDataGridThemeData>();

  final CellBorderConfiguration dataCellDecoration;
  //final double? dataRowMinHeight;
  //final double? dataRowMaxHeight;
  // final TextStyle? dataTextStyle;
  // final WidgetStateProperty<Color?>? headingRowColor;
  // final double? headingRowHeight;
  // final TextStyle? headingTextStyle;
  // final double? horizontalMargin;
  // final double? columnSpacing;
  // final double? checkboxHorizontalMargin;
  // final WidgetStateProperty<MouseCursor?>? headingCellCursor;
  // final WidgetStateProperty<MouseCursor?>? dataRowCursor;
  // final MainAxisAlignment? headingRowAlignment;

  CollapsibleDataGridThemeData({CellBorderConfiguration? dataCellDecoration}
      // this.dataRowMinHeight,
      // this.dataRowMaxHeight,
      // this.dataTextStyle,
      // this.headingRowColor,
      // this.headingRowHeight,
      // this.headingTextStyle,
      // this.horizontalMargin,
      // this.columnSpacing,
      // this.checkboxHorizontalMargin,
      // this.headingCellCursor,
      // this.dataRowCursor,
      // this.headingRowAlignment,
      )
      : this.dataCellDecoration =
            dataCellDecoration ?? const CellBorderConfiguration();

  @override
  ThemeExtension<CollapsibleDataGridThemeData> copyWith() {
    return CollapsibleDataGridThemeData();
  }

  @override
  ThemeExtension<CollapsibleDataGridThemeData> lerp(
      covariant ThemeExtension<CollapsibleDataGridThemeData>? other, double t) {
    return CollapsibleDataGridThemeData();
  }
}