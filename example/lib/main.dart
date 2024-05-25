import 'package:collapsible_data_grid_example/src/simple_table/simple_table.dart';
import 'package:collapsible_data_grid_example/src/material_style_table/material_style_table.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flex Table Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SimpleTable(title: 'Simple table test'),
          '/solid_table': (context) =>
              const MaterialStyleTable(title: 'Simple table test'),
        });
  }
}
