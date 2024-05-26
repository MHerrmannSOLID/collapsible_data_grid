import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/decorated_cell.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({required this.columns, Color? headerBackground, super.key})
      : _headerBackground = headerBackground ?? Colors.white;

  final Iterable<ColumnConfiguration> columns;
  final Color _headerBackground;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: columns
          .map(
            (column) => Expanded(
              flex: column.weight.toInt(),
              child: DecoratedCell(
                borderConfiguration: column.borderConfiguration,
                child: column.header,
              ),
            ),
          )
          .toList(),
    );
  }
}
