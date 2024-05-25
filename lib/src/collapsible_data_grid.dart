import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/expandable_table_row.dart';
import 'package:collapsible_data_grid/src/static_table_row.dart';
import 'package:collapsible_data_grid/src/table_header.dart';
import 'package:flutter/material.dart';
import 'types/expandable_row.dart';
import 'types/row_configuration.dart';

class CollapsibleDataGrid extends StatelessWidget {
  final CollapsibleGridController controller;
  final headerHeight = 50.0;
  final Color _bodyBackground;
  final Color _headerBackground;

  const CollapsibleDataGrid({
    super.key,
    required this.controller,
    Color? bodyBackground,
    Color? headerBackground,
  })  : _bodyBackground = bodyBackground ?? Colors.white,
        _headerBackground = headerBackground ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableHeader(
                columns: controller.columnConfigurations,
                headerBackground: _headerBackground),
            Container(
              height: constraints.maxHeight - headerHeight,
              color: _bodyBackground,
              child: ListView(
                children: controller.rowConfigurations
                    .map((rowData) => _createTileFrom(rowData))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _createTileFrom(RowConfiguration data) => (data.isExpandable)
      ? ExpandableTableRow(
          columnConfigurations: controller.columnConfigurations,
          data: data as ExpandableRow)
      : StaticTableRow(
          columnConfigurations: controller.columnConfigurations, rowData: data);
}
