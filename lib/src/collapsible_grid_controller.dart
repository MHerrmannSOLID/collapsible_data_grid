import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

typedef CollapseHeaderBuilder = Widget Function(
    BuildContext context, List<RowConfiguration> rows);

class CollapsibleGridController<TGroupKey extends Comparable<TGroupKey>> {
  late final List<ColumnConfiguration> columnConfigurations;
  final List<RowConfiguration> rowConfigurations;
  final CollapseHeaderBuilder collapseHeaderBuilder;
  final int groupingColumnIndex;

  static Widget _defaultCollapseHeaderBuilder(
      BuildContext context, List<RowConfiguration> rows) {
    return Container();
  }

  CollapsibleGridController(
      {required List columnConfigurations,
      required this.rowConfigurations,
      this.collapseHeaderBuilder = _defaultCollapseHeaderBuilder,
      this.groupingColumnIndex = -1}) {
    this.columnConfigurations = _createColumnsFrom(columnConfigurations);
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
