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
    return Row(
      children: columns
          .map(
            (column) => Expanded(
              flex: column.weight.toInt(),
              child: DecoratedCell(
                background: column.background ?? headerBackground,
                borderConfiguration:
                    column.borderConfiguration ?? borderConfiguration,
                child: column.header,
              ),
            ),
          )
          .toList(),
    );
  }
}
