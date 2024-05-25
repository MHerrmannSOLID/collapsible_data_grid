import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'project_data_entry.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'projects_data.dart';

class ProjectsDataFactory {
  static var serviceIcons = {
    'Replace': Icons.published_with_changes,
    'Repair': Icons.construction,
    'Assess': Icons.assessment,
    'Deliver': Icons.delivery_dining,
  };

  static Future<ProjectsData> createFromAsset(
      {required String assetPath}) async {
    var assetContent = (await rootBundle.loadString(assetPath)).split('\n');

    var columnHeaders = _getColumnHeaders(assetContent.removeAt(0));

    var entries = assetContent.map(_parseEntry).toList();

    return ProjectsData(columnHeaders: columnHeaders, data: entries);
  }

  static List<String> _getColumnHeaders(String headerLine) =>
      headerLine.split('\t');

  static ProjectDataEntry _parseEntry(String line) {
    var elements = line.split('\t');
    return ProjectDataEntry(
      workOrder: elements[0],
      district: elements[1],
      leadTech: elements[2],
      service: _getServiceIcon(elements[3]),
      reqDate: DateTime.parse(elements[4]),
      workDate: DateTime.parse(elements[5]),
      techs: int.parse(elements[6]),
      payment: elements[7],
    );
  }

  static IconData _getServiceIcon(String element) {
    return serviceIcons[element] ?? Icons.help;
  }
}
