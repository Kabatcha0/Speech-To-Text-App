import 'package:flutter/material.dart';
import 'package:speechtotext/modules/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
