import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home: PayCalculator(),
    );
  }
}

class PayCalculator extends StatefulWidget {
  @override
  _PayCalculatorState createState() => _PayCalculatorState();
}

class _PayCalculatorState extends State<PayCalculator> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  String regularPay = '';
  String overtimePay = '';
  String totalPay = '';
  String tax = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Hours Worked',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hourly Rate',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (validateInput()) {
                  calculatePay();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ERROR'),
                        content: Text('Please enter valid values for both worked hours and hourly rate.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Calculate',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).hintColor,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Report',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Regular Pay: $regularPay',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Overtime Pay: $overtimePay',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Total Pay: $totalPay',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Tax: $tax',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Praful Rana',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '301360320',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateInput() {
    return hoursController.text.isNotEmpty && rateController.text.isNotEmpty;
  }

  void calculatePay() {
    double hours = double.tryParse(hoursController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;

    if (hours <= 40) {
      regularPay = (hours * rate).toStringAsFixed(2);
      overtimePay = '0.00';
    } else {
      regularPay = (40 * rate).toStringAsFixed(2);
      overtimePay = ((hours - 40) * rate * 1.5).toStringAsFixed(2);
    }

    double totalPayValue = double.parse(regularPay) + double.parse(overtimePay);
    totalPay = totalPayValue.toStringAsFixed(2);

    double taxValue = totalPayValue * 0.18;
    tax = taxValue.toStringAsFixed(2);

    setState(() {});
  }
}
