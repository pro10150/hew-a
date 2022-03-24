import 'package:flutter/material.dart';
import 'user_report.dart';

class luncher extends StatefulWidget {
  static const routeName='/';
  const luncher({ Key? key }) : super(key: key);

  @override
  _luncherState createState() => _luncherState();
}

class _luncherState extends State<luncher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: userReport()
    );
  }
}