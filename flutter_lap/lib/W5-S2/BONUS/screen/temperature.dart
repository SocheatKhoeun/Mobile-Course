import 'package:flutter/material.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  final TextEditingController _celsiusController = TextEditingController();
  String fahrenheit = '0'; // State to store the converted value

  /// Method to convert Celsius to Fahrenheit
  void _convertTemperature() {
    final input = _celsiusController.text; // Get input value from the TextField
    if (input.isNotEmpty) {
      try {
        double celsius = double.parse(input); // Parse the input as a double
        double fahrenheitValue = (celsius * 9 / 5) + 32;
        setState(() {
          fahrenheit = fahrenheitValue.toStringAsFixed(2); // Limit to 2 decimals
        });
      } catch (e) {
        // Handle invalid input (e.g., non-numeric values)
        setState(() {
          fahrenheit = 'Invalid input';
        });
      }
    } else {
      setState(() {
        fahrenheit = '0'; // Default state when input is empty
      });
    }
  }

  @override
  void dispose() {
    _celsiusController.dispose(); // Dispose of the controller when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: const Color(0xff16C062),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff16C062),
              Color(0xff00BCDC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.thermostat_outlined,
              size: 120,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 45),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Temperature in Celsius:",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _celsiusController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter a temperature',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (value) => _convertTemperature(),
            ),
            const SizedBox(height: 30),
            const Text(
              "Temperature in Fahrenheit:",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                fahrenheit,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
