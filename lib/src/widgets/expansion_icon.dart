import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpansionIcon extends StatefulWidget {
  final ExpandableController contoller;

  final Animatable<double> _halfTween;

  final IconData icon;
  final double startAngleRad;
  final double stopAngleRad;
  final Duration animationDuration;

  static double _rad2Tween(double rad) => rad / (2 * 3.1415);

  ExpansionIcon(
      {required this.contoller,
      this.icon = Icons.chevron_right,
      this.startAngleRad = 0.0,
      this.stopAngleRad = 3.1415 / 2.0,
      this.animationDuration = const Duration(milliseconds: 300),
      super.key})
      : _halfTween = Tween<double>(
            begin: _rad2Tween(startAngleRad), end: _rad2Tween(stopAngleRad)) {}

  @override
  State<StatefulWidget> createState() => ExpansionIconState();
}

class ExpansionIconState extends State<ExpansionIcon>
    with TickerProviderStateMixin {
  late final Animation<double> _iconTurns;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  @override
  void initState() {
    super.initState();
    var animationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
    animationController.value = 0;
    _iconTurns =
        animationController.drive(widget._halfTween.chain(_easeInTween));
    widget.contoller
        .addListener(() => onExpansionStateChange(animationController));
  }

  void onExpansionStateChange(AnimationController animationController) {
    if (widget.contoller.expanded)
      animationController.forward();
    else
      animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _iconTurns,
      child: Icon(widget.icon),
    );
  }
}
