import 'package:flutter/material.dart';
import 'user_report.dart';

class ReportLauncher extends StatefulWidget {
  static const routeName = '/';
  const ReportLauncher({Key? key}) : super(key: key);

  @override
  _ReportLauncher createState() => _ReportLauncher();
}

class _ReportLauncher extends State<ReportLauncher> {
  @override
  Widget build(BuildContext context) {
    return Container(child: userReport());
  }
}
