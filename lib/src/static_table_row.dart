import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

import 'table_grid_cell.dart';

class StaticTableRow extends StatelessWidget {
  StaticTableRow(
      {required Iterable<ColumnConfiguration> columnConfigurations,
      required this.rowData,
      super.key})
      : columnConfigurations = columnConfigurations.toList();

  final RowConfiguration rowData;
  final List<ColumnConfiguration> columnConfigurations;

  Widget _clickWrapper(
          {required Widget child, required BuildContext context}) =>
      (rowData.onTap == null)
          ? child
          : Material(
              child: InkWell(
                  onTap: () => rowData.onTap?.call(context), child: child));

  @override
  Widget build(BuildContext context) => _clickWrapper(
        context: context,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _createCells(),
          ),
        ),
      );

  List<Widget> _createCells() {
    var cells = <Widget>[];

    for (var i = 0; i < rowData.cells.length; i++) {
      double weight = 0;

      for (var j = 0; j < rowData.cells[i].colSpan; j++)
        weight += (columnConfigurations[i + j].weight);

      cells.add(TableGridCell(weight: weight, cellData: rowData.cells[i]));
    }
    return cells;
  }
}
