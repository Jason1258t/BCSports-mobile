import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCSports',
      theme: ThemeData(
        fontFamily: 'HN',
      ),
      home: Text('12341234',
        style: TextStyle(fontFamily: 'HN'),),
    );
  }
}
