import 'dart:collection';
import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';

typedef CollapseHeaderBuilder = Widget Function(
    BuildContext context, List<RowConfiguration> rows);

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

  static Widget _defaultCollapseHeaderBuilder(
      BuildContext context, List<RowConfiguration> rows) {
    return Container();
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
      for (var cell in row.cells) {
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
    var allRowsLinkedList = LinkedList<RowEntryItem>();
    var btree = BinaryTree<TreeNode>();
    var hadFoldedRows = false;

    for (var row in _originalRowConfigurations) {
      var acrRow = RowEntryItem(row);
      var collapseColumn = row.cells[columnIdx];
      allRowsLinkedList.add(acrRow);
      var toAdd = TreeNode(collapseColumn, <RowEntryItem>[acrRow]);
      var node = btree.search(toAdd);
      if (node != null) {
        hadFoldedRows = true;
        node.rows.add(acrRow);
      } else {
        btree.insert(toAdd);
      }
    }
    if (!hadFoldedRows) return;

    btree.forEach((node) {
      if (node.rows.length > 1) {
        var expandableRow = ExpandableRow<GridCellData>(
            cells: node.rows.first.rowConfiguration.cells,
            children: node.rows.map((e) => e.rowConfiguration).toList());
        for (var item in node.rows) {
          allRowsLinkedList.remove(item);
        }
        if (node.rows.first.previous != null)
          node.rows.first.previous?.insertAfter(RowEntryItem(expandableRow));
        else
          allRowsLinkedList.addFirst(RowEntryItem(expandableRow));
      }
    });
    _rowConfigurations =
        allRowsLinkedList.map((e) => e.rowConfiguration).toList();
    notifyListeners();
  }
}

class TreeNode implements Comparable {
  final GridCellData data;
  final List<RowEntryItem> rows;

  TreeNode(this.data, this.rows);

  operator ==(other) => compareTo(other) == 0;

  @override
  int compareTo(other) {
    if (other is TreeNode) {
      return data.compareTo(other.data);
    }
    return -1;
  }
}

final class RowEntryItem extends LinkedListEntry<RowEntryItem> {
  final RowConfiguration rowConfiguration;

  RowEntryItem(this.rowConfiguration);
}
