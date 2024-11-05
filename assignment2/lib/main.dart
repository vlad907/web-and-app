import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CINS467 Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Adds a dark theme for a modern look
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CINS467 Project'),
        centerTitle: true, // Centers the title for a more balanced look
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CINS467 Hello World!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('WOW!'),
          content: const Text('You pressed the button!'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent, // Corrected button background color
    padding: const EdgeInsets.symmetric(
      horizontal: 25.0,
      vertical: 15.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: const Text(
    'Click Me',
    style: TextStyle(fontSize: 18),
  ),
)
            ],
          ),
        ),
      ),
    );
  }
}
