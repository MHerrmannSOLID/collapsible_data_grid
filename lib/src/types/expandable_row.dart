import 'package:expandable/expandable.dart';
import 'package:collapsible_data_grid/src/types/grid_cell_data.dart';
import 'package:collapsible_data_grid/src/types/row_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ExpandableRow implements RowConfiguration {
  final List<RowConfiguration> children;
  final ExpandableController _controller;

  final NumberFormat numberFormat;

  @override
  final bool isExpandable;

  final List<GridCellData> _cells;

  @override
  void Function(BuildContext context)? get onTap => null;

  ExpandableRow(
      {required List<GridCellData> cells,
      required this.children,
      ExpandableController? controller,
      NumberFormat? numberFormat})
      : isExpandable = true,
        _cells = cells,
        numberFormat = numberFormat ?? RowConfiguration.defaultNumberFormat,
        _controller = controller ?? ExpandableController();

  ExpandableController get controller => _controller;

  @override
  List<GridCellData<Comparable>> getCells() => _cells;

  @override
  List<Comparable> get cellsData => _cells;
}
