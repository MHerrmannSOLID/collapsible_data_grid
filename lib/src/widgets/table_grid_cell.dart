import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';

class TableGridCell extends StatelessWidget {
  const TableGridCell(
      {required this.cellData,
      required this.weight,
      this.background,
      //   this.cellBorder,
      super.key});

  final GridCellData cellData;
  final double weight;
  final Color? background;
  //final CellBorderConfiguration? cellBorder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: weight.toInt(),
      child: DecoratedCell(
        background: cellData.backgroundColor ?? background,
        //   borderConfiguration: cellData.borderConfiguration ?? cellBorder,
        child: cellData.buildCell(),
      ),
    );
  }
}
