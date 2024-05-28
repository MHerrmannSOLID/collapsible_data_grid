import 'dart:collection';
import 'package:collapsible_data_grid/collapsible_data_grid.dart';

final class RowEntryItem extends LinkedListEntry<RowEntryItem> {
  final RowConfiguration rowConfiguration;

  RowEntryItem(this.rowConfiguration);
}
