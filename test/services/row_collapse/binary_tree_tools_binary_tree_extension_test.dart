import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/services/row_collapse/binary_tree_tools.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing the binary tree extension of the binary tree tools', () {
    test(
        'Putting a node into the tree which is not there yet'
        '--> node will simply be added call returns true.', () {
      var testTree = BinaryTree<RowsTreeNode>([
        RowsTreeNode(FakeCell(1), []),
        RowsTreeNode(FakeCell(4), []),
        RowsTreeNode(FakeCell(2), [])
      ]);

      var wasAdded = testTree.putIfAbsent(RowsTreeNode(FakeCell(3), []));

      expect(wasAdded, isTrue);
      expect(testTree.search(RowsTreeNode(FakeCell(3), [])), isNotNull);
    });

    test(
        'Putting a node into the tree which is already there'
        '--> should return false since node could not be added.', () {
      var testTree = BinaryTree<RowsTreeNode>([
        RowsTreeNode(FakeCell(1), []),
        RowsTreeNode(FakeCell(4), []),
        RowsTreeNode(FakeCell(2), [])
      ]);

      var wasAdded = testTree.putIfAbsent(RowsTreeNode(FakeCell(4), []));

      expect(wasAdded, isFalse);
      expect(testTree.search(RowsTreeNode(FakeCell(4), [])), isNotNull);
    });

    test(
        'Putting a node into the tree which is not there yet'
        '--> node will simply be added no call to onIsPresent .', () {
      bool onIsPresentCalled = false;
      var testTree = BinaryTree<RowsTreeNode>([
        RowsTreeNode(FakeCell(1), []),
        RowsTreeNode(FakeCell(4), []),
        RowsTreeNode(FakeCell(2), [])
      ]);

      testTree.putIfAbsent(RowsTreeNode(FakeCell(3), []),
          onIsPresent: (node) => onIsPresentCalled = true);

      expect(onIsPresentCalled, isFalse);
      expect(testTree.search(RowsTreeNode(FakeCell(3), [])), isNotNull);
    });

    test(
        'Putting a node into the tree which is already there'
        '--> should call the the onIsPresent callback handler.', () {
      bool onIsPresentCalled = false;
      var testTree = BinaryTree<RowsTreeNode>([
        RowsTreeNode(FakeCell(1), []),
        RowsTreeNode(FakeCell(4), []),
        RowsTreeNode(FakeCell(2), [])
      ]);

      testTree.putIfAbsent(RowsTreeNode(FakeCell(4), []),
          onIsPresent: (node) => onIsPresentCalled = true);

      expect(onIsPresentCalled, isTrue);
      expect(testTree.search(RowsTreeNode(FakeCell(4), [])), isNotNull);
    });

    test(
        'Putting a node into the tree which is already there'
        '--> onIsPresent should serve the correct instace of the existing element.',
        () {
      RowsTreeNode? servedNode = null;
      var testNode = RowsTreeNode(FakeCell(4), []);
      var testTree = BinaryTree<RowsTreeNode>([
        RowsTreeNode(FakeCell(1), []),
        testNode,
        RowsTreeNode(FakeCell(2), [])
      ]);

      testTree.putIfAbsent(RowsTreeNode(FakeCell(4), []),
          onIsPresent: (node) => servedNode = node);

      expect(servedNode, isNotNull);
      expect(identical(servedNode, testNode), isTrue);
    });
  });
}

class FakeCell extends Fake implements GridCellData<num> {
  bool _compareToWasCalled = false;

  bool get compareToWasCalled => _compareToWasCalled;

  @override
  final num groupKey;

  FakeCell(this.groupKey);

  @override
  operator ==(other) {
    if (other is! GridCellData<num>) return false;
    return compareTo(other) == 0;
  }

  @override
  int compareTo(GridCellData<num> other) {
    _compareToWasCalled = true;
    return groupKey.compareTo(other.groupKey);
  }
}
