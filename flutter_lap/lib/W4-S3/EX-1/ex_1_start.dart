import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom buttons"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableButton(),
              const SizedBox(height: 20),
              SelectableButton(),
              const SizedBox(height: 20),
              SelectableButton(),
              const SizedBox(height: 20),
              SelectableButton(),
            ],
          ),
        ),
      ),
    ));

class SelectableButton extends StatefulWidget {
  @override
  _SelectableButtonState createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 100,
        child: ElevatedButton(
          onPressed: _toggleSelection,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isSelected ? Colors.blue[500] : Colors.blue[50],
          ),
          child: Center(
            child: Text(
              _isSelected ? "Selected" : "Not Selected",
              style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
