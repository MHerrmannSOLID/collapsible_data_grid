import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/decorated_cell.dart';
import 'package:flutter/material.dart';

class TableGridCell extends StatelessWidget {
  const TableGridCell(
      {required this.cellData, required this.weight, super.key});

  final GridCellData cellData;
  final double weight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: weight.toInt(),
      child: DecoratedCell(
        borderConfiguration: cellData.borderConfiguration,
        child: cellData.buildCell(),
      ),
    );
  }
}
