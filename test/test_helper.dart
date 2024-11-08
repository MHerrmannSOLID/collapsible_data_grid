import 'package:collapsible_data_grid/src/types/collapsible_data_grid_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ColumnTestHelper on Widget {
  Widget wrapDirectional(
          {CollapsibleDataGridThemeData? collapsibleDataGridThemeData}) =>
      MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            extensions: collapsibleDataGridThemeData == null
                ? []
                : [collapsibleDataGridThemeData]),
        home: this,
      );
}
