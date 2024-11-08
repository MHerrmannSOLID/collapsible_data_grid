import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader(
      {required this.columns,
      this.headerBackground,
      this.borderConfiguration,
      super.key});

  final Iterable<ColumnConfiguration> columns;
  final Color? headerBackground;
  final CellBorderConfiguration? borderConfiguration;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columns
          .map(
            (column) => Expanded(
              flex: column.weight.toInt(),
              child: DecoratedCell(
                background: column.background ?? headerBackground,
                child: column.header,
              ),
            ),
          )
          .toList(),
    ));
  }
}
