import 'dart:ffi';

import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:flutter/material.dart';

class CollapsibleDataGridThemeData
    extends ThemeExtension<CollapsibleDataGridThemeData> {
  static CollapsibleDataGridThemeData? of(BuildContext ctx) =>
      Theme.of(ctx).extension<CollapsibleDataGridThemeData>();

  final CellBorderConfiguration dataCellDecoration;
  final TableColorProperty tableBackground;

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

  CollapsibleDataGridThemeData({
    CellBorderConfiguration? dataCellDecoration,
    TableColorProperty? tableBackground,
  }
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
      )  : dataCellDecoration = dataCellDecoration ?? const CellBorderConfiguration(),
        tableBackground = tableBackground ??
            TableColorProperty(mainColor: Colors.transparent);

  @override
  ThemeExtension<CollapsibleDataGridThemeData> copyWith({
    CellBorderConfiguration? dataCellDecoration,
    TableColorProperty? tableBackground,
  }) {
    return CollapsibleDataGridThemeData(
      dataCellDecoration: dataCellDecoration ?? this.dataCellDecoration,
      tableBackground: tableBackground ?? this.tableBackground,
    );
  }

  @override
  ThemeExtension<CollapsibleDataGridThemeData> lerp(
      covariant ThemeExtension<CollapsibleDataGridThemeData>? other, double t) {
    if (identical(this, other) || other == null) return this;
    var target = other as CollapsibleDataGridThemeData;
    return CollapsibleDataGridThemeData(
      tableBackground: tableBackground.lerp(target.tableBackground, t),
    );
  }
}
