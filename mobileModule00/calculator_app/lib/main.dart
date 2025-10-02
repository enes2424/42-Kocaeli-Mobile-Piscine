import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'calculator_app', home: MyHomePage());
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
  final StringBuffer _expression = StringBuffer();
  String _result = "";

  String _calculateResult(String expression) {
    if (expression.isEmpty) {
      return "";
    }
    List<String> list = [];
    int startIndex = 0;
    int index = 0;
    for (; index < expression.length; index++) {
      if (int.tryParse(expression[index]) == null && expression[index] != '.') {
        if (startIndex != index) {
          list.add(expression.substring(startIndex, index));
        }
        list.add(expression[index]);
        startIndex = index + 1;
      }
    }
    if (startIndex != index) {
      list.add(expression.substring(startIndex, index));
    }
    double result = 0, number;
    int sign = 1;
    bool ctrl = false;
    String operation = "", alternateOperation = "";
    try {
      int i = 0;
      if (list[0] == '-') {
        sign = -1;
        i = 1;
      }
      result = sign * double.parse(list[i]);
      sign = 1;
      for (i++; i < list.length; i++) {
        if (ctrl) {
          if (list[i] == '-') {
            sign = -1;
            if (list[i - 1] == '-') {
              return "Invalid expression!";
            }
            continue;
          }
          number = sign * double.parse(list[i]);
          if (operation == 'x') {
            result *= number;
          } else if (operation == '/') {
            if (number == 0) {
              return "Divisible by zero!";
            }
            result /= number;
          } else {
            if (i + 1 < list.length &&
                (list[i + 1] == 'x' || list[i + 1] == '/')) {
              sign = 1;
              alternateOperation = list[i + 1];
              for (i += 2; i < list.length; i++) {
                if (ctrl) {
                  if (list[i] == '-') {
                    sign = -1;
                    if (list[i - 1] == '-') {
                      return "Invalid expression!";
                    }
                    continue;
                  }
                  if (alternateOperation == 'x') {
                    number *= sign * double.parse(list[i]);
                  } else if (alternateOperation == '/') {
                    if (sign * double.parse(list[i]) == 0) {
                      return "Divisible by zero!";
                    }
                    number /= sign * double.parse(list[i]);
                  }
                  if (!(i + 1 < list.length &&
                      (list[i + 1] == 'x' || list[i + 1] == '/'))) {
                    break;
                  }
                  sign = 1;
                  ctrl = false;
                } else {
                  alternateOperation = list[i];
                  ctrl = true;
                }
              }
            }
            if (operation == '+') {
              result += number;
            } else if (operation == '-') {
              result -= number;
            }
          }
          sign = 1;
          ctrl = false;
        } else {
          operation = list[i];
          ctrl = true;
        }
      }
      if (ctrl) {
        return "Invalid expression!";
      }
    } catch (e) {
      return "Invalid expression!";
    }
    String str = result.toString();
    if (str.length > 1 && str[str.length - 2] == '.' && str[str.length - 1] == '0') {
      return str.substring(0, str.length - 2);
    }
    return str;
  }

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
                        _expression.toString(),
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
                              setState(() {
                                if (_calculatorKeys[index] == 'C') {
                                  if (_expression.isNotEmpty) {
                                    String currentString =
                                        _expression.toString();
                                    _expression.clear();
                                    _expression.write(
                                      currentString.substring(
                                        0,
                                        currentString.length - 1,
                                      ),
                                    );
                                  }
                                } else if (_calculatorKeys[index] == 'AC') {
                                  _expression.clear();
                                  _result = "";
                                } else if (_calculatorKeys[index] == '=') {
                                  _result = _calculateResult(_expression.toString());
                                } else {
                                  _expression.write(_calculatorKeys[index]);
                                }
                              });
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
