import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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

  Widget addThemeProvider(
          {CollapsibleDataGridThemeData? collapsibleDataGridThemeData}) =>
      Provider(
        create: (_) =>
            collapsibleDataGridThemeData ?? CollapsibleDataGridThemeData(),
        builder: (context, child) => this,
      );
}
