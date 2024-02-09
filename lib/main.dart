import 'package:flutter/material.dart';
import 'components.dart';

void main() {
  runApp(TipCalculator());
}

class TipCalculator extends StatelessWidget {
  const TipCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TipCalculatorScreen(),
    );
  }
}

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  double billAmount = 0.0;
  double tipPercentage = 0.1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const SansText('Tip Calculator', 25.0),
        ),
        body: Container(
          child: ListView(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    billAmount = double.parse(value);
                  });
                },
                decoration: InputDecoration(labelText: 'Enter bill amount'),
              ),
              SizedBox(height: 20.0),
              SansText('Select Tip Percentage', 20.0),
              Slider(value: tipPercentage, onChanged: (value) {
                setState(() {
                  tipPercentage = value;
                });
              },
              min: 1,
              max: 0.3,
              divisions: 4,
                label: '${(tipPercentage * 100).round()}%',
              ),
              SizedBox(height: 20.0),
              SansText('Tip Amount: \$${(billAmount * tipPercentage).toStringAsFixed(2)}', 20.0),
              SizedBox(height: 10.0),
              SansText('Total Amount: \$${(billAmount + (billAmount * tipPercentage)).toStringAsFixed(2)}', 20.0),
            ],
          ),
        ),
      ),
    );
  }
}


