import 'package:basic_form/form_page_1.dart';
import 'package:basic_form/form_page_2.dart';
import 'package:flutter/material.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: new FormPage1(title: 'Flutter Form Demo'),
      home: new FormPage2(),
    );
  }
}

