import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Comparing two GridCellData instances with string keys'
      '--> should be same resutl like the direct comparison of the strings',
      () {
    var gc1 = GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1');
    var gc2 = GridCellData(child: const Text('Cell 2'), groupKey: 'Cell 2');

    expect(gc1.groupKey, 'Cell 1');
    expect(gc2.groupKey, 'Cell 2');
    expect(gc1.compareTo(gc2), 'Cell 1'.compareTo('Cell 2'));
  });
}
