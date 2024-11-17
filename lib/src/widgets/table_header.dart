import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({required this.columns, super.key});

  final Iterable<ColumnConfiguration> columns;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CollapsibleDataGridThemeData>(context);
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columns
          .map(
            (column) => Expanded(
              flex: column.weight.toInt(),
              child: DecoratedCell(
                cellTheme: theme.headerTheme,
                child: column.header,
              ),
            ),
          )
          .toList(),
    ));
  }
}
