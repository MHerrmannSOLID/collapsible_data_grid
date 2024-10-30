import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/services/row_collapse/row_collapse_service.dart';
import 'package:flutter/material.dart';

typedef CollapseHeaderBuilder = List<GridCellData> Function(
    List<RowConfiguration> rows, ExpandableController controller);

typedef CellStyleBuilder = void Function(
    int colIdx, int rowIdx, GridCellData toStyle);

class CollapsibleGridController extends ChangeNotifier {
  List _originalColumnConfigurations = [];
  List<RowConfiguration> _originalRowConfigurations = [];

  List<ColumnConfiguration> _columnConfigurations = [];
  List<RowConfiguration> _rowConfigurations = [];

  final CollapseHeaderBuilder collapseHeaderBuilder;
  final CellStyleBuilder? cellStyleBuilder;
  final int groupingColumnIndex;

  static List<GridCellData> _defaultCollapseHeaderBuilder(
      List<RowConfiguration> rows, ExpandableController controller) {
    return rows.first.getCells();
  }

  CollapsibleGridController(
      {this.collapseHeaderBuilder = _defaultCollapseHeaderBuilder,
      this.cellStyleBuilder,
      this.groupingColumnIndex = -1});

  void initialize(
      List columnConfigurations, List<RowConfiguration> rowConfigurations) {
    if (columnConfigurations == _originalColumnConfigurations &&
        rowConfigurations == _originalRowConfigurations) return;

    _originalColumnConfigurations = columnConfigurations;
    _originalRowConfigurations = rowConfigurations;
    _columnConfigurations = _createColumnsFrom(_originalColumnConfigurations);
    _rowConfigurations = _originalRowConfigurations.toList();
    _applyCellStyles();
  }

  Iterable<ColumnConfiguration> get columnConfigurations sync* {
    for (var colConf in _columnConfigurations) {
      yield colConf;
    }
  }

  Iterable<RowConfiguration> get rowConfigurations sync* {
    for (var rowConf in _rowConfigurations) {
      yield rowConf;
    }
  }

  void _applyCellStyles() {
    if (cellStyleBuilder == null) return;
    int rowIdx = 0;
    for (var row in _rowConfigurations) {
      int colIdx = 0;
      for (var cell in row.getCells()) {
        cellStyleBuilder!(colIdx, rowIdx, cell);
        colIdx++;
      }
      rowIdx++;
    }
  }

  List<ColumnConfiguration> _createColumnsFrom(List columnConfigurations) =>
      columnConfigurations
          .map((column) => (column is ColumnConfiguration)
              ? column
              : _getNonPreconfiguredColumn(column))
          .toList();

  ColumnConfiguration _getNonPreconfiguredColumn(column) => (column is Widget)
      ? ColumnConfiguration(header: column)
      : ColumnConfiguration.textColumn(headerText: column.toString());

  void collapseColumn({required int columnIdx}) {
    var foldingService = RowCollapseService(
        collapseHeaderBuilder: collapseHeaderBuilder,
        rowConfigurations: _originalRowConfigurations);
    foldingService.foldRowsBy(columnIdx: columnIdx);

    if (!foldingService.hadFoldedRows) return;

    _rowConfigurations = foldingService.collapedRows;
    notifyListeners();
  }
}
