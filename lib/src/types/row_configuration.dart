import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RowConfiguration {
  static final defaultNumberFormat = NumberFormat('#.#');
  final List<Comparable> cellsData = [];
  final bool isExpandable;
  final NumberFormat numberFormat;
  final void Function(BuildContext context)? onTap;

  RowConfiguration(
      {required List cells, this.onTap, NumberFormat? numberFormat})
      : isExpandable = false,
        numberFormat = numberFormat ?? defaultNumberFormat {
    cellsData.addAll(cells.map(_mapToCompareable).toList());
  }

  List<GridCellData> getCells() {
    return cellsData.map((cell) => _mapToGridCellData(cell)).toList();
  }

  GridCellData _mapToGridCellData(dynamic cell) => (cell is GridCellData)
      ? cell
      : GridCellData<Comparable>(
          child: _mapToWidget(cell),
          groupKey: cell,
        );

  Widget _mapToWidget(cell) =>
      (cell is Collapsible) ? cell : Text(_formatAsString(cell));

  String _formatAsString(cell) =>
      (cell is num) ? numberFormat.format(cell) : cell.toString();

  Comparable _mapToCompareable(dynamic element) {
    if (element is Comparable) return element;
    if (element is Widget) {
      return Collapsible(groupKey: 0 as num, child: element);
    }
    print(
        '\x1B[31mError: Cell data needs to be compareable https://api.dart.dev/stable/3.4.2/dart-core/Comparable-class.html. Since this is not the case for ${element.runtimeType.toString()} it will displayed as a String !\x1B[0m');
    return element.toString();
  }
}
