import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/collapsible_data_grid_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeResolver {
  static CollapsibleDataGridThemeData resolve(
      CollapsibleDataGrid dataGrid, ThemeData theme) {
    var dataTableTheme = theme.dataTableTheme;
    var tableTheme = theme.extension<CollapsibleDataGridThemeData>();
    return tableTheme ?? CollapsibleDataGridThemeData();
  }
}
