import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

import 'table_grid_cell.dart';

class StaticTableRow extends StatelessWidget {
  StaticTableRow(
      {required Iterable<ColumnConfiguration> columnConfigurations,
      required this.rowData,
      this.background,
      this.cellBorder,
      super.key})
      : columnConfigurations = columnConfigurations.toList();

  final RowConfiguration rowData;
  final Color? background;
  final CellBorderConfiguration? cellBorder;
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
    var rowDataCells = rowData.getCells();

    for (var i = 0; i < rowDataCells.length; i++) {
      double weight = 0;

      cells.add(TableGridCell(
          weight: _calculateCellWeight(rowDataCells, i, weight),
          background: background,
          cellBorder: cellBorder,
          cellData: rowDataCells[i]));
    }
    return cells;
  }

  double _calculateCellWeight(
      List<GridCellData<Comparable>> rowDataCells, int i, double weight) {
    if (!_isSpanningMultipleColumns(rowDataCells[i]))
      return columnConfigurations[i].weight;

    for (var j = 0; j < rowDataCells[i].colSpan; j++)
      weight += (columnConfigurations[i + j].weight);
    return weight;
  }

  bool _isSpanningMultipleColumns(
          GridCellData<Comparable<dynamic>> currentCell) =>
      currentCell.colSpan > 1;
}
