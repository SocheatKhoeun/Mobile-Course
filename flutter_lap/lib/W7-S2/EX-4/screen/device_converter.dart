import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final TextEditingController _dollarController = TextEditingController();
  String _selectedDevice = 'Euro'; // Default device
  double _convertedAmount = 0;

  final Map<String, double> _conversionRates = {
    'Euro': 0.85,
    'Riels': 4000,
    'Dong': 23000,
  };

  @override
  void dispose() {
    _dollarController.dispose();
    super.dispose();
  }

  void _convert() {
    final String dollarText = _dollarController.text;
    if (dollarText.isEmpty) {
      setState(() {
        _convertedAmount = 0;
      });
      return;
    }

    final double? dollarValue = double.tryParse(dollarText);
    if (dollarValue != null) {
      setState(() {
        _convertedAmount = dollarValue * _conversionRates[_selectedDevice]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.money, size: 60, color: Colors.white),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Amount in dollars:"),
            const SizedBox(height: 10),
            TextField(
              controller: _dollarController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefix: const Text('\$ '),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollars',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => _convert(),
            ),
            const SizedBox(height: 30),
            const Text("Device:"),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedDevice,
              dropdownColor: const Color.fromARGB(255, 252, 115, 47),
              items: _conversionRates.keys.map((String device) {
                return DropdownMenuItem<String>(
                  value: device,
                  child: Text(
                    device,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? newDevice) {
                if (newDevice != null) {
                  setState(() {
                    _selectedDevice = newDevice;
                  });
                  _convert();
                }
              },
            ),
            const SizedBox(height: 30),
            const Text("Amount in selected device:"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _convertedAmount.toStringAsFixed(2),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
