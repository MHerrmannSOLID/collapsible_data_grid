import 'package:collapsible_data_grid/src/types/cell_border_configuration.dart';
import 'package:flutter/material.dart';

class GridCellData<TGroupKey extends Comparable>
    implements Comparable<GridCellData<TGroupKey>> {
  final Widget child;
  CellBorderConfiguration? borderConfiguration;
  final AlignmentGeometry _alignmentGeometry;
  final int colSpan;
  final TGroupKey groupKey;

  GridCellData(
      {required this.child,
      required this.groupKey,
      this.colSpan = 1,
      this.borderConfiguration,
      AlignmentGeometry? alignmentGeometry})
      : _alignmentGeometry = alignmentGeometry ?? Alignment.center;

  Widget buildCell() {
    return Align(
      alignment: _alignmentGeometry,
      child: child,
    );
  }

  @override
  int compareTo(GridCellData<TGroupKey> other) =>
      groupKey.compareTo(other.groupKey);
}
