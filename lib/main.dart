import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double _output = 0;
  double _input = 0;
  String _operator = "";
  bool showOutput = false;
  String prevButton = "";

  double calculate() {
    if (_operator == "") {
      return _output = _input;
    }
    if (_operator == "+") {
      _output = _output + _input;
    } else if (_operator == "-") {
      _output = _output - _input;
    } else if (_operator == "*") {
      _output = _output * _input;
    } else if (_operator == "/") {
      _output = _output / _input;
    }

    return _output;
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _input = 0;
          _output = 0;
          _operator = "";
          showOutput = false;
          break;
        case '=':
          _output = calculate();
          showOutput = true;
          _operator = "";
          _input = 0;
          break;
        case '+':
        case '-':
        case '*':
        case '/':
          if (prevButton == "=") {
            _operator = buttonText;
            _input = 0;
          } else {
            _output = calculate();
            showOutput = true;
            _operator = buttonText;
            _input = 0;
          }
          break;
        default:
          _input = double.parse(_input.toString() + buttonText);
          showOutput = false;
      }
    });
    prevButton = buttonText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Text('output: $_output', style: const TextStyle(fontSize: 12.0)),
          Text('input: $_input', style: const TextStyle(fontSize: 12.0)),
          Text('operator: $_operator', style: const TextStyle(fontSize: 12.0)),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                showOutput ? _output.toString() : _input.toString(),
                style: const TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
