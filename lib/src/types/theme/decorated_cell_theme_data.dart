import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:flutter/material.dart';

class DecoratedCellThemeData extends ThemeExtension<DecoratedCellThemeData> {
  final CellBorderConfiguration boderDecoration;
  final TableColorProperty tableBackground;

  DecoratedCellThemeData({
    CellBorderConfiguration? dataCellDecoration,
    TableColorProperty? tableBackground,
  })  : boderDecoration = dataCellDecoration ?? const CellBorderConfiguration(),
        tableBackground = tableBackground ??
            TableColorProperty(mainColor: Colors.transparent);

  @override
  ThemeExtension<DecoratedCellThemeData> copyWith({
    CellBorderConfiguration? dataCellDecoration,
    TableColorProperty? tableBackground,
  }) {
    return DecoratedCellThemeData(
      dataCellDecoration: dataCellDecoration ?? this.boderDecoration,
      tableBackground: tableBackground ?? this.tableBackground,
    );
  }

  @override
  ThemeExtension<DecoratedCellThemeData> lerp(
      covariant ThemeExtension<DecoratedCellThemeData>? other, double t) {
    if (identical(this, other) || other == null) return this;
    var target = other as DecoratedCellThemeData;
    return DecoratedCellThemeData(
      tableBackground: tableBackground.lerp(target.tableBackground, t),
    );
  }
}
