import 'package:flutter/material.dart';

class DemoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('-=| Solid Flex-Table Demo |=-'),
        Spacer(),
        TextButton(onPressed: () => Navigator.pushNamed(context, '/solid_table'), child: Text('SOLID style table')),
        TextButton(onPressed: () => Navigator.pushNamed(context, '/'), child: Text('Simple table')),
        SizedBox(width: 20.0)
      ],
    );
  }
}
