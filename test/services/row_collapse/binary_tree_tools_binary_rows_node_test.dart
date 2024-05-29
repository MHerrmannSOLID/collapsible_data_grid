import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/services/row_collapse/binary_tree_tools.dart';
import 'package:collapsible_data_grid/src/types/row_entry_item.dart';
import 'package:flutter_test/flutter_test.dart';

import 'binary_tree_tools_binary_tree_extension_test.dart';

void main() {
  group('Testing RowsTreeNode of the binary tree tools', () {
    test(
        'Comparing two nodes having the same key'
        '--> the equality oerator should return true', () {
      var node1 = RowsTreeNode(FakeCell(1), [
        RowEntryItem(RowConfiguration(cells: [1, 2, 3]))
      ]);
      var node2 = RowsTreeNode(FakeCell(1), []);

      expect(node1 == node2, isTrue);
    });

    test(
        'Comparing two nodes having the different key'
        '--> the equality oerator should return false', () {
      var node1 = RowsTreeNode(FakeCell(2), [
        RowEntryItem(RowConfiguration(cells: [1, 2, 3]))
      ]);
      var node2 = RowsTreeNode(FakeCell(1), []);

      expect(node1 == node2, isFalse);
    });

    test(
        'Comparing two nodes same but different key'
        '--> the equality oerator should return false', () {
      var node1 = RowsTreeNode(FakeCell(2), [
        RowEntryItem(RowConfiguration(cells: [1, 2, 3]))
      ]);
      var node2 = RowsTreeNode(FakeCell(1), [
        RowEntryItem(RowConfiguration(cells: [1, 2, 3]))
      ]);

      expect(node1 == node2, isFalse);
    });

    test(
        'Comparing thwo nodes '
        '--> the comapreTo overrride should be used on equality test.', () {
      var fakeCell1 = FakeCell(1);
      var fakeCell2 = FakeCell(1);

      var node1 = RowsTreeNode(fakeCell1, []);
      var node2 = RowsTreeNode(fakeCell2, []);

      var isEqual = node1 == node2;

      expect(isEqual, isTrue);
      var eitehrCompeToWasCalled =
          fakeCell1.compareToWasCalled || fakeCell2.compareToWasCalled;
      expect(eitehrCompeToWasCalled, isTrue);
    });

    test(
        'RowTreeNode compareTo other node'
        '--> one of the  data elements comapeTo is called.', () {
      var fakeCell1 = FakeCell(1);
      var fakeCell2 = FakeCell(1);

      var node1 = RowsTreeNode(fakeCell1, []);
      var node2 = RowsTreeNode(fakeCell2, []);

      node1.compareTo(node2);

      var eitehrCompeToWasCalled =
          fakeCell1.compareToWasCalled || fakeCell2.compareToWasCalled;
      expect(eitehrCompeToWasCalled, isTrue);
    });

    test(
        'RowTreeNode compareTo other compareable'
        '--> one of the  data elements comapeTo is called.', () {
      var node1 = RowsTreeNode(FakeCell(1), []);

      expect(node1.compareTo("test"), -1);
    });
  });
}
