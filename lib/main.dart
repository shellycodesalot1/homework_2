import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";  // Display value
  String _operand = "";  // Current operand
  double _firstNumber = 0.0;  // First number
  double _secondNumber = 0.0; // Second number
  String _operator = "";  // Current operator

  void _buttonPressed(String value) {
    setState(() {
      // If the "Clear" button is pressed
      if (value == "C") {
        _output = "0";
        _firstNumber = 0;
        _secondNumber = 0;
        _operator = "";
        _operand = "";
        return;
      }

      // If an operator is pressed
      if (value == "+" || value == "-" || value == "*" || value == "/") {
        _firstNumber = double.parse(_output);
        _operator = value;
        _output = "0";
        return;
      }

      // If the "=" button is pressed
      if (value == "=") {
        _secondNumber = double.parse(_output);

        if (_operator == "+") {
          _output = (_firstNumber + _secondNumber).toString();
        } else if (_operator == "-") {
          _output = (_firstNumber - _secondNumber).toString();
        } else if (_operator == "*") {
          _output = (_firstNumber * _secondNumber).toString();
        } else if (_operator == "/") {
          if (_secondNumber != 0) {
            _output = (_firstNumber / _secondNumber).toString();
          } else {
            _output = "Error";  // Handle divide by zero
          }
        }
        _operator = "";
        return;
      }

      // Append numbers to the operand
      if (_output == "0") {
        _output = value;
      } else {
        _output += value;
      }
    });
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: InkWell(
        onTap: () => _buttonPressed(label),
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 4,
              )
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CalculatorApp"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("0"),
                  _buildButton("C"),
                  _buildButton("="),
                  _buildButton("+"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
