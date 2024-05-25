import 'package:flutter/material.dart';

class Collapsible<TGroupKey extends Comparable<TGroupKey>>
    extends StatelessWidget implements Comparable<Collapsible<TGroupKey>> {
  const Collapsible({required this.child, required this.groupKey, super.key});

  final Widget child;
  final TGroupKey groupKey;

  @override
  Widget build(BuildContext context) => child;

  @override
  int compareTo(Collapsible<TGroupKey> other) =>
      groupKey.compareTo(other.groupKey);
}
