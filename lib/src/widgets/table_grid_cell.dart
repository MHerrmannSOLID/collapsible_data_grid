import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableGridCell extends StatelessWidget {
  const TableGridCell(
      {required this.cellData, required this.weight, super.key});

  final GridCellData cellData;
  final double weight;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CollapsibleDataGridThemeData>(context);
    return Expanded(
      flex: weight.toInt(),
      child: DecoratedCell(
        cellTheme: theme.cellTheme,
        child: cellData.buildCell(),
      ),
    );
  }
}
