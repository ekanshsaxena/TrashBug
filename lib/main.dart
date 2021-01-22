import 'package:flutter/material.dart';
import 'package:trashbug/ui/dashboard.dart';
import 'package:trashbug/ui/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Trash Bug',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DashboardOnePage(),
    );
  }
}
