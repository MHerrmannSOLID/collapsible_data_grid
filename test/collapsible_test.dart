import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

void main() {
  testWidgets(
      'Creating a Collapsible widget with child widget'
      '--> child widget should be renderd', (tester) async {
    var collapsible = const Collapsible<num>(
        groupKey: 1,
        child: Text(
          'test',
          key: Key('test'),
        ));

    await tester.pumpWidget(collapsible.wrapDirectional());

    expect(find.byKey(const Key('test')), findsOneWidget);
  });

  test(
      'Comparing two num key collapsible widgets '
      '--> should be same result like ', () {
    var collapsible1 = const Collapsible<num>(groupKey: 1, child: Text('test'));
    var collapsible2 = const Collapsible<num>(groupKey: 2, child: Text('test'));

    expect(collapsible1.compareTo(collapsible2), 1.compareTo(2));
  });
}
