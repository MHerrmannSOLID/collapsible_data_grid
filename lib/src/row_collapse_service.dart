import 'dart:collection';

import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';

class RowCollapseService {
  final CollapseHeaderBuilder? collapseHeaderBuilder;
  final List<RowConfiguration> rowConfigurations;

  var _hadFoldedRows = false;
  var allRowsLinkedList = LinkedList<RowEntryItem>();
  var btree = BinaryTree<TreeNode>();

  RowCollapseService({
    required this.collapseHeaderBuilder,
    required this.rowConfigurations,
  });

  bool get hadFoldedRows => _hadFoldedRows;
  List<RowConfiguration> get collapedRows =>
      allRowsLinkedList.map((e) => e.rowConfiguration).toList();

  void foldRowsBy({required int columnIdx}) {
    _analyseStructure(columnIdx);
    if (!hadFoldedRows) return;
    _foldStructure();
  }

  void _foldStructure() {
    for (var node in btree) {
      if (node.rows.length > 1) {
        var expandableRow = _createExpandableRow(node);

        var previouosNode = node.rows.first.previous;

        for (var item in node.rows) {
          allRowsLinkedList.remove(item);
        }

        if (previouosNode != null)
          previouosNode.insertAfter(RowEntryItem(expandableRow));
        else
          allRowsLinkedList.addFirst(RowEntryItem(expandableRow));
      }
    }
  }

  ExpandableRow<GridCellData<Comparable<dynamic>>> _createExpandableRow(
      TreeNode node) {
    var childRows = node.rows.map((e) => e.rowConfiguration).toList();
    return ExpandableRow<GridCellData>(
        cells: collapseHeaderBuilder!(childRows), children: childRows);
  }

  void _analyseStructure(int columnIdx) {
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
  }
}

class TreeNode implements Comparable {
  final GridCellData data;
  final List<RowEntryItem> rows;

  TreeNode(this.data, this.rows);

  @override
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
