import 'dart:collection';
import 'package:collapsible_data_grid/src/types/row_entry_item.dart';
import 'binary_tree_tools.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';

/// A service to collapse rows based on the value of a column.
///
/// This services automates the search of rows that can be collapsed
/// based on one columns value. The equality of the values will be determined
/// based on the [Comparable.compareTo] method.
/// In cases where multiple rows can be collapsed into one, the service will
/// generate an expandable row that contains the collapsed rows.
/// Further the service will remove the rows that have been collapsed and
/// call the [CollapseHeaderBuilder] to generate the header for the expandable row.
///
/// Since such a search is not trivial regarding time complexity
/// (the intuitive solution would be O(n^2)), this service uses a binary tree,
/// as well as a linked list to keep track of the rows.
///
/// The binary tree is used to search for rows that can be collapsed in O(log n)
/// and the linked list empowers the service to remove and insert rows in O(1).
/// Since ervery needs to be touched at least once, the overall time complexity
/// should be about O(n log(n)).
/// This way it should be possible to collapse a few hundred rows without any
/// feelable performance impact ina single thread.
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
    btree.forEach(_tryToCollapse);
  }

  void _tryToCollapse(RowsTreeNode node) {
    if (_isNotCollapsible(node)) return;
    var expandableRow = _createExpandableRow(node);

    var previouosNode = node.rows.first.previous;

    node.rows.forEach(allRowsLinkedList.remove);

    _insertNewRowIntoList(previouosNode, expandableRow);
  }

  bool _isNotCollapsible(RowsTreeNode node) => node.rows.length == 1;

  void _insertNewRowIntoList(
      RowEntryItem? previouosNode, ExpandableRow expandableRow) {
    if (previouosNode != null)
      previouosNode.insertAfter(RowEntryItem(expandableRow));
    else
      allRowsLinkedList.addFirst(RowEntryItem(expandableRow));
  }

  ExpandableRow _createExpandableRow(RowsTreeNode node) {
    var childRows = node.rows.map((e) => e.rowConfiguration).toList();
    return ExpandableRow(
        cells: _collapseHeaderBuilder(childRows), children: childRows);
  }

  /// This method creates both the binary tree and the linked list
  /// So strictly seen it does two things, but it's still kept
  /// in one method because then we just need to itrerate once
  /// over the rowConfigurations.
  void _initDataStructures(int columnIdx) {
    for (var row in rowConfigurations) {
      var currentRow = RowEntryItem(row);
      var collapseColumn = row.cells[columnIdx];

      allRowsLinkedList.add(currentRow);

      var treeNodeToAdd =
          RowsTreeNode(collapseColumn, <RowEntryItem>[currentRow]);
      btree.putIfAbsent(treeNodeToAdd,
          onIsPresent: _addCurrentRowToPresentNode);
    }
  }

  /// If the tree already contains a node with the same key,
  /// the current row needs to be added to the present node.
  /// as a sub node.
  /// This way the tree conatains already all sub nodes for
  /// collapsable rows
  void _addCurrentRowToPresentNode(RowsTreeNode presentNode) {
    _hadFoldedRows = true;
    presentNode.rows.add(allRowsLinkedList.last);
  }
}
