import 'package:binary_tree/binary_tree.dart';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/row_entry_item.dart';

class RowsTreeNode implements Comparable {
  final GridCellData data;
  final List<RowEntryItem> rows;

  RowsTreeNode(this.data, this.rows);

  @override
  operator ==(other) => compareTo(other) == 0;

  @override
  int compareTo(other) {
    if (other is RowsTreeNode) {
      return data.compareTo(other.data);
    }
    return -1;
  }
}

extension BinaryTreeExtensions<T extends Comparable> on BinaryTree<T> {
  bool putIfAbsent(T node, {void Function(T)? onIsPresent}) {
    var found = search(node);
    if (found != null) {
      onIsPresent?.call(found);
      return false;
    }
    insert(node);
    return true;
  }
}
