import 'dart:collection';
import 'package:collapsible_data_grid/src/types/row_entry_item.dart';
import 'binary_tree_tools.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';

class RowCollapseService {
  final CollapseHeaderBuilder _collapseHeaderBuilder;
  final List<RowConfiguration> rowConfigurations;

  var _hadFoldedRows = false;
  var allRowsLinkedList = LinkedList<RowEntryItem>();
  var btree = BinaryTree<RowsTreeNode>();

  RowCollapseService({
    required CollapseHeaderBuilder collapseHeaderBuilder,
    required this.rowConfigurations,
  }) : _collapseHeaderBuilder = collapseHeaderBuilder;

  bool get hadFoldedRows => _hadFoldedRows;
  List<RowConfiguration> get collapedRows =>
      allRowsLinkedList.map((e) => e.rowConfiguration).toList();

  void foldRowsBy({required int columnIdx}) {
    _initDataStructures(columnIdx);
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
      RowsTreeNode node) {
    var childRows = node.rows.map((e) => e.rowConfiguration).toList();
    return ExpandableRow<GridCellData>(
        cells: _collapseHeaderBuilder!(childRows), children: childRows);
  }

  // This method creates both the binary tree and the linked list
  // So strictly seen it does two things, but it's still kept
  // in one method because then we just need to itrerate once
  // over the rowConfigurations.
  void _initDataStructures(int columnIdx) {
    for (var row in rowConfigurations) {
      var acrRow = RowEntryItem(row);
      var collapseColumn = row.cells[columnIdx];
      allRowsLinkedList.add(acrRow);
      var toAdd = RowsTreeNode(collapseColumn, <RowEntryItem>[acrRow]);
      // Map test = {};
      // test.putIfAbsent(key, () => nu7ll)
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
