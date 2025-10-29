import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String? conversionType;
  final TextEditingController amountController = TextEditingController();
  String resultat = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TP1 - AppFlutter'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(children: [Text('Montant')],),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            RadioListTile<String>(
              title: Text('Dinar en Euro'),
              value: 'dinar_to_euro',
              groupValue: conversionType,
              onChanged: (String? value) {
                setState(() {
                  conversionType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Euro en Dinar'),
              value: 'euro_to_dinar',
              groupValue: conversionType,
              onChanged: (String? value) {
                setState(() {
                  conversionType = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (conversionType != null && amountController.text.isNotEmpty) {
                  double amount = double.tryParse(amountController.text) ?? 0;
                  if (conversionType == 'dinar_to_euro') {
                    // Taux de change approximatif: 1 Euro = 3.3 Dinar
                    double result = amount / 3.3;
                    setState(() {
                      resultat = '${result.toStringAsFixed(2)} Euro';
                    });
                  } else if (conversionType == 'euro_to_dinar') {
                    // Taux de change approximatif: 1 Euro = 3.3 Dinar
                    double result = amount * 3.3;
                    setState(() {
                      resultat = '${result.toStringAsFixed(2)} Dinar';
                    });
                  }
                }
              },
              child: Text('Calculer'),
            ),
            SizedBox(height: 20),
            Text('Resultat: $resultat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
