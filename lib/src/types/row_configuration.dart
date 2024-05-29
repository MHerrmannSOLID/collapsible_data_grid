import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RowConfiguration {
  static final defaultNumberFormat = NumberFormat('#.#');
  final List<GridCellData> cells = [];
  final bool isExpandable;
  final NumberFormat numberFormat;
  final void Function(BuildContext context)? onTap;

  RowConfiguration(
      {required List cells, this.onTap, NumberFormat? numberFormat})
      : isExpandable = false,
        numberFormat = numberFormat ?? defaultNumberFormat {
    this.cells.addAll(cells.map((cell) => _mapToGridCellData(cell)).toList());
  }

  GridCellData _mapToGridCellData(dynamic cell) => (cell is GridCellData)
      ? cell
      : GridCellData<Comparable>(
          child: _mapToWidget(cell),
          groupKey: cell,
          backgroundColor: Colors.white);

  Widget _mapToWidget(cell) =>
      (cell is Collapsible) ? cell : Text(_formatAsString(cell));

  String _formatAsString(cell) =>
      (cell is num) ? numberFormat.format(cell) : cell.toString();
}
