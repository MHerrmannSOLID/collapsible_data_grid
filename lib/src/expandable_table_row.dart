import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/static_table_row.dart';
import 'package:flutter/material.dart';

class ExpandableTableRow extends StatelessWidget {
  const ExpandableTableRow(
      {required this.columnConfigurations, required this.data, super.key});

  final ExpandableRow data;
  final Iterable<ColumnConfiguration> columnConfigurations;

  @override
  Widget build(BuildContext context) {
    var rows = data.children
        .map((cell) => StaticTableRow(
            columnConfigurations: columnConfigurations, rowData: cell))
        .toList();

    return ExpandablePanel(
      controller: data.controller,
      header: StaticTableRow(
          columnConfigurations: columnConfigurations, rowData: data),
      theme: const ExpandableThemeData(
          iconPadding: EdgeInsets.all(0), iconSize: 1, hasIcon: false),
      collapsed: const SizedBox(
        height: 0,
        width: 0,
      ),
      expanded: Column(
        children: rows,
      ),
    );
  }
}
