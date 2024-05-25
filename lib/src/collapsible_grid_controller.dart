import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

typedef CollapseHeaderBuilder = Widget Function(
    BuildContext context, List<RowConfiguration> rows);

typedef CellStyleBuilder = void Function(
    int colIdx, int rowIdx, GridCellData toStyle);

class CollapsibleGridController {
  final List<ColumnConfiguration> columnConfigurations = [];
  final List<RowConfiguration> rowConfigurations = [];
  final CollapseHeaderBuilder collapseHeaderBuilder;
  final CellStyleBuilder? cellStyleBuilder;
  final int groupingColumnIndex;

  static Widget _defaultCollapseHeaderBuilder(
      BuildContext context, List<RowConfiguration> rows) {
    return Container();
  }

  CollapsibleGridController(
      {this.collapseHeaderBuilder = _defaultCollapseHeaderBuilder,
      this.cellStyleBuilder,
      this.groupingColumnIndex = -1});

  void initialize(
      List columnConfigurations, List<RowConfiguration> rowConfigurations) {
    this.columnConfigurations.addAll(_createColumnsFrom(columnConfigurations));
    this.rowConfigurations.addAll(rowConfigurations);
    _applyCellStyles();
  }

  void _applyCellStyles() {
    if (cellStyleBuilder == null) return;
    int rowIdx = 0;
    for (var row in rowConfigurations) {
      int colIdx = 0;
      for (var cell in row.cells) {
        cellStyleBuilder!(rowIdx, colIdx, cell);
        colIdx++;
      }
      rowIdx++;
    }
  }

  List<ColumnConfiguration> _createColumnsFrom(List columnConfigurations) =>
      columnConfigurations
          .map((column) => (column is ColumnConfiguration)
              ? column
              : _getNonPreconfiguredColumn(column))
          .toList();

  ColumnConfiguration _getNonPreconfiguredColumn(column) => (column is Widget)
      ? ColumnConfiguration(header: column)
      : ColumnConfiguration.textColumn(headerText: column.toString());
}
