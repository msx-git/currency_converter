import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyConverterPage(),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _controller = TextEditingController();
  double _result = 0.0;
  static const double _usdToUzsRate = 12600.0; // 1 USD = 12,600 UZS
  static const double _uzsToUsdRate = 1 / 12600.0; // 1 UZS = 0.00007937 USD
  bool _isUsdToUzs = true;

  void _convert() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0.0;
      if (_isUsdToUzs) {
        _result = input * _usdToUzsRate;
      } else {
        _result = input * _uzsToUsdRate;
      }
    });
  }

  void _swapCurrencies() {
    setState(() {
      _isUsdToUzs = !_isUsdToUzs;
      _result = 0.0;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valyuta hisoblagich'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _isUsdToUzs ? 'USD' : 'UZS',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                    "Valyuta kursi: \n1\$ = ${_usdToUzsRate.toStringAsFixed(2)} uzs\n1 uzs = ${_uzsToUsdRate.toStringAsFixed(8)} usd"),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Hisoblash'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Natija: ${_result.toStringAsFixed(2)} ${_isUsdToUzs ? 'UZS' : 'USD'}',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _swapCurrencies,
              child: const Text('Valyutani almashtirish'),
            ),
          ],
        ),
      ),
    );
  }
}
