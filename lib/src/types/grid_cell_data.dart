import 'package:collapsible_data_grid/src/types/cell_border_configuration.dart';
import 'package:flutter/material.dart';

class GridCellData<TGroupKey extends Comparable<TGroupKey>>
    implements Comparable<GridCellData<TGroupKey>> {
  final Widget _child;
  final CellBorderConfiguration _borderConfiguration;
  final AlignmentGeometry _alignmentGeometry;
  final int colSpan;
  final Color? backgroundColor;
  final TGroupKey groupKey;

  GridCellData(
      {required Widget child,
      required this.groupKey,
      this.colSpan = 1,
      this.backgroundColor,
      CellBorderConfiguration? borderConfiguration,
      AlignmentGeometry? alignmentGeometry})
      : _borderConfiguration = borderConfiguration ?? CellBorderConfiguration(),
        _child = child,
        _alignmentGeometry = alignmentGeometry ?? Alignment.center;

  CellBorderConfiguration get borderConfiguration => _borderConfiguration;

  Widget get child {
    return Container(
      color: backgroundColor,
      child: Align(
        alignment: _alignmentGeometry,
        child: _child,
      ),
    );
  }

  @override
  int compareTo(GridCellData<TGroupKey> other) =>
      groupKey.compareTo(other.groupKey);
}
