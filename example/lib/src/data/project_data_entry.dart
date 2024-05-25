import 'package:flutter/widgets.dart';

class ProjectDataEntry {
  final String workOrder;
  final String district;
  final String leadTech;
  final IconData service;
  final DateTime reqDate;
  final DateTime workDate;
  final int techs;
  final String payment;

  ProjectDataEntry({
    required this.workOrder,
    required this.district,
    required this.leadTech,
    required this.service,
    required this.reqDate,
    required this.workDate,
    required this.techs,
    required this.payment,
  });
}
