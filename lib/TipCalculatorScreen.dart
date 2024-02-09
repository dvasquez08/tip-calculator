import 'package:flutter/material.dart';
import 'components.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF005f73),
          centerTitle: true,
          title: const SansText('Tip Calculator', 25.0),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
          child: ListView(
            children: [
              const SizedBox(height: 40.0),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(20.0)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          billAmount = double.parse(value);
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter bill amount here',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .white), // Set the color of the underline
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20.0),
                    const SansText('Select Tip Percentage', 20.0),
                    Slider(
                      value: tipPercentage,
                      onChanged: (value) {
                        setState(() {
                          tipPercentage = value;
                        });
                      },
                      min: 0.1,
                      max: 0.3,
                      divisions: 4,
                      label: '${(tipPercentage * 100).round()}%',
                    ),
                    const SizedBox(height: 20.0),
                    SansText(
                        'Tip Amount: \$${(billAmount * tipPercentage).toStringAsFixed(2)}',
                        20.0),
                    const SizedBox(height: 10),
                    SansText(
                        'Total Amount: \$${(billAmount + (billAmount * tipPercentage)).toStringAsFixed(2)}',
                        20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
