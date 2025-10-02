import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'ex02', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _calculatorKeys = [
    '7',
    '8',
    '9',
    'C',
    'AC',
    '4',
    '5',
    '6',
    '+',
    '-',
    '1',
    '2',
    '3',
    'x',
    '/',
    '0',
    '.',
    '00',
    '=',
  ];
  final String _expression = "0";
  final String _result = "0";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calculator", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 96, 125, 139),
      ),
      backgroundColor: const Color.fromARGB(255, 55, 71, 79),
      body: Stack(
        children: [
          SizedBox(
            height:
                screenHeight -
                (appBarHeight +
                    (appBarHeight > screenHeight / 2
                        ? screenHeight - appBarHeight
                        : screenHeight / 2)),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _expression,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 96, 125, 139),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _result,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 96, 125, 139),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          (appBarHeight < screenHeight)
              ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height:
                        appBarHeight > screenHeight / 2
                            ? screenHeight - appBarHeight
                            : screenHeight / 2,
                    color: const Color.fromARGB(255, 96, 125, 139),
                    child: Wrap(
                      children: List.generate(19, (index) {
                        return SizedBox(
                          width: screenWidth / 5,
                          height:
                              appBarHeight > screenHeight / 2
                                  ? (screenHeight - appBarHeight) / 4
                                  : screenHeight / 8,
                          child: TextButton(
                            onPressed: () {
                              print('button pressed :${_calculatorKeys[index]}');
                            },
                            child: Center(
                              child: Text(
                                _calculatorKeys[index],
                                style: TextStyle(
                                  color:
                                      ((index % 5) < 3)
                                          ? const Color.fromARGB(
                                            255,
                                            55,
                                            71,
                                            79,
                                          )
                                          : (index < 5)
                                          ? const Color.fromARGB(
                                            255,
                                            163,
                                            50,
                                            54,
                                          )
                                          : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              )
              : const Column(),
        ],
      ),
    );
  }
}
