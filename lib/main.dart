import 'package:flutter/material.dart';

const String studentName = 'I Ketut Darmawan Wirakusuma';
const String studentId = '2415051021';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter UI Fundamentals'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Text(
            '$studentId\n$studentName',
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}