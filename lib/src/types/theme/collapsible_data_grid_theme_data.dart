export 'package:collapsible_data_grid/src/types/theme/decorated_cell_theme_data.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:flutter/material.dart';

class CollapsibleDataGridThemeData
    extends ThemeExtension<CollapsibleDataGridThemeData> {
  static CollapsibleDataGridThemeData? of(BuildContext ctx) =>
      Theme.of(ctx).extension<CollapsibleDataGridThemeData>();

  final DecoratedCellThemeData headerTheme;
  final DecoratedCellThemeData cellTheme;
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
    DecoratedCellThemeData? headerTheme,
    DecoratedCellThemeData? cellTheme,
  })  : headerTheme = headerTheme ?? DecoratedCellThemeData(),
        cellTheme = cellTheme ?? DecoratedCellThemeData();
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

  @override
  ThemeExtension<CollapsibleDataGridThemeData> copyWith({
    DecoratedCellThemeData? headerTheme,
    DecoratedCellThemeData? cellTheme,
  }) {
    return CollapsibleDataGridThemeData(
      headerTheme: headerTheme ?? this.headerTheme,
      cellTheme: cellTheme ?? this.cellTheme,
    );
  }

  @override
  ThemeExtension<CollapsibleDataGridThemeData> lerp(
      covariant ThemeExtension<CollapsibleDataGridThemeData>? other, double t) {
    if (identical(this, other) || other == null) return this;
    var target = other as CollapsibleDataGridThemeData;
    return CollapsibleDataGridThemeData();
  }
}
