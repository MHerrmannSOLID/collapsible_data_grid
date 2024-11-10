import 'package:flutter/material.dart';

class TableColorProperty extends WidgetStateProperty<Color> {
  final mainColor;
  final Map<Set<WidgetState>, Color> stateColors;

  TableColorProperty(
      {required this.mainColor, Map<Set<WidgetState>, Color>? stateColors})
      : stateColors = stateColors ?? {},
        super();

  @override
  Color resolve(Set<WidgetState> states) {
    var matchingSet = _findKeyFor(states);
    return matchingSet.isEmpty ? mainColor : stateColors[matchingSet]!;
  }

  Set<WidgetState> _findKeyFor(Set<WidgetState> states) =>
      _findKeyForStatesIn(stateColors, states);

  static Set<WidgetState> _findKeyForStatesIn(
      Map<Set<WidgetState>, Color> stateSet, Set<WidgetState> states) {
    return stateSet.keys.firstWhere(
        (definedStateKeys) =>
            definedStateKeys.containsAll(states) &&
            definedStateKeys.length == states.length,
        orElse: () => <WidgetState>{});
  }

  TableColorProperty lerp(TableColorProperty? other, double t) {
    if (identical(this, other) || other == null) return this;
    var allStates = _mergeAllStates(other.stateColors);
    return TableColorProperty(
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      stateColors: Map.fromEntries(
        allStates.keys.map((stateSet) {
          var otherStatColor = _findKeyForStatesIn(other.stateColors, stateSet);
          return MapEntry(
            stateSet,
            Color.lerp(allStates[stateSet], other.stateColors[otherStatColor],
                    t) ??
                Colors.transparent,
          );
        }),
      ),
    );
  }

  Map<Set<WidgetState>, Color?> _mergeAllStates(
      Map<Set<WidgetState>, Color> map2) {
    var mergedMap = Map<Set<WidgetState>, Color?>.from(stateColors);

    for (var key2 in map2.keys) {
      if (!_doesKeyExist(key2)) mergedMap[key2] = null;
    }
    return mergedMap;
  }

  bool _doesKeyExist(Set<WidgetState> key2) =>
      stateColors.keys.any((key1) => key1.containsAll(key2));
}
