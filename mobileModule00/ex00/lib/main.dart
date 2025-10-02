import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'ex00', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 98, 98, 0),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'A simple text',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  backgroundColor: const Color.fromARGB(255, 246, 243, 242),
                ),
                onPressed: () {
                  print("Button pressed");
                },
                child: const Text(
                  'Click me',
                  style: TextStyle(
                    color: Color.fromARGB(255, 98, 98, 0),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
