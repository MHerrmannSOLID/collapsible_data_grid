import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ColumnTestHelper on Widget {
  Widget wrapDirectional() => Directionality(
        textDirection: TextDirection.ltr,
        child: this,
      );
}
