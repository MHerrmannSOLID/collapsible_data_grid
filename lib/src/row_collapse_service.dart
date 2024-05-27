import 'dart:collection';

import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';

class RowCollapseService {
  final CellStyleBuilder? cellStyleBuilder;
  final List<RowConfiguration> rowConfigurations;

  var _hadFoldedRows = false;
  var allRowsLinkedList = LinkedList<RowEntryItem>();
  var btree = BinaryTree<TreeNode>();

  RowCollapseService({
    required this.cellStyleBuilder,
    required this.rowConfigurations,
  });

  bool get hadFoldedRows => _hadFoldedRows;
  List<RowConfiguration> get collapedRows =>
      allRowsLinkedList.map((e) => e.rowConfiguration).toList();

  void foldRowsBy({required int columnIdx}) {
    for (var row in rowConfigurations) {
      var acrRow = RowEntryItem(row);
      var collapseColumn = row.cells[columnIdx];
      allRowsLinkedList.add(acrRow);
      var toAdd = TreeNode(collapseColumn, <RowEntryItem>[acrRow]);
      var node = btree.search(toAdd);
      if (node != null) {
        _hadFoldedRows = true;
        node.rows.add(acrRow);
      } else {
        btree.insert(toAdd);
      }
    }
    if (!hadFoldedRows) return;

    for (var node in btree) {
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
    }
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
