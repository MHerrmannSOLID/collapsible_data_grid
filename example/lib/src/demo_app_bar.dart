import 'package:flutter/material.dart';

class DemoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('-=| Collapsible Data Grid Demo |=-'),
        Spacer(),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/material_table'),
            child: Text('Material style table')),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: Text('Simple table')),
        SizedBox(width: 20.0)
      ],
    );
  }
}
